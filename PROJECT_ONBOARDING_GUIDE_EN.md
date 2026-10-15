# Template Onboarding Guide (EN)

> Last updated: simplified profile (offline queue, feature flags, remote config, event bus, CI/hook automation removed)

This guide is the operational map for engineers joining this template.

## 1) Core Architecture

Canonical flow:

`UI -> ViewModel -> Repository -> DataSource -> DioClient -> API`

Primary stack:
- State: `Provider + ChangeNotifier`
- DI: `GetIt`
- Routing: `go_router`
- Networking: `Dio` interceptors

## 2) First Files to Read

- `lib/main.dart`
- `lib/app.dart`
- `lib/injection.dart`
- `lib/providers.dart`
- `lib/core/routing/app_router.dart`
- `lib/core/session/session_manager.dart`
- `lib/components/ui_kit.dart`
- `lib/components/ui_kit_showcase_screen.dart`

## 3) Startup and Session Flow

Startup sequence:
1. `AppEnvironment.initialize()`
2. `injection.init()`
3. `MaterialApp.router`
4. `StartupFlow` resolves entry route

Session states:
- `unauthenticated`
- `guest`
- `authenticated`

Guest mode is always available in this profile.

## 4) Session Purge Behavior

`SessionManager.clearTokens()` performs centralized user-scoped purge.

Cleared on logout/expiry:
- auth/refresh/guest session markers
- search history and recent viewed items
- in-app notifications state
- user-scoped cache

Preserved intentionally:
- theme mode
- locale/language

## 5) Routing and Guards

Guard types:
- `none`
- `authOnly`
- `authOrGuest`
- `guestOnly`

Unknown routes are fail-closed.
Protected actions should use `AuthActionGuard`.

## 6) Networking

Interceptor order in `DioClient`:
1. `ApiMonitoringInterceptor`
2. `AuthInterceptor`
3. `RateLimitInterceptor`
4. `RetryInterceptor`
5. `LoggingInterceptor`

Notes:
- Auth refresh distinguishes transient vs terminal failures.
- Retry defaults to idempotent methods; mutating requests require `extra.retryable=true`.

## 7) Cache and Limits

- Cache strategy: stale-while-revalidate
- Default memory cache cap: `300`
- In-app notifications cap: `100`

## 8) UI Foundation and Storybook

Shared UI is under `lib/components/`.
Use `/ui-kit` for component QA:
- viewport presets
- text scale preview
- forced RTL preview
- component state stories (loading/empty/error/content)

## 9) Localization and Theme

- ARB files: `lib/l10n/app_en.arb`, `lib/l10n/app_ar.arb`
- Regenerate after ARB changes:

```bash
flutter gen-l10n
```

## 10) Daily Commands

```bash
flutter pub get
flutter gen-l10n
dart run tool/architecture_lint.dart
flutter analyze
flutter test
flutter test integration_test -d linux
flutter run --dart-define=ENV=dev
```

## 11) Bootstrap Checklist

1. Set package IDs and app name.
2. Configure `ENV` and `API_BASE_URL`.
3. Configure Android/iOS release signing.
4. Keep Android `INTERNET` permission in main manifest.
5. Replace noop push provider if needed.
6. Review route guards for every new route.
7. Validate logout/session-expiry purge behavior.
8. Validate UI kit stories in `/ui-kit`.
9. Ensure lint/analyze/tests pass.

## 12) Removed from This Profile

- Offline action queue/replay
- Feature flags
- Remote config service
- Global event bus
- Crash/analytics abstractions
- GitHub CI workflow and git-hook setup scripts

## 13) Source of Truth Rule

If docs and implementation diverge:
1. code first
2. `README.md`
3. onboarding guides
