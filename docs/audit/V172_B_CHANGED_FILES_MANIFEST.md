# V172-B Changed Files Manifest

## Runtime Files Changed

1. `lib/state/calculator_controller.dart`
   - Keeps the caret inside single open `functionArgument` templates after first insertion.
   - Adds a private `_indexOfNthPlaceholder` helper used only for this narrow caret placement repair.

2. `lib/features/editor/selection_controller.dart`
   - Updates the caret controller version string to include the V172-B function-continuity contract while preserving prior `v8` / `phase6-token-aware` compatibility substrings used by existing tests.

## Test Files Changed

3. `test/core_editor_regression_test.dart`
   - Adds V172-B regression tests for `sin(300)` typing continuity and visible digit-gap caret targeting.

## Documentation / Metadata Changed

4. `README.md`
5. `pubspec.yaml`
6. `docs/audit/V172_B_TAP_TO_CURSOR_ACCURACY_AUDIT_REPORT.md`
7. `docs/audit/V172_B_CHANGED_FILES_MANIFEST.md`
8. `docs/audit/V172_B_SELF_CHECK_REPORT.md`

## Protected Runtime Files Not Edited

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/features/graph/graph_card.dart`
- `lib/features/history/history_controller.dart`
- `lib/features/history/history_panel.dart`
