import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:shipments/core/monitoring/api_monitoring_service.dart';
import 'package:shipments/core/monitoring/api_request_metric.dart';
import 'package:shipments/core/session/session_manager.dart';
import 'package:shipments/core/storage/secure_storage.dart';
import 'package:shipments/data/datasource/remote/dio/api_monitoring_interceptor.dart';
import 'package:shipments/data/datasource/remote/dio/auth_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiMonitoringInterceptor', () {
    test('tracks successful request', () async {
      final monitor = _FakeMonitoringService();
      final dio = Dio(
        BaseOptions(baseUrl: 'https://example.com'),
      )..httpClientAdapter = _StubAdapter(
          statusCode: 200,
          body: '{"ok":true}',
        );

      dio.interceptors.add(
        ApiMonitoringInterceptor(monitoringService: monitor),
      );

      await dio.get<dynamic>('/ok');

      expect(monitor.started, hasLength(1));
      expect(monitor.completed, hasLength(1));
      expect(monitor.failedEvents, isEmpty);
    });

    test('tracks failed request', () async {
      final monitor = _FakeMonitoringService();
      final dio = Dio(
        BaseOptions(baseUrl: 'https://example.com'),
      )..httpClientAdapter = _StubAdapter(
          statusCode: 500,
          body: '{"error":true}',
        );

      dio.interceptors.add(
        ApiMonitoringInterceptor(monitoringService: monitor),
      );

      await expectLater(
        dio.get<dynamic>('/fail'),
        throwsA(isA<DioException>()),
      );

      expect(monitor.started, hasLength(1));
      expect(monitor.failedEvents, hasLength(1));
    });

    test('does not record failure when auth interceptor recovers 401',
        () async {
      final monitor = _FakeMonitoringService();
      final sessionManager = SessionManager(
        secureStorage: InMemorySecureStorage(),
      );
      await sessionManager.saveTokens(
        accessToken: 'expired_access',
        refreshToken: 'refresh_1',
      );

      final dio = Dio(
        BaseOptions(baseUrl: 'https://example.com'),
      )..httpClientAdapter = _UnauthorizedThenSuccessAdapter();

      dio.interceptors.addAll(
        <Interceptor>[
          ApiMonitoringInterceptor(monitoringService: monitor),
          AuthInterceptor(
            dio: dio,
            sessionManager: sessionManager,
            tokenRefresher: _SuccessTokenRefresher(),
          ),
        ],
      );

      final response = await dio.get<dynamic>('/secure');
      expect(response.statusCode, 200);
      expect(monitor.started, isNotEmpty);
      expect(monitor.completed, isNotEmpty);
      expect(monitor.failedEvents, isEmpty);
    });

    test('records failure for non-replayable auth 401 requests', () async {
      final monitor = _FakeMonitoringService();
      final sessionManager = SessionManager(
        secureStorage: InMemorySecureStorage(),
      );
      await sessionManager.saveTokens(
        accessToken: 'expired_access',
        refreshToken: 'refresh_1',
      );

      final dio = Dio(
        BaseOptions(baseUrl: 'https://example.com'),
      )..httpClientAdapter = _UnauthorizedOnlyAdapter();

      dio.interceptors.addAll(
        <Interceptor>[
          ApiMonitoringInterceptor(monitoringService: monitor),
          AuthInterceptor(
            dio: dio,
            sessionManager: sessionManager,
            tokenRefresher: _SuccessTokenRefresher(),
          ),
        ],
      );

      await expectLater(
        dio.post<dynamic>(
          '/upload',
          data: Stream<Uint8List>.fromIterable(
            <Uint8List>[
              Uint8List.fromList(<int>[1, 2, 3]),
            ],
          ),
          options: Options(
            headers: <String, String>{
              Headers.contentLengthHeader: '3',
              Headers.contentTypeHeader: 'application/octet-stream',
            },
          ),
        ),
        throwsA(isA<DioException>()),
      );

      expect(monitor.started, hasLength(1));
      expect(monitor.failedEvents, hasLength(1));
    });
  });
}

class _FakeMonitoringService implements ApiMonitoringService {
  final List<String> started = <String>[];
  final List<String> completed = <String>[];
  final List<String> failedEvents = <String>[];

  @override
  void clear() {}

  @override
  List<ApiRequestMetric> recent({int limit = 30}) => <ApiRequestMetric>[];

  @override
  List<ApiRequestMetric> slowest({int limit = 10}) => <ApiRequestMetric>[];

  @override
  List<ApiRequestMetric> failed({int limit = 20}) => <ApiRequestMetric>[];

  @override
  void onRequestCompleted({
    required String requestId,
    required int? statusCode,
    required DateTime completedAt,
  }) {
    completed.add(requestId);
  }

  @override
  void onRequestFailed({
    required String requestId,
    required int? statusCode,
    required String errorType,
    required DateTime completedAt,
  }) {
    failedEvents.add(requestId);
  }

  @override
  void onRequestStarted({
    required String requestId,
    required String method,
    required String path,
    required DateTime startedAt,
  }) {
    started.add(requestId);
  }
}

class _StubAdapter implements HttpClientAdapter {
  _StubAdapter({
    required this.statusCode,
    required this.body,
  });

  final int statusCode;
  final String body;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      body,
      statusCode,
      headers: <String, List<String>>{
        Headers.contentTypeHeader: <String>[Headers.jsonContentType],
      },
    );
  }
}

class _UnauthorizedThenSuccessAdapter implements HttpClientAdapter {
  bool _firstCall = true;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    if (_firstCall) {
      _firstCall = false;
      return ResponseBody.fromString(
        '{"message":"unauthorized"}',
        401,
        headers: <String, List<String>>{
          Headers.contentTypeHeader: <String>[Headers.jsonContentType],
        },
      );
    }

    return ResponseBody.fromString(
      '{"ok":true}',
      200,
      headers: <String, List<String>>{
        Headers.contentTypeHeader: <String>[Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class _UnauthorizedOnlyAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      '{"message":"unauthorized"}',
      401,
      headers: <String, List<String>>{
        Headers.contentTypeHeader: <String>[Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class _SuccessTokenRefresher implements TokenRefresher {
  @override
  Future<TokenRefreshResult?> refreshToken(String refreshToken) async {
    return const TokenRefreshResult(accessToken: 'new_access');
  }
}
