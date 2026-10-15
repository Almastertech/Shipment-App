# ADR 0004: Guest Mode as First-Class Session

## Status
Accepted

## Context
Apps often need public browse flows with protected checkout/favorite actions. Treating guest as just unauthenticated leads to brittle route/action behavior.

## Decision
Represent guest mode explicitly in `SessionManager` (`isGuest`, `isSignedIn`) and route guards (`authOrGuest`) while keeping protected actions auth-only.

## Alternatives Considered
- Only unauthenticated/authenticated: forces early login and weak browse UX.
- Separate guest token auth backend requirement: out of scope for template default.

## Consequences
- Clear three-state model: unauthenticated, guest, authenticated.
- Better UX for browse-first apps.
- Protected actions can consistently prompt login upgrade.
