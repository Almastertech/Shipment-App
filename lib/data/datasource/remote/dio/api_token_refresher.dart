import 'package:dio/dio.dart';

import '../../../app_urls/app_url.dart';
import 'auth_interceptor.dart';

class ApiTokenRefresher implements TokenRefresher {
  ApiTokenRefresher({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<TokenRefreshResult?> refreshToken(String refreshToken) async {
    final response = await _dio.post<dynamic>(
      AppUrl.refreshToken,
      data: <String, dynamic>{'refreshToken': refreshToken},
      options: Options(
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

    final rawAccessToken = payload['accessToken'] ?? payload['access_token'];
    final accessToken = rawAccessToken?.toString().trim() ?? '';
    if (accessToken.isEmpty) {
      return null;
    }

    final rawRefreshToken = payload['refreshToken'] ?? payload['refresh_token'];
    final nextRefreshToken = rawRefreshToken?.toString().trim();

    return TokenRefreshResult(
      accessToken: accessToken,
      refreshToken:
          (nextRefreshToken?.isNotEmpty ?? false) ? nextRefreshToken : null,
    );
  }
}
