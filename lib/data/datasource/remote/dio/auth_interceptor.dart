import 'dart:async';

import 'package:dio/dio.dart';

import '../../../../core/logger.dart';
import '../../../../core/session/session_expiry_handler.dart';
import '../../../../core/session/session_manager.dart';

class TokenRefreshResult {
  const TokenRefreshResult({
    required this.accessToken,
    this.refreshToken,
  });

  final String accessToken;
  final String? refreshToken;
}

abstract class TokenRefresher {
  Future<TokenRefreshResult?> refreshToken(String refreshToken);
}

class NoopTokenRefresher implements TokenRefresher {
  @override
  Future<TokenRefreshResult?> refreshToken(String refreshToken) async {
    return null;
  }
}

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required Dio dio,
    required SessionManager sessionManager,
    required TokenRefresher tokenRefresher,
    SessionExpiryHandler? sessionExpiryHandler,
  })  : _dio = dio,
        _sessionManager = sessionManager,
        _tokenRefresher = tokenRefresher,
        _sessionExpiryHandler =
            sessionExpiryHandler ?? NoopSessionExpiryHandler();

  final Dio _dio;
  final SessionManager _sessionManager;
  final TokenRefresher _tokenRefresher;
  final SessionExpiryHandler _sessionExpiryHandler;

  Completer<_RefreshAttempt>? _refreshCompleter;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final requiresAuth = options.extra['requiresAuth'] != false;

    if (!requiresAuth ||
        options.headers.containsKey('Authorization') ||
        options.extra['isRefreshCall'] == true) {
      handler.next(options);
      return;
    }

    final accessToken = await _sessionManager.getAccessToken();
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!_shouldAttemptRefresh(err)) {
      handler.next(err);
      return;
    }

    err.requestOptions.extra['suppressMonitoringFailure'] = true;
    final refreshToken = await _sessionManager.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      err.requestOptions.extra['auth_retry'] = true;
      err.requestOptions.extra['suppressMonitoringFailure'] = false;
      await _handleExpiredSession();
      handler.next(err);
      return;
    }

    final refreshAttempt = await _refreshOnce(refreshToken);
    if (refreshAttempt.error != null) {
      final error = refreshAttempt.error!;
      final stackTrace = refreshAttempt.stackTrace;
      AppLogger.error(
        'Token refresh failed.',
        error: error,
        stackTrace: stackTrace,
        category: AppLogCategory.auth,
      );

      if (_shouldExpireSessionOnRefreshFailure(error)) {
        await _handleExpiredSession();
      }
      err.requestOptions.extra['auth_retry'] = true;
      err.requestOptions.extra['suppressMonitoringFailure'] = false;
      handler.next(err);
      return;
    }

    final refreshed = refreshAttempt.result;
    if (refreshed == null) {
      err.requestOptions.extra['auth_retry'] = true;
      err.requestOptions.extra['suppressMonitoringFailure'] = false;
      await _handleExpiredSession();
      handler.next(err);
      return;
    }

    final requestOptions = err.requestOptions;
    if (!_canReplayRequest(requestOptions)) {
      requestOptions.extra['auth_retry'] = true;
      requestOptions.extra['suppressMonitoringFailure'] = false;
      handler.next(err);
      return;
    }

    requestOptions.extra['auth_retry'] = true;
    requestOptions.headers['Authorization'] = 'Bearer ${refreshed.accessToken}';

    try {
      final response = await _dio.fetch<dynamic>(requestOptions);
      handler.resolve(response);
    } on DioException catch (replayError, replayStackTrace) {
      AppLogger.warning(
        'Auth replay failed with status=${replayError.response?.statusCode}.',
        category: AppLogCategory.auth,
      );
      if (_shouldExpireSessionOnReplayFailure(replayError)) {
        await _handleExpiredSession();
      }
      AppLogger.debug(
        'Replay failure stackTrace=$replayStackTrace',
        category: AppLogCategory.auth,
      );
      replayError.requestOptions.extra['suppressMonitoringFailure'] = false;
      handler.next(replayError);
    }
  }

  bool _shouldAttemptRefresh(DioException err) {
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

  Future<_RefreshAttempt> _refreshOnce(String refreshToken) async {
    if (_refreshCompleter != null) {
      return _refreshCompleter!.future;
    }

    final completer = Completer<_RefreshAttempt>();
    _refreshCompleter = completer;

    try {
      final result = await _tokenRefresher.refreshToken(refreshToken);
      if (result != null) {
        await _sessionManager.saveTokens(
          accessToken: result.accessToken,
          refreshToken: result.refreshToken,
        );
      }
      completer.complete(_RefreshAttempt.success(result));
    } catch (error, stackTrace) {
      completer.complete(
        _RefreshAttempt.failure(
          error: error,
          stackTrace: stackTrace,
        ),
      );
    } finally {
      _refreshCompleter = null;
    }

    return completer.future;
  }

  Future<void> _handleExpiredSession() async {
    await _sessionManager.clearTokens();
    await _sessionExpiryHandler.onSessionExpired();
  }

  bool _shouldExpireSessionOnRefreshFailure(Object error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      if (statusCode == 400 ||
          statusCode == 401 ||
          statusCode == 403 ||
          statusCode == 422) {
        return true;
      }
      if (statusCode == 408 || statusCode == 429) {
        return false;
      }
      if (statusCode != null && statusCode >= 500) {
        return false;
      }

      return switch (error.type) {
        DioExceptionType.connectionError ||
        DioExceptionType.connectionTimeout ||
        DioExceptionType.receiveTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.cancel =>
          false,
        DioExceptionType.badCertificate ||
        DioExceptionType.unknown ||
        DioExceptionType.badResponse =>
          false,
      };
    }

    return false;
  }

  bool _shouldExpireSessionOnReplayFailure(DioException error) {
    final statusCode = error.response?.statusCode;
    return statusCode == 401 || statusCode == 403;
  }
}

class _RefreshAttempt {
  const _RefreshAttempt.success(this.result)
      : error = null,
        stackTrace = null;

  const _RefreshAttempt.failure({
    required this.error,
    required this.stackTrace,
  }) : result = null;

  final TokenRefreshResult? result;
  final Object? error;
  final StackTrace? stackTrace;
}
