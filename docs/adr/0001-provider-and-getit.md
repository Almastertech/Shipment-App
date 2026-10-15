# ADR 0001: Provider + GetIt

## Status
Accepted

## Context
The template needs a state management approach that remains simple for teams, supports route-scoped view models, and avoids heavy framework lock-in.

## Decision
Use `Provider + ChangeNotifier` for UI state and `GetIt` for dependency composition.

## Alternatives Considered
- Riverpod: strong compile-time safety but adds migration/learning overhead for this template baseline.
- BLoC/Cubit: strong event/state modeling but more boilerplate for small and medium features.

## Consequences
- Fast onboarding and low boilerplate.
- Clear composition root in `injection.dart`.
- Teams can incrementally migrate specific features later if needed.
