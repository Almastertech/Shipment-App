import 'package:flutter/foundation.dart';

import '../../data/datasource/remote/exception/api_error.dart';
import '../../data/model/customer_home.dart';
import '../../data/model/response/base/api_response.dart';
import '../../data/repository/customer_home_repository.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._repository);

  final CustomerHomeRepository _repository;
  CustomerHome? home;
  ApiError? error;
  bool loading = false;
  bool _disposed = false;

  Future<void> load() async {
    if (loading || _disposed) return;
    loading = true;
    error = null;
    notifyListeners();
    final result = await _repository.fetch();
    if (_disposed) return;
    if (result case ApiSuccess<CustomerHome>(:final data)) {
      home = data;
    } else if (result case ApiFailure<CustomerHome>(:final error)) {
      this.error = error;
    }
    loading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
