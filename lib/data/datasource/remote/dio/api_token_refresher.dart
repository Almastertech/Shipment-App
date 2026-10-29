import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/device/device_id_service.dart';
import '../../../app_urls/app_url.dart';
import 'auth_interceptor.dart';

class ApiTokenRefresher implements TokenRefresher {
  ApiTokenRefresher({
    required Dio dio,
    required DeviceIdService deviceIdService,
  })  : _dio = dio,
        _deviceIdService = deviceIdService;

  final Dio _dio;
  final DeviceIdService _deviceIdService;

  @override
  Future<TokenRefreshResult?> refreshToken(String refreshToken) async {
    final deviceId = await _deviceIdService.getOrCreate();
    final response = await _dio.post<dynamic>(
      AppUrl.refreshToken,
      data: jsonEncode(<String, dynamic>{
        'principal_type': 'CUSTOMER',
        'refresh_token': refreshToken,
      }),
      options: Options(
        contentType: 'application/json',
        headers: <String, String>{'x-device-id': deviceId},
        extra: <String, dynamic>{
          'isRefreshCall': true,
          'requiresAuth': false,
          'retryable': false,
          'skipRateLimit': true,
        },
      ),
    );

    final body = response.data as Map<String, dynamic>? ?? <String, dynamic>{};
    final payload = body['data'] as Map<String, dynamic>? ?? body;

    final rawAccessToken = payload['access_token'] ?? payload['accessToken'];
    final accessToken = rawAccessToken?.toString().trim() ?? '';
    if (accessToken.isEmpty) {
      return null;
    }

    final rawRefreshToken = payload['refresh_token'] ?? payload['refreshToken'];
    final nextRefreshToken = rawRefreshToken?.toString().trim();

    return TokenRefreshResult(
      accessToken: accessToken,
      refreshToken:
          (nextRefreshToken?.isNotEmpty ?? false) ? nextRefreshToken : null,
    );
  }
}
