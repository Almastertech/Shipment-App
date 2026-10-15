# ADR 0002: go_router + Route Guards

## Status
Accepted

## Context
The template requires declarative navigation, deep links, and centralized auth/guest route protection.

## Decision
Use `go_router` with guard resolution in `AppRouter.resolveGuardedRoute` and session-aware startup flow.

## Alternatives Considered
- Navigator 1.0: less declarative and harder to scale for guarded deep links.
- AutoRoute: capable but adds another layer and generator dependency.

## Consequences
- Route behavior is explicit and testable.
- Deep links and auth/guest behavior remain centralized.
- Push/deep-link route handling can reuse the same guard resolver.
