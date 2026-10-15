import 'package:shipments/core/session/auth_action_guard.dart';
import 'package:shipments/core/session/session_manager.dart';
import 'package:shipments/core/storage/secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthActionGuard', () {
    test('allows authenticated users', () async {
      final sessionManager = SessionManager(
        secureStorage: InMemorySecureStorage(),
      );
      await sessionManager.saveTokens(accessToken: 'token_1');

      final guard = AuthActionGuard(sessionManager: sessionManager);
      expect(
        guard.requireAuthenticated(),
        AuthActionGuardDecision.allowed,
      );
    });

    test('requires login for guests and unauthenticated users', () async {
      final sessionManager = SessionManager(
        secureStorage: InMemorySecureStorage(),
      );
      await sessionManager.startGuestSession();
      final guard = AuthActionGuard(sessionManager: sessionManager);
      expect(
        guard.requireAuthenticated(),
        AuthActionGuardDecision.requiresLogin,
      );

      await sessionManager.clearTokens();
      expect(
        guard.requireAuthenticated(),
        AuthActionGuardDecision.requiresLogin,
      );
    });
  });
}
