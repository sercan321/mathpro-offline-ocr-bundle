# MathPro V86 — Calculus Structural Migration Audit

## Scope

This phase is a UI/editor-core phase, not a solver phase. It promotes the high-risk calculus derivative family from generic function-call handling toward a dedicated structural `MathNodeKind.derivative` path.

## Protected product contract

Unchanged:

- Keyboard positions
- Tab order
- `MORE`
- `Ans`
- `↵` evaluation role
- `=` equality role
- Graph UI
- History UI
- Solution panel UI
- Root long-press list
- Integral long-press list

## Main changes

- Added `MathNodeKind.derivative`.
- Added `NodeFactory.derivative()`.
- `d/dx(□)`, `d²/dx²(□)`, `d³/dx³(□)`, `∂/∂x(□)`, and `∂²/∂x²(□)` now parse as derivative nodes.
- `dy/dx` and `d²y/dx²` now parse as derivative nodes while staying non-solver notation.
- Added `derivativeBody` and `derivativeVariable` slot policy support.
- Added derivative-body hit-test sizing and role ordering.
- Updated PremiumMathKeySpecs and ActionUtils so derivative inputs focus `derivativeBody`, not generic `functionArgument`.
- Updated EditorTexSerializer so structural derivative nodes serialize to premium TeX.
- Added `test/v86_calculus_family_structural_migration_test.dart`.

## Explicit non-claims

- No differential equation solver was added.
- No symbolic derivative solver was added.
- No PDE/ODE classifier was added.
- No keyboard layout was changed.
- No solution panel behavior was changed.

## Acceptance evidence expected on user machine

```bash
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

This environment did not include Flutter/Dart, so those commands were not run here.
