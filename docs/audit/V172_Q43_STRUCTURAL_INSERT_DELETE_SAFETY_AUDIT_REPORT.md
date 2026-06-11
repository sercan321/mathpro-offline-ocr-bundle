# V172-Q43 Structural Insert/Delete Safety Audit Report

Q43 is a P6-locked cursor/editor phase. It does not alter keyboard layout, key faces, MORE, long-press popup, app shell, MathLabel, Graph, History, or Solution surfaces.

## Target

Typed input inside filled structural slots should stay inside the active slot instead of replacing the whole payload:

- `sin(3|00) + 5 -> sin(3500)`
- `log₂(5|00) + 9 -> log₂(5900)`
- `x^(1|2) + 3 -> x^(132)`
- `12/3|45 + 9 -> 12/3945`

## Honest limit

Q43 is not a final Photomath/Wolfram PASS. It only adds structural insert/delete safety. Final acceptance still requires Flutter logs and real-device cursor evidence.

## P6 locked surfaces

The following surfaces must remain byte-identical to P6:

- `key_config.dart`
- `math_keyboard.dart`
- `bottom_dock.dart`
- `long_press_popup.dart`
- `premium_key.dart`
- `math_label.dart`
- `template_tray.dart`
- `app_shell.dart`
- `solution_steps_panel.dart`
- `graph_card.dart`
- `history_controller.dart`
- `history_panel.dart`
