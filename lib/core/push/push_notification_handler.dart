import 'dart:async';

import 'package:go_router/go_router.dart';

import '../../features/notifications/application/in_app_notification_center.dart';
import '../../features/notifications/domain/in_app_notification.dart';
import '../logger.dart';
import '../routing/app_router.dart';
import 'push_message.dart';
import 'push_notification_service.dart';

typedef PushRouteNavigator = void Function(String route);
typedef PushRouteGuardResolver = String Function(String route);
typedef PushKnownRouteChecker = bool Function(String route);

class PushNotificationHandler {
  PushNotificationHandler({
    required PushNotificationService service,
    required GoRouter router,
    required InAppNotificationCenter notificationCenter,
    PushRouteNavigator? navigateTo,
    PushRouteGuardResolver? resolveGuardedRoute,
    PushKnownRouteChecker? isKnownRoute,
  })  : _service = service,
        _router = router,
        _notificationCenter = notificationCenter,
        _navigateTo = navigateTo,
        _resolveGuardedRoute = resolveGuardedRoute,
        _isKnownRoute = isKnownRoute;

  final PushNotificationService _service;
  final GoRouter _router;
  final InAppNotificationCenter _notificationCenter;
  final PushRouteNavigator? _navigateTo;
  final PushRouteGuardResolver? _resolveGuardedRoute;
  final PushKnownRouteChecker? _isKnownRoute;

  StreamSubscription<PushMessage>? _messageSub;
  StreamSubscription<PushMessage>? _openSub;
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) {
      return;
    }
    try {
      await _service.initialize();
      _messageSub = _service.onMessageReceived.listen(_onMessageReceived);
      _openSub = _service.onMessageOpenedApp.listen(_onMessageOpenedApp);
      _initialized = true;
    } on Object {
      _initialized = false;
      rethrow;
    }
  }

  Future<void> _onMessageReceived(PushMessage message) async {
    await _notificationCenter.push(
      InAppNotification.create(
        title: message.title,
        message: message.body,
        type: InAppNotificationType.info,
      ),
    );
  }

  Future<void> _onMessageOpenedApp(PushMessage message) async {
    final route = message.data['route'];
    if (route == null || route.isEmpty) {
      return;
    }

    final knownRouteChecker = _isKnownRoute ?? AppRouter.isKnownRoute;
    if (!knownRouteChecker(route)) {
      AppLogger.warning(
        'Ignored unknown push route: $route',
        category: AppLogCategory.routing,
      );
      return;
    }

    final guardedRouteResolver =
        _resolveGuardedRoute ?? AppRouter.resolveGuardedRoute;
    final guardedRoute = guardedRouteResolver(route);
    final navigator = _navigateTo ?? _router.go;
    navigator(guardedRoute);
  }

  Future<void> dispose() async {
    await _messageSub?.cancel();
    await _openSub?.cancel();
    _messageSub = null;
    _openSub = null;
    _initialized = false;
  }
}
