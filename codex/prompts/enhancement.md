# Prompt Template: Enhancement

## Task
Enhance an existing system while preserving current conventions and APIs where possible.

## Required Process
1. Inspect current implementation and extension points.
2. Prefer extending existing abstractions over introducing parallel systems.
3. Keep behavior compatible unless change is intentional and documented.
4. Update related tests.
5. Update docs when user-visible/architectural behavior changes.
6. Run verification commands.

## Constraints
- Avoid broad refactors unless requested.
- Keep code strongly typed and testable.
- Respect existing DI/routing/workflow patterns.

## Output Format
1. What was enhanced and why
2. File operations
3. Full content for changed/new files
4. Verification + docs updates
