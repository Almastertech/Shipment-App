# Features Folder (Hybrid Migration)

This template now supports a phased, feature-first structure under `lib/features/`.

Current migrated reference feature:
- `notifications/`
  - `domain/` models
  - `application/` state/service layer
  - `presentation/` widgets

Migration strategy:
1. Keep existing `screens/` and `data/` modules working.
2. Add new features directly under `lib/features/<feature_name>/`.
3. Migrate legacy features incrementally to avoid disruptive rewrites.
4. Keep cross-cutting shared infrastructure in `lib/core/`.