# MathPro Premium Keyboard V28 — Changed Files Manifest

## Runtime files changed

- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_indicator.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/workspace/math_label.dart`
- `lib/features/workspace/template_tray.dart`

## Test contract changed

- `test/widget_test.dart`

Reason: V27 intentionally removed the long-press popup dismiss `×` chip after real-device visual review. The old standalone popup test still expected that removed chip. The test was updated to lock the new user-approved contract: no dismiss `×` chip in standalone long-press popup.

## Audit files added

- `docs/audit/PREMIUM_KEYBOARD_V28_VISUAL_REPAIR_CHANGED_FILES_MANIFEST.md`
- `docs/audit/PREMIUM_KEYBOARD_V28_VISUAL_REPAIR_IMPLEMENTATION_REPORT.md`
- `docs/audit/PREMIUM_KEYBOARD_V28_VISUAL_REPAIR_RELEASE_HYGIENE_REPORT.md`
- `docs/audit/PREMIUM_KEYBOARD_V28_VISUAL_REPAIR_STATIC_CHECK.txt`

## Files intentionally not changed

- Graph runtime files
- History runtime files
- Solver/evaluator bridge behavior
- Android/Gradle files
- Core keyboard key distribution in `key_config.dart`
