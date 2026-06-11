# MathPro V84 — True Slot Focus + Hit-Test Visual Order Audit

## Scope

This phase targets editor interaction quality, not solver capability. It preserves the frozen keyboard layout and focuses on the structural editor path that controls how visible math slots map to semantic slots.

## Changed runtime areas

- `lib/features/formula_engine/template_slot_navigation_policy.dart`
  - Reordered slot navigation to match visible placeholder order instead of generic semantic priority.
  - High-risk templates now map visible placeholders to the expected roles:
    - `log₍□₎(□)` → `logBase`, then `functionArgument`
    - `∫_{□}^{□}(□)d□` → `integralLowerLimit`, `integralUpperLimit`, `integralBody`, `integralDifferential`
    - `□√(□)` → `rootIndex`, then `sqrtValue`
    - `□^(□)` → `powerBase`, then `powerExponent`
    - `□⁄□` → `fractionNumerator`, then `fractionDenominator`

- `lib/features/formula_engine/render_mapped_slot_hit_test.dart`
  - Slot visual rects are now role-aligned vertically.
  - Tiny math areas such as log base, subscript, power exponent, root index, fraction numerator/denominator and integral limits are no longer flattened to one center line.
  - This reduces the old failure mode where the user taps the visible lower/upper/base slot but the wrong semantic slot receives focus.

- `lib/features/workspace/editor_viewport.dart`
  - Active-slot auto-visibility now uses render-mapped slot rectangles rather than a placeholder-only approximation.
  - Long/nested expression caret-follow therefore tracks the actual active slot rectangle more closely.

- `lib/features/formula_engine/slot_interaction_calibration_policy.dart`
  - Added missing ordering for `subscript`, `subscriptBase`, `logBase`, and `derivativeOrder` in the mobile hit priority order.

## Added test

- `test/v84_slot_focus_hit_test_visual_order_test.dart`

The test locks:

1. visible placeholder order for log/root/power/fraction/integral templates,
2. semantic hit-test result at visual placeholder centers,
3. role-aware vertical placement for upper/lower/base slots,
4. mobile finger target minimums for tiny math slots,
5. V84 render-mapped slot hit-test version metadata.

## Explicit non-claims

- This phase does not add a CAS/solver.
- This phase does not claim full Photomath/WolframAlpha parity.
- This phase does not claim real-device PASS until `flutter run -d 23106RN0DA` is tested by the user.
- This phase does not modify graph/history/solution-panel UX.

## Frozen contracts preserved

- Keyboard tab order unchanged.
- Key positions unchanged.
- `MORE` unchanged.
- `Ans` unchanged.
- `↵` remains evaluate.
- `=` remains equality.
- Root long-press contract unchanged.
- Integral long-press contract unchanged.
