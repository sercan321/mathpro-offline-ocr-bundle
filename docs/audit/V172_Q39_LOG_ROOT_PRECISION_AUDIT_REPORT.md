# V172-Q39 Log / Root Precision Engine Audit Report

## Purpose
Q39 keeps the P6 visual baseline locked and only tightens the existing cursor hit-test geometry path for log/root ambiguity. It adds `LogRootPrecisionCursorPolicy` and wires it into the existing slot hit-test stack so `logBase` vs `functionArgument` and `rootIndex` vs `sqrtValue` are resolved more deterministically when mobile touch targets overlap.

## Honest limit
This is not a fake Photomath/Wolfram final PASS. It is a log/root precision repair that still requires real Flutter analyze/test and real-device screenshots/video.

## P6 locked file status
- `lib/features/keyboard/key_config.dart`: SAME
- `lib/features/keyboard/math_keyboard.dart`: SAME
- `lib/features/keyboard/bottom_dock.dart`: SAME
- `lib/features/keyboard/long_press_popup.dart`: SAME
- `lib/features/keyboard/premium_key.dart`: SAME
- `lib/features/workspace/math_label.dart`: SAME
- `lib/features/workspace/template_tray.dart`: SAME
- `lib/app/app_shell.dart`: SAME
- `lib/features/solution/solution_steps_panel.dart`: SAME
- `lib/features/graph/graph_card.dart`: SAME
- `lib/features/history/history_controller.dart`: SAME
- `lib/features/history/history_panel.dart`: SAME

## Changed / added files versus P6
- `README.md` — CHANGED
- `docs/audit/V172_Q30_FILE_DIFF_VS_P6.csv` — ADDED
- `docs/audit/V172_Q30_P6_BASELINE_CURSOR_ONLY_RESTORE_AUDIT_REPORT.md` — ADDED
- `docs/audit/V172_Q31_FILE_DIFF_VS_P6.csv` — ADDED
- `docs/audit/V172_Q31_LEGACY_AUDIT_TRACE_CLEANUP_REPORT.md` — ADDED
- `docs/audit/V172_Q31_SELF_CHECK_REPORT.md` — ADDED
- `docs/audit/V172_Q32_FILE_DIFF_VS_P6.csv` — ADDED
- `docs/audit/V172_Q32_P6_LOCKED_ROLE_AWARE_CURSOR_GEOMETRY_REPAIR_REPORT.md` — ADDED
- `docs/audit/V172_Q33_CHANGED_FILES_MANIFEST.md` — ADDED
- `docs/audit/V172_Q33_CURSOR_ENGINE_INVENTORY.csv` — ADDED
- `docs/audit/V172_Q33_FAILURE_MAP_AND_PLUS95_PATH.md` — ADDED
- `docs/audit/V172_Q33_P6_LOCKED_CURSOR_ENGINE_INVENTORY.md` — ADDED
- `docs/audit/V172_Q34_CHANGED_FILES_MANIFEST.md` — ADDED
- `docs/audit/V172_Q34_DETERMINISTIC_SLOT_GEOMETRY_REGISTRY_AUDIT_REPORT.md` — ADDED
- `docs/audit/V172_Q34_FILE_DIFF_VS_P6.csv` — ADDED
- `docs/audit/V172_Q35_CHANGED_FILES_MANIFEST.md` — ADDED
- `docs/audit/V172_Q35_FILE_DIFF_VS_P6.csv` — ADDED
- `docs/audit/V172_Q35_PLACEHOLDER_SAFE_CURSOR_ENGINE_AUDIT_REPORT.md` — ADDED
- `docs/audit/V172_Q36_CHANGED_FILES_MANIFEST.md` — ADDED
- `docs/audit/V172_Q36_FILE_DIFF_VS_P6.csv` — ADDED
- `docs/audit/V172_Q36_ROLE_BASED_CURSOR_SIZE_AUDIT_REPORT.md` — ADDED
- `docs/audit/V172_Q36_SELF_CHECK_REPORT.md` — ADDED
- `docs/audit/V172_Q37_CHANGED_FILES_MANIFEST.md` — ADDED
- `docs/audit/V172_Q37_FILE_DIFF_VS_P6.csv` — ADDED
- `docs/audit/V172_Q37_FRACTION_PRECISION_ENGINE_AUDIT_REPORT.md` — ADDED
- `docs/audit/V172_Q37_SELF_CHECK_REPORT.md` — ADDED
- `docs/audit/V172_Q38_FILE_DIFF_VS_P6.csv` — ADDED
- `docs/audit/V172_Q38_SCRIPT_PRECISION_ENGINE_AUDIT_REPORT.md` — ADDED
- `lib/features/editor/render/mathjax_render_surface.dart` — CHANGED
- `lib/features/editor/selection_controller.dart` — CHANGED
- `lib/features/formula_engine/deterministic_slot_geometry_registry.dart` — ADDED
- `lib/features/formula_engine/fraction_precision_cursor_policy.dart` — ADDED
- `lib/features/formula_engine/log_root_precision_cursor_policy.dart` — ADDED
- `lib/features/formula_engine/premium_cursor_visual_polish_policy.dart` — CHANGED
- `lib/features/formula_engine/render_mapped_slot_hit_test.dart` — CHANGED
- `lib/features/formula_engine/script_precision_cursor_policy.dart` — ADDED
- `lib/features/formula_engine/slot_hit_testing.dart` — CHANGED
- `lib/features/workspace/editor_caret_overlay.dart` — CHANGED
- `lib/logic/mathpro_package_contract.dart` — CHANGED
- `pubspec.yaml` — CHANGED
- `test/v172_q38_script_precision_engine_test.dart` — ADDED
- `test/v172_q39_log_root_precision_engine_test.dart` — ADDED
- `tool/verify_mathpro_contract.py` — CHANGED
- `tool/verify_mathpro_contract_report.json` — CHANGED
- `tool/verify_mathpro_contract_report.md` — CHANGED

## Required real-device targets
- `log₂(500)`
- `log_□(□)`
- `√123`
- `³√27`
- `ⁿ√x`

## Closure rule
If any P6 locked UI file changes, the package is REJECT. If real device cursor still selects log base/argument or root index/radicand incorrectly, the phase remains CONDITIONAL.
