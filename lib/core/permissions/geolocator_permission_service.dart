import 'package:geolocator/geolocator.dart';

import 'app_permission.dart';
import 'permission_result.dart';
import 'permission_service.dart';
import 'unconfigured_permission_service.dart';

class GeolocatorPermissionService implements PermissionService {
  const GeolocatorPermissionService();

  static const UnconfiguredPermissionService _fallback =
      UnconfiguredPermissionService();

  @override
  Future<PermissionStatusResult> check(AppPermission permission) async {
    if (permission != AppPermission.location) {
      return _fallback.check(permission);
    }

    final status = await Geolocator.checkPermission();
    return PermissionStatusResult(
      permission: permission,
      status: _mapStatus(status),
    );
  }

  @override
  Future<PermissionRequestResult> request(AppPermission permission) async {
    if (permission != AppPermission.location) {
      return _fallback.request(permission);
    }

    final before = await check(permission);
    final after = await Geolocator.requestPermission();
    final afterStatus = _mapStatus(after);
    return PermissionRequestResult(
      permission: permission,
      before: before.status,
      after: afterStatus,
    );
  }

  @override
  Future<bool> openAppSettings() => Geolocator.openAppSettings();

  AppPermissionStatus _mapStatus(LocationPermission permission) {
    return switch (permission) {
      LocationPermission.always ||
      LocationPermission.whileInUse =>
        AppPermissionStatus.granted,
      LocationPermission.denied => AppPermissionStatus.denied,
      LocationPermission.deniedForever => AppPermissionStatus.restricted,
      LocationPermission.unableToDetermine => AppPermissionStatus.unavailable,
    };
  }
}
