# MathPro Solution Panel V37 Test Const Repair Audit Report

## Scope
V37 is a targeted real-log repair package after the user's V36 Flutter output stopped at `test/widget_test.dart` compilation/analyzer issues.

This is not a new feature phase and not a prompt expansion. Runtime UI behavior is not changed.

## User Log Symptoms Targeted
- `unnecessary_const` at `test/widget_test.dart:639:14`
- `unnecessary_const` at `test/widget_test.dart:692:14`
- `unnecessary_const` at `test/widget_test.dart:737:14`
- `const_initialized_with_non_constant_value` at `test/widget_test.dart:907:14`
- `invalid_constant` at `test/widget_test.dart:907:14`
- Test loading failure: `steps: steps` was used inside a `const SolutionStepsSnapshot`.

## Changes
- Removed redundant explicit `const` from three `steps: <SolutionStep>[...]` list literals that already live inside const context.
- Converted the long-content regression snapshot from `const` to `final`, because it receives the runtime-generated `steps` list.
- Bumped `pubspec.yaml` version to `0.37.0+37`.

## Protected Runtime Areas
No runtime UI files were modified in this package.

Protected files intentionally unchanged:
- `lib/app/app_shell.dart`
- `lib/features/workspace/workspace_panel.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/features/solution/solution_step_models.dart`
- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/long_press_indicator.dart`
- `lib/features/keyboard/key_model.dart`
- `lib/features/graph/graph_card.dart`
- `lib/features/history/history_panel.dart`

## Local Verification Limits
Flutter/Dart is not available in the packaging container, so no local `flutter analyze`, `flutter test`, or `flutter run` PASS is claimed.

## Required User Verification
Run:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

## Decision
V37 is a targeted compile/analyzer repair for the exact V36 user log. Final PASS depends on the next real Flutter log.
