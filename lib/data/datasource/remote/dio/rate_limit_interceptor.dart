import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/network/network_rate_limiter.dart';

class RateLimitInterceptor extends Interceptor {
  RateLimitInterceptor({required NetworkRateLimiter limiter})
      : _limiter = limiter;

  final NetworkRateLimiter _limiter;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_isBypassed(options)) {
      handler.next(options);
      return;
    }

    final key =
        (options.extra['rateLimitKey'] as String?) ?? _buildKey(options);

    if (_limiter.isAllowed(key)) {
      handler.next(options);
      return;
    }

    final retryAfter = _limiter.retryAfter(key) ?? const Duration(seconds: 1);

    handler.reject(
      DioException(
        requestOptions: options,
        response: Response<dynamic>(
          requestOptions: options,
          statusCode: 429,
          data: <String, dynamic>{
            'message': 'Too many requests. Please try again shortly.',
            'retryAfterMs': retryAfter.inMilliseconds,
          },
        ),
        type: DioExceptionType.badResponse,
        message:
            'Rate limit exceeded for ${options.method} ${options.path}. retryAfterMs=${retryAfter.inMilliseconds}',
      ),
      true,
    );
  }

  bool _isBypassed(RequestOptions options) {
    return options.extra['skipRateLimit'] == true ||
        options.extra['isBackgroundRefresh'] == true;
  }

  String _buildKey(RequestOptions options) {
    final buffer =
        StringBuffer('${options.method.toUpperCase()}:${options.path}');

    final query = options.queryParameters;
    if (query.isNotEmpty) {
      final sortedKeys = query.keys.toList()..sort();
      for (final key in sortedKeys) {
        buffer.write('|$key=${query[key]}');
      }
    }

    if (options.data != null) {
      Object? encoded;
      try {
        encoded = jsonEncode(options.data);
      } on Object {
        encoded = options.data.toString();
      }
      buffer.write('|data=$encoded');
    }

    return buffer.toString();
  }
}
