# Phase 5 Changed Files Manifest

This is a full package delivery, not a patch package.

## Added

- `lib/features/editor/render/math_render_surface.dart`
- `lib/features/editor/render/math_tex_serializer.dart`
- `lib/features/editor/render/visible_renderer_policy.dart`
- `lib/features/editor/render/premium_root_glyph.dart`
- `docs/audit/PHASE5_CHANGED_FILES_MANIFEST.md`
- `docs/audit/PHASE5_RENDER_DECISION_AUDIT.md`
- `docs/audit/PHASE5_KEYBOARD_REGRESSION_AUDIT.md`
- `docs/audit/PHASE5_STATIC_VERIFICATION.md`
- `docs/audit/PHASE5_TEST_REPORT.md`

## Modified

- `pubspec.yaml`
  - package name updated to `mathpro_flutter_phase5`
  - version updated to `0.5.0+5`
  - `flutter_math_fork` dependency added
- `lib/features/workspace/editor_viewport.dart`
  - active expression preview now uses `MathRenderSurface`
  - existing caret/empty-slot visual behavior preserved
- `lib/features/workspace/result_view.dart`
  - result line now uses `MathRenderSurface`
- `test/widget_test.dart`
  - package import updated to Phase 5
  - expression assertions updated to render-surface keys because active expression is no longer plain `Text`
- `README.md`
  - updated for Phase 5 scope and limitations

## Unchanged keyboard-critical files

The following files were compared against Phase 4 and intentionally left unchanged:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/long_press_indicator.dart`
- `lib/features/keyboard/key_model.dart`
