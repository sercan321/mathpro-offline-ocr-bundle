# V172-Q190R4 Production Bridge Queue Focus Repair Changed Files Manifest

## Modified
- `README.md`
- `assets/mathlive/manifest.json`
- `assets/mathlive/mathlive_prod_bridge.js`
- `lib/features/mathlive/mathlive_main_editor_surface.dart`
- `tool/verify_mathlive_real_device_defect_repair_compile_fix_v172_q190r1.mjs`
- `tool/verify_mathlive_production_active_path_hardening_v172_q190r2.mjs`
- `tool/verify_mathlive_production_command_bus_court_v172_q190r3.mjs`

## Added
- `lib/features/mathlive/mathlive_production_bridge_queue_focus_repair_policy.dart`
- `test/v172_q190r4_production_bridge_queue_focus_repair_test.dart`
- `tool/verify_mathlive_production_bridge_queue_focus_repair_v172_q190r4.mjs`
- `docs/audit/V172_Q190R4_PRODUCTION_BRIDGE_QUEUE_FOCUS_REPAIR_AUDIT_REPORT.md`
- `docs/audit/V172_Q190R4_PRODUCTION_BRIDGE_QUEUE_FOCUS_REPAIR_CHANGED_FILES_MANIFEST.md`
- `docs/audit/V172_Q190R4_PROTECTED_FILE_HASH_MANIFEST.md`

## Protected Unchanged
- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/workspace/template_tray.dart`
- `lib/features/graph/graph_card.dart`
- `lib/features/graph/graph_controller.dart`
- `lib/features/history/history_controller.dart`
- `lib/features/history/history_panel.dart`
- `lib/features/solution/solution_steps_panel.dart`

## Why prior verifiers changed
Q190R1/Q190R2/Q190R3 verifiers were updated only to accept Q190R4 as a verified successor `latestProductionPhase`; their original phase gates remain intact.
