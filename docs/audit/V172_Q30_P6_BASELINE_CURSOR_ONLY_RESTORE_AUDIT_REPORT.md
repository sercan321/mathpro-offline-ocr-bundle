# MathPro Q30 Surgical Comparison Report

Baseline: `MathProFlutterPhase17_P6_VERIFY_22e7f761(2).zip`.
Output: `MathProFlutterPhase17_Q30_P6_BASELINE_CURSOR_ONLY_FULL.zip`.

## Verdict
Q30 is built from P6, not Q29. Keyboard, visual key face, MORE tray, app shell layout, long-press popup, Graph, History, and Solution protected files are byte-identical to P6. Only package metadata, README, verifier reports, and `mathjax_render_surface.dart` are changed for the cursor/input visibility repair.

## Changed files vs P6
- `README.md` — modified
- `lib/features/editor/render/mathjax_render_surface.dart` — modified
- `lib/logic/mathpro_package_contract.dart` — modified
- `pubspec.yaml` — modified
- `tool/verify_mathpro_contract_report.json` — modified
- `tool/verify_mathpro_contract_report.md` — modified

## Red-line equality table
| File | P6 == Q30 | Q30 SHA256 prefix |
|---|---:|---|
| `lib/features/keyboard/key_config.dart` | YES | `4ecd7270e29a27d7` |
| `lib/features/keyboard/math_keyboard.dart` | YES | `f4f2a9acdc226cdc` |
| `lib/features/keyboard/bottom_dock.dart` | YES | `f75e70c490827bae` |
| `lib/features/keyboard/long_press_popup.dart` | YES | `d6b2c030bd3e8281` |
| `lib/features/solution/solution_steps_panel.dart` | YES | `cefded355d74046a` |
| `lib/features/graph/graph_card.dart` | YES | `ea1010e17627c4f1` |
| `lib/features/history/history_controller.dart` | YES | `331a6d84dbe4a940` |
| `lib/features/history/history_panel.dart` | YES | `fad987605894ffaf` |
| `lib/features/keyboard/premium_key.dart` | YES | `2d0941666300c4db` |
| `lib/features/workspace/math_label.dart` | YES | `e7a185deabadfc05` |
| `lib/features/workspace/template_tray.dart` | YES | `9310d7ae9b61334e` |
| `lib/app/app_shell.dart` | YES | `df584bf0af59a640` |

## Q29 visual/layout changes intentionally excluded
- `lib/features/keyboard/premium_key.dart` restored/kept from P6 byte-for-byte.
- `lib/features/workspace/math_label.dart` restored/kept from P6 byte-for-byte.
- `lib/features/workspace/template_tray.dart` restored/kept from P6 byte-for-byte.
- `lib/app/app_shell.dart` restored/kept from P6 byte-for-byte.

## Actual code change
Only `lib/features/editor/render/mathjax_render_surface.dart` received runtime input visibility repair: when the expression is non-empty but MathJax/WebView is not yet showing the current frame, Q30 shows a readable current-expression mirror instead of an empty ghost. This does not change keyboard inventory, key faces, MORE, long-press, Graph, History, Solution, or app shell layout.
