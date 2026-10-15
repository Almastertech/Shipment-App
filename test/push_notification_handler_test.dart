import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shipments/core/push/push_message.dart';
import 'package:shipments/core/push/push_notification_handler.dart';
import 'package:shipments/core/push/push_notification_service.dart';
import 'package:shipments/core/storage/local_storage.dart';
import 'package:shipments/features/notifications/application/in_app_notification_center.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PushNotificationHandler', () {
    late _FakePushService pushService;
    late InAppNotificationCenter notificationCenter;
    late List<String> navigated;

    setUp(() async {
      pushService = _FakePushService();
      notificationCenter = InAppNotificationCenter(
        storage: _MemoryLocalStorage(),
        storageKey: 'notification_key',
      );
      await notificationCenter.initialize();
      navigated = <String>[];
    });

    test('received message is added to local notification center', () async {
      final handler = PushNotificationHandler(
        service: pushService,
        router: _router,
        notificationCenter: notificationCenter,
      );
      await handler.initialize();

      pushService.emitReceived(
        PushMessage(
          id: 'm1',
          title: 'Welcome',
          body: 'Body',
          sentAt: DateTime(2026, 1, 1),
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 1));

      expect(notificationCenter.items.length, 1);
      expect(notificationCenter.items.first.title, 'Welcome');
    });

    test('opened message navigates through guard resolver', () async {
      final handler = PushNotificationHandler(
        service: pushService,
        router: _router,
        notificationCenter: notificationCenter,
        navigateTo: navigated.add,
        isKnownRoute: (_) => true,
        resolveGuardedRoute: (route) => '$route?guarded=1',
      );
      await handler.initialize();

      pushService.emitOpened(
        PushMessage(
          id: 'm2',
          title: 'Open',
          body: 'Body',
          sentAt: DateTime(2026, 1, 1),
          data: <String, String>{'route': '/sample/1'},
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 1));

      expect(navigated, contains('/sample/1?guarded=1'));
    });

    test('unknown route is ignored', () async {
      final handler = PushNotificationHandler(
        service: pushService,
        router: _router,
        notificationCenter: notificationCenter,
        navigateTo: navigated.add,
        isKnownRoute: (_) => false,
      );
      await handler.initialize();

      pushService.emitOpened(
        PushMessage(
          id: 'm3',
          title: 'Unknown',
          body: 'Body',
          sentAt: DateTime(2026, 1, 1),
          data: <String, String>{'route': '/unknown'},
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 1));

      expect(navigated, isEmpty);
    });

    test('initialize can retry after service init failure', () async {
      final flakyService = _FlakyPushService();
      final handler = PushNotificationHandler(
        service: flakyService,
        router: _router,
        notificationCenter: notificationCenter,
      );

      await expectLater(handler.initialize(), throwsException);
      await expectLater(handler.initialize(), completes);
    });
  });
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(path: '/', builder: (_, __) => const SizedBox.shrink()),
  ],
);

class _FakePushService implements PushNotificationService {
  final StreamController<PushMessage> _received =
      StreamController<PushMessage>.broadcast();
  final StreamController<PushMessage> _opened =
      StreamController<PushMessage>.broadcast();

  @override
  Future<String?> getDeviceToken() async => 'token';

  @override
  Future<void> initialize() async {}

  @override
  Stream<PushMessage> get onMessageOpenedApp => _opened.stream;

  @override
  Stream<PushMessage> get onMessageReceived => _received.stream;

  @override
  Future<void> subscribeToTopic(String topic) async {}

  @override
  Future<void> unsubscribeFromTopic(String topic) async {}

  void emitOpened(PushMessage message) => _opened.add(message);

  void emitReceived(PushMessage message) => _received.add(message);
}

class _FlakyPushService extends _FakePushService {
  bool _failedOnce = false;

  @override
  Future<void> initialize() async {
    if (!_failedOnce) {
      _failedOnce = true;
      throw Exception('init failed once');
    }
  }
}

class _MemoryLocalStorage implements LocalStorage {
  final Map<String, Object> _data = <String, Object>{};

  @override
  Future<bool> clear() async {
    _data.clear();
    return true;
  }

  @override
  bool? getBool(String key) => _data[key] as bool?;

  @override
  int? getInt(String key) => _data[key] as int?;

  @override
  String? getString(String key) => _data[key] as String?;

  @override
  Future<bool> remove(String key) async {
    _data.remove(key);
    return true;
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    _data[key] = value;
    return true;
  }

  @override
  Future<bool> setInt(String key, int value) async {
    _data[key] = value;
    return true;
  }

  @override
  Future<bool> setString(String key, String value) async {
    _data[key] = value;
    return true;
  }
}
