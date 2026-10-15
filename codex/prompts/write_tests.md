# Prompt Template: Write Tests

## Task
Add meaningful tests for specified modules/features in this repository.

## Required Process
1. Inspect implementation and existing test style first.
2. Cover critical behavior and edge cases with deterministic tests.
3. Use fakes/in-memory services; avoid flaky timing/network dependencies.
4. Prefer unit tests for services/viewmodels; add widget tests for reusable UI behavior.
5. Keep test names behavior-oriented and readable.
6. Run full test command and report result.

## Focus Areas (examples)
- Route guards and session states
- Interceptors/retry/rate-limit/dedup logic
- ViewModel state transitions
- Validation mapping/localization behavior
- Offline queue and persistence behavior

## Output Format
1. Test plan
2. File operations
3. Full content for changed/new tests
4. `flutter test` result summary
