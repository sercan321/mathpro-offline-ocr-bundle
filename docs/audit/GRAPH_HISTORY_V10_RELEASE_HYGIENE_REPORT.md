# GRAPH/HISTORY V10 Release Hygiene Report

## Package hygiene policy

The release ZIP must not include generated or temporary build artifacts.

Forbidden examples:

- `build/`
- `.dart_tool/`
- `.gradle/`
- `__pycache__/`
- `.pyc`
- `.pytest_cache/`
- partial patch-only delivery

## Result

The V10 package was prepared as a full project ZIP. Forbidden generated artifacts were scanned before packaging.

## Keyboard protection

Keyboard-critical files were not edited in V10:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
