import 'package:dio/dio.dart';

import '../../../../core/network/request_deduplicator.dart';
import '../../../../core/session/session_manager.dart';
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
    required SessionManager sessionManager,
    RequestDeduplicator? deduplicator,
  })  : _dio = dio,
        _sessionManager = sessionManager,
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
  final SessionManager _sessionManager;
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
  }) async {
    final requestOptions = await _optionsForCurrentSession(options);
    final dedup = _deduplicator;
    final hasExplicitAuthorization = _hasExplicitAuthorization(requestOptions);
    if (deduplicate && dedup != null && !hasExplicitAuthorization) {
      final requiresAuth = requestOptions?.extra?['requiresAuth'] != false;
      final sessionScope = requiresAuth
          ? (requestOptions?.extra?[AuthInterceptor.sessionGenerationExtraKey]
              as int?)
          : null;
      final key = _buildDedupKey(
        'GET',
        path,
        queryParameters,
        sessionScope: sessionScope,
      );
      return dedup.deduplicate<Response<dynamic>>(
        key,
        () => _dio.get<dynamic>(
          path,
          queryParameters: queryParameters,
          options: requestOptions,
          cancelToken: cancelToken,
        ),
      );
    }

    return _dio.get<dynamic>(
      path,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
  }

  Future<Response<dynamic>> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final requestOptions = await _optionsForCurrentSession(options);
    return _dio.post<dynamic>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
  }

  Future<Response<dynamic>> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final requestOptions = await _optionsForCurrentSession(options);
    return _dio.put<dynamic>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
  }

  Future<Response<dynamic>> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final requestOptions = await _optionsForCurrentSession(options);
    return _dio.delete<dynamic>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
  }

  String _buildDedupKey(
    String method,
    String path,
    Map<String, dynamic>? queryParameters, {
    int? sessionScope,
  }) {
    final buffer = StringBuffer('$method:$path');
    if (sessionScope != null) buffer.write(':session=$sessionScope');
    if (queryParameters != null && queryParameters.isNotEmpty) {
      final sortedKeys = queryParameters.keys.toList()..sort();
      for (final key in sortedKeys) {
        buffer.write(':$key=${queryParameters[key]}');
      }
    }
    return buffer.toString();
  }

  Future<Options?> _optionsForCurrentSession(Options? options) async {
    if (options?.extra?['requiresAuth'] == false ||
        _hasExplicitAuthorization(options)) {
      return options;
    }

    final session = await _sessionManager.getSnapshot();
    final extra = <String, Object?>{
      ...?options?.extra,
      AuthInterceptor.sessionGenerationExtraKey: session.generation,
    };
    return options?.copyWith(extra: extra) ?? Options(extra: extra);
  }

  bool _hasExplicitAuthorization(Options? options) {
    return options?.headers?.keys.any(
          (key) => key.toLowerCase() == 'authorization',
        ) ??
        false;
  }
}
