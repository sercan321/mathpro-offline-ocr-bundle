# V172-Q77 Changed Files Manifest

Active version: `0.172.108+172`

## Added

- `lib/features/formula_engine/native_integral_slotbox_specialization_policy.dart`
  - Adds deterministic native integral SlotBox lane resolution for upper limit, lower limit, body and differential slots.
- `test/v172_q77_integral_native_slotbox_specialization_test.dart`
  - Adds Q77 regression tests for integral native SlotBox lane selection, `d|□` law and protected-surface guards.
- `docs/audit/V172_Q77_INTEGRAL_NATIVE_SLOTBOX_SPECIALIZATION_AUDIT_REPORT.md`
- `docs/audit/V172_Q77_CHANGED_FILES_MANIFEST.md`

## Modified

- `pubspec.yaml`
  - Advances active package identity to `0.172.108+172` / V172-Q77.
- `README.md`
  - Updates active top-level package description and real-device checklist to Q77.
- `lib/logic/mathpro_package_contract.dart`
  - Advances active metadata and adds `q77IntegralNativeSlotBoxSpecializationRule`.
- `lib/features/formula_engine/native_slotbox_hit_test_policy.dart`
  - Routes overlapping integral candidates through `NativeIntegralSlotBoxSpecializationPolicy.resolveIntegralCandidate(...)`.
- `lib/features/formula_engine/slot_geometry_bundle_authority.dart`
  - Routes integral hitRect, placeholder and leading-rail refinement through the Q77 native integral policy while preserving Q58 lineage markers.
- `lib/features/formula_engine/native_slotbox_input_surface_integration_policy.dart`
  - Adds Q77 frame-level proof helper for complete native integral slot sets.
- `tool/verify_mathpro_contract.py`
  - Adds Q77 static gate and updates active metadata expectations.
- Existing V172 tests
  - Updated only where they pin active metadata from Q76/Q77-nextPhase to Q77/Q78.

## Protected files not edited

The following protected files remain byte-identical to the incoming Q76 package:

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

## Evidence

- `python3 tool/verify_mathpro_contract.py .` completed without hard failures.
- ZIP hygiene check excludes build/cache/interpreter/binary artifacts.
- Flutter/Dart unavailable in assistant environment, so no Flutter analyze/test/run PASS is claimed.
