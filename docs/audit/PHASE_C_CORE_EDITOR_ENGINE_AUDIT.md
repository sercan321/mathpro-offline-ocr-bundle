# MathPro Core Editor Engine — Phase C Audit

## Phase name
Phase C — Invisible Hit Area / Minimum 44x44 Mobile Touch Target Foundation

## Objective
Separate the visible slot/caret highlight from the invisible mobile touch target so small mathematical regions remain visually premium but are easier to tap on a phone.

## Implemented

### 1. Visual rect and hit rect are now separate concepts
`MathLayoutEngine` now emits visual slot rectangles only. These are used for the visible highlight/caret layer.

`SlotHitTesting` now builds a separate `SlotHitTarget`:

```text
visualRect -> visible highlight / caret geometry
hitRect    -> invisible finger target used by tap selection
```

### 2. Minimum touch target hardening
Every hit target is expanded to at least the global mobile target floor:

```text
minimumFingerTarget = 44
```

Role-specific policies can still request larger targets; for example root, fraction, and integral limit targets remain more generous.

### 3. User-facing debug contract preserved
No new debug overlay was added. `hitRect` is not rendered. The editor still renders only the active visual highlight/caret.

### 4. Regression coverage added
`test/widget_test.dart` now includes checks that:

- integral upper/lower/body/differential hit targets are at least 44x44,
- visual centers are inside hit targets,
- an outside-visual but inside-hit tap still selects the intended integral upper limit,
- sqrt/fraction/power/nested-root structures retain reachable hit targets.

### 5. Self-check hardened
`SlotEngineSelfCheck` now validates hit target minimum sizing and visual-center containment for the structural smoke-expression catalog.

## Preserved from previous phases

- Phase A debug-clean policy remains intact.
- Phase A/B TeX render path remains intact.
- Phase B node/template/slot ownership logic remains intact.
- Keyboard source files are unchanged from Phase B.
- `MORE`, `Ans`, `↵`, and literal `=` contracts are unchanged.

## Not claimed
This is not the full Photomath-level hit-test engine yet. Phase C provides the invisible target foundation. Full nearest-slot scoring and more nuanced overlap resolution belongs to Phase D — Priority Hit-Test Engine.

## Required local verification
Run locally:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```
