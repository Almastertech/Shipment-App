# Prompt Template: Bug Fix

## Task
Fix a bug in this repository without breaking architecture.

## Required Process
1. Reproduce/locate bug path via existing tests and relevant source files.
2. Add a failing test first when feasible.
3. Fix root cause in the correct layer (not UI workaround unless UI bug).
4. Keep backward compatibility unless explicitly approved otherwise.
5. Add regression coverage.
6. Run verification commands and report outcomes.

## Constraints
- Keep changes minimal and focused.
- Respect routing/session/guard behavior.
- Respect architecture lint boundaries.

## Output Format
1. Root cause summary
2. File operations
3. Full content for changed/new files
4. Verification + regression tests
