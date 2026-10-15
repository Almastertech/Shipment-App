import 'package:shipments/core/cache/cache_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MemoryCacheStore', () {
    late MemoryCacheStore cache;

    setUp(() {
      cache = MemoryCacheStore();
    });

    test('put and get return cached value', () {
      cache.put('key1', '{"value": 1}');
      final entry = cache.get('key1');

      expect(entry, isNotNull);
      expect(entry!.data, '{"value": 1}');
    });

    test('get returns null for missing key', () {
      expect(cache.get('nonexistent'), isNull);
    });

    test('invalidate removes specific key', () {
      cache.put('key1', 'data1');
      cache.put('key2', 'data2');
      cache.invalidate('key1');

      expect(cache.get('key1'), isNull);
      expect(cache.get('key2'), isNotNull);
    });

    test('clear removes all entries', () {
      cache.put('key1', 'data1');
      cache.put('key2', 'data2');
      cache.clear();

      expect(cache.get('key1'), isNull);
      expect(cache.get('key2'), isNull);
    });

    test('isExpired returns true when TTL exceeded', () async {
      cache.put('key1', 'data');
      // Wait a tiny bit to get a non-zero age
      await Future<void>.delayed(const Duration(milliseconds: 20));

      final entry = cache.get('key1')!;
      expect(entry.isExpired(const Duration(milliseconds: 1)), isTrue);
      expect(entry.isExpired(const Duration(hours: 1)), isFalse);
    });

    test('evicts oldest entries when max capacity is exceeded', () {
      final bounded = MemoryCacheStore(maxEntries: 2);
      bounded.put('k1', '1');
      bounded.put('k2', '2');
      bounded.put('k3', '3');

      expect(bounded.get('k1'), isNull);
      expect(bounded.get('k2')?.data, '2');
      expect(bounded.get('k3')?.data, '3');
    });
  });

  group('CacheCodec', () {
    test('encodeList and decodeList round-trip', () {
      final items = <Map<String, dynamic>>[
        <String, dynamic>{'id': '1', 'name': 'First'},
        <String, dynamic>{'id': '2', 'name': 'Second'},
      ];

      final encoded = CacheCodec.encodeList<Map<String, dynamic>>(
        items,
        (item) => item,
      );

      final decoded = CacheCodec.decodeList<Map<String, dynamic>>(
        encoded,
        (json) => json,
      );

      expect(decoded.length, 2);
      expect(decoded[0]['id'], '1');
      expect(decoded[1]['name'], 'Second');
    });
  });
}
