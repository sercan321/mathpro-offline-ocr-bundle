# MathPro FINAL REPAIR V8 — Phase 5 Slot Hitbox Audit

## Scope

This package implements Phase 5: Slot Hitbox Motor hardening.

Focus areas:

- `tan(□)`, `sin(□)`, `cos(□)`, `ln(□)` function argument slot selection.
- `√(□)` radicand slot selection.
- fraction numerator/denominator selection.
- integral lower/upper/body/differential selection.
- invisible touch target enlargement without changing visible keyboard layout.

## Root Cause Found

`tan(□)` was parsed as a `functionCall` and it did create a `functionArgument` slot. However, `TreeUtils.containsStructuralNode()` did not classify `MathNodeKind.functionCall` as structural. That meant the visible slot overlay path could be skipped for function templates, causing function arguments to fall back toward linear caret behavior instead of reliable slot selection.

## Implementation

Changed files:

- `lib/features/editor/tree_utils.dart`
- `lib/features/editor/slot_registry.dart`
- `lib/features/formula_engine/slot_interaction_calibration_policy.dart`
- `lib/features/formula_engine/slot_hit_testing.dart`
- `lib/features/formula_engine/slot_priority_policy.dart`
- `lib/features/formula_engine/real_device_slot_test_protocol.dart`
- `test/core_editor_regression_test.dart`

Untouched keyboard contract files:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`

## Key Fixes

- Function calls are now structural for slot overlay visibility.
- `functionArgument` minimum invisible touch target raised to 96dp.
- `sqrtValue`, `fractionNumerator`, `fractionDenominator` minimum invisible touch targets raised to 88dp.
- `integralUpperLimit` and `integralLowerLimit` minimum invisible touch targets raised to 88dp.
- `integralBody` minimum invisible touch target raised to 82dp.
- `integralDifferential` minimum invisible touch target raised to 72dp.
- Role-specific slop/fallback radii added for more forgiving edge taps.
- Priority scoring now gives stronger bias to critical small slots while keeping depth and visual containment behavior.
- Real-device protocol now includes a dedicated `function-argument-direct` scenario.
- Regression tests now lock Phase 5 minimum touch targets and function overlay behavior.

## Static Check Summary

```text
missing_dart_import_targets=0
dirty_cache_artifacts=0
runtime_history_shared_prefs_hits=0
key_config_unchanged_vs_v7=True
math_keyboard_unchanged_vs_v7=True
tree_utils_function_call_structural=True
function_argument_target_96=True
sqrt_fraction_integral_target_88=True
nearest_fallback_role_radius=True
function_manual_protocol_added=True
phase5_regression_tests_added=True
integral_longpress_no_double=True
```

## Not Run Here

This environment does not have Flutter/Dart SDK installed. The following commands were not executed here and must be run on the user's machine:

```powershell
flutter clean
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

No PASS claim is made without command evidence and real-device evidence.
