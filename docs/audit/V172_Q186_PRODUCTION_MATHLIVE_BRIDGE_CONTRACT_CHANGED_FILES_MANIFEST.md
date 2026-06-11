# V172-Q186 Changed Files Manifest

## Modified

- `README.md`
- `assets/mathlive/manifest.json`
- `assets/mathlive/mathlive_prod_bridge.js`
- `lib/app/app_shell.dart`
- `lib/features/mathlive/mathlive_main_editor_surface.dart`
- `tool/verify_mathlive_production_cutover_surface_v172_q184.mjs`
- `tool/verify_mathlive_production_html_finalization_v172_q185.mjs`
- `tool/verify_mathpro_contract_report.json`
- `tool/verify_mathpro_contract_report.md`

## Added

- `lib/features/mathlive/mathlive_production_bridge_contract_policy.dart`
- `test/v172_q186_production_mathlive_bridge_contract_test.dart`
- `tool/verify_mathlive_production_bridge_contract_v172_q186.mjs`
- `docs/audit/V172_Q186_PRODUCTION_MATHLIVE_BRIDGE_CONTRACT_AUDIT_REPORT.md`
- `docs/audit/V172_Q186_PRODUCTION_MATHLIVE_BRIDGE_CONTRACT_CHANGED_FILES_MANIFEST.md`

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

Q186 does not claim assistant-side Flutter analyze/test/run PASS and does not claim Android real-device premium PASS.
