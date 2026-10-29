import 'package:flutter/foundation.dart';
import '../../data/datasource/remote/exception/api_error.dart';
import '../../data/model/customer_activity.dart';
import '../../data/model/response/base/api_response.dart';
import '../../data/repository/customer_activity_repository.dart';

class ActivityViewModel extends ChangeNotifier {
  ActivityViewModel(this._repository);
  final CustomerActivityRepository _repository;
  List<CustomerActivity> items = [];
  String type = 'all';
  String? nextCursor;
  bool hasMore = false;
  bool loading = false;
  bool loadingMore = false;
  ApiError? error;
  int _generation = 0;
  bool _disposed = false;

  Future<void> selectType(String value) async {
    if (value == type && (loading || items.isNotEmpty)) return;
    type = value;
    await load();
  }

  Future<void> load() async {
    final generation = ++_generation;
    loading = true;
    loadingMore = false;
    items = [];
    nextCursor = null;
    hasMore = false;
    error = null;
    notifyListeners();
    final result = await _repository.fetch(type: type);
    if (_disposed || generation != _generation) return;
    if (result is ApiSuccess<CustomerActivityPage>) {
      items = result.data.items;
      hasMore = result.data.hasMore;
      nextCursor = result.data.nextCursor;
    } else if (result is ApiFailure<CustomerActivityPage>) {
      error = result.error;
    }
    loading = false;
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (loading || loadingMore || !hasMore || nextCursor == null) return;
    final generation = _generation;
    final cursor = nextCursor!;
    loadingMore = true;
    error = null;
    notifyListeners();
    final result = await _repository.fetch(type: type, cursor: cursor);
    if (_disposed || generation != _generation) return;
    if (result is ApiSuccess<CustomerActivityPage>) {
      final ids = items.map((item) => item.id).toSet();
      items = [
        ...items,
        ...result.data.items.where((item) => ids.add(item.id))
      ];
      hasMore = result.data.hasMore;
      nextCursor = result.data.nextCursor;
    } else if (result is ApiFailure<CustomerActivityPage>) {
      error = result.error;
    }
    loadingMore = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
