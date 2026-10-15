import 'package:flutter/foundation.dart';
import '../storage/secure_storage.dart';
import '../utils/app_constants.dart';
import 'session_scoped_data_purger.dart';

class SessionTokens {
  const SessionTokens({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String? refreshToken;
}

class SessionManager extends ChangeNotifier {
  SessionManager({
    required SecureStorage secureStorage,
    SessionScopedDataPurger? sessionScopedDataPurger,
  })  : _secureStorage = secureStorage,
        _sessionScopedDataPurger =
            sessionScopedDataPurger ?? NoopSessionScopedDataPurger();

  final SecureStorage _secureStorage;
  final SessionScopedDataPurger _sessionScopedDataPurger;

  bool _hydrated = false;
  String? _accessToken;
  String? _refreshToken;
  bool _isGuest = false;

  bool get isAuthenticated {
    final accessToken = _accessToken;
    return accessToken != null && accessToken.isNotEmpty;
  }

  bool get isGuest => _isGuest;

  bool get isSignedIn => isAuthenticated || isGuest;

  Future<void> initialize() async {
    await _hydrate();
    notifyListeners();
  }

  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken ?? _refreshToken;
    _isGuest = false;
    _hydrated = true;

    await _secureStorage.write(
      key: AppConstants.authTokenStorageKey,
      value: accessToken,
    );

    if (refreshToken != null) {
      await _secureStorage.write(
        key: AppConstants.refreshTokenStorageKey,
        value: refreshToken,
      );
    }

    await _secureStorage.delete(key: AppConstants.guestSessionStorageKey);

    notifyListeners();
  }

  Future<void> startGuestSession() async {
    _accessToken = null;
    _refreshToken = null;
    _isGuest = true;
    _hydrated = true;

    await _secureStorage.delete(key: AppConstants.authTokenStorageKey);
    await _secureStorage.delete(key: AppConstants.refreshTokenStorageKey);
    await _secureStorage.write(
      key: AppConstants.guestSessionStorageKey,
      value: '1',
    );

    notifyListeners();
  }

  Future<String?> getAccessToken() async {
    await _hydrate();
    return _accessToken;
  }

  Future<String?> getRefreshToken() async {
    await _hydrate();
    return _refreshToken;
  }

  Future<SessionTokens?> getTokens() async {
    await _hydrate();
    final accessToken = _accessToken;
    if (accessToken == null || accessToken.isEmpty) {
      return null;
    }
    return SessionTokens(
      accessToken: accessToken,
      refreshToken: _refreshToken,
    );
  }

  Future<void> clearTokens() async {
    _accessToken = null;
    _refreshToken = null;
    _isGuest = false;
    _hydrated = true;

    await _secureStorage.delete(key: AppConstants.authTokenStorageKey);
    await _secureStorage.delete(key: AppConstants.refreshTokenStorageKey);
    await _secureStorage.delete(key: AppConstants.guestSessionStorageKey);
    await _sessionScopedDataPurger.purgeUserScopedData();

    notifyListeners();
  }

  Future<void> _hydrate() async {
    if (_hydrated) return;

    _accessToken = await _secureStorage.read(
      key: AppConstants.authTokenStorageKey,
    );
    _refreshToken = await _secureStorage.read(
      key: AppConstants.refreshTokenStorageKey,
    );
    final guestRaw = await _secureStorage.read(
      key: AppConstants.guestSessionStorageKey,
    );
    _isGuest = guestRaw == '1';
    _hydrated = true;
  }
}
