import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:shipments/data/datasource/remote/dio/retry_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RetryInterceptor', () {
    test('retries idempotent GET request after connection error', () async {
      final adapter = _SequenceAdapter(
        <Future<ResponseBody> Function(RequestOptions)>[
          _connectionError,
          _successResponse,
        ],
      );
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = adapter;
      dio.interceptors.add(
        RetryInterceptor(
          dio: dio,
          baseRetryDelay: Duration.zero,
          jitterFactor: 0,
        ),
      );

      final response = await dio.get<dynamic>('/items');

      expect(response.statusCode, 200);
      expect(adapter.calls, 2);
    });

    test('does not retry POST by default', () async {
      final adapter = _SequenceAdapter(
        <Future<ResponseBody> Function(RequestOptions)>[
          _connectionError,
          _successResponse,
        ],
      );
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = adapter;
      dio.interceptors.add(
        RetryInterceptor(
          dio: dio,
          baseRetryDelay: Duration.zero,
          jitterFactor: 0,
        ),
      );

      await expectLater(
        dio.post<dynamic>('/items', data: <String, dynamic>{'a': 1}),
        throwsA(isA<DioException>()),
      );
      expect(adapter.calls, 1);
    });

    test('retries POST when request sets retryable=true', () async {
      final adapter = _SequenceAdapter(
        <Future<ResponseBody> Function(RequestOptions)>[
          _connectionError,
          _successResponse,
        ],
      );
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = adapter;
      dio.interceptors.add(
        RetryInterceptor(
          dio: dio,
          baseRetryDelay: Duration.zero,
          jitterFactor: 0,
        ),
      );

      final response = await dio.post<dynamic>(
        '/items',
        data: <String, dynamic>{'a': 1},
        options: Options(extra: <String, dynamic>{'retryable': true}),
      );

      expect(response.statusCode, 200);
      expect(adapter.calls, 2);
    });

    test('does not retry validation error responses', () async {
      final adapter = _SequenceAdapter(
        <Future<ResponseBody> Function(RequestOptions)>[
          _statusResponse(422),
          _successResponse,
        ],
      );
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = adapter;
      dio.interceptors.add(
        RetryInterceptor(
          dio: dio,
          baseRetryDelay: Duration.zero,
          jitterFactor: 0,
        ),
      );

      await expectLater(
        dio.get<dynamic>('/items'),
        throwsA(isA<DioException>()),
      );

      expect(adapter.calls, 1);
    });
  });
}

Future<ResponseBody> _successResponse(RequestOptions options) async {
  return ResponseBody.fromString(
    '{"ok": true}',
    200,
    headers: <String, List<String>>{
      Headers.contentTypeHeader: <String>[Headers.jsonContentType],
    },
  );
}

Future<ResponseBody> _connectionError(RequestOptions options) async {
  throw DioException.connectionError(
    requestOptions: options,
    reason: 'No internet',
    error: const SocketException('No internet'),
  );
}

Future<ResponseBody> Function(RequestOptions) _statusResponse(int statusCode) {
  return (RequestOptions options) async {
    return ResponseBody.fromString(
      '{"message":"error"}',
      statusCode,
      headers: <String, List<String>>{
        Headers.contentTypeHeader: <String>[Headers.jsonContentType],
      },
    );
  };
}

class _SequenceAdapter implements HttpClientAdapter {
  _SequenceAdapter(this._steps);

  final List<Future<ResponseBody> Function(RequestOptions options)> _steps;
  int _calls = 0;

  int get calls => _calls;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    _calls += 1;
    final index = _calls - 1;
    final step = index < _steps.length ? _steps[index] : _steps.last;
    return step(options);
  }

  @override
  void close({bool force = false}) {}
}
