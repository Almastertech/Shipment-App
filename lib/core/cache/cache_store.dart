import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// A timestamped cache entry with TTL support.
class CacheEntry<T> {
  CacheEntry({required this.data, required this.timestamp});

  final T data;
  final DateTime timestamp;

  bool isExpired(Duration ttl) {
    return DateTime.now().difference(timestamp) > ttl;
  }
}

/// Abstract cache store with generic get/put/invalidate.
abstract class CacheStore {
  CacheEntry<String>? get(String key);
  void put(String key, String value);
  void invalidate(String key);
  void clear();
}

/// In-memory cache backed by a simple [Map].
class MemoryCacheStore implements CacheStore {
  MemoryCacheStore({this.maxEntries = 200}) : assert(maxEntries > 0);

  final int maxEntries;
  final Map<String, CacheEntry<String>> _store = <String, CacheEntry<String>>{};

  @override
  CacheEntry<String>? get(String key) => _store[key];

  @override
  void put(String key, String value) {
    _store.remove(key);
    _store[key] = CacheEntry<String>(
      data: value,
      timestamp: DateTime.now(),
    );
    _trimIfNeeded();
  }

  @override
  void invalidate(String key) {
    _store.remove(key);
  }

  @override
  void clear() {
    _store.clear();
  }

  void _trimIfNeeded() {
    while (_store.length > maxEntries) {
      final oldestKey = _store.keys.first;
      _store.remove(oldestKey);
    }
  }
}

/// Persistent cache backed by [SharedPreferences].
///
/// Stores JSON-encoded values with a `_ts:` timestamp prefix.
/// Do NOT use for sensitive data (tokens, passwords, etc.).
class PrefsCacheStore implements CacheStore {
  PrefsCacheStore(this._prefs, {this.prefix = 'cache_'});

  final SharedPreferences _prefs;
  final String prefix;

  static const String _separator = '|';

  String _prefixedKey(String key) => '$prefix$key';

  @override
  CacheEntry<String>? get(String key) {
    final raw = _prefs.getString(_prefixedKey(key));
    if (raw == null) return null;

    final separatorIndex = raw.indexOf(_separator);
    if (separatorIndex == -1) return null;

    final timestampStr = raw.substring(0, separatorIndex);
    final data = raw.substring(separatorIndex + 1);
    final timestamp = DateTime.tryParse(timestampStr) ??
        DateTime.fromMillisecondsSinceEpoch(0);

    return CacheEntry<String>(data: data, timestamp: timestamp);
  }

  @override
  void put(String key, String value) {
    final encoded = '${DateTime.now().toIso8601String()}$_separator$value';
    _prefs.setString(_prefixedKey(key), encoded);
  }

  @override
  void invalidate(String key) {
    _prefs.remove(_prefixedKey(key));
  }

  @override
  void clear() {
    final keys = _prefs
        .getKeys()
        .where((k) => k.startsWith(prefix))
        .toList(growable: false);
    for (final k in keys) {
      _prefs.remove(k);
    }
  }
}

/// Helper to encode/decode list data for cache storage.
class CacheCodec {
  static String encodeList<T>(
    List<T> items,
    Map<String, dynamic> Function(T) toJson,
  ) {
    return jsonEncode(items.map(toJson).toList(growable: false));
  }

  static List<T> decodeList<T>(
    String raw,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .whereType<Map<String, dynamic>>()
        .map(fromJson)
        .toList(growable: false);
  }
}
