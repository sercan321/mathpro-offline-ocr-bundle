# V172-Q187 Changed Files Manifest

## Modified

- `README.md`
- `assets/mathlive/manifest.json`
- `lib/features/mathlive/mathlive_keyboard_bridge_policy.dart`
- `test/v172_q184_production_mathlive_cutover_surface_test.dart`

## Added

- `lib/features/mathlive/mathlive_template_command_contract_freeze_policy.dart`
- `test/v172_q187_template_command_contract_freeze_test.dart`
- `tool/verify_mathlive_template_command_contract_freeze_v172_q187.mjs`
- `docs/audit/V172_Q187_TEMPLATE_COMMAND_CONTRACT_FREEZE_AUDIT_REPORT.md`
- `docs/audit/V172_Q187_TEMPLATE_COMMAND_CONTRACT_FREEZE_CHANGED_FILES_MANIFEST.md`

## Protected surfaces intentionally not changed

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/workspace/template_tray.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/features/graph/graph_card.dart`
- `lib/features/history/history_panel.dart`

## Verification note

Q187 does not claim assistant-side Flutter analyze/test/run PASS and does not claim Android real-device premium PASS.
