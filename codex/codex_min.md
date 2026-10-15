# `Shipments` Codex Mini Rules

## Stack
- Flutter + `Provider/ChangeNotifier`
- `GetIt` DI
- `Dio` networking
- `go_router` routing
- `gen-l10n` ARB localization

## Architecture
```text
UI -> ViewModel -> Repository -> DataSource -> DioClient -> API
```
- Cross-cutting services in `lib/core/*`
- Composition root in `lib/injection.dart`

## Absolute Rules
- Inspect existing files first; do not invent new architecture.
- Keep changes additive and minimal.
- Use constructor injection; register dependencies in `injection.dart`.
- New routes must be added in `app_routes.dart` and wired/guarded in `app_router.dart`.
- Respect session model: unauthenticated / guest / authenticated.
- Use shared UI systems (`ScreenStateLayout`, `ToastService`, `StatusBanner`, `AppBottomSheetService`, `AppNetworkImage`).

## Forbidden Patterns
- `lib/screens/**` importing `dio` or `data/datasource/remote/dio/*`.
- `lib/data/repository/**` importing `screens/*` or Flutter UI packages.
- `lib/features/**` importing `injection.dart` directly.
- Using EventBus for local widget state.

## Current System Constraints
- Push: adapter/noop by default (no vendor SDK wired).
- Permissions: abstraction-only default (`UnconfiguredPermissionService`), no platform declaration changes.
- API monitoring: local in-memory hooks + debug route (non-prod).
- In-app notifications: local/API-fed center, not push delivery.

## Required Verification
```bash
flutter pub get                      # if pubspec changed
flutter gen-l10n                     # if ARB changed
dart format --set-exit-if-changed .
dart run tool/architecture_lint.dart
flutter analyze
flutter test
```

## Completion Checklist
- [ ] Architecture boundaries respected
- [ ] DI/routes/localization updated if needed
- [ ] Tests added/updated
- [ ] README/migration/ADR docs updated for architectural changes
- [ ] Verification commands passed
