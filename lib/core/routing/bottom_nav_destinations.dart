import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';

/// Indexes must stay aligned with the five destinations in the app shell.
abstract final class BottomNavDestinations {
  static const int home = 0;
  static const int shipments = 1;
  static const int orders = 2;
  static const int stores = 3;
  static const int profile = 4;

  static void go(BuildContext context, int index) {
    switch (index) {
      case home:
        context.go(AppRoutes.home);
      case shipments:
        context.go(AppRoutes.shipments);
      case profile:
        context.go(AppRoutes.profile);
      default:
        break;
    }
  }
}
