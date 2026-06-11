# Phase 17 Changed Files Manifest

## Changed source files

- `lib/features/workspace/template_tray.dart`
  - Replaced lazy horizontal `ListView.builder` with an all-built horizontal row inside `SingleChildScrollView` so all reference premium template labels, including `Norm`, exist in the widget tree during tests.
  - Added compact chip sizing to keep reference templates accessible in widget-test viewport without changing the frozen keyboard.

- `lib/features/history/history_drawer.dart`
  - Added `AnimationStyle.noAnimation` to `showModalBottomSheet` so history section headers such as `BUGÜN` are immediately available during widget tests after a normal pump.

- `pubspec.yaml`
  - Updated package identity to `mathpro_flutter_phase17`, version `0.17.0+17`.

- `test/widget_test.dart`
  - Updated package imports and test names to Phase 17.

## Added audit files

- `docs/audit/PHASE14_TEST_REPAIR_REPORT.md`
- `docs/audit/PHASE14_CHANGED_FILES_MANIFEST.md`
- `docs/audit/PHASE14_CONTENTS.txt`

## Frozen files not intentionally changed

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/long_press_indicator.dart`
