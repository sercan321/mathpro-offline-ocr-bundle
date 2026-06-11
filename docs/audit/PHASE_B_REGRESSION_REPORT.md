# PHASE B REGRESSION REPORT

## Keyboard freeze check

PASS by file diff against Phase A package.

Unchanged files:

- `key_config.dart`
- `bottom_dock.dart`
- `math_keyboard.dart`
- `premium_key.dart`
- `long_press_popup.dart`
- `long_press_indicator.dart`

## Debug surface check

No user-facing `Aktif slot:` output was reintroduced. Internal roles remain internal engine identifiers only.

## Structural behavior checks added to tests

- Power template `□^(□)` exposes base and exponent slots.
- Filling base results in `x^(□)` and exponent remains structurally addressable.
- Fraction `□⁄□` supports numerator and denominator partial fills.
- `√(x)` still serializes as structural TeX `\sqrt{x}`.
- Nested root `√(√(□))` exposes nested sqrt slot entries.
- Editable definite integral `∫_{□}^{□}(□)d□` exposes lower/upper/body/differential slots.
- Fixed definite integral `∫₀¹(□)dx` exposes body only, not false lower/upper slots.

## Not executed here

Flutter SDK is not installed in this environment, so the following were not executed here:

- `flutter pub get`
- `flutter analyze`
- `flutter test`
- `flutter run`

These commands are required on the user's local machine before calling the package runtime PASS.
