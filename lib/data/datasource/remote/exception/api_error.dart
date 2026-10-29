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
    this.code,
    this.correlationId,
    this.invalidParams,
    this.retryAfter,
    this.remainingAttempts,
  });

  final ApiErrorType type;
  final String message;
  final int? statusCode;
  final String? code;
  final String? correlationId;
  final List<ApiInvalidParam>? invalidParams;
  final int? retryAfter;
  final int? remainingAttempts;

  @override
  String toString() {
    final code = statusCode != null ? ' (code: $statusCode)' : '';
    return '$message$code';
  }
}

class ApiInvalidParam {
  const ApiInvalidParam({required this.name, required this.reason});

  final String name;
  final String reason;
}
