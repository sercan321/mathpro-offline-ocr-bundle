# Phase 7 Keyboard Regression Audit

## Result

No keyboard-source drift was introduced in Phase 7.

## Hash/byte comparison basis

The following files were compared against Phase 6 and remained identical:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/long_press_indicator.dart`

## Frozen decisions preserved

- Tabs: `Temel`, `Cebir`, `Kalkülüs`, `Kompleks`, `Lineer Cebir`
- `Temel`: 20-key core keyboard
- Expanded tabs: 8 × 5 grid logic
- `MORE`: unchanged label and command role
- `Ans`: unchanged visible key
- `↵`: evaluation/enter action
- `=`: literal equality symbol
- Long-press map: unchanged
- Kalkülüs null/empty cells: unchanged

## Runtime note

Flutter runtime verification was not executed in the packaging environment because Flutter/Dart SDK was unavailable.
