# MathPro V68 — Changed Files Manifest

- M `lib/features/keyboard/bottom_dock.dart`
- M `lib/features/workspace/workspace_panel.dart`
- M `pubspec.yaml`
- M `test/widget_test.dart`

## Intentional Production Changes

- `lib/features/workspace/workspace_panel.dart`: remove workspace card horizontal shrink.
- `lib/features/keyboard/bottom_dock.dart`: lock keyboard shell to full available outer rail and add regression key.

## No Solution/Solver/Keyboard Topology Change

The keyboard topology remains sourced from `key_config.dart` and `math_keyboard.dart`; both are unchanged.
