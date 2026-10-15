# Contributing Guide

## Core Principles
- Keep architecture additive and low-disruption.
- Prefer strongly typed APIs over dynamic maps.
- Add focused files instead of broad rewrites.
- Preserve existing conventions unless a strong architectural reason exists.

## Folder Conventions
- `lib/core`: cross-cutting infrastructure and abstractions.
- `lib/data`: API/data-source/repository layer.
- `lib/screens`: current presentation layer.
- `lib/features`: phased modular migration target.
- `lib/components`: shared UI foundation.

## Adding a Feature
1. Add screen/view model under `lib/screens/<feature>/` (or `lib/features/<feature>/` for new modules).
2. Add repository/data source contracts in `lib/data`.
3. Register dependencies in `lib/injection.dart`.
4. Add route constants and route builders.
5. Add/extend tests for view model + repository + routing behavior.

## Routing Rules
- Register paths in `AppRoutes`.
- Use `AppRouter.resolveGuardedRoute` for auth/guest behavior.
- Public browse routes may use `authOrGuest`; protected actions remain auth-only.

## Dependency Registration Rules
- Use `registerLazySingleton` for long-lived services.
- Use `registerFactory` for route-scoped view models.
- Avoid direct `GetIt` lookups inside domain classes.

## Config Rules
- Use `AppRemoteConfig` static defaults for runtime tunables.
- Do not reintroduce remote-config providers without updating docs/tests.

## Removed Systems in This Profile
Do not re-add these by accident in routine feature work:
- offline queue/replay
- feature flags
- event bus
- crash/analytics abstractions
- GitHub workflow + git-hook setup scripts

## Testing Expectations
- Add unit tests for each new service and edge case.
- Add widget tests for reusable UI components where practical.
- Keep fast checks runnable locally.

## Docs Update Expectations
For architecture-impacting changes update:
- `README.md`
- `PROJECT_ONBOARDING_GUIDE_EN.md`
- `PROJECT_ONBOARDING_GUIDE_AR.md`
- relevant ADR under `docs/adr/`
