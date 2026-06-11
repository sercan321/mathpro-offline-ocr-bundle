# MathPro Final Repair V7 — Changed Files Manifest

## Modified

1. `lib/features/keyboard/long_press_popup.dart`
   - Rebuilt the popup as a fixed-height premium horizontal overlay surface.
   - Added public envelope constants for regression protection.
   - Increased chip height and bounded integral chip width.

2. `lib/features/workspace/math_label.dart`
   - Enlarged the compact/chip bounded integral glyph.
   - Increased integral mark size and limit box size.
   - Preserved the keycap variant behavior.

3. `test/core_editor_regression_test.dart`
   - Added a regression contract for Phase 4 long-press popup envelope constants.
   - Confirms integral long-press map excludes `∬`.

4. `test/widget_test.dart`
   - Added a widget regression check for the bounded integral chip envelope.

## Explicitly unchanged

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
