# V172-Q108 Changed Files Manifest

## Added

- `lib/features/mathlive/mathlive_real_device_cursor_court_execution_policy.dart`
- `tool/verify_mathlive_real_device_cursor_court_execution.mjs`
- `test/v172_q108_real_device_cursor_court_execution_test.dart`
- `docs/audit/V172_Q108_REAL_DEVICE_CURSOR_COURT_EXECUTION_AUDIT_REPORT.md`
- `docs/audit/V172_Q108_CHANGED_FILES_MANIFEST.md`

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

## Non-goals

Q108 does not mount MathLive in the main workspace, does not switch the default editor, does not claim cursor/device PASS, does not fake runtime/smoke/device evidence, does not retire the legacy main path, and does not physically delete legacy cursor files.
