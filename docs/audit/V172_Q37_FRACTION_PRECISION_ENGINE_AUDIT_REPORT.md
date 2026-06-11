# V172-Q37 Fraction Precision Engine Audit Report

## Scope

Q37 is a P6-locked cursor-only phase. It targets fraction numerator/denominator ambiguity inside the existing cursor engine. It does not modify keyboard layout, key faces, MORE tray, long-press popup, app shell/layout, Graph, History, or Solution.

## Package Identity

- Description: `MathPro Flutter phase 17 - V172-Q37 fraction precision engine.`
- Version: `0.172.64+172`

## P6 Locked File Check

- `lib/features/keyboard/key_config.dart`: **SAME**
- `lib/features/keyboard/math_keyboard.dart`: **SAME**
- `lib/features/keyboard/bottom_dock.dart`: **SAME**
- `lib/features/keyboard/long_press_popup.dart`: **SAME**
- `lib/features/keyboard/premium_key.dart`: **SAME**
- `lib/features/workspace/math_label.dart`: **SAME**
- `lib/features/workspace/template_tray.dart`: **SAME**
- `lib/app/app_shell.dart`: **SAME**
- `lib/features/solution/solution_steps_panel.dart`: **SAME**
- `lib/features/graph/graph_card.dart`: **SAME**
- `lib/features/history/history_controller.dart`: **SAME**
- `lib/features/history/history_panel.dart`: **SAME**

Overall locked status: **PASS**

## Production Cursor Changes

Q37 adds `fraction_precision_cursor_policy.dart` and wires it into `slot_hit_testing.dart`. The policy chooses numerator or denominator by deterministic lane boundary when expanded mobile hit targets overlap. It also tightens fraction hit rectangles without changing visible UI files.

Key Q37 markers:

- `fractionPrecisionEngineAvailable = true`
- `numeratorDenominatorLaneSplitEnabled = true`
- `fractionBarCrossLaneSelectionAllowed = false`
- `requiredCorrectTapSelectionsPerTwenty = 19`

## Honest Limit

Q37 is not a fake Photomath/Wolfram final PASS. It specifically targets pay/payda lane precision. Real-device proof is still required for `9/6`, `12/345`, and `123/4567`.

## Diff Summary Versus P6

- Same files: 861
- Changed files: 12
- Added files: 23
- Removed files: 0

Changed files include metadata/verifier/audit plus cursor-geometry source files only. See `V172_Q37_FILE_DIFF_VS_P6.csv` for the full manifest.
