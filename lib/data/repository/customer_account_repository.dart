import '../datasource/remote/customer_account_data_source.dart';
import '../model/customer_account.dart';
import '../model/auth/otp_models.dart';
import '../model/response/base/api_response.dart';
import 'base_repository.dart';

class CustomerAccountRepository extends BaseRepository {
  CustomerAccountRepository(this._source);
  final CustomerAccountDataSource _source;

  Future<ApiResult<CustomerAccount>> fetchAccount() =>
      guard<CustomerAccount>(_source.fetchAccount);

  Future<ApiResult<OtpRequestResponse>> requestPhoneChange(String phone) =>
      guard(() => _source.requestPhoneChange(phone));

  Future<ApiResult<String>> verifyPhoneChange(
          {required String phone, required String code}) =>
      guard(() => _source.verifyPhoneChange(phone: phone, code: code));

  Future<ApiResult<CustomerAccount>> updateAccount({
    required String fullName,
    String? email,
    required String preferredLanguage,
  }) =>
      guard<CustomerAccount>(
        () => _source.updateAccount(
          fullName: fullName,
          email: email,
          preferredLanguage: preferredLanguage,
        ),
      );
}
