import 'package:shipments/core/permissions/app_permission.dart';
import 'package:shipments/core/permissions/permission_result.dart';
import 'package:shipments/core/permissions/unconfigured_permission_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UnconfiguredPermissionService', () {
    const service = UnconfiguredPermissionService();

    test('check returns unavailable or notConfigured safely', () async {
      final result = await service.check(AppPermission.camera);

      expect(
        <AppPermissionStatus>[
          AppPermissionStatus.unavailable,
          AppPermissionStatus.notConfigured,
        ],
        contains(result.status),
      );
      expect(result.reason, isNotNull);
    });

    test('request mirrors safe non-crashing status', () async {
      final request = await service.request(AppPermission.notification);

      expect(
        <AppPermissionStatus>[
          AppPermissionStatus.unavailable,
          AppPermissionStatus.notConfigured,
        ],
        contains(request.after),
      );
      expect(request.granted, isFalse);
    });

    test('openAppSettings returns false by default', () async {
      expect(await service.openAppSettings(), isFalse);
    });
  });
}
