# MathPro Phase H — Analyze Info Clean Changed Files Manifest

## Changed source/test files

1. `lib/features/editor/node_factory.dart`
   - Changed explicit-integral parser offset declaration to `const`.

2. `lib/features/editor/tex_serializer.dart`
   - Changed TeX function command composition from string concatenation to interpolation.

3. `lib/features/formula_engine/viewport_coordinate_transform.dart`
   - Removed redundant `dart:ui` import.

4. `test/core_editor_regression_test.dart`
   - Added `const` to constant `SlotEntry` fixtures.
   - Replaced deprecated `Matrix4.translate` / `Matrix4.scale` calls with typed alternatives.

5. `test/widget_test.dart`
   - Added `const` to constant `SlotEntry` fixtures and `Rect` fixture.
   - Replaced deprecated `Matrix4.translate` / `Matrix4.scale` calls with typed alternatives.

## Added audit files

1. `docs/audit/PHASE_H_ANALYZE_INFO_CLEAN_REPORT.md`
2. `docs/audit/PHASE_H_ANALYZE_INFO_CLEAN_CHANGED_FILES_MANIFEST.md`
3. `docs/audit/PHASE_H_ANALYZE_INFO_CLEAN_STATIC_CHECK.txt`

## Explicitly untouched keyboard files

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/key_model.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/long_press_indicator.dart`
