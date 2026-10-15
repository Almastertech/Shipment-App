import 'dart:convert';

import '../storage/local_storage.dart';

class SearchHistoryService {
  SearchHistoryService({
    required LocalStorage storage,
    required this.queryStorageKey,
    required this.recentItemStorageKey,
    this.maxItems = 10,
  }) : _storage = storage;

  final LocalStorage _storage;
  final String queryStorageKey;
  final String recentItemStorageKey;
  final int maxItems;

  final List<String> _queries = <String>[];
  final List<String> _recentItemIds = <String>[];

  List<String> get queries => List<String>.unmodifiable(_queries);
  List<String> get recentItemIds => List<String>.unmodifiable(_recentItemIds);

  Future<void> initialize() async {
    _queries
      ..clear()
      ..addAll(_readList(queryStorageKey));

    _recentItemIds
      ..clear()
      ..addAll(_readList(recentItemStorageKey));
  }

  Future<void> addQuery(String query) async {
    final normalized = query.trim();
    if (normalized.isEmpty) {
      return;
    }

    _upsert(_queries, normalized);
    await _persist(queryStorageKey, _queries);
  }

  Future<void> addRecentItem(String itemId) async {
    final normalized = itemId.trim();
    if (normalized.isEmpty) {
      return;
    }

    _upsert(_recentItemIds, normalized);
    await _persist(recentItemStorageKey, _recentItemIds);
  }

  Future<void> clearQueries() async {
    _queries.clear();
    await _persist(queryStorageKey, _queries);
  }

  Future<void> clearRecentItems() async {
    _recentItemIds.clear();
    await _persist(recentItemStorageKey, _recentItemIds);
  }

  void _upsert(List<String> target, String value) {
    target.remove(value);
    target.insert(0, value);

    if (target.length > maxItems) {
      target.removeRange(maxItems, target.length);
    }
  }

  List<String> _readList(String key) {
    final raw = _storage.getString(key);
    if (raw == null || raw.isEmpty) {
      return <String>[];
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List<dynamic>) {
        return <String>[];
      }

      return decoded.map((e) => e.toString()).where((e) => e.isNotEmpty).toList(
            growable: false,
          );
    } on Object {
      return <String>[];
    }
  }

  Future<void> _persist(String key, List<String> values) {
    return _storage.setString(key, jsonEncode(values));
  }
}
