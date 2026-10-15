import 'app_permission.dart';
import 'permission_result.dart';

abstract class PermissionService {
  Future<PermissionStatusResult> check(AppPermission permission);

  Future<PermissionRequestResult> request(AppPermission permission);

  Future<bool> openAppSettings();
}
