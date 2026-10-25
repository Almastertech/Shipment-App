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
  static const String sessionGenerationExtraKey = 'auth_session_generation';

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

  final Map<int, Completer<_RefreshAttempt>> _refreshCompleters =
      <int, Completer<_RefreshAttempt>>{};

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final requiresAuth = options.extra['requiresAuth'] != false;

    if (!requiresAuth || options.extra['isRefreshCall'] == true) {
      handler.next(options);
      return;
    }

    final session = await _sessionManager.getSnapshot();
    final expectedGeneration = options.extra[sessionGenerationExtraKey] as int?;
    if (expectedGeneration != null &&
        expectedGeneration != session.generation) {
      handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.cancel,
          message: 'Session changed before the request was sent.',
        ),
      );
      return;
    }

    options.extra[sessionGenerationExtraKey] = session.generation;
    if (options.headers.containsKey('Authorization')) {
      handler.next(options);
      return;
    }

    final accessToken = session.accessToken;
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
    final session = await _sessionManager.getSnapshot();
    final requestGeneration =
        err.requestOptions.extra[sessionGenerationExtraKey] as int? ??
            session.generation;
    if (requestGeneration != session.generation) {
      err.requestOptions.extra['suppressMonitoringFailure'] = false;
      handler.next(err);
      return;
    }

    final refreshToken = session.refreshToken;
    if (refreshToken == null || refreshToken.isEmpty) {
      err.requestOptions.extra['auth_retry'] = true;
      err.requestOptions.extra['suppressMonitoringFailure'] = false;
      await _handleExpiredSession(requestGeneration);
      handler.next(err);
      return;
    }

    final refreshAttempt = await _refreshOnce(
      refreshToken,
      expectedGeneration: requestGeneration,
    );
    if (refreshAttempt.error is _SessionChangedDuringRefresh) {
      err.requestOptions.extra['suppressMonitoringFailure'] = false;
      handler.next(err);
      return;
    }

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
        await _handleExpiredSession(requestGeneration);
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
      await _handleExpiredSession(requestGeneration);
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

    final generationAfterRefresh = refreshAttempt.sessionGeneration;
    if (generationAfterRefresh == null ||
        (await _sessionManager.getSnapshot()).generation !=
            generationAfterRefresh) {
      err.requestOptions.extra['suppressMonitoringFailure'] = false;
      handler.next(err);
      return;
    }

    requestOptions.extra['auth_retry'] = true;
    requestOptions.extra[sessionGenerationExtraKey] = generationAfterRefresh;
    requestOptions.headers['Authorization'] = 'Bearer ${refreshed.accessToken}';

    try {
      final response = await _dio.fetch<dynamic>(requestOptions);
      if ((await _sessionManager.getSnapshot()).generation !=
          generationAfterRefresh) {
        err.requestOptions.extra['suppressMonitoringFailure'] = false;
        handler.next(err);
        return;
      }
      handler.resolve(response);
    } on DioException catch (replayError, replayStackTrace) {
      AppLogger.warning(
        'Auth replay failed with status=${replayError.response?.statusCode}.',
        category: AppLogCategory.auth,
      );
      if (_shouldExpireSessionOnReplayFailure(replayError)) {
        await _handleExpiredSession(generationAfterRefresh);
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

  Future<_RefreshAttempt> _refreshOnce(
    String refreshToken, {
    required int expectedGeneration,
  }) async {
    final existing = _refreshCompleters[expectedGeneration];
    if (existing != null) {
      return existing.future;
    }

    final completer = Completer<_RefreshAttempt>();
    _refreshCompleters[expectedGeneration] = completer;

    try {
      final result = await _tokenRefresher.refreshToken(refreshToken);
      if (result != null) {
        final savedSession = await _sessionManager.saveTokensIfGeneration(
          expectedGeneration: expectedGeneration,
          accessToken: result.accessToken,
          refreshToken: result.refreshToken,
        );
        if (savedSession == null) {
          completer.complete(const _RefreshAttempt.sessionChanged());
        } else {
          completer.complete(
            _RefreshAttempt.success(
              result,
              sessionGeneration: savedSession.generation,
            ),
          );
        }
      } else {
        completer.complete(
          _RefreshAttempt.success(
            null,
            sessionGeneration: expectedGeneration,
          ),
        );
      }
    } catch (error, stackTrace) {
      completer.complete(
        _RefreshAttempt.failure(
          error: error,
          stackTrace: stackTrace,
        ),
      );
    } finally {
      if (identical(_refreshCompleters[expectedGeneration], completer)) {
        _refreshCompleters.remove(expectedGeneration);
      }
    }

    return completer.future;
  }

  Future<void> _handleExpiredSession(int expectedGeneration) async {
    final cleared =
        await _sessionManager.clearTokensIfGeneration(expectedGeneration);
    if (cleared) await _sessionExpiryHandler.onSessionExpired();
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
  const _RefreshAttempt.success(
    this.result, {
    required this.sessionGeneration,
  })  : error = null,
        stackTrace = null;

  const _RefreshAttempt.sessionChanged()
      : result = null,
        error = const _SessionChangedDuringRefresh(),
        stackTrace = null,
        sessionGeneration = null;

  const _RefreshAttempt.failure({
    required this.error,
    required this.stackTrace,
  })  : result = null,
        sessionGeneration = null;

  final TokenRefreshResult? result;
  final Object? error;
  final StackTrace? stackTrace;
  final int? sessionGeneration;
}

class _SessionChangedDuringRefresh implements Exception {
  const _SessionChangedDuringRefresh();
}
