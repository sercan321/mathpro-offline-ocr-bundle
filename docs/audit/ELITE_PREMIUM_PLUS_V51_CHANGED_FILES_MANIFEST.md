# V51 Changed Files Manifest

## Runtime changed

1. `lib/logic/evaluator_bridge.dart`
   - Added semantic analyzer and limited symbolic evaluator bridge.
   - Added numeric support for powers, constants and selected elementary functions.
   - Added derivative/integral/ODE/PDE classification and scoped handling.

2. `lib/features/solution/solution_step_models.dart`
   - Solution panel step composer now consumes semantic analysis.
   - Unsupported advanced structures now produce clear limitation steps.
   - Derivative/integral/ODE/PDE inputs get more meaningful in-workspace explanation text.

## Package/docs changed

3. `pubspec.yaml`
   - Version bumped to `0.51.0+51`.

4. `README.md`
   - Added V51 release section.

5. `docs/audit/ELITE_PREMIUM_PLUS_V51_*`
   - Added audit, manifest and hygiene records.

## Explicitly unchanged frozen keyboard files

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/long_press_popup.dart`
