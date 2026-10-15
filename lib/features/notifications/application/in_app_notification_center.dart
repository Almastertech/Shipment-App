import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../core/storage/local_storage.dart';
import '../domain/in_app_notification.dart';

class InAppNotificationCenter extends ChangeNotifier {
  InAppNotificationCenter({
    required LocalStorage storage,
    required String storageKey,
    this.maxItems = 100,
  })  : _storage = storage,
        _storageKey = storageKey,
        assert(maxItems > 0);

  final LocalStorage _storage;
  final String _storageKey;
  final int maxItems;

  final List<InAppNotification> _items = <InAppNotification>[];

  List<InAppNotification> get items =>
      List<InAppNotification>.unmodifiable(_items);

  int get unreadCount => _items.where((item) => !item.isRead).length;

  Future<void> initialize() async {
    final raw = _storage.getString(_storageKey);
    if (raw == null || raw.isEmpty) {
      return;
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List<dynamic>) {
        return;
      }
      _items
        ..clear()
        ..addAll(
          decoded
              .whereType<Map<String, dynamic>>()
              .map(InAppNotification.fromJson)
              .toList(growable: false),
        );
      _trimToMax();
      notifyListeners();
    } on Object {
      // Ignore malformed cache.
    }
  }

  Future<void> push(InAppNotification notification) async {
    _items.insert(0, notification);
    _trimToMax();
    await _persist();
    notifyListeners();
  }

  Future<void> markRead(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    if (index == -1) return;

    final existing = _items[index];
    if (existing.isRead) return;

    _items[index] = existing.copyWith(isRead: true);
    await _persist();
    notifyListeners();
  }

  Future<void> markAllRead() async {
    var changed = false;
    for (var i = 0; i < _items.length; i++) {
      final item = _items[i];
      if (!item.isRead) {
        _items[i] = item.copyWith(isRead: true);
        changed = true;
      }
    }

    if (!changed) return;

    await _persist();
    notifyListeners();
  }

  Future<void> clear() async {
    _items.clear();
    await _persist();
    notifyListeners();
  }

  Future<void> _persist() {
    final encoded = jsonEncode(
      _items.map((item) => item.toJson()).toList(growable: false),
    );
    return _storage.setString(_storageKey, encoded);
  }

  void _trimToMax() {
    if (_items.length <= maxItems) {
      return;
    }
    _items.removeRange(maxItems, _items.length);
  }
}
