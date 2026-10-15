import 'package:flutter/foundation.dart';

import 'app_permission.dart';
import 'permission_result.dart';
import 'permission_service.dart';

class UnconfiguredPermissionService implements PermissionService {
  const UnconfiguredPermissionService();

  static const String _notConfiguredReason =
      'Permission declarations are intentionally not configured in this template pass.';

  @override
  Future<PermissionStatusResult> check(AppPermission permission) async {
    if (!_isSupportedPlatform()) {
      return PermissionStatusResult(
        permission: permission,
        status: AppPermissionStatus.unavailable,
        reason: 'This platform does not expose runtime permission APIs here.',
      );
    }

    return PermissionStatusResult(
      permission: permission,
      status: AppPermissionStatus.notConfigured,
      reason: _notConfiguredReason,
    );
  }

  @override
  Future<bool> openAppSettings() async {
    return false;
  }

  @override
  Future<PermissionRequestResult> request(AppPermission permission) async {
    final before = await check(permission);
    return PermissionRequestResult(
      permission: permission,
      before: before.status,
      after: before.status,
      reason: before.reason,
    );
  }

  bool _isSupportedPlatform() {
    if (kIsWeb) {
      return false;
    }

    return switch (defaultTargetPlatform) {
      TargetPlatform.android || TargetPlatform.iOS => true,
      _ => false,
    };
  }
}
