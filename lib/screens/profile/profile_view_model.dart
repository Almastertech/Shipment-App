import 'package:flutter/foundation.dart';

import '../../data/datasource/remote/exception/api_error.dart';
import '../../data/model/customer_account.dart';
import '../../data/model/auth/otp_models.dart';
import '../../data/model/response/base/api_response.dart';
import '../../data/repository/customer_account_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel(this._repository);
  final CustomerAccountRepository _repository;
  CustomerAccount? account;
  ApiError? error;
  bool loading = false;
  bool saving = false;
  bool _disposed = false;

  Future<void> load() async {
    if (loading) return;
    loading = true;
    error = null;
    notifyListeners();
    final result = await _repository.fetchAccount();
    if (_disposed) return;
    if (result is ApiSuccess<CustomerAccount>) {
      account = result.data;
    } else if (result is ApiFailure<CustomerAccount>) {
      error = result.error;
    }
    loading = false;
    notifyListeners();
  }

  Future<ApiResult<CustomerAccount>> save({
    required String fullName,
    String? email,
    required String preferredLanguage,
  }) async {
    saving = true;
    notifyListeners();
    final result = await _repository.updateAccount(
      fullName: fullName,
      email: email,
      preferredLanguage: preferredLanguage,
    );
    if (!_disposed) {
      if (result is ApiSuccess<CustomerAccount>) account = result.data;
      saving = false;
      notifyListeners();
    }
    return result;
  }

  void updateAccount(CustomerAccount value) {
    account = value;
    notifyListeners();
  }

  Future<ApiResult<OtpRequestResponse>> requestPhoneChange(String phone) =>
      _repository.requestPhoneChange(phone);

  Future<ApiResult<String>> verifyPhoneChange(
          {required String phone, required String code}) =>
      _repository.verifyPhoneChange(phone: phone, code: code);

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
