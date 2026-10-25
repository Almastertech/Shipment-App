import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipments/core/session/session_expiry_handler.dart';
import 'package:shipments/core/session/session_manager.dart';
import 'package:shipments/core/session/session_scoped_data_purger.dart';
import 'package:shipments/core/storage/secure_storage.dart';
import 'package:shipments/data/datasource/remote/dio/auth_interceptor.dart';

void main() {
  group('AuthInterceptor', () {
    test('adds Authorization header when access token exists', () async {
      final adapter = _CapturingAdapter();
      final sessionManager = SessionManager(
        secureStorage: InMemorySecureStorage(),
      );
      await sessionManager.saveTokens(accessToken: 'token_123');

      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = adapter;
      dio.interceptors.add(
        AuthInterceptor(
          dio: dio,
          sessionManager: sessionManager,
          tokenRefresher: NoopTokenRefresher(),
        ),
      );

      await dio.get<dynamic>('/secure');

      expect(adapter.lastRequest, isNotNull);
      expect(adapter.lastRequest!.headers['Authorization'], 'Bearer token_123');
    });

    test('skips Authorization header when requiresAuth=false', () async {
      final adapter = _CapturingAdapter();
      final sessionManager = SessionManager(
        secureStorage: InMemorySecureStorage(),
      );
      await sessionManager.saveTokens(accessToken: 'token_123');

      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = adapter;
      dio.interceptors.add(
        AuthInterceptor(
          dio: dio,
          sessionManager: sessionManager,
          tokenRefresher: NoopTokenRefresher(),
        ),
      );

      await dio.get<dynamic>(
        '/public',
        options: Options(extra: <String, dynamic>{'requiresAuth': false}),
      );

      expect(adapter.lastRequest, isNotNull);
      expect(
        adapter.lastRequest!.headers.containsKey('Authorization'),
        isFalse,
      );
    });

    test('clears session and triggers expiry handler when refresh is missing',
        () async {
      final sessionManager = SessionManager(
        secureStorage: InMemorySecureStorage(),
      );
      await sessionManager.saveTokens(accessToken: 'token_123');
      final expiryHandler = _FakeSessionExpiryHandler();

      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = _UnauthorizedAdapter();
      dio.interceptors.add(
        AuthInterceptor(
          dio: dio,
          sessionManager: sessionManager,
          tokenRefresher: NoopTokenRefresher(),
          sessionExpiryHandler: expiryHandler,
        ),
      );

      await expectLater(
        dio.get<dynamic>('/secure'),
        throwsA(isA<DioException>()),
      );

      expect(expiryHandler.calls, 1);
      expect(await sessionManager.getAccessToken(), isNull);
      expect(await sessionManager.getRefreshToken(), isNull);
    });

    test('does not refresh non-replayable stream requests', () async {
      final refresher = _CountingTokenRefresher();
      final sessionManager = SessionManager(
        secureStorage: InMemorySecureStorage(),
      );
      await sessionManager.saveTokens(
        accessToken: 'token_123',
        refreshToken: 'refresh_123',
      );

      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = _UnauthorizedAdapter();
      dio.interceptors.add(
        AuthInterceptor(
          dio: dio,
          sessionManager: sessionManager,
          tokenRefresher: refresher,
        ),
      );

      await expectLater(
        dio.post<dynamic>(
          '/upload',
          data: Stream<Uint8List>.fromIterable(
            <Uint8List>[
              Uint8List.fromList(<int>[1, 2, 3]),
            ],
          ),
          options: Options(
            headers: <String, String>{
              Headers.contentLengthHeader: '3',
              Headers.contentTypeHeader: 'application/octet-stream',
            },
          ),
        ),
        throwsA(isA<DioException>()),
      );

      expect(refresher.calls, 0);
      expect(await sessionManager.getAccessToken(), 'token_123');
      expect(await sessionManager.getRefreshToken(), 'refresh_123');
    });

    test('keeps session on transient refresh failures', () async {
      final sessionManager = SessionManager(
        secureStorage: InMemorySecureStorage(),
      );
      await sessionManager.saveTokens(
        accessToken: 'token_123',
        refreshToken: 'refresh_123',
      );
      final expiryHandler = _FakeSessionExpiryHandler();

      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = _UnauthorizedAdapter();
      dio.interceptors.add(
        AuthInterceptor(
          dio: dio,
          sessionManager: sessionManager,
          tokenRefresher: _ThrowingTokenRefresher.transient(),
          sessionExpiryHandler: expiryHandler,
        ),
      );

      await expectLater(
        dio.get<dynamic>('/secure'),
        throwsA(isA<DioException>()),
      );

      expect(expiryHandler.calls, 0);
      expect(await sessionManager.getAccessToken(), 'token_123');
      expect(await sessionManager.getRefreshToken(), 'refresh_123');
    });

    test('expires session on terminal refresh auth failure', () async {
      final purger = _FakeSessionScopedDataPurger();
      final sessionManager = SessionManager(
        secureStorage: InMemorySecureStorage(),
        sessionScopedDataPurger: purger,
      );
      await sessionManager.saveTokens(
        accessToken: 'token_123',
        refreshToken: 'refresh_123',
      );
      final expiryHandler = _FakeSessionExpiryHandler();

      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = _UnauthorizedAdapter();
      dio.interceptors.add(
        AuthInterceptor(
          dio: dio,
          sessionManager: sessionManager,
          tokenRefresher: _ThrowingTokenRefresher.unauthorized(),
          sessionExpiryHandler: expiryHandler,
        ),
      );

      await expectLater(
        dio.get<dynamic>('/secure'),
        throwsA(isA<DioException>()),
      );

      expect(expiryHandler.calls, 1);
      expect(purger.calls, 1);
      expect(await sessionManager.getAccessToken(), isNull);
      expect(await sessionManager.getRefreshToken(), isNull);
    });

    test('does not restore tokens when logout occurs during token refresh',
        () async {
      final sessionManager = SessionManager(
        secureStorage: InMemorySecureStorage(),
      );
      await sessionManager.saveTokens(
        accessToken: 'account_a_access',
        refreshToken: 'account_a_refresh',
      );
      final refresher = _CompletingTokenRefresher();
      final adapter = _UnauthorizedAdapterWithRequestCount();
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = adapter;
      dio.interceptors.add(
        AuthInterceptor(
          dio: dio,
          sessionManager: sessionManager,
          tokenRefresher: refresher,
        ),
      );

      final request = dio.get<dynamic>('/secure');
      await refresher.started.future;
      await sessionManager.clearTokens();
      refresher.complete(
        const TokenRefreshResult(
          accessToken: 'account_a_refreshed',
          refreshToken: 'account_a_refresh_2',
        ),
      );

      await expectLater(request, throwsA(isA<DioException>()));
      expect(await sessionManager.getAccessToken(), isNull);
      expect(await sessionManager.getRefreshToken(), isNull);
      expect(
        adapter.requestCount,
        1,
        reason: 'stale requests are not replayed',
      );
    });

    test('does not overwrite a new account when an old refresh completes',
        () async {
      final sessionManager = SessionManager(
        secureStorage: InMemorySecureStorage(),
      );
      await sessionManager.saveTokens(
        accessToken: 'account_a_access',
        refreshToken: 'account_a_refresh',
      );
      final refresher = _CompletingTokenRefresher();
      final adapter = _UnauthorizedAdapterWithRequestCount();
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = adapter;
      dio.interceptors.add(
        AuthInterceptor(
          dio: dio,
          sessionManager: sessionManager,
          tokenRefresher: refresher,
        ),
      );

      final request = dio.get<dynamic>('/secure');
      await refresher.started.future;
      await sessionManager.saveTokens(
        accessToken: 'account_b_access',
        refreshToken: 'account_b_refresh',
      );
      refresher.complete(
        const TokenRefreshResult(
          accessToken: 'account_a_refreshed',
          refreshToken: 'account_a_refresh_2',
        ),
      );

      await expectLater(request, throwsA(isA<DioException>()));
      expect(await sessionManager.getAccessToken(), 'account_b_access');
      expect(await sessionManager.getRefreshToken(), 'account_b_refresh');
      expect(
        adapter.requestCount,
        1,
        reason: 'stale requests are not replayed',
      );
    });
  });
}

class _CapturingAdapter implements HttpClientAdapter {
  RequestOptions? lastRequest;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastRequest = options;
    return ResponseBody.fromString(
      '{"ok": true}',
      200,
      headers: <String, List<String>>{
        Headers.contentTypeHeader: <String>[Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class _UnauthorizedAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      '{"message":"unauthorized"}',
      401,
      headers: <String, List<String>>{
        Headers.contentTypeHeader: <String>[Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class _UnauthorizedAdapterWithRequestCount implements HttpClientAdapter {
  int requestCount = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requestCount++;
    return ResponseBody.fromString(
      '{"message":"unauthorized"}',
      401,
      headers: <String, List<String>>{
        Headers.contentTypeHeader: <String>[Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class _CompletingTokenRefresher implements TokenRefresher {
  final Completer<void> started = Completer<void>();
  final Completer<TokenRefreshResult?> _result =
      Completer<TokenRefreshResult?>();

  void complete(TokenRefreshResult result) => _result.complete(result);

  @override
  Future<TokenRefreshResult?> refreshToken(String refreshToken) {
    if (!started.isCompleted) started.complete();
    return _result.future;
  }
}

class _FakeSessionExpiryHandler implements SessionExpiryHandler {
  int calls = 0;

  @override
  Future<void> onSessionExpired() async {
    calls += 1;
  }
}

class _CountingTokenRefresher implements TokenRefresher {
  int calls = 0;

  @override
  Future<TokenRefreshResult?> refreshToken(String refreshToken) async {
    calls += 1;
    return const TokenRefreshResult(accessToken: 'new_token');
  }
}

class _ThrowingTokenRefresher implements TokenRefresher {
  _ThrowingTokenRefresher._(this._errorFactory);

  factory _ThrowingTokenRefresher.transient() {
    return _ThrowingTokenRefresher._(
      (requestOptions) => DioException(
        requestOptions: requestOptions,
        type: DioExceptionType.connectionTimeout,
      ),
    );
  }

  factory _ThrowingTokenRefresher.unauthorized() {
    return _ThrowingTokenRefresher._(
      (requestOptions) => DioException(
        requestOptions: requestOptions,
        response: Response<dynamic>(
          requestOptions: requestOptions,
          statusCode: 401,
        ),
        type: DioExceptionType.badResponse,
      ),
    );
  }

  final DioException Function(RequestOptions requestOptions) _errorFactory;

  @override
  Future<TokenRefreshResult?> refreshToken(String refreshToken) async {
    final requestOptions = RequestOptions(path: '/auth/refresh');
    throw _errorFactory(requestOptions);
  }
}

class _FakeSessionScopedDataPurger implements SessionScopedDataPurger {
  int calls = 0;

  @override
  Future<void> purgeUserScopedData() async {
    calls += 1;
  }
}
