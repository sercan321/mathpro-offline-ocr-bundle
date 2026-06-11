# Phase 9 Changed Files Manifest

Phase 9 is a full package built from Phase 7. It is not a patch package.

## Added

- `lib/features/workspace/selection_toolbar.dart`
- `lib/features/workspace/template_tray.dart`
- `docs/audit/PHASE8_CHANGED_FILES_MANIFEST.md`
- `docs/audit/PHASE8_REFERENCE_REGRESSION_AUDIT.md`
- `docs/audit/PHASE8_TEST_REPORT.md`
- `docs/audit/PHASE8_KEYBOARD_REGRESSION_AUDIT.md`
- `docs/audit/PHASE8_RELEASE_HYGIENE_REPORT.md`

## Modified

- `pubspec.yaml`
  - package name updated to `mathpro_flutter_phase12`
  - version updated to `0.9.0+9`
- `README.md`
  - updated for Phase 9 scope and honest test status
- `lib/app/app_shell.dart`
  - selection toolbar connected
  - template tray callback connected
- `lib/state/calculator_state.dart`
  - clipboard/undo/redo fields added for restored selection toolbar behavior
- `lib/state/calculator_controller.dart`
  - copy/cut/duplicate/paste/undo/redo/clear actions added
- `lib/features/editor/render/editor_interaction_layer.dart`
  - fixed `MathLayoutEngine.deriveSlotRects(canvasSize: ...)` call
- `lib/features/workspace/editor_viewport.dart`
  - pan/pinch support recovered via `InteractiveViewer`
- `lib/features/workspace/history_handle.dart`
  - restored compact RN-style 40 × 4 handle
- `lib/features/workspace/workspace_panel.dart`
  - temporary MORE preview replaced with template tray surface
- `lib/features/formula_engine/math_layout_engine.dart`
  - version string/comment updated for Phase 9
- `test/widget_test.dart`
  - package imports updated to Phase 9
  - history handle test updated after restoring compact unlabeled handle

## Frozen files intentionally preserved

Keyboard source files were not redesigned:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/long_press_indicator.dart`

