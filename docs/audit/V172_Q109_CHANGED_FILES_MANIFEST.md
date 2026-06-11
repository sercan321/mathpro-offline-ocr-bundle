# V172-Q109 Changed Files Manifest

## Added

- `lib/features/mathlive/mathlive_main_editor_switch_conditional_activation_policy.dart`
- `tool/verify_mathlive_main_editor_switch_conditional_activation.mjs`
- `test/v172_q109_main_editor_switch_conditional_activation_test.dart`
- `docs/audit/V172_Q109_MAIN_EDITOR_SWITCH_CONDITIONAL_ACTIVATION_AUDIT_REPORT.md`
- `docs/audit/V172_Q109_CHANGED_FILES_MANIFEST.md`

## Modified

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

## Explicitly not performed

- No MathLive default editor switch.
- No main-workspace MathLive mount.
- No legacy cursor retirement.
- No legacy cursor physical deletion.
- No keyboard/MORE/long-press mutation.
- No AppShell/Graph/History/Solution UI mutation.
- No fake runtime/smoke/Flutter/device evidence.
- No cursor/device PASS claim.
