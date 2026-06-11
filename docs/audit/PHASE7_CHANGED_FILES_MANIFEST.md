# Phase 7 Changed Files Manifest

## Added

- `lib/features/formula_engine/slot_interaction_calibration_policy.dart`
- `lib/features/formula_engine/slot_engine_self_check.dart`
- `docs/audit/PHASE7_CHANGED_FILES_MANIFEST.md`
- `docs/audit/PHASE7_KEYBOARD_REGRESSION_AUDIT.md`
- `docs/audit/PHASE7_SLOT_ENGINE_HARDENING_AUDIT.md`
- `docs/audit/PHASE7_STATIC_VERIFICATION.md`
- `docs/audit/PHASE7_TEST_REPORT.md`
- `docs/audit/PHASE7_RELEASE_HYGIENE_REPORT.md`

## Modified

- `pubspec.yaml`
  - Package renamed to `mathpro_flutter_phase7`.
  - Version updated to `0.7.0+7`.
- `README.md`
  - Updated Phase 7 scope and run notes.
- `lib/features/editor/slot_registry.dart`
  - Stable priority tie-breaks added for deterministic primary slot ordering.
- `lib/features/formula_engine/math_layout_engine.dart`
  - Approximate slot rects now pass through mobile calibration/clamping policy.
- `lib/features/formula_engine/slot_hit_testing.dart`
  - Hit slop moved behind centralized calibration policy.
  - Candidate tie-breaks hardened.
- `test/widget_test.dart`
  - Package imports updated to phase 7.
  - Previously loose structural-slot test placement fixed by rewriting tests under one `main()`.
  - Added slot engine self-check catalog test.
- `docs/audit/RUN_INSTRUCTIONS.md`
  - Updated package/version expectations.

## Explicitly not modified

The following keyboard files were hash-compared against Phase 6 and intentionally left unchanged:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/long_press_indicator.dart`
