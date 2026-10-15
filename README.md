# Shipments

Flutter application for the Shipments Insurance Platform, built on a production-ready foundation.

This profile keeps the core architecture and UX foundations while intentionally removing:
- offline action queue/replay strategy
- feature flags
- remote config service
- global event bus
- GitHub CI/CD + git-hook automation files
- crash/analytics scaffolding (Sentry/Crashlytics-style adapters)

## Quick Links

- English onboarding: [PROJECT_ONBOARDING_GUIDE_EN.md](PROJECT_ONBOARDING_GUIDE_EN.md)
- Arabic onboarding: [PROJECT_ONBOARDING_GUIDE_AR.md](PROJECT_ONBOARDING_GUIDE_AR.md)
- Contributor guide: [CONTRIBUTING.md](CONTRIBUTING.md)
- ADRs: [docs/adr](docs/adr)
- Pull-to-refresh contract: [docs/patterns/pull_to_refresh_contract.md](docs/patterns/pull_to_refresh_contract.md)

## What You Get

### Core Stack

| Layer | Tool |
| --- | --- |
| State Management | Provider + ChangeNotifier |
| Dependency Injection | GetIt |
| Networking | Dio |
| Routing | go_router |
| Localization | gen-l10n + ARB |
| Images | cached_network_image + flutter_svg |
| Loading Skeleton | skeletonizer |

### Production Systems Included

- Session manager + auth interceptor + startup flow
- Guest mode (`unauthenticated / guest / authenticated`)
- Request deduplication
- Smart retry with backoff + jitter
- Network rate limiting
- In-memory cache with stale-while-revalidate reads
- Global toast overlay
- Local in-app notification center
- Push notification adapter architecture (`NoopPushNotificationService` by default)
- Permission abstraction layer
- API monitoring hooks + debug monitor screen
- Typed UI state (`UiState<T>`)
- Unified validation helpers
- Search history + recent items
- Rich empty/error states
- Bottom sheet service
- Shared design tokens + reusable section/card patterns
- Storybook-style UI kit showcase (`/ui-kit`)

## Removed in This Profile

The following template features were removed to keep the baseline smaller and simpler:

- `lib/core/offline/*`
- `lib/core/feature_flags/*`
- `lib/core/remote_config/*`
- `lib/core/events/*`
- `lib/core/observability/*`
- `.github/workflows/*`
- `.githooks/*`
- `scripts/setup-git-hooks.*`
- `tool/pre_commit.dart`

## Architecture

### Application Flow

```text
UI Screen
  -> ViewModel (ChangeNotifier)
  -> Repository
  -> DataSource
  -> DioClient + Interceptors
  -> API
```

### Composition Root

```text
main.dart
  -> injection.dart (GetIt)
  -> providers.dart
  -> AppRouter
```

## Folder Structure

```text
lib/
  app.dart
  main.dart
  injection.dart
  providers.dart

  core/
    cache/
    config/
    monitoring/
    network/
    permissions/
    push/
    refresh/
    routing/
    search/
    session/
    startup/
    state/
    storage/
    resources/  // includes AppImages
    utils/

  data/
    app_urls/
    datasource/remote/
    model/
    repository/

  features/
    notifications/

  components/
  screens/
  localization/
  l10n/
  themes/

docs/
  adr/
  patterns/

tool/
  architecture_lint.dart

test/
integration_test/
```

## Assets

Visual asset paths are centralized in `lib/core/resources/app_images.dart`.

- Use `AppImages.image('photo.png')` for raster assets in `assets/images/`
- Use `AppImages.svg('icon.svg')` with `SvgPicture.asset(...)` for SVG assets in `assets/images/`
- Use `AppImages.gif('loader.gif')` for assets in `assets/gif/`
- Use `AppImages.lottie('loading.json')` or `AppImages.loading` for assets in `assets/lottie/`

Example:

```dart
SvgPicture.asset(AppImages.svg('icon.svg'));
```

## Quick Start

```bash
flutter pub get
flutter gen-l10n
flutter run --dart-define=ENV=dev
```

### Environment Examples

```bash
flutter run --dart-define=ENV=staging
flutter run --dart-define=ENV=prod
flutter run --dart-define=USE_MOCK_API=false
flutter run --dart-define=ENABLE_LOGS=true
flutter run --dart-define=API_BASE_URL=https://your-api.example.com
```

Defaults:
- `USE_MOCK_API=true` in `ENV=dev`
- `USE_MOCK_API=false` in `ENV=staging` and `ENV=prod`
- `ENV=prod` requires non-placeholder `API_BASE_URL`

## Session and Routing Rules

- Session states: `unauthenticated`, `guest`, `authenticated`
- Guard types: `none`, `authOnly`, `authOrGuest`, `guestOnly`
- Unknown routes are fail-closed
- `SessionManager.clearTokens()` purges user-scoped persisted data:
  - search history
  - recent items
  - in-app notifications
  - in-memory user cache
- App-scoped preferences remain preserved:
  - theme mode
  - locale

## Networking and Cache

Interceptor order in `DioClient`:
1. `ApiMonitoringInterceptor`
2. `AuthInterceptor`
3. `RateLimitInterceptor`
4. `RetryInterceptor`
5. `LoggingInterceptor`

Cache behavior:
- stale-while-revalidate read pattern for list data
- cache fallback on request failure when valid cached data exists
- memory cache cap: `300` entries

## Notifications, Push, Permissions

In-app notifications:
- local notification center
- badge + persistence

Push notifications:
- adapter architecture ready
- default provider is noop (no vendor SDK wired)

Permissions:
- abstraction exists
- safe fallback behavior
- dangerous runtime permissions are not auto-declared

## Production Prerequisites

Before shipping:
1. Configure Android/iOS release signing.
2. Set valid `API_BASE_URL` for `ENV=prod`.
3. Keep Android `INTERNET` permission in manifest.
4. Replace noop push service if your app needs real push delivery.

## Testing

```bash
flutter gen-l10n
dart format --set-exit-if-changed .
dart run tool/architecture_lint.dart
flutter analyze
flutter test
flutter test integration_test -d linux
```

## Modular Migration Direction

Current stable shape:
- `screens/*`
- `data/*`
- `core/*`

Feature-first migration target:
- `features/<feature_name>/*`

Reference migrated module:
- `features/notifications`

## When to Use This Template

Use it when you need:
- auth + guest browsing
- stable layered architecture
- resilient networking + caching
- reusable UI foundation
- localization + testing baseline

Avoid it for:
- quick throwaway prototypes
- UI-only demos with no backend/session logic
