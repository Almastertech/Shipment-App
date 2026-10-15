/// Prevents duplicate in-flight requests for the same key.
///
/// If an identical request is already running, the same [Future] is returned.
/// On completion or error the entry is automatically cleaned up.
class RequestDeduplicator {
  final Map<String, Future<Object?>> _inFlight = <String, Future<Object?>>{};

  /// Returns the number of currently in-flight deduplicated requests.
  int get activeCount => _inFlight.length;

  /// Executes [request] only if no in-flight request exists for [key].
  ///
  /// If a request with the same [key] is already running, the existing
  /// [Future] is returned (single-flight).
  Future<T> deduplicate<T>(
    String key,
    Future<T> Function() request,
  ) {
    final existing = _inFlight[key];
    if (existing != null) {
      return existing.then((value) => value as T);
    }

    final future = request().whenComplete(() {
      _inFlight.remove(key);
    });

    _inFlight[key] = future;
    return future;
  }

  /// Clears all tracked in-flight requests (does NOT cancel them).
  void clear() {
    _inFlight.clear();
  }
}
