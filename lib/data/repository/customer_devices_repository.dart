import '../../core/push/customer_device_api.dart';
import '../datasource/remote/customer_devices_data_source.dart';

/// Implements push-device operations using the remote data source.
class CustomerDevicesRepository implements CustomerDeviceApi {
  /// Creates the repository with its remote data source.
  CustomerDevicesRepository(this._dataSource);

  final CustomerDevicesDataSource _dataSource;

  @override
  Future<void> registerDevice({
    required String deviceId,
    required String pushToken,
    required String platform,
    required String appVersion,
  }) {
    return _dataSource.register(
      deviceId: deviceId,
      pushToken: pushToken,
      platform: platform,
      appVersion: appVersion,
    );
  }

  @override
  Future<void> revokeCurrentDevice({required String deviceId}) {
    return _dataSource.revokeCurrent(deviceId: deviceId);
  }
}
