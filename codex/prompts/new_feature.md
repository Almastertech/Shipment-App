# Prompt Template: New Feature

## Task
Implement a new feature in this repository following existing architecture.

## Required Process
1. Inspect related files first (`injection.dart`, routing, feature screens/viewmodels, repositories, tests, docs).
2. Keep the flow: `UI -> ViewModel -> Repository -> DataSource -> DioClient`.
3. Add files in the correct layer (`core`, `data`, `screens`/`features`).
4. Register dependencies in `lib/injection.dart`.
5. Add/update routes in `app_routes.dart` + `app_router.dart` (including guards).
6. Add localization keys in ARB and run `flutter gen-l10n` if needed.
7. Add tests (unit/widget where practical).
8. Run verification commands and report results.

## Constraints
- Minimal disruption, strong typing, constructor injection.
- Respect architecture lint boundaries.
- Reuse existing UI systems (`ScreenStateLayout`, `StatusBanner`, `ToastService`, bottom sheet service, etc.).

## Output Format
1. Repository understanding (brief)
2. File operations
3. Full content for changed/new files
4. Verification results
