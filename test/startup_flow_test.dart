import 'package:shipments/core/routing/app_routes.dart';
import 'package:shipments/core/session/session_manager.dart';
import 'package:shipments/core/startup/startup_flow.dart';
import 'package:shipments/core/storage/prefs_storage.dart';
import 'package:shipments/core/storage/secure_storage.dart';
import 'package:shipments/core/utils/app_constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('StartupFlow', () {
    test('resolves to login when no session exists', () async {
      final sessionManager = SessionManager(
        secureStorage: InMemorySecureStorage(),
      );
      await sessionManager.initialize();

      final startupFlow = StartupFlow(sessionManager: sessionManager);
      expect(startupFlow.resolveInitialRoute(), AppRoutes.login);
    });

    test('resolves to home when authenticated', () async {
      SharedPreferences.setMockInitialValues(<String, Object>{
        AppConstants.onboardingCompletedStorageKey: true,
      });
      final localStorage = PrefsStorage(
        await SharedPreferences.getInstance(),
      );
      final sessionManager = SessionManager(
        secureStorage: InMemorySecureStorage(),
      );
      await sessionManager.saveTokens(accessToken: 'token_123');

      final startupFlow = StartupFlow(
        sessionManager: sessionManager,
        localStorage: localStorage,
      );
      expect(startupFlow.resolveInitialRoute(), AppRoutes.home);
    });

    test('resolves to home when guest session exists', () async {
      final sessionManager = SessionManager(
        secureStorage: InMemorySecureStorage(),
      );
      await sessionManager.startGuestSession();

      final startupFlow = StartupFlow(sessionManager: sessionManager);
      expect(startupFlow.resolveInitialRoute(), AppRoutes.home);
    });
  });
}
