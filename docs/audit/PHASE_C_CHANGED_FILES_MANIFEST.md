# MathPro Core Editor — Phase C Changed Files Manifest

## Scope
Phase C: Invisible Hit Area / 44x44 mobile touch target hardening.

## Changed files

1. `lib/features/formula_engine/math_layout_engine.dart`
   - Promoted layout output to visual slot rectangles only.
   - Removed visual-rect promotion to large finger target size.
   - Added Phase C layout version marker.

2. `lib/features/formula_engine/slot_interaction_calibration_policy.dart`
   - Added public canvas clamp helpers.
   - Kept role-based minimum touch target policy.
   - Added Phase C calibration version marker.

3. `lib/features/formula_engine/slot_hit_testing.dart`
   - Added `SlotHitTarget` with separate `visualRect` and `hitRect`.
   - Added public `targetFor` and `targetsFor` helpers.
   - Hit testing now evaluates invisible hit targets while returning visual rect for caret/highlight.
   - Added Phase C hit target version marker.

4. `lib/features/formula_engine/slot_engine_self_check.dart`
   - Added self-check coverage for minimum 44x44 hit rectangles.
   - Added visual-center containment check.
   - Added Phase C self-check version marker.

5. `test/widget_test.dart`
   - Added regression tests for visual vs invisible hit target separation.
   - Added regression tests for 44x44 minimum touch target contract.
   - Existing keyboard, render, template, and debug-clean tests preserved.

## Explicitly not changed

- `lib/features/keyboard/*`
- Tab names
- Key order
- Long-press mapping
- `MORE`
- `Ans`
- `↵`
- literal `=` behavior
- Android Gradle/bootstrap files
