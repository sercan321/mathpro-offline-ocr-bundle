# V172-Q38 Script Precision Engine Audit Report

Q38 keeps P6 visual/keyboard/layout surfaces locked and changes only cursor/geometry/test/audit/metadata files required for script precision.

## Changed or added files vs P6

- **CHANGED** `README.md`
- **ADDED** `docs/audit/V172_Q30_FILE_DIFF_VS_P6.csv`
- **ADDED** `docs/audit/V172_Q30_P6_BASELINE_CURSOR_ONLY_RESTORE_AUDIT_REPORT.md`
- **ADDED** `docs/audit/V172_Q31_FILE_DIFF_VS_P6.csv`
- **ADDED** `docs/audit/V172_Q31_LEGACY_AUDIT_TRACE_CLEANUP_REPORT.md`
- **ADDED** `docs/audit/V172_Q31_SELF_CHECK_REPORT.md`
- **ADDED** `docs/audit/V172_Q32_FILE_DIFF_VS_P6.csv`
- **ADDED** `docs/audit/V172_Q32_P6_LOCKED_ROLE_AWARE_CURSOR_GEOMETRY_REPAIR_REPORT.md`
- **ADDED** `docs/audit/V172_Q33_CHANGED_FILES_MANIFEST.md`
- **ADDED** `docs/audit/V172_Q33_CURSOR_ENGINE_INVENTORY.csv`
- **ADDED** `docs/audit/V172_Q33_FAILURE_MAP_AND_PLUS95_PATH.md`
- **ADDED** `docs/audit/V172_Q33_P6_LOCKED_CURSOR_ENGINE_INVENTORY.md`
- **ADDED** `docs/audit/V172_Q34_CHANGED_FILES_MANIFEST.md`
- **ADDED** `docs/audit/V172_Q34_DETERMINISTIC_SLOT_GEOMETRY_REGISTRY_AUDIT_REPORT.md`
- **ADDED** `docs/audit/V172_Q34_FILE_DIFF_VS_P6.csv`
- **ADDED** `docs/audit/V172_Q35_CHANGED_FILES_MANIFEST.md`
- **ADDED** `docs/audit/V172_Q35_FILE_DIFF_VS_P6.csv`
- **ADDED** `docs/audit/V172_Q35_PLACEHOLDER_SAFE_CURSOR_ENGINE_AUDIT_REPORT.md`
- **ADDED** `docs/audit/V172_Q36_CHANGED_FILES_MANIFEST.md`
- **ADDED** `docs/audit/V172_Q36_FILE_DIFF_VS_P6.csv`
- **ADDED** `docs/audit/V172_Q36_ROLE_BASED_CURSOR_SIZE_AUDIT_REPORT.md`
- **ADDED** `docs/audit/V172_Q36_SELF_CHECK_REPORT.md`
- **ADDED** `docs/audit/V172_Q37_CHANGED_FILES_MANIFEST.md`
- **ADDED** `docs/audit/V172_Q37_FILE_DIFF_VS_P6.csv`
- **ADDED** `docs/audit/V172_Q37_FRACTION_PRECISION_ENGINE_AUDIT_REPORT.md`
- **ADDED** `docs/audit/V172_Q37_SELF_CHECK_REPORT.md`
- **CHANGED** `lib/features/editor/render/mathjax_render_surface.dart`
- **CHANGED** `lib/features/editor/selection_controller.dart`
- **ADDED** `lib/features/formula_engine/deterministic_slot_geometry_registry.dart`
- **ADDED** `lib/features/formula_engine/fraction_precision_cursor_policy.dart`
- **CHANGED** `lib/features/formula_engine/premium_cursor_visual_polish_policy.dart`
- **CHANGED** `lib/features/formula_engine/render_mapped_slot_hit_test.dart`
- **ADDED** `lib/features/formula_engine/script_precision_cursor_policy.dart`
- **CHANGED** `lib/features/formula_engine/slot_hit_testing.dart`
- **CHANGED** `lib/features/workspace/editor_caret_overlay.dart`
- **CHANGED** `lib/logic/mathpro_package_contract.dart`
- **CHANGED** `pubspec.yaml`
- **ADDED** `test/v172_q38_script_precision_engine_test.dart`
- **CHANGED** `tool/verify_mathpro_contract.py`
- **CHANGED** `tool/verify_mathpro_contract_report.json`
- **CHANGED** `tool/verify_mathpro_contract_report.md`

## Locked P6 visual files
All locked P6 visual/keyboard/layout files remain byte-identical to P6 in the Q38 verification pass.

## Honest limit
Q38 is a script-lane precision repair. It does not claim final Photomath/Wolfram +95 PASS without Flutter analyze/test and real-device cursor evidence.
