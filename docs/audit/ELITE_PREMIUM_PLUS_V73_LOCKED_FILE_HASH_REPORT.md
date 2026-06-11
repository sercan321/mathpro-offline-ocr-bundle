# MathPro V73 — Locked File Hash Report

Baseline runtime: V72.
V73 runtime code delta: none.

| File | SHA256 |
|---|---|
| `lib/features/keyboard/key_config.dart` | `59c021f32e7910a364a2ae09c14073f3e22342aa7f4133c033fdbbadc2c3609f` |
| `lib/features/keyboard/math_keyboard.dart` | `f4f2a9acdc226cdc9838a265a96f2539a5b9ecf1f4feccd5fbb76745370b7ad2` |
| `lib/features/keyboard/bottom_dock.dart` | `f75e70c490827baeeb6b71a59ccddeaabcdcafe851726d953db9ada0066022c8` |
| `lib/features/keyboard/premium_key.dart` | `ab0eadaa88364bb29953d4c6827473822a277a807bdc8d60c9909ca54bc88b71` |
| `lib/features/keyboard/long_press_popup.dart` | `358be825f26e4e0a75feeb1b72c4839b81ae1f2804b2fda1eec309e250b578e7` |
| `lib/features/solution/solution_steps_panel.dart` | `cefded355d74046a1d5252deebc06b0a8841a39265f5736d7f65865e092be08b` |
| `lib/logic/evaluator_bridge.dart` | `dc8e8e7d2d2b149e2072972fb879be1f9d4813c37f57047b0b5e6541ab0e4f2b` |
| `lib/features/solution/solution_step_models.dart` | `4389fb421d097a2306da5c468ff6e1650d359ab55b3f33256e0325d2fe975f30` |
| `lib/features/workspace/editor_viewport.dart` | `0209998ecc63b105ee827e395c2a63cd52feec601160793e9528dc6a2951120c` |
| `lib/features/editor/render/editor_interaction_layer.dart` | `7242ccf9aa808e2e3c91625bd361069ce43c816e18a7d7e91f4d03a05fb917c3` |
| `lib/features/editor/editor_commands.dart` | `bc2b6f08c8218a4dbd6d8eb1ceb4cba8c21bdab42d6808d1badaa859c4e12f1b` |
| `lib/state/calculator_controller.dart` | `a11cb9e03c8fc4cd2dd203ce234cf1db53551f8ab530bba2fc58c93205bf21cd` |
| `lib/features/workspace/math_label.dart` | `60c1fcb73cf751a3a8a2b9e19d8646fed51e16d801d2fbb5e3fc598d61e7386e` |
| `lib/features/editor/render/math_tex_serializer.dart` | `23968d0282042fbc059d54dbc4eac7c5fa912c044037ad46fe72ab45ae1dd582` |
| `lib/features/editor/tex_serializer.dart` | `0b36f1d21fdc9554d070ffc891a1d65282a834d3902d99401b36a583636d93b3` |

## Locked-area interpretation

- `solution_steps_panel.dart` remains frozen in V73.
- `evaluator_bridge.dart` remains frozen in V73.
- `solution_step_models.dart` remains frozen in V73.
- Keyboard topology files are not modified in V73.
- `key_config.dart` was changed in V72 only because the user explicitly requested long-press cleanup; V73 does not modify it.
