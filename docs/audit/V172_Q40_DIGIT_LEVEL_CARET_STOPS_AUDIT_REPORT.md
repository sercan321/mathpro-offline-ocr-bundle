# V172-Q40 Digit-Level Caret Stops Audit Report

Q40 keeps the P6 keyboard, key faces, MORE tray, long-press popup, app shell, MathLabel, Graph, History, and Solution surfaces locked while adding digit-level caret stop logic to the existing cursor engine.

## Active identity

- description: MathPro Flutter phase 17 - V172-Q40 digit-level caret stops.
- version: 0.172.67+172

## Locked P6 file check

- lib/features/keyboard/key_config.dart: SAME
- lib/features/keyboard/math_keyboard.dart: SAME
- lib/features/keyboard/bottom_dock.dart: SAME
- lib/features/keyboard/long_press_popup.dart: SAME
- lib/features/keyboard/premium_key.dart: SAME
- lib/features/workspace/math_label.dart: SAME
- lib/features/workspace/template_tray.dart: SAME
- lib/app/app_shell.dart: SAME
- lib/features/solution/solution_steps_panel.dart: SAME
- lib/features/graph/graph_card.dart: SAME
- lib/features/history/history_controller.dart: SAME
- lib/features/history/history_panel.dart: SAME

## Cursor-only changes

- Added `lib/features/formula_engine/digit_level_caret_stop_policy.dart`.
- Updated `lib/features/editor/selection_controller.dart` so numeric runs prefer digit-gap caret stops before structural boundary snaps.
- Updated `lib/features/formula_engine/deterministic_slot_geometry_registry.dart` with Q40 capability flags only.
- Updated metadata, tests, verifier, and audit reports.

## Honest limit

Q40 does not claim renderer glyph identity and is not a final Photomath/Wolfram PASS. It improves digit-run caret selection using existing P6 linear caret rails. Real device tap evidence is required.
