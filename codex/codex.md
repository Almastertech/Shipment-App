# Codex Operating Guide for `Shipments`

This file defines how Codex should execute work in this repository.

## 0) Official Flutter AI Rules (Codex Only)
- Codex must also apply the official Flutter AI rules mirrored here:
  - `codex/flutter_ai_rules/rules.md` (full)
  - `codex/flutter_ai_rules/rules_10k.md` (preferred compact default)
  - `codex/flutter_ai_rules/rules_4k.md`
  - `codex/flutter_ai_rules/rules_1k.md`
- These rules are for Codex usage in this repository only.
- Precedence:
  1. User request
  2. `codex/codex.md` (repo-specific)
  3. `codex/flutter_ai_rules/*` (generic Flutter guidance)

## 1) Core Operating Principles
- Inspect first, then change code.
- Prefer low-disruption edits that preserve existing architecture and naming.
- Keep solutions strongly typed and testable.
- Reuse existing abstractions/components before adding new ones.
- Update docs/tests with behavior changes.

## 2) Execution Flow (Always)
1. Discover impacted architecture/files.
2. Identify existing abstraction to extend.
3. Implement minimal additive changes.
4. Wire DI/routes/providers/localization as needed.
5. Add or update tests.
6. Run verification commands.
7. Update docs when architecture/workflow changes.

## 3) New Feature Workflow
1. Define feature scope and guard requirements (public/guest/auth-only).
2. Place files:
   - cross-cutting infra -> `lib/core/*`
   - data/repository/datasource -> `lib/data/*`
   - presentation + VM -> `lib/screens/<feature>/` (or `lib/features/<feature>/` for modular migration)
3. Build flow `UI -> VM -> Repository -> DataSource -> DioClient`.
4. Register dependencies in `lib/injection.dart`.
5. Add route constants in `app_routes.dart`; wire `app_router.dart`; update guard logic.
6. Localize user-facing strings in `lib/l10n/app_en.arb` + `app_ar.arb`.
7. Add tests for new logic and route behavior.

## 4) Bug Fix Workflow
1. Reproduce from existing tests or create failing test first.
2. Trace through proper layer (UI/VM/repository/network/session).
3. Fix at the root layer, not with UI-only patching.
4. Keep API compatibility unless fix requires controlled change.
5. Add regression test.
6. Run targeted + full verification.

## 5) Enhancement Workflow
1. Confirm enhancement is extension of existing system (not parallel duplicate).
2. Prefer extending current abstractions (`FeatureFlags`, `RemoteConfigService`, `UiState`, `StatusBanner`, etc.).
3. Keep old call sites working when possible.
4. Document behavioral deltas in README/migration report when user-visible or architectural.

## 6) Refactor Workflow
1. Refactor only within requested scope.
2. Preserve behavior; rely on tests as guardrails.
3. Split into mechanical vs behavioral changes.
4. Avoid broad migration unless explicitly requested.
5. If introducing a new architectural decision, add/update ADR.

## 7) Architecture Guardrails
- Presentation (`lib/screens/**`) must not import `dio` or remote dio datasource files.
- Repositories must not import presentation/widgets.
- Feature modules should avoid direct imports of `injection.dart`.
- EventBus is only for app-wide events.
- Use `DioClient`, not raw API calls from UI/VM.

## 8) State and ViewModel Rules
- New/updated screens should prefer typed `UiState<T>`.
- Keep VM dependencies constructor-injected.
- Avoid side effects in getters.
- Support refresh/loadMore patterns via existing pagination + pull-to-refresh contract.

## 9) Routing and Session Rules
- Route definitions: `app_routes.dart`.
- Guard resolution + known route checks: `app_router.dart`.
- Session states: unauthenticated / guest / authenticated (`SessionManager`).
- Protected actions must enforce authenticated state; guest can browse allowed routes only.

## 10) Networking Rules
- Interceptors are centralized in `DioClient`.
- Respect retry policy:
  - idempotent methods retry by default
  - mutating methods retry only when `extra['retryable'] == true`
  - no retry for 401/403/422
- Respect rate-limit bypass flags only for approved internal/background flows.

## 11) Generated/Derived Files
- Localization:
  - Edit ARB files only (`lib/l10n/app_en.arb`, `app_ar.arb`)
  - Run `flutter gen-l10n` to regenerate localization Dart files.
- Do not hand-edit generated localization outputs unless unavoidable.

## 12) DI / Provider Wiring Checklist
When adding a service:
- Register in `lib/injection.dart`.
- Choose lifecycle correctly:
  - singleton/lazy singleton for app-wide service
  - factory for screen/route scoped VM.
- If service is `ChangeNotifier` used by app shell/debug screens, expose via `lib/providers.dart`.

## 13) UI System Usage Rules
- For loading/empty/error/content, use `ScreenStateLayout` + `ErrorUiMapper`.
- For transient global feedback, use `ToastService` (overlay), not snackbar.
- For inline status feedback, use `StatusBanner`.
- For modal actions/confirmations, use `AppBottomSheetService`.
- For network images, use `AppNetworkImage`.

## 14) Documentation Update Rules
Update `README.md` when:
- adding/removing major system capabilities
- changing setup/verification workflow
- changing folder conventions

Update `TEMPLATE_MIGRATION_REPORT.md` when:
- architecture-level upgrades or migration milestones occur

Update `docs/adr/*` when:
- a core architectural decision changes (routing/DI/state/offline/config boundaries)

Update `CONTRIBUTING.md` when:
- team process, rules, or contribution workflow changes.

## 15) When to Ask for Clarification
Ask user before proceeding only when:
- business rule is ambiguous and affects auth/guest/security behavior
- a change can break public API/contracts materially
- provider/vendor selection is required but not specified

Otherwise, make safe assumptions consistent with current repo patterns.

## 16) Required Verification Before Finalizing
```bash
flutter pub get                      # if pubspec changed
flutter gen-l10n                     # if ARB changed
dart format --set-exit-if-changed .
dart run tool/architecture_lint.dart
flutter analyze
flutter test
```

Recommended for quick local loop:
```bash
dart run tool/pre_commit.dart
```

## 17) Final Output Expectations (for change tasks)
- List exact file operations.
- Explain what changed and why (brief, technical).
- Report verification commands and outcomes.
- Call out any intentional skips due to constraints (noop/adapter-only/local-only).
