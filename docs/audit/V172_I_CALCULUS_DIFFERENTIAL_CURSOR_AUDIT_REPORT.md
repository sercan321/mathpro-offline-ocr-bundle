# V172-I Calculus / Differential Cursor Audit Report

## Scope
V172-I adds a dedicated cursor/navigation policy for calculus and differential-equation editing surfaces. This is not a solver phase and does not claim advanced ODE/PDE solving.

## Implemented
- Added `lib/features/editor/calculus_cursor_navigation_policy.dart`.
- Integrated the calculus policy into `TemplateSlotNavigationPolicy` for same-node calculus slot ordering.
- Strengthened `SlotPriorityPolicy` scoring for calculus boundary slots: integral limits, limit variable/target, sum/product limits, integral differential and derivative variable.
- Strengthened `LongExpressionNavigationPolicy` caret visibility targets for calculus slots.
- Added regression tests in `test/core_editor_regression_test.dart`.

## Protected Areas
The following behavior is intended to remain untouched:
- Keyboard layout and key positions.
- MORE behavior.
- Ans / = / ↵ contracts.
- Long-press maps and ordering.
- Graph / History / Solution behavior.
- Green debug overlay remains disabled in production.

## Evidence
- Local `tool/verify_mathpro_contract.py` completed without hard failures.
- Flutter/Dart are not installed in the assistant execution environment, so no local Flutter PASS is claimed.
- GitHub Actions must run `flutter pub get`, `flutter analyze`, and `flutter test` on this package.

## Remaining Risks
- Real-device tap accuracy for calculus slots still needs manual Pixel/Android QA.
- Renderer-synchronized bounds and long-press loupe are still later phases.
- This phase does not add a CAS or differential equation solver.
