# V172-Q135-Q139 Changed Files Manifest

## Modified

- `README.md`
- `assets/mathlive/mathlive_bridge.js`
- `lib/features/mathlive/mathlive_main_editor_surface.dart`
- `lib/features/workspace/workspace_panel.dart`
- `lib/logic/mathpro_package_contract.dart`

## Added

- `lib/features/editor_adapter/mathlive_full_main_editor_migration_v172_q135_q139_policy.dart`
- `docs/audit/V172_Q135_Q139_MATHLIVE_FULL_MAIN_EDITOR_MIGRATION_AUDIT_REPORT.md`
- `docs/audit/V172_Q135_Q139_MATHLIVE_FULL_MAIN_EDITOR_MIGRATION_CHANGED_FILES_MANIFEST.md`
- `tool/verify_mathlive_full_main_editor_migration_v172_q135_q139.mjs`

## Protected keyboard / UI files intentionally untouched

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/workspace/math_label.dart`
- `lib/features/workspace/template_tray.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/features/graph/graph_card.dart`
- `lib/features/history/history_controller.dart`
- `lib/features/history/history_panel.dart`

`lib/app/app_shell.dart` had already been touched by the prior MathLive main-editor routing phases; this Q135-Q139 batch does not require further AppShell mutation.
