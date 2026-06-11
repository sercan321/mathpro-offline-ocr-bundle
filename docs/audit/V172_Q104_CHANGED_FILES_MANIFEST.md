# V172-Q104 Changed Files Manifest

## Added

- `lib/features/mathlive/mathlive_history_adapter_policy.dart`
- `tool/verify_mathlive_history_adapter.mjs`
- `test/v172_q104_mathlive_history_adapter_test.dart`
- `docs/audit/V172_Q104_HISTORY_ADAPTER_AUDIT_REPORT.md`
- `docs/audit/V172_Q104_CHANGED_FILES_MANIFEST.md`

## Modified

- `lib/features/mathlive/mathlive_graph_history_solution_adapter_policy.dart`
- `lib/logic/mathpro_package_contract.dart`
- `pubspec.yaml`
- `README.md`
- `assets/mathlive/manifest.json`
- `tool/verify_mathpro_contract.py`

## Protected files intentionally untouched

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

## Explicit non-actions

- No History UI/controller mutation.
- No MathLive main/default editor activation.
- No protected UI mutation.
- No fake smoke evidence.
- No fake runtime History write.
- No legacy cursor deletion.
