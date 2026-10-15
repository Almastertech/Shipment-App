import '../routing/app_routes.dart';
import '../session/session_manager.dart';
import '../storage/local_storage.dart';
import '../utils/app_constants.dart';

class StartupFlow {
  StartupFlow({
    required SessionManager sessionManager,
    LocalStorage? localStorage,
  })  : _sessionManager = sessionManager,
        _localStorage = localStorage;

  final SessionManager _sessionManager;
  final LocalStorage? _localStorage;

  String resolveInitialRoute() {
    if (_localStorage != null &&
        _localStorage.getBool(AppConstants.onboardingCompletedStorageKey) !=
            true) {
      return AppRoutes.onboarding;
    }

    if (_sessionManager.isAuthenticated) {
      return AppRoutes.home;
    }

    if (_sessionManager.isGuest) {
      return AppRoutes.home;
    }

    return AppRoutes.login;
  }
}
