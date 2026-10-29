import '../datasource/remote/auth_data_source.dart';
import '../model/auth/otp_models.dart';
import '../model/response/base/api_response.dart';
import 'base_repository.dart';

abstract class AuthRepository {
  Future<ApiResult<OtpRequestResponse>> requestOtp({
    required String channel,
    String? phone,
    String? email,
  });

  Future<ApiResult<OtpVerifyResponse>> verifyOtp({
    required String deviceId,
    required String channel,
    required String code,
    String? phone,
    String? email,
  });

  Future<ApiResult<void>> logout({required String deviceId});

  Future<ApiResult<void>> deleteAccount({required String idempotencyKey});
}

class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  AuthRepositoryImpl(this._dataSource);

  final AuthDataSource _dataSource;

  @override
  Future<ApiResult<OtpRequestResponse>> requestOtp({
    required String channel,
    String? phone,
    String? email,
  }) async {
    return guard<OtpRequestResponse>(
      () => _dataSource.requestOtp(
        channel: channel,
        phone: phone,
        email: email,
      ),
    );
  }

  @override
  Future<ApiResult<OtpVerifyResponse>> verifyOtp({
    required String deviceId,
    required String channel,
    required String code,
    String? phone,
    String? email,
  }) async {
    return guard<OtpVerifyResponse>(
      () => _dataSource.verifyOtp(
        deviceId: deviceId,
        channel: channel,
        code: code,
        phone: phone,
        email: email,
      ),
    );
  }

  @override
  Future<ApiResult<void>> logout({required String deviceId}) async {
    return guard<void>(() => _dataSource.logout(deviceId: deviceId));
  }

  @override
  Future<ApiResult<void>> deleteAccount({required String idempotencyKey}) {
    return guard<void>(
      () => _dataSource.deleteAccount(idempotencyKey: idempotencyKey),
    );
  }
}
