import 'api_request_metric.dart';

abstract class ApiMonitoringService {
  void onRequestStarted({
    required String requestId,
    required String method,
    required String path,
    required DateTime startedAt,
  });

  void onRequestCompleted({
    required String requestId,
    required int? statusCode,
    required DateTime completedAt,
  });

  void onRequestFailed({
    required String requestId,
    required int? statusCode,
    required String errorType,
    required DateTime completedAt,
  });

  List<ApiRequestMetric> recent({int limit = 30});

  List<ApiRequestMetric> slowest({int limit = 10});

  List<ApiRequestMetric> failed({int limit = 20});

  void clear();
}
