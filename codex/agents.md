# AI Agent Onboarding: `Shipments`

## 1) Project Summary
- Flutter production template focused on architecture, not just UI starter screens.
- Current stack: `Provider + ChangeNotifier`, `GetIt`, `Dio`, `go_router`, `gen-l10n` (ARB), `SharedPreferences`, `flutter_secure_storage`.
- The repository already includes advanced systems: feature flags, remote config, event bus, smart guest mode, retry/rate-limit/dedup networking, offline queue, in-app notifications, push adapter (noop), permission abstraction (unconfigured by default), API monitoring hooks, typed UI state, validation layer, bottom sheet service, status banners, pre-commit tooling, architecture lint script, ADRs.

## 2) Architecture Shape

```text
UI (screens/component)
  -> ViewModel (ChangeNotifier)
  -> Repository (data/repository)
  -> DataSource (data/repository or data/datasource/remote)
  -> DioClient + Interceptors
  -> API
```

Cross-cutting services live in `lib/core/*` and are composed in `lib/injection.dart`.

## 3) Stack and Key Libraries
- State: `provider`, `ChangeNotifier`
- DI: `get_it`
- Routing: `go_router`
- Network: `dio`
- Localization: `flutter gen-l10n` from `lib/l10n/*.arb`
- Images: `cached_network_image` via `AppNetworkImage`
- Skeletons: `skeletonizer`

## 4) Folder Conventions
- `lib/core/`: infrastructure, abstractions, cross-cutting policies.
- `lib/data/`: API urls, datasource exceptions/dio plumbing, repositories, models.
- `lib/screens/`: current presentation layer (auth/sample/splash/UI kit/shared components).
- `lib/features/`: phased modular migration target (currently `features/notifications` as reference).
- `docs/adr/`: architecture decisions.
- `docs/patterns/`: reusable behavior contracts.
- `tool/`: automation scripts (`architecture_lint.dart`, `pre_commit.dart`).
- `.githooks/` + `scripts/`: local hook setup.

## 5) Feature Placement Rules
- Add cross-feature services to `lib/core/`.
- Add API/domain implementation to `lib/data/`.
- Add screens and ChangeNotifier VMs under `lib/screens/<feature>/` unless intentionally migrating to `lib/features/<feature>/`.
- Keep migration incremental: do not force full move from `screens/` to `features/` in one pass.

## 6) Import Boundaries (Repository Rules)
These are partially enforced by `tool/architecture_lint.dart`:
- `lib/screens/**` must not import:
  - `package:dio/dio.dart`
  - `lib/data/datasource/remote/dio/*`
- `lib/data/repository/**` must not import UI/presentation:
  - `lib/screens/*`
  - `package:flutter/material.dart`
  - `package:flutter/widgets.dart`
- `lib/features/**` should not import `injection.dart` directly.

Additional practical boundary:
- Prefer resolving dependencies in composition roots (DI/router/provider wiring) and passing them down via constructors.

## 7) State Management Rules
- Use `ChangeNotifier` view models for screen state.
- Prefer typed `UiState<T>` (`initial/loading/content/empty/error`) over raw enum+boolean flags for new work.
- Existing compatibility fields may remain, but new state logic should use typed state as source of truth.
- Keep view models testable: constructor-injected dependencies, minimal static/global logic.

## 8) DI Rules (`lib/injection.dart`)
- Register long-lived services with `registerLazySingleton`.
- Register route/screen-scoped view models with `registerFactory`.
- Initialize async services in `init()` in proper order (storage -> config -> session -> networking -> features).
- If you add a new global `ChangeNotifier`, also wire provider exposure in `lib/providers.dart` when needed.

## 9) Routing and Guard Rules
- Route constants live in `lib/core/routing/app_routes.dart`.
- Route setup and guards live in `lib/core/routing/app_router.dart`.
- Guard types:
  - `none`
  - `authOnly`
  - `authOrGuest`
  - `guestOnly`
- Push route handling relies on `AppRouter.isKnownRoute` and `resolveGuardedRoute`; update both when adding guarded route patterns.

## 10) Auth/Session/Guest Mode
- `SessionManager` supports 3 states:
  - unauthenticated
  - guest
  - authenticated
- `StartupFlow.resolveInitialRoute()` sends signed-in (guest or auth) users to `/sample`, otherwise `/login`.
- Guests can browse allowed routes (`authOrGuest`), but protected actions should require authenticated users and prompt login.

## 11) Networking Rules
- Use `DioClient` for requests (not raw Dio from UI/presentation).
- Current interceptor order:
  1. `AuthInterceptor`
  2. `ApiMonitoringInterceptor`
  3. `RateLimitInterceptor`
  4. `RetryInterceptor`
  5. `LoggingInterceptor`
- Reliability systems already present:
  - auth token attach/refresh
  - request dedup (`GET` path/query key)
  - rate limiting (`429` response when exceeded)
  - smart retries with backoff + jitter
  - sanitized logging

## 12) Cache and Offline Rules
- Repository cache pattern uses `CacheStore` with stale-while-revalidate style.
- Offline write queue:
  - `OfflineActionQueue` + `OfflineActionProcessor` + `OfflineActionExecutor`
  - store only non-sensitive payloads in local JSON storage.
- Do not queue sensitive actions/data unless explicitly approved and secured.

## 13) Feature Flags / Remote Config / Event Bus
- Feature flags are typed (`FeatureFlags`), backed by local defaults + remote config overrides.
- Default remote config is local asset (`assets/config/remote_config.json`) and DI-swappable.
- Event bus (`AppEventBus`) is for app-wide events only (auth/theme/language/connectivity/cart-wide).
- Do not use EventBus for local widget-to-widget state that belongs in VM/controller.

## 14) Notifications, Push, Permissions, Monitoring
- In-app notifications: local/API-fed center (`features/notifications`), not push delivery.
- Push: adapter architecture only by default (`NoopPushNotificationService`), safe to initialize without provider SDK.
- Permissions: abstraction-only default (`UnconfiguredPermissionService`), graceful `notConfigured/unavailable` behavior.
- API monitor: in-memory hooks + debug screen, route exposed only in non-prod.

## 15) UI System Rules
- Prefer existing shared components from `lib/screens/component/`:
  - `ScreenStateLayout`, `ErrorUiMapper`, `EmptyState`, `StatusBanner`
  - `AppBottomSheet` + `AppBottomSheetService`
  - `OverlayToastService`
  - `AppNetworkImage`
  - skeleton widgets
- Keep localization-friendly strings in ARB files, not hardcoded in feature logic.

## 16) Testing Rules
- Add tests for logic changes in same PR/task:
  - unit tests for services/viewmodels/interceptors
  - widget tests for reusable UI behaviors when practical
- Keep new tests deterministic and isolated with fake/in-memory dependencies.
- Existing suite is broad; preserve/extend patterns in `test/*`.

## 17) Docs and Workflow Rules
- If architecture/behavior changes, update:
  - `README.md`
  - `TEMPLATE_MIGRATION_REPORT.md`
  - `docs/adr/*` when decision-level change
  - `CONTRIBUTING.md` if workflow/conventions change

## 18) Required Verification Commands
Run what applies before completion:
```bash
flutter pub get                      # if dependencies changed
flutter gen-l10n                     # if ARB/localization changed
dart format --set-exit-if-changed .
dart run tool/architecture_lint.dart
flutter analyze
flutter test
```

Optional fast local gate:
```bash
dart run tool/pre_commit.dart
```

## 19) Do / Do Not
### Do
- Make minimal, additive, repository-faithful changes.
- Preserve constructor injection and strong typing.
- Reuse existing abstractions before creating new ones.
- Keep routes/DI/tests/docs synchronized.

### Do Not
- Do not bypass architecture boundaries (UI directly using Dio/data-datasource).
- Do not add vendor push SDK as default without explicit request.
- Do not add platform permission declarations in architecture-only permission tasks.
- Do not replace working patterns with broad refactors unless explicitly requested.

## 20) Completion Checklist
- [ ] Architecture boundaries respected.
- [ ] DI and routing updated if needed.
- [ ] Localization updated and generated (if strings changed).
- [ ] Tests added/updated and passing.
- [ ] Docs updated when behavior/architecture changed.
- [ ] Verification commands executed and reported.
