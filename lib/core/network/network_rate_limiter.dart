import 'dart:collection';

class NetworkRateLimiter {
  NetworkRateLimiter({
    required this.maxRequests,
    required this.window,
    this.maxTrackedKeys = 1000,
  });

  final int maxRequests;
  final Duration window;
  final int maxTrackedKeys;

  final Map<String, Queue<DateTime>> _history = <String, Queue<DateTime>>{};
  final Queue<String> _keyInsertionOrder = Queue<String>();

  bool isAllowed(String key, {DateTime? now}) {
    final current = now ?? DateTime.now();
    final queue = _queueForKey(key);

    _trimExpired(queue, current);

    if (queue.length >= maxRequests) {
      return false;
    }

    queue.addLast(current);
    return true;
  }

  Duration? retryAfter(String key, {DateTime? now}) {
    final current = now ?? DateTime.now();
    final queue = _history[key];
    if (queue == null || queue.isEmpty) {
      return null;
    }

    _trimExpired(queue, current);
    if (queue.isEmpty) {
      _removeKey(key);
      return null;
    }
    if (queue.length < maxRequests) {
      return null;
    }

    final oldest = queue.first;
    final elapsed = current.difference(oldest);
    final remaining = window - elapsed;
    if (remaining.isNegative) {
      return Duration.zero;
    }
    return remaining;
  }

  void clear([String? key]) {
    if (key == null) {
      _history.clear();
      _keyInsertionOrder.clear();
      return;
    }

    _history.remove(key);
    _keyInsertionOrder.remove(key);
  }

  int trackedKeysCount() => _history.length;

  Queue<DateTime> _queueForKey(String key) {
    final existing = _history[key];
    if (existing != null) {
      return existing;
    }

    final queue = Queue<DateTime>();
    _history[key] = queue;
    _keyInsertionOrder.addLast(key);
    _enforceMaxTrackedKeys();
    return queue;
  }

  void _enforceMaxTrackedKeys() {
    if (_history.length <= maxTrackedKeys) {
      return;
    }

    while (_history.length > maxTrackedKeys && _keyInsertionOrder.isNotEmpty) {
      final oldestKey = _keyInsertionOrder.removeFirst();
      _history.remove(oldestKey);
    }
  }

  void _removeKey(String key) {
    _history.remove(key);
    _keyInsertionOrder.remove(key);
  }

  void _trimExpired(Queue<DateTime> queue, DateTime now) {
    while (queue.isNotEmpty && now.difference(queue.first) >= window) {
      queue.removeFirst();
    }
  }
}
