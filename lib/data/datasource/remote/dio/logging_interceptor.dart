import 'package:dio/dio.dart';

import '../../../../core/logger.dart';

class LogSanitizer {
  static const String _redacted = '***';
  static const Set<String> _sensitiveKeys = <String>{
    'authorization',
    'proxyauthorization',
    'cookie',
    'setcookie',
    'apikey',
    'accesstoken',
    'refreshtoken',
    'token',
    'password',
    'newpassword',
    'oldpassword',
    'secret',
  };

  static Object? sanitize(Object? value, {String? key}) {
    if (key != null && _isSensitiveKey(key)) {
      return _redacted;
    }

    if (value is Map) {
      final sanitized = <String, Object?>{};
      value.forEach((dynamic k, dynamic v) {
        final mapKey = k.toString();
        sanitized[mapKey] = sanitize(v, key: mapKey);
      });
      return sanitized;
    }

    if (value is List) {
      return value
          .map<Object?>((item) => sanitize(item))
          .toList(growable: false);
    }

    if (value is FormData) {
      return <String, Object?>{
        'fields': sanitize(
          Map<String, String>.fromEntries(value.fields),
        ),
        'filesCount': value.files.length,
      };
    }

    if (value is MultipartFile) {
      return '<multipart-file>';
    }

    return value;
  }

  static bool _isSensitiveKey(String key) {
    final normalized = key.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    return _sensitiveKeys.contains(normalized);
  }
}

class LoggingInterceptor extends Interceptor {
  LoggingInterceptor({required this.enabled});

  final bool enabled;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (enabled) {
      final headers = LogSanitizer.sanitize(options.headers);
      final query = LogSanitizer.sanitize(options.queryParameters);
      final body = LogSanitizer.sanitize(options.data);

      AppLogger.debug(
        '[${options.method}] ${options.baseUrl}${options.path} headers=$headers query=$query data=$body',
        category: AppLogCategory.network,
      );
    }

    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (enabled) {
      final body = LogSanitizer.sanitize(response.data);
      AppLogger.info(
        '[${response.requestOptions.method}] ${response.requestOptions.baseUrl}${response.requestOptions.path} '
        'status=${response.statusCode} data=$body',
        category: AppLogCategory.network,
      );
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (enabled) {
      final safeDetails = LogSanitizer.sanitize(
        <String, Object?>{
          'message': err.message,
          'type': err.type.name,
          'request': <String, Object?>{
            'method': err.requestOptions.method,
            'url': '${err.requestOptions.baseUrl}${err.requestOptions.path}',
            'headers': err.requestOptions.headers,
            'query': err.requestOptions.queryParameters,
            'data': err.requestOptions.data,
          },
          'response': err.response == null
              ? null
              : <String, Object?>{
                  'statusCode': err.response?.statusCode,
                  'data': err.response?.data,
                },
        },
      );
      AppLogger.error(
        '[${err.requestOptions.method}] ${err.requestOptions.baseUrl}${err.requestOptions.path} '
        'status=${err.response?.statusCode} details=$safeDetails',
        category: AppLogCategory.network,
      );
    }

    handler.next(err);
  }
}
