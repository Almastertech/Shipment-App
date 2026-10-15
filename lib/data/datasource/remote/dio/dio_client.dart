import 'package:dio/dio.dart';

import '../../../../core/network/request_deduplicator.dart';
import 'api_monitoring_interceptor.dart';
import 'auth_interceptor.dart';
import 'logging_interceptor.dart';
import 'rate_limit_interceptor.dart';
import 'retry_interceptor.dart';

class DioClient {
  DioClient({
    required String baseUrl,
    required Dio dio,
    required AuthInterceptor authInterceptor,
    required ApiMonitoringInterceptor apiMonitoringInterceptor,
    required LoggingInterceptor loggingInterceptor,
    required RetryInterceptor retryInterceptor,
    required RateLimitInterceptor rateLimitInterceptor,
    RequestDeduplicator? deduplicator,
  })  : _dio = dio,
        _deduplicator = deduplicator {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    _dio.interceptors.addAll(<Interceptor>[
      apiMonitoringInterceptor,
      authInterceptor,
      rateLimitInterceptor,
      retryInterceptor,
      loggingInterceptor,
    ]);
  }

  final Dio _dio;
  final RequestDeduplicator? _deduplicator;

  Dio get rawDio => _dio;

  void updateHeaders({String? languageCode}) {
    if (languageCode != null) {
      _dio.options.headers['Accept-Language'] = languageCode;
    }
  }

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool deduplicate = true,
  }) {
    final dedup = _deduplicator;
    if (deduplicate && dedup != null) {
      final key = _buildDedupKey('GET', path, queryParameters);
      return dedup.deduplicate<Response<dynamic>>(
        key,
        () => _dio.get<dynamic>(
          path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ),
      );
    }

    return _dio.get<dynamic>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<dynamic>> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.post<dynamic>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<dynamic>> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.put<dynamic>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<dynamic>> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.delete<dynamic>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  String _buildDedupKey(
    String method,
    String path,
    Map<String, dynamic>? queryParameters,
  ) {
    final buffer = StringBuffer('$method:$path');
    if (queryParameters != null && queryParameters.isNotEmpty) {
      final sortedKeys = queryParameters.keys.toList()..sort();
      for (final key in sortedKeys) {
        buffer.write(':$key=${queryParameters[key]}');
      }
    }
    return buffer.toString();
  }
}
