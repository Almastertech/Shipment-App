import 'package:shipments/core/cache/cache_store.dart';
import 'package:shipments/core/search/search_history_service.dart';
import 'package:shipments/core/session/session_manager.dart';
import 'package:shipments/core/session/session_scoped_data_purger.dart';
import 'package:shipments/core/storage/local_storage.dart';
import 'package:shipments/core/storage/secure_storage.dart';
import 'package:shipments/core/utils/app_constants.dart';
import 'package:shipments/features/notifications/application/in_app_notification_center.dart';
import 'package:shipments/features/notifications/domain/in_app_notification.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SessionScopedDataPurger', () {
    test('clearTokens purges user-scoped data and preserves app-scoped values',
        () async {
      final storage = _MemoryLocalStorage();
      await storage.setString(AppConstants.themeModeStorageKey, 'dark');
      await storage.setString(AppConstants.localeStorageKey, 'ar');

      final searchHistoryService = SearchHistoryService(
        storage: storage,
        queryStorageKey: AppConstants.searchHistoryStorageKey,
        recentItemStorageKey: AppConstants.recentViewedItemsStorageKey,
      );
      await searchHistoryService.initialize();
      await searchHistoryService.addQuery('pizza');
      await searchHistoryService.addRecentItem('42');

      final notificationCenter = InAppNotificationCenter(
        storage: storage,
        storageKey: AppConstants.inAppNotificationsStorageKey,
      );
      await notificationCenter.initialize();
      await notificationCenter.push(
        InAppNotification.create(
          title: 't',
          message: 'm',
        ),
      );

      final cacheStore = MemoryCacheStore();
      cacheStore.put('user_data', '{"id":"u1"}');

      final purger = CompositeSessionScopedDataPurger(
        stopBackgroundWork: () async {},
        asyncTasks: <AsyncPurgeTask>[
          () async {
            await searchHistoryService.clearQueries();
            await searchHistoryService.clearRecentItems();
          },
          notificationCenter.clear,
        ],
        syncTasks: <SyncPurgeTask>[
          cacheStore.clear,
        ],
        resumeBackgroundWork: () async {},
      );

      final sessionManager = SessionManager(
        secureStorage: InMemorySecureStorage(),
        sessionScopedDataPurger: purger,
      );
      await sessionManager.saveTokens(
        accessToken: 'access_1',
        refreshToken: 'refresh_1',
      );

      await sessionManager.clearTokens();

      expect(await sessionManager.getAccessToken(), isNull);
      expect(await sessionManager.getRefreshToken(), isNull);
      expect(searchHistoryService.queries, isEmpty);
      expect(searchHistoryService.recentItemIds, isEmpty);
      expect(notificationCenter.items, isEmpty);
      expect(cacheStore.get('user_data'), isNull);

      expect(
        storage.getString(AppConstants.themeModeStorageKey),
        'dark',
      );
      expect(
        storage.getString(AppConstants.localeStorageKey),
        'ar',
      );
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
