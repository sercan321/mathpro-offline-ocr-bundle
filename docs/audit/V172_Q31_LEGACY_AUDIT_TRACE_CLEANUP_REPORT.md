# V172-Q31 Legacy Audit Trace Cleanup with P6 Visual Baseline Locked

## Scope
Q31 is an audit/verifier hygiene repair. It does not change keyboard layout, key rendering, MORE rendering, long-press popup rendering, workspace layout, Graph, History, or Solution internals.

## What was cleaned
The previous static verifier reported `legacy_raw_math_warning_scan` as a warning because it counted internal compatibility aliases and regression guards as if they were visible UI leaks. Q31 changes this check to classify occurrences into:

- visible user-facing surfaces: keyboard/workspace/editor render paths;
- allowed internal compatibility/regression guard surfaces: `lib/logic` and `test`.

Only visible leaks can now produce a warning. Internal guards for legacy aliases such as inverse-function raw aliases, `log(2)(5)` corruption examples, and `x8n` corruption guards are preserved because they prevent regressions and are not user-facing UI.

## What was deliberately not removed
Q31 did not remove parser aliases, canonicalization maps, release-evidence scenarios, or regression tests. Those are not dead traces; they are guardrails that keep old raw forms from leaking back into the UI.

## P6 visual lock
The following files must remain byte-identical to P6/Q30 surgical baseline:

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

## No fake PASS
Q31 does not claim Flutter analyze/test/run PASS. Real Flutter/device logs remain the source of truth.
