import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipments/core/monitoring/in_memory_api_monitoring_service.dart';
import 'package:shipments/core/network/network_rate_limiter.dart';
import 'package:shipments/core/network/request_deduplicator.dart';
import 'package:shipments/core/session/session_manager.dart';
import 'package:shipments/core/storage/secure_storage.dart';
import 'package:shipments/data/datasource/remote/dio/api_monitoring_interceptor.dart';
import 'package:shipments/data/datasource/remote/dio/auth_interceptor.dart';
import 'package:shipments/data/datasource/remote/dio/dio_client.dart';
import 'package:shipments/data/datasource/remote/dio/logging_interceptor.dart';
import 'package:shipments/data/datasource/remote/dio/rate_limit_interceptor.dart';
import 'package:shipments/data/datasource/remote/dio/retry_interceptor.dart';

void main() {
  test('authenticated GETs from different sessions are not deduplicated',
      () async {
    final sessionManager = SessionManager(
      secureStorage: InMemorySecureStorage(),
    );
    await sessionManager.saveTokens(
      accessToken: 'account_a_access',
      refreshToken: 'account_a_refresh',
    );

    final adapter = _SessionResponseAdapter();
    final dio = Dio();
    dio.httpClientAdapter = adapter;
    final client = DioClient(
      baseUrl: 'https://example.com',
      dio: dio,
      authInterceptor: AuthInterceptor(
        dio: dio,
        sessionManager: sessionManager,
        tokenRefresher: NoopTokenRefresher(),
      ),
      apiMonitoringInterceptor: ApiMonitoringInterceptor(
        monitoringService: InMemoryApiMonitoringService(),
      ),
      loggingInterceptor: LoggingInterceptor(enabled: false),
      retryInterceptor: RetryInterceptor(dio: dio, retries: 0),
      rateLimitInterceptor: RateLimitInterceptor(
        limiter: NetworkRateLimiter(
          maxRequests: 10,
          window: const Duration(minutes: 1),
        ),
      ),
      sessionManager: sessionManager,
      deduplicator: RequestDeduplicator(),
    );

    final accountARequest = client.get('/profile');
    await adapter.firstRequestStarted.future;

    await sessionManager.saveTokens(
      accessToken: 'account_b_access',
      refreshToken: 'account_b_refresh',
    );
    final accountBRequest = client.get('/profile');
    await adapter.secondRequestStarted.future;

    adapter.completeSecondRequest();
    final accountBResponse = await accountBRequest;
    adapter.completeFirstRequest();
    final accountAResponse = await accountARequest;

    expect(adapter.authorizationHeaders, <String?>[
      'Bearer account_a_access',
      'Bearer account_b_access',
    ]);
    expect(accountAResponse.data, <String, String>{'owner': 'account_a'});
    expect(accountBResponse.data, <String, String>{'owner': 'account_b'});
    expect(adapter.requestCount, 2);
  });
}

class _SessionResponseAdapter implements HttpClientAdapter {
  final Completer<void> firstRequestStarted = Completer<void>();
  final Completer<void> secondRequestStarted = Completer<void>();
  final Completer<ResponseBody> _firstResponse = Completer<ResponseBody>();
  final Completer<ResponseBody> _secondResponse = Completer<ResponseBody>();
  final List<String?> authorizationHeaders = <String?>[];

  int requestCount = 0;

  void completeFirstRequest() =>
      _firstResponse.complete(_response('account_a'));

  void completeSecondRequest() =>
      _secondResponse.complete(_response('account_b'));

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    authorizationHeaders.add(options.headers['Authorization'] as String?);
    requestCount++;
    if (requestCount == 1) {
      firstRequestStarted.complete();
      return _firstResponse.future;
    }
    secondRequestStarted.complete();
    return _secondResponse.future;
  }

  ResponseBody _response(String owner) => ResponseBody.fromString(
        '{"owner":"$owner"}',
        200,
        headers: <String, List<String>>{
          Headers.contentTypeHeader: <String>[Headers.jsonContentType],
        },
      );

  @override
  void close({bool force = false}) {}
}
