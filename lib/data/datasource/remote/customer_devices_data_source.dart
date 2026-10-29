import 'package:dio/dio.dart';

import '../../app_urls/app_url.dart';
import 'dio/dio_client.dart';

/// Sends device-token registration and revocation requests to the API.
class CustomerDevicesDataSource {
  /// Creates the data source using the shared authenticated client.
  CustomerDevicesDataSource(this._client);

  final DioClient _client;

  /// Registers a customer push token for the given installation.
  Future<void> register({
    required String deviceId,
    required String pushToken,
    required String platform,
    required String appVersion,
  }) async {
    await _client.post(
      AppUrl.customerDevices,
      data: <String, dynamic>{
        'push_token': pushToken,
        'platform': platform,
        'app_version': appVersion,
      },
      options: Options(
        headers: <String, String>{'X-Device-Id': deviceId},
      ),
    );
  }

  /// Removes the current installation from the authenticated customer.
  Future<void> revokeCurrent({required String deviceId}) async {
    await _client.delete(
      AppUrl.currentCustomerDevice,
      options: Options(
        headers: <String, String>{'X-Device-Id': deviceId},
      ),
    );
  }
}
