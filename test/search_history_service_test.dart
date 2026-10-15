import 'package:shipments/core/search/search_history_service.dart';
import 'package:shipments/core/storage/local_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SearchHistoryService', () {
    late _MemoryLocalStorage storage;
    late SearchHistoryService service;

    setUp(() async {
      storage = _MemoryLocalStorage();
      service = SearchHistoryService(
        storage: storage,
        queryStorageKey: 'queries',
        recentItemStorageKey: 'items',
        maxItems: 3,
      );
      await service.initialize();
    });

    test('stores queries with dedup and max limit', () async {
      await service.addQuery('pizza');
      await service.addQuery('burger');
      await service.addQuery('pizza');
      await service.addQuery('sushi');
      await service.addQuery('salad');

      expect(service.queries, <String>['salad', 'sushi', 'pizza']);
    });

    test('stores recent items with dedup and clear', () async {
      await service.addRecentItem('1');
      await service.addRecentItem('2');
      await service.addRecentItem('1');

      expect(service.recentItemIds, <String>['1', '2']);

      await service.clearRecentItems();
      expect(service.recentItemIds, isEmpty);
    });

    test('persists and reloads values', () async {
      await service.addQuery('noodles');

      final reloaded = SearchHistoryService(
        storage: storage,
        queryStorageKey: 'queries',
        recentItemStorageKey: 'items',
        maxItems: 3,
      );
      await reloaded.initialize();

      expect(reloaded.queries, <String>['noodles']);
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
