# V172-Q100 Changed Files Manifest

## Added

- `lib/features/mathlive/mathlive_official_runtime_bundle_closure_policy.dart`
- `tool/verify_mathlive_official_runtime_bundle.mjs`
- `test/v172_q100_official_runtime_bundle_closure_test.dart`
- `docs/audit/V172_Q100_OFFICIAL_RUNTIME_BUNDLE_CLOSURE_AUDIT_REPORT.md`
- `docs/audit/V172_Q100_CHANGED_FILES_MANIFEST.md`

## Modified

- `tool/install_mathlive_runtime.mjs`
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

## Non-actions

- MathLive was not made the main/default editor.
- Legacy cursor files were not deleted.
- Graph/History/Solution UI files were not modified.
- Keyboard layout, MORE, long-press, Ans, `↵`, and `=` contracts were not modified.
- No official runtime files were fabricated.
- No smoke evidence was fabricated.
