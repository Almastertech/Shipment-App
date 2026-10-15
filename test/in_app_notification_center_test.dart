import 'package:shipments/core/storage/local_storage.dart';
import 'package:shipments/features/notifications/application/in_app_notification_center.dart';
import 'package:shipments/features/notifications/domain/in_app_notification.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InAppNotificationCenter', () {
    late _MemoryLocalStorage storage;

    setUp(() {
      storage = _MemoryLocalStorage();
    });

    test('push increments unread count', () async {
      final center = InAppNotificationCenter(
        storage: storage,
        storageKey: 'notifications_key',
      );
      await center.initialize();

      await center.push(
        InAppNotification.create(
          title: 'Test',
          message: 'Message',
        ),
      );

      expect(center.items.length, 1);
      expect(center.unreadCount, 1);
    });

    test('markRead and markAllRead update unread count', () async {
      final center = InAppNotificationCenter(
        storage: storage,
        storageKey: 'notifications_key',
      );
      await center.initialize();

      await center.push(
        InAppNotification.create(title: '1', message: 'm1'),
      );
      await center.push(
        InAppNotification.create(title: '2', message: 'm2'),
      );

      final firstId = center.items.first.id;
      await center.markRead(firstId);
      expect(center.unreadCount, 1);

      await center.markAllRead();
      expect(center.unreadCount, 0);
    });

    test('persists notifications across instances', () async {
      final center = InAppNotificationCenter(
        storage: storage,
        storageKey: 'notifications_key',
      );
      await center.initialize();

      await center.push(
        InAppNotification.create(title: 'Persisted', message: 'Body'),
      );

      final reloaded = InAppNotificationCenter(
        storage: storage,
        storageKey: 'notifications_key',
      );
      await reloaded.initialize();

      expect(reloaded.items.length, 1);
      expect(reloaded.items.first.title, 'Persisted');
    });

    test('keeps only latest notifications within maxItems cap', () async {
      final center = InAppNotificationCenter(
        storage: storage,
        storageKey: 'notifications_key',
        maxItems: 2,
      );
      await center.initialize();

      await center.push(
        InAppNotification.create(title: '1', message: 'm1'),
      );
      await center.push(
        InAppNotification.create(title: '2', message: 'm2'),
      );
      await center.push(
        InAppNotification.create(title: '3', message: 'm3'),
      );

      expect(center.items.length, 2);
      expect(center.items.first.title, '3');
      expect(center.items.last.title, '2');
    });
  });
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
