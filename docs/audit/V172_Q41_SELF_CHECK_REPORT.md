# V172-Q41 P6 Locked Nested Expression Depth Engine Self Check

## Package

- Description: MathPro Flutter phase 17 - V172-Q41 nested expression depth engine.
- Version: 0.172.68+172

## Scope

Q41 modifies only cursor/hit-test/audit/metadata surfaces needed to add nested-expression depth filtering. It does not modify P6 keyboard, key faces, MORE tray, long-press popup, app shell, MathLabel, Graph, History, or Solution surfaces.

## P6 locked file check

- `lib/features/keyboard/key_config.dart`: SAME `4ecd7270e29a27d75bdd80d36aa5b6f1064a2c3a1d3360c3edd4856432d0f1a2`
- `lib/features/keyboard/math_keyboard.dart`: SAME `f4f2a9acdc226cdc9838a265a96f2539a5b9ecf1f4feccd5fbb76745370b7ad2`
- `lib/features/keyboard/bottom_dock.dart`: SAME `f75e70c490827baeeb6b71a59ccddeaabcdcafe851726d953db9ada0066022c8`
- `lib/features/keyboard/long_press_popup.dart`: SAME `d6b2c030bd3e82819dff7ab66edaa5ac20855c19db72940c742b229cdede4081`
- `lib/features/keyboard/premium_key.dart`: SAME `2d0941666300c4db73b8ae99d7554a2f7e6a38289e58fb0f9234fc853705c179`
- `lib/features/workspace/math_label.dart`: SAME `e7a185deabadfc05678de481adbe73797616d22208bdc5c1d3c055665b9687f9`
- `lib/features/workspace/template_tray.dart`: SAME `9310d7ae9b61334e4ccd055bea78b37420c8d82b309bd5a5455ee710c0caac66`
- `lib/app/app_shell.dart`: SAME `df584bf0af59a6405c141787ce2e8cba9f1572404808e986a3ec4de56f35ffc7`
- `lib/features/solution/solution_steps_panel.dart`: SAME `cefded355d74046a1d5252deebc06b0a8841a39265f5736d7f65865e092be08b`
- `lib/features/graph/graph_card.dart`: SAME `ea1010e17627c4f1754a5e8ba2dc18004adbb98121ebd7da8a8cd876de8c1e4f`
- `lib/features/history/history_controller.dart`: SAME `331a6d84dbe4a940f185a69bc5623c6aaa0f2b16f4198f2149a4f4b375be3f51`
- `lib/features/history/history_panel.dart`: SAME `fad987605894ffafc0069fa80f560908c6f529a05da81d2165e924524728537b`

## Honest limit

Q41 does not claim renderer-glyph identity and does not claim final +95 Photomath/Wolfram PASS. It prefers deepest valid structural candidates inside existing deterministic geometry and must be validated on a real device.
