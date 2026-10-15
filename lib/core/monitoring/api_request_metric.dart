class ApiRequestMetric {
  const ApiRequestMetric({
    required this.requestId,
    required this.method,
    required this.path,
    required this.startedAt,
    required this.duration,
    required this.isSuccess,
    this.statusCode,
    this.errorType,
  });

  final String requestId;
  final String method;
  final String path;
  final DateTime startedAt;
  final Duration duration;
  final bool isSuccess;
  final int? statusCode;
  final String? errorType;
}
