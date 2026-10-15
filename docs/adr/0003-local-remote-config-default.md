# ADR 0003: Static Local Runtime Config Defaults

## Status
Accepted

## Context
The simplified template profile intentionally removes remote config providers and feature flag systems to reduce moving parts and onboarding complexity.

## Decision
Use `AppRemoteConfig` as a static in-app defaults object (no remote provider, no runtime fetch layer).

## Alternatives Considered
- Local asset-backed remote config service: still adds provider lifecycle and parsing surface area.
- Vendor remote config by default: external dependency and setup overhead.

## Consequences
- Smaller dependency graph and simpler DI bootstrap.
- Deterministic runtime config behavior across environments.
- Teams can still adjust values centrally in `AppRemoteConfig` and evolve later if needed.
