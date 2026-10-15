import 'dart:async';

import 'package:dio/dio.dart';

import '../../../../core/monitoring/api_monitoring_service.dart';

class ApiMonitoringInterceptor extends Interceptor {
  ApiMonitoringInterceptor({required ApiMonitoringService monitoringService})
      : _monitoringService = monitoringService;

  static const String _requestIdKey = 'monitor_request_id';
  static const String _startedAtKey = 'monitor_started_at';

  final ApiMonitoringService _monitoringService;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final requestOptions = err.requestOptions;
    if (_shouldSkipRecoverableAuthFailure(err)) {
      handler.next(err);
      return;
    }

    final suppressed =
        requestOptions.extra['suppressMonitoringFailure'] == true;
    if (suppressed) {
      handler.next(err);
      return;
    }

    final requestId = requestOptions.extra[_requestIdKey] as String?;
    if (requestId != null && requestId.isNotEmpty) {
      _monitoringService.onRequestFailed(
        requestId: requestId,
        statusCode: err.response?.statusCode,
        errorType: err.type.name,
        completedAt: DateTime.now(),
      );
    }

    handler.next(err);
  }

  bool _shouldSkipRecoverableAuthFailure(DioException err) {
    final requestOptions = err.requestOptions;
    final statusCode = err.response?.statusCode;
    final requiresAuth = requestOptions.extra['requiresAuth'] != false;
    final alreadyRetried = requestOptions.extra['auth_retry'] == true;
    final isRefreshCall = requestOptions.extra['isRefreshCall'] == true;

    return statusCode == 401 &&
        requiresAuth &&
        !alreadyRetried &&
        !isRefreshCall &&
        _canReplayRequest(requestOptions);
  }

  bool _canReplayRequest(RequestOptions options) {
    if (options.cancelToken?.isCancelled == true) {
      return false;
    }

    if (options.data is Stream) {
      return false;
    }

    return true;
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final startedAt = DateTime.now();
    final requestId =
        '$startedAt|${options.method}|${options.path}|${options.hashCode}';

    options.extra[_requestIdKey] = requestId;
    options.extra[_startedAtKey] = startedAt.toIso8601String();

    _monitoringService.onRequestStarted(
      requestId: requestId,
      method: options.method,
      path: options.path,
      startedAt: startedAt,
    );

    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final requestId = response.requestOptions.extra[_requestIdKey] as String?;
    if (requestId != null && requestId.isNotEmpty) {
      _monitoringService.onRequestCompleted(
        requestId: requestId,
        statusCode: response.statusCode,
        completedAt: DateTime.now(),
      );
    }

    handler.next(response);
  }
}
