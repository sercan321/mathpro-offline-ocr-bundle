# V172-Q118 Changed Files Manifest

## Added

- `lib/features/mathlive/mathlive_main_editor_activation_dry_run_gate_policy.dart`
- `tool/verify_mathlive_main_editor_activation_dry_run_gate.mjs`
- `test/v172_q118_main_editor_activation_dry_run_gate_test.dart`
- `docs/audit/V172_Q118_MAIN_EDITOR_ACTIVATION_DRY_RUN_GATE_AUDIT_REPORT.md`
- `docs/audit/V172_Q118_MAIN_EDITOR_ACTIVATION_DRY_RUN_GATE_CHANGED_FILES_MANIFEST.md`

## Updated metadata / static contract

- `README.md`
- `assets/mathlive/manifest.json`
- `lib/logic/mathpro_package_contract.dart`
- `tool/verify_mathpro_contract.py`

## Protected files

Protected files intentionally untouched:

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

## Runtime behavior

No runtime activation was implemented. MathLive is not enabled as the default/main editor. Legacy cursor remains default and rollback. Physical legacy cleanup remains blocked.
