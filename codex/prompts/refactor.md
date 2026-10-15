# Prompt Template: Refactor

## Task
Refactor code for clarity/maintainability without changing intended behavior.

## Required Process
1. Define exact refactor scope and non-goals.
2. Inspect tests covering the area; add missing safety tests if needed.
3. Perform mechanical refactor in small, reviewable edits.
4. Preserve architecture boundaries and DI/routing contracts.
5. Re-run tests and static checks.

## Constraints
- No behavior drift unless explicitly requested.
- No architecture rewrites during local refactor tasks.
- Keep public APIs stable where possible.

## Output Format
1. Refactor scope
2. File operations
3. Full content for changed/new files
4. Verification and behavior parity notes
