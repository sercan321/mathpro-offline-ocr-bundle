# V172-Q49 Structural Cursor Release Hardening Audit Report

## Scope

Q49 hardens the cursor/editor/geometry line only. It does not change the P6 keyboard, key faces, MORE tray, long-press popup, app shell, MathLabel, Solution, Graph, or History surfaces.

## Active identity

- Description: `MathPro Flutter phase 17 - V172-Q49 structural cursor release hardening.`
- Version: `0.172.77+172`
- Current phase: `V172-Q49 Structural Cursor Release Hardening`
- Next phase: `V172-Q50 P6-locked +95 cursor candidate freeze`

## Runtime changes

- Added `lib/features/formula_engine/structural_cursor_release_hardening_policy.dart`.
- Wired `slot_hit_testing.dart` to pass final candidates through the Q49 release-hardening stage and to apply a deterministic nested-candidate final sort.
- Wired `editor_interaction_layer.dart` to use Q49 structural caret index selection instead of raw slot-width division.
- Wired `editor_caret_overlay.dart` to keep Q48 native LayoutBox geometry while applying Q49 final caret rect guards.

## Protected surfaces

The following surfaces must remain byte-identical relative to the incoming Q48R3 package and P6 visual baseline unless the user explicitly permits changes:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/workspace/math_label.dart`
- `lib/features/workspace/template_tray.dart`
- `lib/app/app_shell.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/features/graph/graph_card.dart`
- `lib/features/history/history_controller.dart`
- `lib/features/history/history_panel.dart`

Q49 static comparison against Q48R3 showed these protected files unchanged.

## Honest limits

Q49 does not claim:

- Flutter analyze PASS
- Flutter test PASS
- Flutter run PASS
- real-device Pixel QA PASS
- Photomath/Wolfram +95 completion
- full native math rendering
- stable AST slot → SVG node identity

Those require external Flutter/device logs.

## Static verifier

`python3 tool/verify_mathpro_contract.py` completed without hard failures after Q49 changes.
