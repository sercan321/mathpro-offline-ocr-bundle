# Phase 17 Changed Files Manifest

## Changed

- `pubspec.yaml`
  - Updated package identity to `mathpro_flutter_phase17`, version `0.17.0+17`.
- `test/widget_test.dart`
  - Updated package imports/test names to Phase 17.
  - Replaced the history drawer test's `pumpAndSettle()` wait with deterministic fixed pumps to avoid timeout from unrelated active UI animations.
- `README.md`
  - Updated to Phase 17.
- `docs/audit/RUN_INSTRUCTIONS.md`
  - Updated to Phase 17.
- `docs/audit/PHASE16_HISTORY_TEST_REPAIR_NOTES.md`
  - Added repair explanation.
- `docs/audit/PHASE16_STATIC_VERIFICATION.md`
  - Added packaging verification notes.

## Not changed

The frozen keyboard source files were not changed:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/long_press_indicator.dart`
