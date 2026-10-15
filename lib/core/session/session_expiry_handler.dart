import 'package:go_router/go_router.dart';

import '../routing/app_routes.dart';

abstract class SessionExpiryHandler {
  Future<void> onSessionExpired();
}

class NoopSessionExpiryHandler implements SessionExpiryHandler {
  @override
  Future<void> onSessionExpired() async {}
}

class NavigationSessionExpiryHandler implements SessionExpiryHandler {
  NavigationSessionExpiryHandler({
    required GoRouter router,
    this.loginRoute = AppRoutes.login,
  }) : _router = router;

  final GoRouter _router;
  final String loginRoute;

  bool _isHandling = false;

  @override
  Future<void> onSessionExpired() async {
    if (_isHandling) return;

    _isHandling = true;
    try {
      _router.go(loginRoute);
    } finally {
      _isHandling = false;
    }
  }
}
