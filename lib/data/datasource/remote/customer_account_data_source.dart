import '../../app_urls/app_url.dart';
import '../../model/customer_account.dart';
import '../../model/auth/otp_models.dart';
import 'dio/dio_client.dart';

class CustomerAccountDataSource {
  CustomerAccountDataSource(this._client);
  final DioClient _client;

  Future<CustomerAccount> fetchAccount() async {
    final response = await _client.get(AppUrl.customerAccount);
    return _parseAccount(response.data);
  }

  Future<CustomerAccount> updateAccount({
    required String fullName,
    String? email,
    required String preferredLanguage,
  }) async {
    final response = await _client.patch(
      AppUrl.customerAccount,
      data: <String, dynamic>{
        'full_name': fullName,
        if (email != null) 'email': email,
        'preferred_language': preferredLanguage,
      },
    );
    return _parseAccount(response.data);
  }

  Future<OtpRequestResponse> requestPhoneChange(String phone) async {
    final response = await _client.post(
      '${AppUrl.customerAccount}/phone/change',
      data: <String, dynamic>{'phone': phone},
    );
    final body = response.data;
    if (body is! Map || body['data'] is! Map) {
      throw const FormatException('Phone change response data is missing.');
    }
    final challenge = OtpRequestResponse.fromJson(
      Map<String, dynamic>.from(body['data'] as Map),
    );
    if (challenge.channel != 'phone' || challenge.destination.isEmpty) {
      throw const FormatException('Phone change destination is missing.');
    }
    return challenge;
  }

  Future<String> verifyPhoneChange(
      {required String phone, required String code}) async {
    final response = await _client.post(
      '${AppUrl.customerAccount}/phone/verify',
      data: <String, dynamic>{'phone': phone, 'code': code},
    );
    final body = response.data;
    final data = body is Map ? body['data'] : null;
    final verifiedPhone = data is Map ? data['phone'] : null;
    if (verifiedPhone is! String || verifiedPhone.isEmpty) {
      throw const FormatException('Verified phone is missing.');
    }
    return verifiedPhone;
  }

  CustomerAccount _parseAccount(dynamic body) {
    if (body is! Map || body['data'] is! Map) {
      throw const FormatException('Customer account response data is missing.');
    }
    return CustomerAccount.fromJson(
      Map<String, dynamic>.from(body['data'] as Map),
    );
  }
}
