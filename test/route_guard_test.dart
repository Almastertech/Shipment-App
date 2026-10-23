import 'package:flutter_test/flutter_test.dart';
import 'package:shipments/core/routing/app_router.dart';
import 'package:shipments/core/routing/app_routes.dart';
import 'package:shipments/core/session/session_manager.dart';
import 'package:shipments/core/storage/secure_storage.dart';

void main() {
  group('AppRouter route guards', () {
    test('redirects unauthenticated users from protected routes to login',
        () async {
      final sessionManager = SessionManager(
        secureStorage: InMemorySecureStorage(),
      );
      await sessionManager.initialize();

      expect(
        AppRouter.resolveGuardedRoute(
          AppRoutes.sampleList,
          sessionManager: sessionManager,
        ),
        AppRoutes.login,
      );
      expect(
        AppRouter.resolveGuardedRoute(
          AppRoutes.sampleDetailsPath('1'),
          sessionManager: sessionManager,
        ),
        AppRoutes.login,
      );
      expect(
        AppRouter.resolveGuardedRoute(
          AppRoutes.cameraPermission,
          sessionManager: sessionManager,
        ),
        AppRoutes.login,
      );
      expect(
        AppRouter.resolveGuardedRoute(
          AppRoutes.storeProtectionOptions,
          sessionManager: sessionManager,
        ),
        AppRoutes.login,
      );
      expect(
        AppRouter.resolveGuardedRoute(
          AppRoutes.uiKitShowcase,
          sessionManager: sessionManager,
        ),
        AppRoutes.uiKitShowcase,
      );
    });

    test('allows guest session to access guest-enabled protected routes',
        () async {
      final sessionManager = SessionManager(
        secureStorage: InMemorySecureStorage(),
      );
      await sessionManager.startGuestSession();

      expect(
        AppRouter.resolveGuardedRoute(
          AppRoutes.sampleList,
          sessionManager: sessionManager,
        ),
        AppRoutes.sampleList,
      );
      expect(
        AppRouter.resolveGuardedRoute(
          AppRoutes.sampleDetailsPath('2'),
          sessionManager: sessionManager,
        ),
        AppRoutes.sampleDetailsPath('2'),
      );
      expect(
        AppRouter.resolveGuardedRoute(
          AppRoutes.cameraPermission,
          sessionManager: sessionManager,
        ),
        AppRoutes.cameraPermission,
      );
      expect(
        AppRouter.resolveGuardedRoute(
          AppRoutes.storeProtectionOptions,
          sessionManager: sessionManager,
        ),
        AppRoutes.storeProtectionOptions,
      );
    });

    test('redirects authenticated users away from guest routes', () async {
      final sessionManager = SessionManager(
        secureStorage: InMemorySecureStorage(),
      );
      await sessionManager.saveTokens(accessToken: 'token_123');

      expect(
        AppRouter.resolveGuardedRoute(
          AppRoutes.login,
          sessionManager: sessionManager,
        ),
        AppRoutes.home,
      );
    });

    test('fails closed for unknown routes when unauthenticated', () async {
      final sessionManager = SessionManager(
        secureStorage: InMemorySecureStorage(),
      );
      await sessionManager.initialize();

      expect(
        AppRouter.resolveGuardedRoute(
          '/future-admin',
          sessionManager: sessionManager,
        ),
        AppRoutes.login,
      );
    });

    test('fails closed for unknown routes when guest', () async {
      final sessionManager = SessionManager(
        secureStorage: InMemorySecureStorage(),
      );
      await sessionManager.startGuestSession();

      expect(
        AppRouter.resolveGuardedRoute(
          '/future-admin',
          sessionManager: sessionManager,
        ),
        AppRoutes.home,
      );
    });

    test('fails closed for unknown routes when authenticated', () async {
      final sessionManager = SessionManager(
        secureStorage: InMemorySecureStorage(),
      );
      await sessionManager.saveTokens(accessToken: 'token_123');

      expect(
        AppRouter.resolveGuardedRoute(
          '/future-admin',
          sessionManager: sessionManager,
        ),
        AppRoutes.home,
      );
    });
  });
}
