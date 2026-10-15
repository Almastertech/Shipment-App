import 'package:flutter/foundation.dart';

import 'api_monitoring_service.dart';
import 'api_request_metric.dart';

class InMemoryApiMonitoringService extends ChangeNotifier
    implements ApiMonitoringService {
  InMemoryApiMonitoringService({this.maxRecords = 200});

  final int maxRecords;

  final Map<String, _InFlightRequest> _inFlight = <String, _InFlightRequest>{};
  final List<ApiRequestMetric> _records = <ApiRequestMetric>[];

  @override
  void clear() {
    _inFlight.clear();
    _records.clear();
    notifyListeners();
  }

  @override
  List<ApiRequestMetric> failed({int limit = 20}) {
    return _records
        .where((metric) => !metric.isSuccess)
        .take(limit)
        .toList(growable: false);
  }

  @override
  void onRequestCompleted({
    required String requestId,
    required int? statusCode,
    required DateTime completedAt,
  }) {
    final inflight = _inFlight.remove(requestId);
    if (inflight == null) {
      return;
    }

    _addMetric(
      ApiRequestMetric(
        requestId: requestId,
        method: inflight.method,
        path: inflight.path,
        startedAt: inflight.startedAt,
        duration: completedAt.difference(inflight.startedAt),
        isSuccess: true,
        statusCode: statusCode,
      ),
    );
  }

  @override
  void onRequestFailed({
    required String requestId,
    required int? statusCode,
    required String errorType,
    required DateTime completedAt,
  }) {
    final inflight = _inFlight.remove(requestId);
    if (inflight == null) {
      return;
    }

    _addMetric(
      ApiRequestMetric(
        requestId: requestId,
        method: inflight.method,
        path: inflight.path,
        startedAt: inflight.startedAt,
        duration: completedAt.difference(inflight.startedAt),
        isSuccess: false,
        statusCode: statusCode,
        errorType: errorType,
      ),
    );
  }

  @override
  void onRequestStarted({
    required String requestId,
    required String method,
    required String path,
    required DateTime startedAt,
  }) {
    _inFlight[requestId] = _InFlightRequest(
      method: method,
      path: path,
      startedAt: startedAt,
    );
  }

  @override
  List<ApiRequestMetric> recent({int limit = 30}) {
    return _records.take(limit).toList(growable: false);
  }

  @override
  List<ApiRequestMetric> slowest({int limit = 10}) {
    final sorted = _records.toList(growable: false)
      ..sort((a, b) => b.duration.compareTo(a.duration));
    return sorted.take(limit).toList(growable: false);
  }

  void _addMetric(ApiRequestMetric metric) {
    _records.insert(0, metric);
    if (_records.length > maxRecords) {
      _records.removeRange(maxRecords, _records.length);
    }
    notifyListeners();
  }
}

class _InFlightRequest {
  const _InFlightRequest({
    required this.method,
    required this.path,
    required this.startedAt,
  });

  final String method;
  final String path;
  final DateTime startedAt;
}
