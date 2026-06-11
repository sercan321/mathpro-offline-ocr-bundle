# V172-Q42 Drag-to-Move Cursor Stability Audit Report

## Scope

Q42 is a P6-locked cursor-only phase. It adds a drag stability policy and wires it into `EditorInteractionLayer` so tiny finger jitter, duplicate drag emissions, and compact-slot oscillation are suppressed during drag-to-move interactions.

It does **not** claim final Photomath/Wolfram +95 PASS. Real Flutter/device evidence remains required.

## P6 Locked File Check

| File | Status vs P6 | Q42 SHA256 short |
|---|---:|---|
| `lib/features/keyboard/key_config.dart` | SAME | `4ecd7270e29a27d7` |
| `lib/features/keyboard/math_keyboard.dart` | SAME | `f4f2a9acdc226cdc` |
| `lib/features/keyboard/bottom_dock.dart` | SAME | `f75e70c490827bae` |
| `lib/features/keyboard/long_press_popup.dart` | SAME | `d6b2c030bd3e8281` |
| `lib/features/keyboard/premium_key.dart` | SAME | `2d0941666300c4db` |
| `lib/features/workspace/math_label.dart` | SAME | `e7a185deabadfc05` |
| `lib/features/workspace/template_tray.dart` | SAME | `9310d7ae9b61334e` |
| `lib/app/app_shell.dart` | SAME | `df584bf0af59a640` |
| `lib/features/solution/solution_steps_panel.dart` | SAME | `cefded355d74046a` |
| `lib/features/graph/graph_card.dart` | SAME | `ea1010e17627c4f1` |
| `lib/features/history/history_controller.dart` | SAME | `331a6d84dbe4a940` |
| `lib/features/history/history_panel.dart` | SAME | `fad987605894ffaf` |

## Changed Files vs P6

- CHANGED: `README.md`
- ADDED: `docs/audit/V172_Q30_FILE_DIFF_VS_P6.csv`
- ADDED: `docs/audit/V172_Q30_P6_BASELINE_CURSOR_ONLY_RESTORE_AUDIT_REPORT.md`
- ADDED: `docs/audit/V172_Q31_FILE_DIFF_VS_P6.csv`
- ADDED: `docs/audit/V172_Q31_LEGACY_AUDIT_TRACE_CLEANUP_REPORT.md`
- ADDED: `docs/audit/V172_Q31_SELF_CHECK_REPORT.md`
- ADDED: `docs/audit/V172_Q32_FILE_DIFF_VS_P6.csv`
- ADDED: `docs/audit/V172_Q32_P6_LOCKED_ROLE_AWARE_CURSOR_GEOMETRY_REPAIR_REPORT.md`
- ADDED: `docs/audit/V172_Q33_CHANGED_FILES_MANIFEST.md`
- ADDED: `docs/audit/V172_Q33_CURSOR_ENGINE_INVENTORY.csv`
- ADDED: `docs/audit/V172_Q33_FAILURE_MAP_AND_PLUS95_PATH.md`
- ADDED: `docs/audit/V172_Q33_P6_LOCKED_CURSOR_ENGINE_INVENTORY.md`
- ADDED: `docs/audit/V172_Q34_CHANGED_FILES_MANIFEST.md`
- ADDED: `docs/audit/V172_Q34_DETERMINISTIC_SLOT_GEOMETRY_REGISTRY_AUDIT_REPORT.md`
- ADDED: `docs/audit/V172_Q34_FILE_DIFF_VS_P6.csv`
- ADDED: `docs/audit/V172_Q35_CHANGED_FILES_MANIFEST.md`
- ADDED: `docs/audit/V172_Q35_FILE_DIFF_VS_P6.csv`
- ADDED: `docs/audit/V172_Q35_PLACEHOLDER_SAFE_CURSOR_ENGINE_AUDIT_REPORT.md`
- ADDED: `docs/audit/V172_Q36_CHANGED_FILES_MANIFEST.md`
- ADDED: `docs/audit/V172_Q36_FILE_DIFF_VS_P6.csv`
- ADDED: `docs/audit/V172_Q36_ROLE_BASED_CURSOR_SIZE_AUDIT_REPORT.md`
- ADDED: `docs/audit/V172_Q36_SELF_CHECK_REPORT.md`
- ADDED: `docs/audit/V172_Q37_CHANGED_FILES_MANIFEST.md`
- ADDED: `docs/audit/V172_Q37_FILE_DIFF_VS_P6.csv`
- ADDED: `docs/audit/V172_Q37_FRACTION_PRECISION_ENGINE_AUDIT_REPORT.md`
- ADDED: `docs/audit/V172_Q37_SELF_CHECK_REPORT.md`
- ADDED: `docs/audit/V172_Q38_FILE_DIFF_VS_P6.csv`
- ADDED: `docs/audit/V172_Q38_SCRIPT_PRECISION_ENGINE_AUDIT_REPORT.md`
- ADDED: `docs/audit/V172_Q39_FILE_DIFF_VS_P6.csv`
- ADDED: `docs/audit/V172_Q39_LOG_ROOT_PRECISION_AUDIT_REPORT.md`
- ADDED: `docs/audit/V172_Q40_CHANGED_FILES_MANIFEST.md`
- ADDED: `docs/audit/V172_Q40_DIGIT_LEVEL_CARET_STOPS_AUDIT_REPORT.md`
- ADDED: `docs/audit/V172_Q40_FILE_DIFF_VS_P6.csv`
- ADDED: `docs/audit/V172_Q41_CHANGED_FILES_MANIFEST.csv`
- ADDED: `docs/audit/V172_Q41_FILE_DIFF_VS_P6.csv`
- ADDED: `docs/audit/V172_Q41_NESTED_EXPRESSION_DEPTH_ENGINE_AUDIT_REPORT.md`
- ADDED: `docs/audit/V172_Q41_SELF_CHECK_REPORT.md`
- CHANGED: `lib/features/editor/render/editor_interaction_layer.dart`
- CHANGED: `lib/features/editor/render/mathjax_render_surface.dart`
- CHANGED: `lib/features/editor/selection_controller.dart`
- ADDED: `lib/features/formula_engine/deterministic_slot_geometry_registry.dart`
- ADDED: `lib/features/formula_engine/digit_level_caret_stop_policy.dart`
- ADDED: `lib/features/formula_engine/drag_to_move_cursor_stability_policy.dart`
- CHANGED: `lib/features/formula_engine/editor_gesture_router_policy.dart`
- ADDED: `lib/features/formula_engine/fraction_precision_cursor_policy.dart`
- ADDED: `lib/features/formula_engine/log_root_precision_cursor_policy.dart`
- ADDED: `lib/features/formula_engine/nested_expression_depth_cursor_policy.dart`
- CHANGED: `lib/features/formula_engine/premium_cursor_visual_polish_policy.dart`
- CHANGED: `lib/features/formula_engine/render_mapped_slot_hit_test.dart`
- ADDED: `lib/features/formula_engine/script_precision_cursor_policy.dart`
- CHANGED: `lib/features/formula_engine/slot_hit_testing.dart`
- CHANGED: `lib/features/workspace/editor_caret_overlay.dart`
- CHANGED: `lib/logic/mathpro_package_contract.dart`
- CHANGED: `pubspec.yaml`
- ADDED: `test/v172_q38_script_precision_engine_test.dart`
- ADDED: `test/v172_q39_log_root_precision_engine_test.dart`
- ADDED: `test/v172_q40_digit_level_caret_stops_test.dart`
- ADDED: `test/v172_q41_nested_expression_depth_engine_test.dart`
- ADDED: `test/v172_q42_drag_to_move_cursor_stability_test.dart`
- CHANGED: `tool/verify_mathpro_contract.py`
- CHANGED: `tool/verify_mathpro_contract_report.json`
- CHANGED: `tool/verify_mathpro_contract_report.md`

## Honest Limits

- Flutter/Dart were not run in the assistant container.
- Q42 does not add renderer-glyph identity.
- Q42 does not alter keyboard, MORE, long-press, layout, Graph, History, or Solution surfaces.
- Drag stability must be validated on a real device using long expressions such as `sin(300)+cos(400)+log₂(500)+√(600)`.
