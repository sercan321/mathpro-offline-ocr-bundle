# MathPro FINAL REPAIR V8 — Changed Files Manifest

## Changed Runtime Files

- `lib/features/editor/tree_utils.dart`
  - Added `MathNodeKind.functionCall` to structural-node detection so function templates show slot overlay instead of falling back to linear caret only.

- `lib/features/editor/slot_registry.dart`
  - Raised min touch sizes and priorities for critical slots: function argument, sqrt, fraction, integral limits/body/differential, power/root, matrix cells.

- `lib/features/formula_engine/slot_interaction_calibration_policy.dart`
  - Added Phase 5 calibration constants.
  - Added role-specific larger minimum touch targets.
  - Added role-specific fallback radii.
  - Increased slop for critical mathematical slots.

- `lib/features/formula_engine/slot_hit_testing.dart`
  - Updated version string.
  - Uses role-specific fallback radius when no direct candidate is found.

- `lib/features/formula_engine/slot_priority_policy.dart`
  - Updated scoring for stronger critical-slot selection.
  - Added role-specific hit containment bonus and distance weighting.

- `lib/features/formula_engine/real_device_slot_test_protocol.dart`
  - Added `function-argument-direct` scenario.
  - Updated protocol version to Phase 5.

## Changed Test Files

- `test/core_editor_regression_test.dart`
  - Added function overlay assertion for `tan(□)`.
  - Added Phase 5 premium invisible touch target regression test.
  - Updated real-device protocol version and scenario expectation.

## Explicitly Unchanged Keyboard Contract Files

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`

No keyboard layout, tab, key order, `MORE`, `Ans`, `↵`, or `=` contract change was made.
