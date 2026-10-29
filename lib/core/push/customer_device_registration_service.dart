import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../device/device_id_service.dart';
import '../logger.dart';
import '../session/session_manager.dart';
import 'customer_device_api.dart';
import 'push_notification_service.dart';

typedef AppVersionProvider = Future<String> Function();
typedef PushPlatformProvider = String? Function();

/// Coordinates push-token registration with the customer session lifecycle.
class CustomerDeviceRegistrationService {
  /// Creates a coordinator for device registration and revocation.
  CustomerDeviceRegistrationService({
    required CustomerDeviceApi deviceApi,
    required DeviceIdService deviceIdService,
    required PushNotificationService pushService,
    required SessionManager sessionManager,
    AppVersionProvider? appVersionProvider,
    PushPlatformProvider? platformProvider,
  })  : _deviceApi = deviceApi,
        _deviceIdService = deviceIdService,
        _pushService = pushService,
        _sessionManager = sessionManager,
        _appVersionProvider = appVersionProvider ?? _readAppVersion,
        _platformProvider = platformProvider ?? _resolvePlatform;

  final CustomerDeviceApi _deviceApi;
  final DeviceIdService _deviceIdService;
  final PushNotificationService _pushService;
  final SessionManager _sessionManager;
  final AppVersionProvider _appVersionProvider;
  final PushPlatformProvider _platformProvider;

  /// Registers the latest available token for the current signed-in customer.
  Future<void> registerCurrentDevice({String? pushToken}) async {
    if (!_sessionManager.isAuthenticated) return;

    try {
      final platform = _platformProvider();
      if (platform == null) return;
      final token = (pushToken ?? await _pushService.getDeviceToken())?.trim();
      if (token == null || token.isEmpty) return;
      await _deviceApi.registerDevice(
        deviceId: await _deviceIdService.getOrCreate(),
        pushToken: token,
        platform: platform,
        appVersion: await _appVersionProvider(),
      );
    } on Object catch (error, stackTrace) {
      AppLogger.error(
        'Unable to register the customer push device.',
        error: error,
        stackTrace: stackTrace,
        category: AppLogCategory.network,
      );
    }
  }

  /// Revokes this device before the customer session is cleared.
  Future<void> unregisterCurrentDevice() async {
    if (!_sessionManager.isAuthenticated) return;
    try {
      await _deviceApi.revokeCurrentDevice(
        deviceId: await _deviceIdService.getOrCreate(),
      );
    } on Object catch (error, stackTrace) {
      AppLogger.error(
        'Unable to revoke the customer push device.',
        error: error,
        stackTrace: stackTrace,
        category: AppLogCategory.network,
      );
    }
  }

  static Future<String> _readAppVersion() async =>
      (await PackageInfo.fromPlatform()).version;

  static String? _resolvePlatform() {
    if (kIsWeb) return null;
    return switch (defaultTargetPlatform) {
      TargetPlatform.iOS => 'ios',
      TargetPlatform.android => 'android',
      _ => null,
    };
  }
}
