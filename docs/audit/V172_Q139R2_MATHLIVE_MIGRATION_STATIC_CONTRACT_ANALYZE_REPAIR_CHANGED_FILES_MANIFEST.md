# V172-Q139R2 Changed Files Manifest

## Modified

- `lib/app/app_shell.dart`
  - `_useMathLiveMainEditor` is now `final bool` to satisfy the analyzer without changing runtime behavior.

- `assets/mathlive/mathlive_bridge.js`
  - Added the backward-compatible Q84 static marker comment `phase: 'V172-Q84'`.

## Added

- `docs/audit/V172_Q139R2_MATHLIVE_MIGRATION_STATIC_CONTRACT_ANALYZE_REPAIR_AUDIT_REPORT.md`
- `docs/audit/V172_Q139R2_MATHLIVE_MIGRATION_STATIC_CONTRACT_ANALYZE_REPAIR_CHANGED_FILES_MANIFEST.md`

## Protected surfaces not modified

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
