abstract interface class CustomerDeviceApi {
  /// Registers the push token for the authenticated customer device.
  Future<void> registerDevice({
    required String deviceId,
    required String pushToken,
    required String platform,
    required String appVersion,
  });

  /// Revokes the current device from the authenticated customer account.
  Future<void> revokeCurrentDevice({required String deviceId});
}
