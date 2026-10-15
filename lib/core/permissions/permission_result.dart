import 'app_permission.dart';

enum AppPermissionStatus {
  unavailable,
  notConfigured,
  denied,
  granted,
  restricted,
  limited,
}

class PermissionStatusResult {
  const PermissionStatusResult({
    required this.permission,
    required this.status,
    this.reason,
  });

  final AppPermission permission;
  final AppPermissionStatus status;
  final String? reason;
}

class PermissionRequestResult {
  const PermissionRequestResult({
    required this.permission,
    required this.before,
    required this.after,
    this.reason,
  });

  final AppPermission permission;
  final AppPermissionStatus before;
  final AppPermissionStatus after;
  final String? reason;

  bool get granted => after == AppPermissionStatus.granted;
}
