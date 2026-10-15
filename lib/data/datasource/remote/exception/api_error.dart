enum ApiErrorType {
  offline,
  timeout,
  unauthorized,
  forbidden,
  notFound,
  server,
  validation,
  network,
  unknown,
}

class ApiError implements Exception {
  const ApiError({
    required this.type,
    required this.message,
    this.statusCode,
  });

  final ApiErrorType type;
  final String message;
  final int? statusCode;

  @override
  String toString() {
    final code = statusCode != null ? ' (code: $statusCode)' : '';
    return '$message$code';
  }
}
