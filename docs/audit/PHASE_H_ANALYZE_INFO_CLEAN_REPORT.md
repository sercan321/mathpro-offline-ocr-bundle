# MathPro Phase H — Flutter Analyze Info Clean Repair Report

## Scope

This repair responds to the user's local `flutter analyze` output showing 18 informational lint issues and no blocking errors.

The repair is intentionally narrow:

- No keyboard layout changes.
- No tab changes.
- No key order changes.
- No long-press map changes.
- No MORE / Ans / ↵ / = behavior changes.
- No runtime editor behavior change beyond lint-safe source cleanup.

## Analyzer issues addressed

### 1. `prefer_const_declarations`

File:

- `lib/features/editor/node_factory.dart`

Change:

- Converted the constant explicit-integral lower marker offset to a const declaration.

Reason:

- The marker `∫_{` is fixed and has a stable source offset of 3 code units in the existing parser contract.

### 2. `prefer_interpolation_to_compose_strings`

File:

- `lib/features/editor/tex_serializer.dart`

Change:

- Replaced string concatenation for TeX function names with Dart string interpolation.

Behavior preserved:

- `sin` still serializes as `\sin`.
- `cos` still serializes as `\cos`.
- `ln` still serializes as `\ln`.

### 3. `unnecessary_import`

File:

- `lib/features/formula_engine/viewport_coordinate_transform.dart`

Change:

- Removed the redundant `dart:ui` import because the needed UI types are already available through `package:flutter/widgets.dart`.

### 4. `prefer_const_constructors`

Files:

- `test/core_editor_regression_test.dart`
- `test/widget_test.dart`

Change:

- Converted constant `SlotEntry` test fixtures to `const`.
- Converted constant test rect declaration to `const`.

Behavior preserved:

- No test logic was weakened.
- Hit-test, priority, nested-depth and selection assertions remain intact.

### 5. `deprecated_member_use` for `Matrix4.translate` and `Matrix4.scale`

Files:

- `test/core_editor_regression_test.dart`
- `test/widget_test.dart`

Change:

- Replaced deprecated matrix mutation calls:
  - `translate(...)` -> `translateByDouble(..., ..., 0.0, 1.0)`
  - `scale(...)` -> `scaleByDouble(..., ..., ..., 1.0)`

Behavior preserved:

- The same pan/zoom transforms are represented.
- Phase F coordinate transform tests still validate canvas/viewport round trips.

## Keyboard contract verification

The following files were compared against the previous full package and were unchanged:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/key_model.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/long_press_indicator.dart`

Result:

- PASS — keyboard source was not modified.

## Hygiene verification

The package was checked for forbidden generated/cache directories:

- `build/`
- `.dart_tool/`
- `.gradle/`
- `__pycache__/`
- `.pytest_cache/`
- `.pyc`

Result:

- PASS — forbidden generated/cache artifacts were not included.

## Flutter command status

This environment does not include Flutter SDK, so the following commands could not be executed here:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

The user should run them locally. The goal of this package is to clear the 18 `flutter analyze` info items reported by the user's local analyzer output.
