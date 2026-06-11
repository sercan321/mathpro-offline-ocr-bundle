# V161 Stale Regression Repair and Structural Contract Restoration Audit

## Scope
V161 repairs regressions surfaced by the real user Flutter log after V160. The log showed `flutter analyze` failures, undefined `TexSerializer`, stale metadata tests, stale V143/V146 assumptions, fixed-atom false slots, series focus drift, and public render contract gaps.

## Repairs
- Restored `TexSerializer.serialize(...)` compatibility facade to `EditorTexSerializer`.
- Updated active package metadata to `V161 / 0.161.0+161`.
- Restored bounded integral first-focus contract to `integralBody` without changing keyboard layout.
- Prevented fixed atom power/postfix nodes such as `i²`, `y′`, `y″`, `y‴`, and `z̄` from exposing false editable slots.
- Restored geometric series focus/slot role contract around `seriesVariable` / `seriesOrder`.
- Added `postfix` and `placeholder` to the owned AST renderability gate so public postfix and derivative-order templates do not fall back to legacy string render.
- Repaired stale regression tests that hard-coded old active package versions.
- Preserved MathJax SVG-only guard.

## Protected Surface Statement
No keyboard topology, key positions, long-press ordering, Graph UI, History UI, Solution UI, EditorViewport layout, or EditorInteractionLayer behavior was intentionally changed.

## Test Honesty
Flutter/Dart are not available in this environment. No local `flutter pub get`, `flutter analyze`, `flutter test`, or `flutter run` PASS is claimed.
