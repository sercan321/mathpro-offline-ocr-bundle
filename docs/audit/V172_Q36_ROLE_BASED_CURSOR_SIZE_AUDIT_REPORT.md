# V172-Q36 Role-Based Cursor Size Engine Audit Report

Q36 is a P6-locked cursor-only geometry phase. It tightens caret height according to structural role and does not change keyboard, MORE, long-press, app shell, MathLabel, Solution, Graph, or History surfaces.

## Locked P6 Files
- **SAME** `lib/features/keyboard/key_config.dart` — P6 `4ecd7270e29a27d7` / Q36 `4ecd7270e29a27d7`
- **SAME** `lib/features/keyboard/math_keyboard.dart` — P6 `f4f2a9acdc226cdc` / Q36 `f4f2a9acdc226cdc`
- **SAME** `lib/features/keyboard/bottom_dock.dart` — P6 `f75e70c490827bae` / Q36 `f75e70c490827bae`
- **SAME** `lib/features/keyboard/long_press_popup.dart` — P6 `d6b2c030bd3e8281` / Q36 `d6b2c030bd3e8281`
- **SAME** `lib/features/keyboard/premium_key.dart` — P6 `2d0941666300c4db` / Q36 `2d0941666300c4db`
- **SAME** `lib/features/workspace/math_label.dart` — P6 `e7a185deabadfc05` / Q36 `e7a185deabadfc05`
- **SAME** `lib/features/workspace/template_tray.dart` — P6 `9310d7ae9b61334e` / Q36 `9310d7ae9b61334e`
- **SAME** `lib/app/app_shell.dart` — P6 `df584bf0af59a640` / Q36 `df584bf0af59a640`
- **SAME** `lib/features/solution/solution_steps_panel.dart` — P6 `cefded355d74046a` / Q36 `cefded355d74046a`
- **SAME** `lib/features/graph/graph_card.dart` — P6 `ea1010e17627c4f1` / Q36 `ea1010e17627c4f1`
- **SAME** `lib/features/history/history_controller.dart` — P6 `331a6d84dbe4a940` / Q36 `331a6d84dbe4a940`
- **SAME** `lib/features/history/history_panel.dart` — P6 `fad987605894ffaf` / Q36 `fad987605894ffaf`

## Q36 Cursor Scope
- `deterministic_slot_geometry_registry.dart` exposes `roleBasedCaretSizeEngineAvailable`, `mainLineCaretUsedInScriptRoles = false`, `roleBasedCaretHeightFor`, and `usesCompactCaretForRole`.
- Script/log/root/limit/fraction roles use role-specific min/max caret heights instead of a generic main-line caret height.
- `premium_cursor_visual_polish_policy.dart` version marker is advanced to Q36 for role-scaled cursor evidence only; it does not change keyboard UI.

## Changed Files vs P6
- `CHANGED` `README.md`
- `ADDED` `docs/audit/V172_Q30_FILE_DIFF_VS_P6.csv`
- `ADDED` `docs/audit/V172_Q30_P6_BASELINE_CURSOR_ONLY_RESTORE_AUDIT_REPORT.md`
- `ADDED` `docs/audit/V172_Q31_FILE_DIFF_VS_P6.csv`
- `ADDED` `docs/audit/V172_Q31_LEGACY_AUDIT_TRACE_CLEANUP_REPORT.md`
- `ADDED` `docs/audit/V172_Q31_SELF_CHECK_REPORT.md`
- `ADDED` `docs/audit/V172_Q32_FILE_DIFF_VS_P6.csv`
- `ADDED` `docs/audit/V172_Q32_P6_LOCKED_ROLE_AWARE_CURSOR_GEOMETRY_REPAIR_REPORT.md`
- `ADDED` `docs/audit/V172_Q33_CHANGED_FILES_MANIFEST.md`
- `ADDED` `docs/audit/V172_Q33_CURSOR_ENGINE_INVENTORY.csv`
- `ADDED` `docs/audit/V172_Q33_FAILURE_MAP_AND_PLUS95_PATH.md`
- `ADDED` `docs/audit/V172_Q33_P6_LOCKED_CURSOR_ENGINE_INVENTORY.md`
- `ADDED` `docs/audit/V172_Q34_CHANGED_FILES_MANIFEST.md`
- `ADDED` `docs/audit/V172_Q34_DETERMINISTIC_SLOT_GEOMETRY_REGISTRY_AUDIT_REPORT.md`
- `ADDED` `docs/audit/V172_Q34_FILE_DIFF_VS_P6.csv`
- `ADDED` `docs/audit/V172_Q35_CHANGED_FILES_MANIFEST.md`
- `ADDED` `docs/audit/V172_Q35_FILE_DIFF_VS_P6.csv`
- `ADDED` `docs/audit/V172_Q35_PLACEHOLDER_SAFE_CURSOR_ENGINE_AUDIT_REPORT.md`
- `ADDED` `docs/audit/V172_Q36_CHANGED_FILES_MANIFEST.md`
- `ADDED` `docs/audit/V172_Q36_FILE_DIFF_VS_P6.csv`
- `ADDED` `docs/audit/V172_Q36_ROLE_BASED_CURSOR_SIZE_AUDIT_REPORT.md`
- `ADDED` `docs/audit/V172_Q36_SELF_CHECK_REPORT.md`
- `CHANGED` `lib/features/editor/render/mathjax_render_surface.dart`
- `CHANGED` `lib/features/editor/selection_controller.dart`
- `ADDED` `lib/features/formula_engine/deterministic_slot_geometry_registry.dart`
- `CHANGED` `lib/features/formula_engine/premium_cursor_visual_polish_policy.dart`
- `CHANGED` `lib/features/formula_engine/render_mapped_slot_hit_test.dart`
- `CHANGED` `lib/features/workspace/editor_caret_overlay.dart`
- `CHANGED` `lib/logic/mathpro_package_contract.dart`
- `CHANGED` `pubspec.yaml`
- `CHANGED` `tool/verify_mathpro_contract.py`
- `CHANGED` `tool/verify_mathpro_contract_report.json`
- `CHANGED` `tool/verify_mathpro_contract_report.md`

## Honest Limit
Q36 is not a fake Photomath/Wolfram final PASS. It specifically repairs role-based cursor sizing. Real device screenshots/video remain required for PASS.
