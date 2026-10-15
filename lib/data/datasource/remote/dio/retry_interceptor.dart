import 'dart:async';
import 'dart:math' as math;

import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required Dio dio,
    this.retries = 2,
    this.baseRetryDelay = const Duration(milliseconds: 350),
    this.maxRetryDelay = const Duration(seconds: 5),
    this.jitterFactor = 0.15,
    Set<String>? retryableMethods,
    math.Random? random,
  })  : _dio = dio,
        _retryableMethods =
            (retryableMethods ?? const <String>{'GET', 'HEAD', 'OPTIONS'})
                .map((method) => method.toUpperCase())
                .toSet(),
        _random = random ?? math.Random();

  final Dio _dio;
  final int retries;
  final Duration baseRetryDelay;
  final Duration maxRetryDelay;
  final double jitterFactor;
  final Set<String> _retryableMethods;
  final math.Random _random;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!_shouldRetry(err)) {
      handler.next(err);
      return;
    }

    final requestOptions = err.requestOptions;
    final retryCount = (requestOptions.extra['retry_count'] as int?) ?? 0;

    if (retryCount >= retries) {
      handler.next(err);
      return;
    }

    requestOptions.extra['retry_count'] = retryCount + 1;

    final retryDelay = _computeDelay(retryCount + 1);
    await Future<void>.delayed(retryDelay);

    try {
      final response = await _retryRequest(requestOptions);
      handler.resolve(response);
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }

  bool _shouldRetry(DioException err) {
    final requestOptions = err.requestOptions;
    final explicitRetryable = requestOptions.extra['retryable'] as bool?;
    final method = requestOptions.method.toUpperCase();

    if (requestOptions.cancelToken?.isCancelled == true) {
      return false;
    }

    if (requestOptions.data is Stream) {
      return false;
    }

    if (explicitRetryable != null && !explicitRetryable) {
      return false;
    }

    if (explicitRetryable != true && !_retryableMethods.contains(method)) {
      return false;
    }

    final statusCode = err.response?.statusCode;

    if (statusCode == 401 || statusCode == 403 || statusCode == 422) {
      return false;
    }

    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      return true;
    }

    if (statusCode == 408) {
      return true;
    }

    if (statusCode != null && statusCode >= 500) {
      return true;
    }

    return false;
  }

  Duration _computeDelay(int attemptNumber) {
    final exponent = attemptNumber - 1;
    final baseMs = baseRetryDelay.inMilliseconds * (1 << exponent);
    final cappedMs = math.min(baseMs, maxRetryDelay.inMilliseconds);

    if (jitterFactor <= 0) {
      return Duration(milliseconds: cappedMs);
    }

    final jitterSpan = (cappedMs * jitterFactor).round();
    if (jitterSpan <= 0) {
      return Duration(milliseconds: cappedMs);
    }

    final jitter = _random.nextInt(jitterSpan * 2 + 1) - jitterSpan;
    final totalMs = math.max(0, cappedMs + jitter);
    return Duration(milliseconds: totalMs);
  }

  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions) {
    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
        responseType: requestOptions.responseType,
        contentType: requestOptions.contentType,
        followRedirects: requestOptions.followRedirects,
        receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
        validateStatus: requestOptions.validateStatus,
        sendTimeout: requestOptions.sendTimeout,
        receiveTimeout: requestOptions.receiveTimeout,
        extra: requestOptions.extra,
      ),
      cancelToken: requestOptions.cancelToken,
      onSendProgress: requestOptions.onSendProgress,
      onReceiveProgress: requestOptions.onReceiveProgress,
    );
  }
}
