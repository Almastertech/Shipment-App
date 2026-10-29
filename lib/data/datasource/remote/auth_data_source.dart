import 'dart:convert';

import 'package:dio/dio.dart';

import '../../app_urls/app_url.dart';
import '../../model/auth/otp_models.dart';
import 'dio/dio_client.dart';

abstract class AuthDataSource {
  Future<OtpRequestResponse> requestOtp({
    required String channel,
    String? phone,
    String? email,
  });

  Future<OtpVerifyResponse> verifyOtp({
    required String deviceId,
    required String channel,
    required String code,
    String? phone,
    String? email,
  });

  Future<void> logout({required String deviceId});

  Future<void> deleteAccount({required String idempotencyKey});
}

class NetworkAuthDataSource implements AuthDataSource {
  NetworkAuthDataSource(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<OtpRequestResponse> requestOtp({
    required String channel,
    String? phone,
    String? email,
  }) async {
    final request = OtpRequest(
      phone: phone,
      email: email,
      channel: channel,
    );
    final response = await _dioClient.post(
      AppUrl.requestOtp,
      data: jsonEncode(request.toJson()),
      options: Options(
        contentType: 'application/json',
        extra: <String, dynamic>{'requiresAuth': false},
      ),
    );

    final body = response.data is Map
        ? Map<String, dynamic>.from(response.data as Map)
        : <String, dynamic>{};
    final rawData = body['data'];
    if (rawData is! Map) {
      throw const FormatException('OTP response data is missing.');
    }

    return OtpRequestResponse.fromJson(
      Map<String, dynamic>.from(rawData),
    );
  }

  @override
  Future<OtpVerifyResponse> verifyOtp({
    required String deviceId,
    required String channel,
    required String code,
    String? phone,
    String? email,
  }) async {
    final request = OtpVerifyRequest(
      phone: phone,
      email: email,
      channel: channel,
      code: code,
    );
    final response = await _dioClient.post(
      AppUrl.verifyOtp,
      data: jsonEncode(request.toJson()),
      options: Options(
        contentType: 'application/json',
        headers: <String, String>{'x-device-id': deviceId},
        extra: <String, dynamic>{'requiresAuth': false},
      ),
    );

    final body = response.data is Map
        ? Map<String, dynamic>.from(response.data as Map)
        : <String, dynamic>{};
    final rawData = body['data'];
    if (rawData is! Map) {
      throw const FormatException('OTP verification response data is missing.');
    }

    return OtpVerifyResponse.fromJson(
      Map<String, dynamic>.from(rawData),
    );
  }

  @override
  Future<void> logout({required String deviceId}) async {
    await _dioClient.post(
      AppUrl.logout,
      options: Options(
        headers: <String, String>{'x-device-id': deviceId},
      ),
    );
  }

  @override
  Future<void> deleteAccount({required String idempotencyKey}) async {
    await _dioClient.delete(
      AppUrl.customerAccount,
      options: Options(
        headers: <String, String>{'Idempotency-Key': idempotencyKey},
        extra: <String, dynamic>{'retryable': true},
      ),
    );
  }
}
