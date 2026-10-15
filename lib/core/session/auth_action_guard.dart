import 'session_manager.dart';

enum AuthActionGuardDecision {
  allowed,
  requiresLogin,
}

/// Centralized auth check for protected UI actions.
///
/// Keeps action-level auth policy in one place instead of screen-specific
/// checks scattered across the presentation layer.
class AuthActionGuard {
  AuthActionGuard({
    required SessionManager sessionManager,
  }) : _sessionManager = sessionManager;

  final SessionManager _sessionManager;

  AuthActionGuardDecision requireAuthenticated() {
    if (_sessionManager.isAuthenticated) {
      return AuthActionGuardDecision.allowed;
    }

    return AuthActionGuardDecision.requiresLogin;
  }
}
