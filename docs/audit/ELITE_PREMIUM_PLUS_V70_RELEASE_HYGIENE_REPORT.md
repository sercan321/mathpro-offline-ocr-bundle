# MathPro V70 — Release Hygiene Report

## Excluded Dirty Outputs

The package creation step excludes:

- `build/`
- `.dart_tool/`
- `.gradle/`
- `.idea/`
- `__pycache__/`
- `*.pyc`
- `.pytest_cache/`
- temporary files

## Changed Production Files

- `lib/features/editor/editor_commands.dart`
- `lib/state/calculator_controller.dart`
- `lib/features/editor/render/math_tex_serializer.dart`
- `lib/features/editor/tex_serializer.dart`

## Locked Areas

The following files were intentionally not modified in V70:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/logic/evaluator_bridge.dart`
- `lib/features/solution/solution_step_models.dart`
