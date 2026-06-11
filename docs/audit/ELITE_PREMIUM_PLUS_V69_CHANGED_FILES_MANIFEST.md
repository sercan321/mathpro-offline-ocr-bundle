# MathPro V69 — Changed Files Manifest

## Production Files Changed

- `lib/features/workspace/editor_viewport.dart`
  - Enables long/nested/slot expression viewport navigation.
  - Adds caret/slot visibility follow logic.
  - Adds a stable `mathpro-editor-interactive-viewer` test key.

- `lib/features/editor/render/editor_interaction_layer.dart`
  - Adds `allowDragCaretUpdates`.
  - Keeps tap-based slot/caret selection while allowing parent viewport panning for long/nested expressions.

## Test / Metadata Files Changed

- `test/widget_test.dart`
  - Adds V69 regression tests for long nested slot expression navigation and short expression tap-first behavior.

- `pubspec.yaml`
  - Version bumped to `0.69.0+69`.

## Files Intentionally Not Changed

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/logic/evaluator_bridge.dart`
- `lib/features/solution/solution_step_models.dart`
