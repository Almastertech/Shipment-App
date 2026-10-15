# Template Migration Report - v3.5

> Note: This is a historical migration record for the v2-v3.5 profile.
> The current simplified profile removed offline queue, feature flags, remote config, event bus, observability abstractions, and GitHub hook/CI automation.
> Use README.md and onboarding guides as the current operational source of truth.

This report is split into seven parts:

- Part 1: v2 production-readiness upgrades
- Part 2: v3 advanced systems addendum
- Part 3: v3.1 architecture enhancement addendum
- Part 4: v3.2 certification hardening addendum
- Part 5: v3.3 session purge + offline truthfulness hardening addendum
- Part 6: v3.4 architecture truthfulness + guard/safety hardening addendum
- Part 7: v3.5 UI foundation + storybook hardening addendum

## Part 1: v2 Production-Readiness Upgrades

This section documents the 10 production-readiness upgrades applied in v2.

### Current Folder Tree

```text
lib/
¦   app.dart
¦   injection.dart
¦   main.dart
¦   providers.dart
¦
+---core
¦   ¦   logger.dart
¦   ¦   network_info.dart
¦   ¦
¦   +---cache
¦   ¦       cache_store.dart
¦   ¦
¦   +---config
¦   ¦       app_environment.dart
¦   ¦
¦   +---network
¦   ¦       request_deduplicator.dart
¦   ¦
¦   +---observability
¦   ¦       analytics_service.dart
¦   ¦       crash_reporter.dart
¦   ¦
¦   +---resources
¦   ¦       adaptive_layout.dart
¦   ¦       app_colors.dart
¦   ¦       app_typography.dart
¦   ¦       screen_utils_helper.dart
¦   ¦       values_manager.dart
¦   ¦
¦   +---routing
¦   ¦       app_router.dart
¦   ¦       app_routes.dart
¦   ¦
¦   +---session
¦   ¦       session_expiry_handler.dart
¦   ¦       session_manager.dart
¦   ¦
¦   +---startup
¦   ¦       startup_flow.dart
¦   ¦
¦   +---storage
¦   ¦       local_storage.dart
¦   ¦       prefs_storage.dart
¦   ¦       secure_storage.dart
¦   ¦
¦   +---utils
¦           app_constants.dart
¦           debouncer.dart
¦           pagination_helper.dart
¦
+---data
¦   +---app_urls
¦   ¦       app_url.dart
¦   ¦
¦   +---datasource
¦   ¦   +---remote
¦   ¦       +---dio
¦   ¦       ¦       api_token_refresher.dart
¦   ¦       ¦       auth_interceptor.dart
¦   ¦       ¦       dio_client.dart
¦   ¦       ¦       logging_interceptor.dart
¦   ¦       ¦       retry_interceptor.dart
¦   ¦       ¦
¦   ¦       +---exception
¦   ¦               api_error.dart
¦   ¦               api_error_handler.dart
¦   ¦
¦   +---model
¦   ¦   ¦   sample_item.dart
¦   ¦   ¦
¦   ¦   +---response
¦   ¦       +---base
¦   ¦               api_response.dart
¦   ¦
¦   +---repository
¦           base_repository.dart
¦           sample_feature_repo.dart
¦
+---l10n
¦       app_ar.arb
¦       app_en.arb
¦       app_localizations.dart
¦       app_localizations_ar.dart
¦       app_localizations_en.dart
¦
+---localization
¦   +---controllers
¦           localization_controller.dart
¦
+---screens
¦   +---auth
¦   ¦       login_screen.dart
¦   ¦       otp_verification_screen.dart
¦   ¦
¦   +---component
¦   ¦   ¦   app_scaffold.dart
¦   ¦   ¦   app_text.dart
¦   ¦   ¦   connectivity_banner.dart
¦   ¦   ¦   empty_state.dart
¦   ¦   ¦   error_state.dart
¦   ¦   ¦   loading_spinner.dart
¦   ¦   ¦   screen_state_layout.dart
¦   ¦   ¦   ui_kit.dart
¦   ¦   ¦   ui_kit_showcase_screen.dart
¦   ¦   ¦
¦   ¦   +---buttons
¦   ¦   ¦       custom_button.dart
¦   ¦   ¦
¦   ¦   +---feedback
¦   ¦   ¦       ...
¦   ¦   ¦
¦   ¦   +---inputs
¦   ¦   ¦       ...
¦   ¦   ¦
¦   ¦   +---layout
¦   ¦           adaptive_page.dart
¦   ¦           adaptive_two_pane.dart
¦   ¦
¦   +---sample_feature
¦   ¦       sample_feature_details_screen.dart
¦   ¦       sample_feature_list_screen.dart
¦   ¦       sample_feature_view_model.dart
¦   ¦
¦   +---splash
¦           splash_screen.dart
¦
+---themes
        app_icon_size.dart
        app_radius.dart
        app_spacing.dart
        app_themes.dart
        theme_controller.dart

test/
    adaptive_layout_test.dart
    api_token_refresher_test.dart
    auth_interceptor_test.dart
    cache_store_test.dart
    log_sanitizer_test.dart
    offline_strategy_test.dart
    request_deduplicator_test.dart
    retry_interceptor_test.dart
    route_guard_test.dart
    sample_feature_repository_test.dart
    sample_feature_view_model_test.dart
    session_expiry_handler_test.dart
    session_manager_test.dart
    startup_flow_test.dart
    ui_kit_widgets_test.dart
    widget_test.dart

integration_test/
    app_flow_test.dart

.github/workflows/
    flutter_ci.yml
```

---

## File Operations (v2 Upgrades)

### New Files (10)

| Operation | File                                             | Purpose                                                              |
| --------- | ------------------------------------------------ | -------------------------------------------------------------------- |
| ADD       | `lib/core/observability/crash_reporter.dart`     | `CrashReporter` abstraction + `NoopCrashReporter`                    |
| ADD       | `lib/core/observability/analytics_service.dart`  | `AnalyticsService` abstraction + `NoopAnalyticsService`              |
| ADD       | `lib/core/cache/cache_store.dart`                | `CacheStore` + `MemoryCacheStore` + `PrefsCacheStore` + `CacheCodec` |
| ADD       | `lib/core/network/request_deduplicator.dart`     | Single-flight request deduplication                                  |
| ADD       | `lib/screens/component/connectivity_banner.dart` | Animated offline status banner                                       |
| ADD       | `test/sample_feature_view_model_test.dart`       | 7 ViewModel unit tests                                               |
| ADD       | `test/request_deduplicator_test.dart`            | 5 dedup unit tests                                                   |
| ADD       | `test/cache_store_test.dart`                     | 6 cache unit tests                                                   |
| ADD       | `test/offline_strategy_test.dart`                | 6 offline strategy tests                                             |
| ADD       | `integration_test/app_flow_test.dart`            | Integration test scaffold                                            |

### Modified Files (10)

| Operation | File                                                            | Change                                                                     |
| --------- | --------------------------------------------------------------- | -------------------------------------------------------------------------- |
| MODIFY    | `lib/main.dart`                                                 | `runZonedGuarded` + `FlutterError.onError` error boundary                  |
| MODIFY    | `lib/injection.dart`                                            | DI fix (controllers ? `registerLazySingleton`) + new service registrations |
| MODIFY    | `lib/core/network_info.dart`                                    | Added `connectivityStream` for real-time status                            |
| MODIFY    | `lib/data/datasource/remote/dio/dio_client.dart`                | Request dedup for GET calls                                                |
| MODIFY    | `lib/data/repository/sample_feature_repo.dart`                  | Caching + stale-while-revalidate + `findItemById`                          |
| MODIFY    | `lib/core/routing/app_routes.dart`                              | `/sample/:id` path param + `sampleDetailsPath` builder                     |
| MODIFY    | `lib/core/routing/app_router.dart`                              | Path param extraction + dynamic guard for `/sample/:id`                    |
| MODIFY    | `lib/screens/sample_feature/sample_feature_details_screen.dart` | Loads item by id from repository                                           |
| MODIFY    | `lib/screens/sample_feature/sample_feature_list_screen.dart`    | Path-param navigation                                                      |
| MODIFY    | `lib/app.dart`                                                  | `ConnectivityBanner` in `MaterialApp.router` builder                       |

### Configuration Changes (2)

| Operation | File                               | Change                                                                   |
| --------- | ---------------------------------- | ------------------------------------------------------------------------ |
| MODIFY    | `pubspec.yaml`                     | Added `fake_async`, `integration_test` dev dependencies                  |
| MODIFY    | `.github/workflows/flutter_ci.yml` | Added `dart format` and `flutter build apk --dart-define=ENV=prod` steps |

---

## Upgrade Details

### 1. DI Lifecycle Fix

**Problem:** `ThemeController` and `LocalizationController` were registered as `factory` in GetIt. Each lookup created a new instance, breaking state sharing across screens.

**Fix:** Changed both to `registerLazySingleton` in `injection.dart`. ViewModel `SampleFeatureViewModel` stays as `factory` (per-route lifecycle).

### 2. Global Error Boundary

**Files:** `main.dart`, `crash_reporter.dart`

- `runZonedGuarded` catches unhandled async errors
- `FlutterError.onError` catches framework errors
- Both forward to `CrashReporter.reportError`
- Default `NoopCrashReporter` logs to console in debug mode
- **To integrate real reporting:** Replace `NoopCrashReporter` with `FirebaseCrashReporter` or `SentryCrashReporter` in `injection.dart`

### 3. Analytics Abstraction

**File:** `analytics_service.dart`

- Abstract class: `logEvent`, `logScreenView`, `setUserId`, `setUserProperty`
- `NoopAnalyticsService` default
- **To integrate:** Replace DI registration with `FirebaseAnalyticsService`, `AmplitudeAnalyticsService`, etc.

### 4. Connectivity Banner

**Files:** `connectivity_banner.dart`, `network_info.dart`, `app.dart`

- `NetworkInfo` now exposes `connectivityStream` (`Stream<bool>`)
- `ConnectivityBanner` listens to stream, animates slide-down error banner
- Mounted globally in `MaterialApp.router` builder ? visible on all screens

### 5. Caching Layer

**File:** `cache_store.dart`

- `CacheStore` abstract with `get(key)`, `put(key, data)`, `invalidate(key)`, `clear()`
- `CacheEntry` stores data + timestamp for TTL
- `MemoryCacheStore`: fast in-memory `Map` (registered as default)
- `PrefsCacheStore`: persistent via `SharedPreferences`
- `CacheCodec`: JSON encode/decode helper

### 6. Request Deduplication

**Files:** `request_deduplicator.dart`, `dio_client.dart`

- `RequestDeduplicator.deduplicate(key, request)`: if key is in-flight, returns same Future
- Integrated in `DioClient.get()` by default
- Key: `GET:/path:param1=value1:param2=value2`
- Opt out: `dioClient.get('/path', deduplicate: false)`

### 7. Offline Strategy (Stale-While-Revalidate)

**File:** `sample_feature_repo.dart`

Flow:

1. Cache hit + valid TTL ? return immediately
2. Online ? fetch network ? update cache + item index + trigger `onCacheHit` (true background UI refresh)
3. Offline + cache ? return stale cache
4. Offline + no cache ? `ApiFailure(offline)`
5. Network error + cache ? fallback to cache

### 8. Deep-Link Routing

**Files:** `app_routes.dart`, `app_router.dart`, details screen, list screen

- Route changed: `/sample/details` ? `/sample/:id`
- Builder method: `AppRoutes.sampleDetailsPath(id)`
- Details screen receives `itemId` string, loads via `repository.findItemById(id)`
- Network fallback: `findItemById` fetches via network if item isn't in local index (fresh launch deep-link).
- Route guard dynamically resolves `/sample/*` patterns as `authOrGuest`
- Navigation: `context.push(AppRoutes.sampleDetailsPath(item.id))`

### 9. ViewModel Unit Tests

**File:** `test/sample_feature_view_model_test.dart`

7 tests covering:

- Initial load: success, failure, empty
- Refresh clears and reloads page 1
- loadMore appends items + increments page
- loadMore stops when `hasMore` is false
- Debounced search with `fakeAsync` timing

### 10. Integration Tests

**File:** `integration_test/app_flow_test.dart`

- Uses `IntegrationTestWidgetsFlutterBinding.ensureInitialized()`
- Verifies splash screen renders
- Foundation for adding more E2E flows

---

## Verification Results

```
flutter analyze ? 0 issues
flutter test   ? all tests passed
```

| Test File                               | Tests | Status     |
| --------------------------------------- | ----- | ---------- |
| adaptive_layout_test.dart               | 4     | ?         |
| api_token_refresher_test.dart           | 2     | ?         |
| auth_interceptor_test.dart              | 3     | ?         |
| **cache_store_test.dart**               | **6** | **? NEW** |
| log_sanitizer_test.dart                 | 4     | ?         |
| **offline_strategy_test.dart**          | **6** | **? NEW** |
| **request_deduplicator_test.dart**      | **5** | **? NEW** |
| retry_interceptor_test.dart             | 3     | ?         |
| route_guard_test.dart                   | 2     | ?         |
| sample_feature_repository_test.dart     | 2     | ?         |
| **sample_feature_view_model_test.dart** | **7** | **? NEW** |
| session_expiry_handler_test.dart        | 1     | ?         |
| session_manager_test.dart               | 2     | ?         |
| startup_flow_test.dart                  | 2     | ?         |
| ui_kit_widgets_test.dart                | 5     | ?         |
| widget_test.dart                        | 7     | ?         |

---

## Dependencies Added (v2)

### dev_dependencies

```yaml
fake_async: ^1.3.2
integration_test:
  sdk: flutter
```

### CI Pipeline Updates

- Added `dart format --set-exit-if-changed .` step before `flutter analyze`.
- Added `flutter build apk --dart-define=ENV=prod` for production build verification.

---

## Swap Guide for Real Services

### Replace Crash Reporter

```dart
// In injection.dart, replace:
getIt.registerLazySingleton<CrashReporter>(NoopCrashReporter.new);
// With:
getIt.registerLazySingleton<CrashReporter>(
  () => FirebaseCrashReporter(FirebaseCrashlytics.instance),
);
```

### Replace Analytics

```dart
// In injection.dart, replace:
getIt.registerLazySingleton<AnalyticsService>(NoopAnalyticsService.new);
// With:
getIt.registerLazySingleton<AnalyticsService>(
  () => FirebaseAnalyticsServiceImpl(FirebaseAnalytics.instance),
);
```

### Replace Cache Backend

```dart
// In injection.dart, replace:
getIt.registerLazySingleton<CacheStore>(MemoryCacheStore.new);
// With:
getIt.registerLazySingleton<CacheStore>(
  () => PrefsCacheStore(getIt<SharedPreferences>()),
);
```

---

## Part 2: v3 Advanced Systems Addendum (15-System Enhancement)

This addendum documents the implementation of the requested advanced production systems while preserving the existing architecture style.

### Implemented Systems

1. Feature flags (`FeatureFlags`) with typed accessors.
2. Remote config abstraction (`RemoteConfigService`) with local asset default provider.
3. Typed global app event bus (`AppEventBus` + typed events).
4. Reusable image optimization layer (`AppNetworkImage` + `ImageUrlOptimizer`).
5. Error-to-UI mapping (`ErrorUiMapper` + `ErrorUiModel`).
6. Global custom overlay toast service (`OverlayToastService`) without SnackBar.
7. Reusable skeleton components (`AppListSkeleton`, `AppCardSkeleton`, `AppDetailsSkeleton`).
8. Pagination helper improvements (states, prefetch threshold, duplicate prevention).
9. Network rate limiting (`NetworkRateLimiter` + `RateLimitInterceptor`).
10. Offline write-action queue (`OfflineAction`, queue, processor, executors).
11. Smart retry strategy (exponential backoff, jitter, idempotency/mutating rules).
12. Free local in-app notification center (badge/list/sheet, persisted).
13. Structured logging upgrades with categories and repetitive-log muting.
14. Modular feature system hybrid migration path with `lib/features/notifications` reference.
15. Smart guest mode with guest session state + updated guards/startup behavior.

### Guest Mode Findings and Implementation

What existed previously:

- Route-level guest/auth guard concept existed.
- No true guest session state.
- `/sample` routes were auth-only.

What was added:

- `SessionManager.isGuest`, `startGuestSession()`, and `isSignedIn`.
- Login screen CTA: `Continue as guest`.
- Router guard `authOrGuest` for browse routes.
- Startup flow restoration for guest session.
- Protected actions still require authenticated users (guest prompts login).

The template now distinguishes between three session states: unauthenticated, guest, and authenticated.

### Free/Local-Only Scope Confirmation

Implemented as free/local:

- Remote config source defaults to local asset JSON.
- In-app notifications implemented as local center architecture (no paid vendor).
- Offline action queue uses local SharedPreferences JSON for non-sensitive payloads.

In-app notifications are local/API-fed only and are not a push delivery system.

Intentionally skipped paid/vendor integrations:

- Push/inbox vendor SDKs (OneSignal/Braze/etc.).
- Paid remote config infrastructure.

### New/Updated Key Files

Core additions:

- `lib/core/remote_config/*`
- `lib/core/feature_flags/feature_flags.dart`
- `lib/core/events/*`
- `lib/core/network/network_rate_limiter.dart`
- `lib/core/offline/*`
- `lib/core/config/app_remote_config.dart`

Feature module additions:

- `lib/features/notifications/domain/in_app_notification.dart`
- `lib/features/notifications/application/in_app_notification_center.dart`
- `lib/features/notifications/presentation/*`
- `lib/features/README.md`

UI component additions:

- `lib/screens/component/images/app_network_image.dart`
- `lib/screens/component/error_ui_mapper.dart`
- `lib/screens/component/error_ui_model.dart`
- `lib/screens/component/skeleton/*`

Key modified files:

- `lib/injection.dart`
- `lib/core/session/session_manager.dart`
- `lib/core/routing/app_router.dart`
- `lib/core/startup/startup_flow.dart`
- `lib/screens/auth/login_screen.dart`
- `lib/screens/sample_feature/*`
- `lib/screens/component/feedback/toast_service.dart`
- `lib/screens/component/connectivity_banner.dart`
- `lib/themes/theme_controller.dart`
- `lib/localization/controllers/localization_controller.dart`

### Test Additions

New tests:

- `test/remote_config_service_test.dart`
- `test/feature_flags_test.dart`
- `test/app_event_bus_test.dart`
- `test/error_ui_mapper_test.dart`
- `test/toast_service_test.dart`
- `test/pagination_helper_test.dart`
- `test/network_rate_limiter_test.dart`
- `test/offline_action_queue_test.dart`
- `test/offline_action_processor_test.dart`
- `test/in_app_notification_center_test.dart`

Updated tests:

- route guards, startup flow, session manager, retry interceptor, sample feature VM/widget tests.

### Verification

Executed successfully after implementation:

```bash
flutter gen-l10n
flutter analyze
flutter test
```

---

## Part 4: v3.2 Certification Hardening Addendum

This addendum captures the production-hardening work applied after the v3.1 audit.
It supersedes any older notes that claimed no platform manifest/signing changes.

### Implemented Hardening Changes

1. Android release networking safety:

- Added `android.permission.INTERNET` to `android/app/src/main/AndroidManifest.xml`.

2. Release signing safety:

- Removed debug-signing fallback from `android/app/build.gradle.kts` release build type.

3. Token refresh reliability:

- Refresh requests now bypass rate limiting (`skipRateLimit: true`).
- Session is no longer force-cleared on transient refresh failures (network/timeouts/5xx/429/408).
- Session expiry remains enforced on terminal auth failures (401/403/400/422 and terminal replay 401/403).

4. Route/session hardening:

- Guard resolution is fail-closed for unknown routes.
- Startup flow now respects `FeatureFlags.guestModeEnabled` when restoring guest sessions.
- `/sample/:id` route recognition is stricter (avoids broad `/sample/*` matching drift).

5. Monitoring signal quality:

- Added recoverable-auth-failure filtering in `ApiMonitoringInterceptor` to avoid false failure records for 401s that are recovered by refresh/replay.

6. State concurrency hardening:

- `SampleFeatureViewModel` now versions in-flight requests and ignores stale responses.
- Refresh keeps previous items visible while request is in flight (no list wipe flicker).

7. Growth bounds and memory safety:

- `MemoryCacheStore` now has bounded capacity with oldest-entry eviction.
- `PrefsOfflineActionQueue` now has bounded max size with oldest-entry drop policy.
- `InAppNotificationCenter` now caps persisted/active notification count.
- `AppLogger` repeated-log suppression maps now have pruning caps.

8. UI consistency tightening:

- Shared state components (`ScreenStateLayout`, `EmptyState`, `ErrorState`) now use localization-aware fallbacks instead of fixed English-only labels.
- Notifications sheet now uses `AppBottomSheetService` instead of direct `showModalBottomSheet`.

9. DI/runtime verification:

- Added injection smoke test with plugin channel mocks for secure storage/connectivity.

10. Integration flow depth:

- Expanded `integration_test/app_flow_test.dart` to cover real app startup and guest navigation flow.

### Added/Updated Tests in v3.2

- `test/startup_flow_test.dart` (guest flag disabled path)
- `test/route_guard_test.dart` (fail-closed unknown route behavior)
- `test/auth_interceptor_test.dart` (transient vs terminal refresh failure behavior)
- `test/api_token_refresher_test.dart` (skipRateLimit assertion)
- `test/api_monitoring_interceptor_test.dart` (auth recovery monitoring case)
- `test/sample_feature_view_model_test.dart` (stale request discard + refresh keeps data)
- `test/cache_store_test.dart` (bounded eviction)
- `test/offline_action_queue_test.dart` (queue cap behavior)
- `test/in_app_notification_center_test.dart` (notification cap behavior)
- `test/injection_smoke_test.dart` (DI graph/runtime smoke)
- `integration_test/app_flow_test.dart` (startup + guest navigation flow)

### v3.2 Verification

Executed successfully:

```bash
flutter analyze
flutter test
```

Result:

- `flutter analyze`: no issues found
- `flutter test`: all tests passed

---

## Part 3: v3.1 Architecture Enhancement Addendum (14 Systems)

This part documents the additive implementation of 14 requested systems while preserving the existing stack and conventions.

### Implemented Systems

1. Push adapter architecture:

- `PushNotificationService`, `PushMessage`, `NoopPushNotificationService`, `PushNotificationHandler`
- route bridging + analytics hooks + in-app notification center integration

2. Permission abstraction:

- `PermissionService` + typed permission/request/status models
- `UnconfiguredPermissionService` with safe `notConfigured`/`unavailable` defaults

3. API monitoring hooks:

- `ApiMonitoringService` + `InMemoryApiMonitoringService`
- `ApiMonitoringInterceptor` in Dio pipeline
- debug route/screen for request insights (non-prod only)

4. Unified validation:

- `AppValidators`, `ValidationResult`, `ValidationMessageMapper`
- OTP flow uses typed validation pipeline

5. Typed UI state migration:

- introduced generic `UiState<T>`
- sample feature ViewModel migrated internally from enum+flags pattern

6. Search history/recent items:

- `SearchHistoryService` with local persistence, dedup, and max-size cap
- integrated in sample search/list flow

7. ADRs:

- `docs/adr/0001-provider-and-getit.md`
- `docs/adr/0002-go-router-and-guards.md`
- `docs/adr/0003-local-remote-config-default.md`
- `docs/adr/0004-guest-mode.md`

8. Contributor guide:

- `CONTRIBUTING.md`

9. Pre-commit hooks:

- hook scripts + setup scripts + `tool/pre_commit.dart`
- fast local subset; full suite remains CI responsibility

10. Architecture lint conventions:

- lightweight enforcement via `tool/architecture_lint.dart`
- CI step added

11. Richer empty states:

- enhanced API with optional illustration/icon and primary/secondary actions

12. Pull-to-refresh contract:

- helper contract + docs for refresh/load-more conflict behavior

13. Unified bottom sheet service:

- confirmation/action/selection/info variants

14. Status/result banners:

- reusable inline success/warning/error/info banners

### Constraint Compliance

- No push vendor SDK integration was added in this pass.
- No AndroidManifest, Info.plist, or platform permission declaration changes were made.
- Monitoring remains local/in-memory and provider-agnostic.

### New Test Coverage Added (v3.1)

- `test/push_notification_service_test.dart`
- `test/push_notification_handler_test.dart`
- `test/permission_service_test.dart`
- `test/api_monitoring_service_test.dart`
- `test/api_monitoring_interceptor_test.dart`
- `test/app_validators_test.dart`
- `test/validation_message_mapper_test.dart`
- `test/ui_state_test.dart`
- `test/search_history_service_test.dart`
- `test/pull_to_refresh_contract_test.dart`
- `test/bottom_sheet_service_test.dart`
- `test/status_banner_test.dart`
- `test/empty_state_test.dart`

### v3.1 Verification

Executed successfully:

```bash
flutter gen-l10n
dart format --set-exit-if-changed .
dart run tool/architecture_lint.dart
flutter analyze
flutter test
```

---

## Part 5: v3.3 Session Purge + Offline Truthfulness Hardening Addendum

This addendum captures two scoped hardening fixes implemented after v3.2:

1. Session-scoped purge on logout/session clear
2. Offline queue truthfulness based on actual replay capability

### Implemented Changes

#### 1) Session-scoped purge on logout and terminal session expiry

- Added `SessionScopedDataPurger` abstraction and `CompositeSessionScopedDataPurger` implementation:
  - `lib/core/session/session_scoped_data_purger.dart`
- Updated `SessionManager` to invoke centralized purge from `clearTokens()`:
  - `lib/core/session/session_manager.dart`
- Wired purge in DI with explicit user-scoped cleanup tasks:
  - `lib/injection.dart`

Purge task coverage:

- Search history + recent viewed items
- In-app notifications state
- Offline action queue
- User-scoped cache store

Operational safety:

- Stops `OfflineActionProcessor` before purge tasks
- Resumes `OfflineActionProcessor` after purge tasks
- Purge task failures are logged and do not crash logout/session-clear flow

Scope safety:

- App-scoped preferences are intentionally preserved (theme/locale/onboarding/static app prefs)
- User-scoped persisted state is removed

Execution paths covered:

- Explicit logout (`SessionManager.clearTokens()`)
- Terminal session expiry/forced clear via auth expiry path that calls `clearTokens()`

#### 2) Offline queue truthfulness (no replay promise without capability)

- Added replay capability checker:
  - `lib/core/offline/offline_replay_capability.dart`
- Registered capability in DI from actual executor list:
  - `lib/injection.dart`
- Updated sample feature VM behavior:
  - `lib/screens/sample_feature/sample_feature_view_model.dart`

Behavior now:

- If no capable executor exists for the action type:
  - action is not enqueued under replay promise assumptions
  - user sees truthful warning messaging
  - result is `OfflineQueueDecision.replayUnavailable`
- If capable executor exists:
  - enqueue and sync-enabled messaging are allowed
  - result is `OfflineQueueDecision.queuedForReplay`

UI alignment:

- `lib/screens/sample_feature/sample_feature_list_screen.dart` now branches toast messaging based on `OfflineQueueDecision`
- Added localization key `offlineReplayUnavailable`:
  - `lib/l10n/app_en.arb`
  - `lib/l10n/app_ar.arb`
  - regenerated localization files

### Tests Added/Updated in v3.3

Added:

- `test/session_scoped_data_purger_test.dart`
  - verifies logout/session clear purges user-scoped persisted data
  - verifies app-scoped preferences remain intact

Updated:

- `test/auth_interceptor_test.dart`
  - terminal refresh-auth failure path now asserts purge execution
- `test/sample_feature_view_model_test.dart`
  - replay unavailable path: no misleading sync promise and no enqueue assumption
  - replay available path: enqueue/sync messaging remains valid
- `test/widget_test.dart`
  - constructor wiring update for replay capability dependency

### v3.3 Verification

Executed successfully:

```bash
dart format --set-exit-if-changed .
dart run tool/architecture_lint.dart
flutter analyze
flutter test
```

Result:

- `dart format --set-exit-if-changed .`: `Formatted 181 files (0 changed)`
- `dart run tool/architecture_lint.dart`: `no violations found`
- `flutter analyze`: `No issues found`
- `flutter test`: all tests passed (`+148`)

---

## Part 6: v3.4 Architecture Truthfulness + Guard/Safety Hardening Addendum

This addendum captures hardening updates applied after the v3.3 audit findings.

### Implemented Changes

1. Architecture boundary correction (Repository/DataSource split):

- Moved sample data source contract + implementations out of repository file:
  - `lib/data/datasource/remote/sample_feature_data_source.dart`
- Added dedicated paginated model:
  - `lib/data/model/paginated_sample_items.dart`
- Repository now depends on datasource contract only:
  - `lib/data/repository/sample_feature_repo.dart`

2. Protected action auth centralization:

- Added `AuthActionGuard`:
  - `lib/core/session/auth_action_guard.dart`
- Registered in DI:
  - `lib/injection.dart`
- Sample protected action now uses centralized guard:
  - `lib/screens/sample_feature/sample_feature_list_screen.dart`

3. Route fail-closed hardening + safe path building:

- Unknown routes now fail-closed for all session states (redirect to known safe route).
- `AppRoutes.sampleDetailsPath` now URI-encodes `id`.
- Updated tests:
  - `test/route_guard_test.dart`
  - `test/app_routes_test.dart`

4. Logging safety hardening:

- `LoggingInterceptor.onError` now logs sanitized request/response details and
  avoids passing raw `DioException` objects directly to logger output.
  - `lib/data/datasource/remote/dio/logging_interceptor.dart`

5. Offline replay idempotency contract:

- Added persisted `idempotencyKey` to `OfflineAction` model with safe fallback.
- Included idempotency metadata in queue/executor/processor logs.
- Updated queue persistence tests.
  - `lib/core/offline/offline_action.dart`
  - `lib/core/offline/offline_action_executor.dart`
  - `lib/core/offline/offline_action_processor.dart`
  - `test/offline_action_queue_test.dart`

6. Localization consistency improvements:

- Removed hardcoded queue notification text from VM API surface by requiring
  localized strings at call-site.
- Added EN/AR localization keys for:
  - offline queue notification title/message
  - generic confirm/cancel/close labels used by bottom-sheet service
- Bottom-sheet default labels now localize via `AppLocalizations`.
  - `lib/screens/sample_feature/sample_feature_view_model.dart`
  - `lib/screens/sample_feature/sample_feature_list_screen.dart`
  - `lib/screens/component/layout/bottom_sheet_service.dart`
  - `lib/l10n/app_en.arb`
  - `lib/l10n/app_ar.arb`
  - regenerated localization files

7. Tooling and CI hardening:

- CI now runs `flutter gen-l10n`.
- CI now runs integration tests on Linux desktop target.
  - `.github/workflows/flutter_ci.yml`
- Architecture lint strengthened with additional repository/datasource rules:
  - `tool/architecture_lint.dart`

8. UI Kit cleanup:

- Removed deprecated `AppSnackBar` export from the default UI kit barrel file.
  - `lib/screens/component/ui_kit.dart`

### Tests Added/Updated in v3.4

Added:

- `test/auth_action_guard_test.dart`
- `test/app_routes_test.dart`

Updated:

- `test/route_guard_test.dart`
- `test/sample_feature_view_model_test.dart`
- `test/offline_action_queue_test.dart`

### v3.4 Verification

Executed locally:

```bash
flutter gen-l10n
dart format --set-exit-if-changed .
dart run tool/architecture_lint.dart
flutter analyze
flutter test
flutter build apk --dart-define=ENV=prod
```

Notes:

- `flutter test integration_test` requires a desktop device target/toolchain.
- CI workflow now includes a Linux desktop integration-test step.


---

## Part 7: v3.5 UI Foundation + Storybook Hardening Addendum

This addendum captures the UI-system-focused upgrades that strengthen template reuse from a design-system perspective.

### Implemented Changes

1. Storybook-style UI showcase hardening:

- Expanded `lib/components/ui_kit_showcase_screen.dart` with dedicated preview controls:
  - viewport presets (`adaptive`, `phone`, `tablet`, `desktop`)
  - text-scale slider
  - forced RTL preview toggle
- Added component stories for:
  - loading/empty/error/content state shell (`ScreenStateLayout`)
  - media and placeholders (`AppNetworkImage`, `AppCardSkeleton`, `AppListSkeleton`, `AppDetailsSkeleton`)
  - layout consistency (`AppSectionCard`, list-tile patterns)

2. Localization completeness for UI kit stories:

- Added missing EN/AR localization keys required by the new storybook controls and media/layout stories.
- Regenerated localization outputs (`app_localizations*.dart`).

3. Documentation alignment with real UI structure:

- Updated `README.md` with a dedicated UI foundation section, must-have vs nice-to-have component categories, and storybook route notes.
- Updated onboarding guides:
  - `PROJECT_ONBOARDING_GUIDE_EN.md`
  - `PROJECT_ONBOARDING_GUIDE_AR.md`
- Corrected shared UI path references to `lib/components/`.

4. Test/doc hygiene fix:

- Fixed Arabic text encoding corruption in `test/confirm_dialog_test.dart` so localized action assertions are valid and readable.

### Files Updated in v3.5

- `lib/components/ui_kit_showcase_screen.dart`
- `lib/l10n/app_en.arb`
- `lib/l10n/app_ar.arb`
- `lib/l10n/app_localizations.dart`
- `lib/l10n/app_localizations_en.dart`
- `lib/l10n/app_localizations_ar.dart`
- `README.md`
- `PROJECT_ONBOARDING_GUIDE_EN.md`
- `PROJECT_ONBOARDING_GUIDE_AR.md`
- `test/confirm_dialog_test.dart`

### v3.5 Verification

Executed locally:

```bash
flutter gen-l10n
dart format --set-exit-if-changed .
dart run tool/architecture_lint.dart
flutter analyze
flutter test
```

