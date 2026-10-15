import 'package:flutter/material.dart';

import '../../injection.dart';
import 'toast_service.dart';

@Deprecated('Use ToastService via getIt<ToastService>() for unified feedback.')
class AppSnackBar {
  AppSnackBar._();

  static void showInfo(
    BuildContext _,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    getIt<ToastService>().info(message, duration: duration);
  }

  static void showSuccess(
    BuildContext _,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    getIt<ToastService>().success(message, duration: duration);
  }

  static void showError(
    BuildContext _,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    getIt<ToastService>().error(message, duration: duration);
  }
}
