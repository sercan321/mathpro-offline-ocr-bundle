# V172-Q114 Changed Files Manifest

## Added

- `lib/features/editor_adapter/release_freeze_clean_full_zip_guard_policy.dart`
- `tool/verify_release_freeze_clean_full_zip_guard.mjs`
- `test/v172_q114_release_freeze_clean_full_zip_guard_test.dart`
- `docs/audit/V172_Q114_RELEASE_FREEZE_CLEAN_FULL_ZIP_GUARD_AUDIT_REPORT.md`
- `docs/audit/V172_Q114_CHANGED_FILES_MANIFEST.md`
- `docs/audit/V172_Q114_RELEASE_FREEZE_CHECKLIST.json`

## Modified

- `lib/logic/mathpro_package_contract.dart`
- `pubspec.yaml`
- `README.md`
- `assets/mathlive/manifest.json`
- `tool/verify_mathpro_contract.py`

## Protected files

The following protected files must remain byte-for-byte identical to Q113 baseline:

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

- No final release PASS.
- No physical cleanup execution.
- No legacy cursor deletion.
- No MathLive default/main editor switch.
- No fake runtime/smoke/device evidence.
- No patch-only delivery.
