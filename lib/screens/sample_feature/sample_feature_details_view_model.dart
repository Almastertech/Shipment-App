import 'package:flutter/foundation.dart';

import '../../data/datasource/remote/exception/api_error.dart';
import '../../data/model/sample_item.dart';
import '../../data/repository/sample_feature_repo.dart';

class SampleFeatureDetailsViewModel extends ChangeNotifier {
  SampleFeatureDetailsViewModel({
    required SampleFeatureRepository repository,
    required String itemId,
  })  : _repository = repository,
        _itemId = itemId;

  final SampleFeatureRepository _repository;
  final String _itemId;

  SampleItem? _item;
  ApiError? _error;
  bool _isLoading = true;
  bool _disposed = false;

  SampleItem? get item => _item;
  ApiError? get error => _error;
  bool get isLoading => _isLoading;
  String get itemId => _itemId;

  Future<void> load() async {
    _isLoading = true;
    _error = null;
    _notifySafely();

    final result = await _repository.findItemById(_itemId);

    result.when(
      success: (item) {
        _item = item;
        _error = null;
      },
      failure: (error) {
        _item = null;
        _error = error;
      },
    );

    _isLoading = false;
    _notifySafely();
  }

  void _notifySafely() {
    if (_disposed) return;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
