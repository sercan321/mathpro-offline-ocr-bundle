# Phase 9 Keyboard Regression Audit

Phase 9 intentionally did not redesign the keyboard.

## Frozen Flutter keyboard files checked against Phase 7

The following files are byte/hash identical between Phase 7 and Phase 9:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/long_press_indicator.dart`

## Preserved source decisions

- Tabs remain: Temel, Cebir, Kalkülüs, Kompleks, Lineer Cebir.
- Temel remains the 20-key core layout.
- Expanded tabs remain 8 × 5 grids.
- `MORE` remains `MORE`; it was not changed to `...`.
- `Ans` remains visible.
- `↵` remains the evaluate/enter action.
- `=` remains a literal equality symbol.
- Long-press options remain sourced from `KeyConfig`.

## Phase 9 UI changes did not alter keyboard geometry

Phase 9 changed workspace, history handle, selection toolbar, and template tray surfaces. It did not change key order, key count, tab order, keyboard height policy, spacing policy, or long-press map.
