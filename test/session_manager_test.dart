import 'package:shipments/core/session/session_manager.dart';
import 'package:shipments/core/storage/secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SessionManager', () {
    test('saves and returns access/refresh tokens', () async {
      final manager = SessionManager(secureStorage: InMemorySecureStorage());

      await manager.saveTokens(
        accessToken: 'access_1',
        refreshToken: 'refresh_1',
      );

      expect(await manager.getAccessToken(), 'access_1');
      expect(await manager.getRefreshToken(), 'refresh_1');
      expect(manager.isAuthenticated, isTrue);
      expect(manager.isGuest, isFalse);
      final tokens = await manager.getTokens();
      expect(tokens?.accessToken, 'access_1');
      expect(tokens?.refreshToken, 'refresh_1');
    });

    test('guest session marks user as guest and signed in', () async {
      final manager = SessionManager(secureStorage: InMemorySecureStorage());

      await manager.startGuestSession();

      expect(manager.isGuest, isTrue);
      expect(manager.isAuthenticated, isFalse);
      expect(manager.isSignedIn, isTrue);
      expect(await manager.getAccessToken(), isNull);
    });

    test('clearTokens removes persisted auth and guest state', () async {
      final manager = SessionManager(secureStorage: InMemorySecureStorage());

      await manager.startGuestSession();
      await manager.clearTokens();

      expect(await manager.getAccessToken(), isNull);
      expect(await manager.getRefreshToken(), isNull);
      expect(await manager.getTokens(), isNull);
      expect(manager.isGuest, isFalse);
      expect(manager.isSignedIn, isFalse);
    });
  });
}
