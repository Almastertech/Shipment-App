import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:shipments/data/app_urls/app_url.dart';
import 'package:shipments/data/datasource/remote/dio/api_token_refresher.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiTokenRefresher', () {
    test('returns tokens when payload contains access token', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = _StaticResponseAdapter(
          body: <String, dynamic>{
            'data': <String, dynamic>{
              'accessToken': 'new_access',
              'refreshToken': 'new_refresh',
            },
          },
        );
      final refresher = ApiTokenRefresher(dio: dio);

      final result = await refresher.refreshToken('old_refresh');

      expect(result, isNotNull);
      expect(result!.accessToken, 'new_access');
      expect(result.refreshToken, 'new_refresh');
    });

    test('returns null when access token is missing', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = _StaticResponseAdapter(
          body: <String, dynamic>{
            'data': <String, dynamic>{'refreshToken': 'new_refresh'},
          },
        );
      final refresher = ApiTokenRefresher(dio: dio);

      final result = await refresher.refreshToken('old_refresh');

      expect(result, isNull);
    });
  });
}

class _StaticResponseAdapter implements HttpClientAdapter {
  _StaticResponseAdapter({required this.body});

  final Map<String, dynamic> body;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    expect(options.path, AppUrl.refreshToken);
    expect(options.extra['isRefreshCall'], isTrue);
    expect(options.extra['requiresAuth'], isFalse);
    expect(options.extra['retryable'], isFalse);
    expect(options.extra['skipRateLimit'], isTrue);

    return ResponseBody.fromString(
      jsonEncode(body),
      200,
      headers: <String, List<String>>{
        Headers.contentTypeHeader: <String>[Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
