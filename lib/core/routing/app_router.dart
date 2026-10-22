import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../components/ui_kit_showcase_screen.dart';
import '../../screens/demands/camera_permission_page.dart';
import '../../screens/demands/in_app_camera_page.dart';
import '../location/location_coordinates.dart';
import '../location/location_service.dart';
import '../camera/camera_capture_service.dart';
import '../../core/permissions/permission_service.dart';
import '../../injection.dart';
import '../../l10n/app_localizations.dart';
import '../../screens/auth/login_method_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/otp_success_screen.dart';
import '../../screens/auth/otp_verification_screen.dart';
import '../../screens/auth/welcome_screen.dart';
import '../../screens/debug/api_monitoring_screen.dart';
import '../../screens/demands/demand_details_page.dart';
import '../../screens/demands/open_demands_page.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/profile/delete_account_screen.dart';
import '../../screens/profile/edit_profile_screen.dart';
import '../../screens/profile/notification_settings_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/onboarding/onboarding_screen.dart';
import '../../screens/sample_feature/sample_feature_details_screen.dart';
import '../../screens/sample_feature/sample_feature_details_view_model.dart';
import '../../screens/sample_feature/sample_feature_list_screen.dart';
import '../../screens/sample_feature/sample_feature_view_model.dart';
import '../../screens/shipments/my_shipments_screen.dart';
import '../../screens/shipments/shipment_details_screen.dart';
import '../../screens/splash/splash_screen.dart';
import '../config/app_environment.dart';
import '../session/session_manager.dart';
import 'app_routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

enum RouteGuardType {
  none,
  authOnly,
  authOrGuest,
  guestOnly,
}

class AppRouter {
  AppRouter({
    required SessionManager sessionManager,
  }) : _sessionManager = sessionManager;

  final SessionManager _sessionManager;

  static const Map<String, RouteGuardType> _routeGuards =
      <String, RouteGuardType>{
    AppRoutes.splash: RouteGuardType.none,
    AppRoutes.onboarding: RouteGuardType.none,
    AppRoutes.loginMethod: RouteGuardType.none,
    AppRoutes.login: RouteGuardType.guestOnly,
    AppRoutes.otp: RouteGuardType.guestOnly,
    AppRoutes.otpSuccess: RouteGuardType.guestOnly,
    AppRoutes.welcome: RouteGuardType.guestOnly,
    AppRoutes.home: RouteGuardType.authOrGuest,
    AppRoutes.shipments: RouteGuardType.authOrGuest,
    AppRoutes.profile: RouteGuardType.authOrGuest,
    AppRoutes.deleteAccount: RouteGuardType.authOrGuest,
    AppRoutes.editProfile: RouteGuardType.authOrGuest,
    AppRoutes.notificationSettings: RouteGuardType.authOrGuest,
    AppRoutes.shipmentDetails: RouteGuardType.authOrGuest,
    AppRoutes.openDemands: RouteGuardType.authOrGuest,
    AppRoutes.demandDetails: RouteGuardType.authOrGuest,
    AppRoutes.cameraPermission: RouteGuardType.authOrGuest,
    AppRoutes.cameraCapture: RouteGuardType.authOrGuest,
    AppRoutes.uiKitShowcase: RouteGuardType.none,
    AppRoutes.sampleList: RouteGuardType.authOrGuest,
  };

  static String resolveGuardedRoute(
    String routeLocation, {
    SessionManager? sessionManager,
  }) {
    final session = sessionManager ?? getIt<SessionManager>();
    if (!isKnownRoute(routeLocation)) {
      // Fail closed for unknown routes so newly-added paths are never
      // accidentally reachable before explicit guard mapping.
      if (session.isAuthenticated || session.isGuest) {
        return AppRoutes.home;
      }
      return AppRoutes.login;
    }
    final guard = _resolveGuardType(routeLocation);

    return switch (guard) {
      RouteGuardType.none => routeLocation,
      RouteGuardType.authOnly =>
        session.isAuthenticated ? routeLocation : AppRoutes.login,
      RouteGuardType.authOrGuest => _resolveAuthOrGuestRoute(
          routeLocation,
          session,
        ),
      RouteGuardType.guestOnly =>
        session.isAuthenticated ? AppRoutes.home : routeLocation,
    };
  }

  static String _resolveAuthOrGuestRoute(
    String routeLocation,
    SessionManager session,
  ) {
    if (session.isAuthenticated) {
      return routeLocation;
    }

    if (session.isGuest) {
      return routeLocation;
    }

    return AppRoutes.login;
  }

  static RouteGuardType _resolveGuardType(String routeLocation) {
    final exact = _routeGuards[routeLocation];
    if (exact != null) return exact;

    if (_isSampleDetailsRoute(routeLocation)) {
      return RouteGuardType.authOrGuest;
    }

    if (_isDebugRoute(routeLocation)) {
      return RouteGuardType.none;
    }

    return RouteGuardType.authOnly;
  }

  static bool isKnownRoute(String routeLocation) {
    if (_routeGuards.containsKey(routeLocation)) {
      return true;
    }

    if (_isSampleDetailsRoute(routeLocation)) {
      return true;
    }

    if (_isDebugRoute(routeLocation)) {
      return true;
    }

    return false;
  }

  static bool _isDebugRoute(String routeLocation) {
    return routeLocation == AppRoutes.debugApiMonitor &&
        AppEnvironment.instance.flavor != AppFlavor.prod;
  }

  static bool _isSampleDetailsRoute(String routeLocation) {
    final uri = Uri.tryParse(routeLocation);
    if (uri == null) {
      return false;
    }

    final segments = uri.pathSegments;
    return segments.length == 2 &&
        segments.first == 'sample' &&
        segments[1].isNotEmpty;
  }

  late final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    refreshListenable: _sessionManager,
    redirect: (context, state) {
      final requestedRoute = state.matchedLocation;
      final targetRoute = resolveGuardedRoute(
        requestedRoute,
        sessionManager: _sessionManager,
      );
      if (requestedRoute != targetRoute) {
        return targetRoute;
      }
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.loginMethod,
        builder: (context, state) => const LoginMethodScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => LoginScreen(
          initialMethod: state.extra as String?,
        ),
      ),
      GoRoute(
        path: AppRoutes.otp,
        builder: (context, state) => OtpVerificationScreen(
          contact: state.extra as String?,
        ),
      ),
      GoRoute(
        path: AppRoutes.otpSuccess,
        builder: (context, state) => OtpSuccessScreen(
          onComplete: () => context.go(AppRoutes.welcome),
        ),
      ),
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.shipments,
        builder: (context, state) => const MyShipmentsScreen(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.deleteAccount,
        builder: (context, state) => const DeleteAccountScreen(),
      ),
      GoRoute(
        path: AppRoutes.editProfile,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.notificationSettings,
        builder: (context, state) => const NotificationSettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.shipmentDetails,
        builder: (context, state) => const ShipmentDetailsScreen(),
      ),
      GoRoute(
        path: AppRoutes.openDemands,
        builder: (context, state) => OpenDemandsPage(
          permissionService: getIt<PermissionService>(),
          locationService: getIt<LocationService>(),
        ),
      ),
      GoRoute(
        path: AppRoutes.demandDetails,
        builder: (context, state) {
          final extra = state.extra;
          return DemandDetailsPage(
            locationUnavailable:
                extra is LocationCoordinates ? false : extra as bool? ?? true,
            location: extra is LocationCoordinates ? extra : null,
            cameraCaptureService: getIt<CameraCaptureService>(),
            permissionService: getIt<PermissionService>(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.cameraPermission,
        builder: (context, state) => CameraPermissionPage(
          cameraCaptureService: getIt<CameraCaptureService>(),
          permissionService: getIt<PermissionService>(),
          mediaType: state.extra is CameraCaptureRequest
              ? (state.extra! as CameraCaptureRequest).mediaType
              : CameraMediaType.photo,
        ),
      ),
      GoRoute(
        path: AppRoutes.cameraCapture,
        builder: (context, state) => InAppCameraPage(
          cameraCaptureService: getIt<CameraCaptureService>(),
          permissionService: getIt<PermissionService>(),
          mediaType: state.extra is CameraCaptureRequest
              ? (state.extra! as CameraCaptureRequest).mediaType
              : CameraMediaType.photo,
          categoryIndex: state.extra is CameraCaptureRequest
              ? (state.extra! as CameraCaptureRequest).categoryIndex
              : 0,
        ),
      ),
      GoRoute(
        path: AppRoutes.uiKitShowcase,
        builder: (context, state) => const UiKitShowcaseScreen(),
      ),
      if (AppEnvironment.instance.flavor != AppFlavor.prod)
        GoRoute(
          path: AppRoutes.debugApiMonitor,
          builder: (context, state) => const ApiMonitoringScreen(),
        ),
      GoRoute(
        path: AppRoutes.sampleList,
        builder: (context, state) {
          return ChangeNotifierProvider<SampleFeatureViewModel>(
            create: (_) => getIt<SampleFeatureViewModel>()..initialize(),
            child: const SampleFeatureListScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.sampleDetails,
        builder: (context, state) {
          final itemId = state.pathParameters['id'] ?? '';
          final l10n = AppLocalizations.of(context);
          if (itemId.isEmpty) {
            return _UnknownRouteScreen(
              title: l10n?.navigationErrorTitle,
              message: l10n?.routeMissingItemId ?? 'Missing item id in route.',
            );
          }
          return SampleFeatureDetailsScreen(
            viewModel: getIt<SampleFeatureDetailsViewModel>(param1: itemId),
          );
        },
      ),
    ],
    errorBuilder: (context, state) {
      final l10n = AppLocalizations.of(context);
      return _UnknownRouteScreen(
        title: l10n?.navigationErrorTitle,
        message: state.error?.toString() ??
            'Route not found: ${state.matchedLocation}',
      );
    },
  );
}

class _UnknownRouteScreen extends StatelessWidget {
  const _UnknownRouteScreen({
    required this.message,
    this.title,
  });

  final String message;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title ?? 'Navigation Error')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(message, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
