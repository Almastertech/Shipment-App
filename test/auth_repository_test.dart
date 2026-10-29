import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipments/core/device/device_id_service.dart';
import 'package:shipments/core/storage/secure_storage.dart';
import 'package:shipments/data/datasource/remote/auth_data_source.dart';
import 'package:shipments/data/datasource/remote/exception/api_error.dart';
import 'package:shipments/data/model/auth/otp_models.dart';
import 'package:shipments/data/repository/auth_repository.dart';

void main() {
  group('OTP models', () {
    test('serializes a phone signup request with the expected API fields', () {
      const request = OtpRequest(
        phone: '+966501234567',
        channel: 'phone',
      );

      expect(request.toJson(), <String, dynamic>{
        'purpose': 'SIGNUP',
        'phone': '+966501234567',
        'channel': 'phone',
      });
    });

    test('parses the OTP request response values', () {
      final response = OtpRequestResponse.fromJson(<String, dynamic>{
        'channel': 'phone',
        'destination': '+966501234567',
        'expires_at': 1776510120,
        'retry_after_seconds': 60,
      });

      expect(response.channel, 'phone');
      expect(response.destination, '+966501234567');
      expect(response.expiresAt, 1776510120);
      expect(response.retryAfterSeconds, 60);
    });

    test('parses the OTP verification response and account', () {
      final response = OtpVerifyResponse.fromJson(<String, dynamic>{
        'access_token': 'access-token',
        'refresh_token': 'refresh-token',
        'token_type': 'Bearer',
        'expires_in': 900,
        'expires_at': 1776510900,
        'refresh_expires_in': 2592000,
        'refresh_expires_at': 1779102900,
        'account': <String, dynamic>{
          'id': 'account-id',
          'phone': '+966501234567',
          'email': 'customer@example.com',
          'phone_verified_at': <String, dynamic>{},
          'email_verified_at': <String, dynamic>{},
          'status': 'ACTIVE',
        },
      });

      expect(response.accessToken, 'access-token');
      expect(response.refreshToken, 'refresh-token');
      expect(response.expiresIn, 900);
      expect(response.account.id, 'account-id');
      expect(response.account.status, 'ACTIVE');
      expect(response.account.phoneVerifiedAt, isNull);
    });

    test('serializes a six-digit OTP verification request', () {
      const request = OtpVerifyRequest(
        phone: '+966501234567',
        channel: 'phone',
        code: '123456',
      );

      expect(request.toJson(), <String, dynamic>{
        'phone': '+966501234567',
        'channel': 'phone',
        'code': '123456',
      });
    });

    test('returns success when logout completes with no content', () async {
      final dataSource = _FakeAuthDataSource(result: null);
      final repository = AuthRepositoryImpl(dataSource);

      final result = await repository.logout(deviceId: 'device-id');

      expect(result.when(success: (_) => true, failure: (_) => false), isTrue);
      expect(dataSource.lastDeviceId, 'device-id');
    });
  });

  test('DeviceIdService persists and reuses its generated identifier',
      () async {
    final storage = InMemorySecureStorage();
    final service = DeviceIdService(storage);

    final first = await service.getOrCreate();
    final second = await service.getOrCreate();
    final restored = await DeviceIdService(storage).getOrCreate();

    expect(first, second);
    expect(first, restored);
    expect(
      first,
      matches(
        RegExp(
          r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
        ),
      ),
    );
  });

  group('AuthRepositoryImpl', () {
    test('returns a successful OTP result from the data source', () async {
      const expected = OtpRequestResponse(
        channel: 'phone',
        destination: '+966501234567',
        expiresAt: 1776510120,
        retryAfterSeconds: 60,
      );
      final dataSource = _FakeAuthDataSource(result: expected);
      final repository = AuthRepositoryImpl(dataSource);

      final result = await repository.requestOtp(
        channel: 'phone',
        phone: '+966501234567',
      );

      expect(
          result.when(success: (data) => data, failure: (_) => null), expected);
      expect(dataSource.lastChannel, 'phone');
      expect(dataSource.lastPhone, '+966501234567');
    });

    test('maps RFC 7807 OTP failures into ApiError metadata', () async {
      final dataSource = _FakeAuthDataSource(
        error: DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/v1/auth/otp/request'),
          response: Response<dynamic>(
            requestOptions: RequestOptions(path: '/v1/auth/otp/request'),
            statusCode: 400,
            data: <String, dynamic>{
              'type': 'about:blank',
              'title': 'Validation failed',
              'status': 400,
              'detail': 'Phone is required.',
              'instance': '/v1/auth/otp/request',
              'code': 'VALIDATION_FAILED',
              'invalid_params': <Map<String, String>>[
                <String, String>{
                  'name': 'phone',
                  'reason': 'Phone is required.',
                },
              ],
              'correlation_id': 'corr_test',
              'timestamp': '2026-10-28T09:02:07.691Z',
            },
          ),
        ),
      );
      final repository = AuthRepositoryImpl(dataSource);

      final result = await repository.requestOtp(channel: 'phone');

      final error = result.when(
        success: (_) => null,
        failure: (value) => value,
      );
      expect(error, isA<ApiError>());
      expect(error?.type, ApiErrorType.validation);
      expect(error?.code, 'VALIDATION_FAILED');
      expect(error?.correlationId, 'corr_test');
      expect(error?.invalidParams?.single.name, 'phone');
      expect(error?.message, 'Phone is required.');
    });
  });
}

class _FakeAuthDataSource implements AuthDataSource {
  _FakeAuthDataSource({this.result, this.error});

  final OtpRequestResponse? result;
  final Object? error;
  String? lastChannel;
  String? lastPhone;
  String? lastEmail;
  String? lastDeviceId;

  @override
  Future<OtpRequestResponse> requestOtp({
    required String channel,
    String? phone,
    String? email,
  }) async {
    lastChannel = channel;
    lastPhone = phone;
    lastEmail = email;
    final error = this.error;
    if (error != null) throw error;
    return result!;
  }

  @override
  Future<OtpVerifyResponse> verifyOtp({
    required String deviceId,
    required String channel,
    required String code,
    String? phone,
    String? email,
  }) async {
    final error = this.error;
    if (error != null) throw error;
    return const OtpVerifyResponse(
      accessToken: 'access-token',
      refreshToken: 'refresh-token',
      tokenType: 'Bearer',
      expiresIn: 900,
      expiresAt: 1776510900,
      refreshExpiresIn: 2592000,
      refreshExpiresAt: 1779102900,
      account: AuthAccount.empty(),
    );
  }

  @override
  Future<void> logout({required String deviceId}) async {
    lastDeviceId = deviceId;
    final error = this.error;
    if (error != null) throw error;
  }

  @override
  Future<void> deleteAccount({required String idempotencyKey}) async {
    final error = this.error;
    if (error != null) throw error;
  }
}
