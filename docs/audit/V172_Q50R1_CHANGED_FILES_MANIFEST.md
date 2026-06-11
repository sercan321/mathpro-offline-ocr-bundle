# V172-Q50R2 Changed Files Manifest

Q50R2 is a targeted repair package based on the user's real Flutter analyze/test log. It preserves the P6 locked visual/keyboard baseline and touches only editor/cursor/test/verifier/audit metadata areas.

## Runtime cursor/editor changes

```text
lib/features/editor/slot_registry.dart
lib/features/editor/selection_controller.dart
lib/features/formula_engine/digit_level_caret_stop_policy.dart
lib/features/editor/render/editor_interaction_layer.dart
lib/features/formula_engine/render_mapped_slot_hit_test.dart
```

## Metadata / contract changes

```text
pubspec.yaml
README.md
lib/logic/mathpro_package_contract.dart
```

## Test / verifier changes

```text
test/v172_q41_nested_expression_depth_engine_test.dart
test/v172_q42_drag_to_move_cursor_stability_test.dart
test/v172_q43_structural_insert_delete_safety_test.dart
test/v172_q46_renderer_slot_identity_prototype_test.dart
test/v172_q48_native_layout_box_cursor_layer_test.dart
test/v172_q49_structural_cursor_release_hardening_test.dart
test/v172_q50_p6_locked_cursor_candidate_freeze_test.dart
tool/verify_mathpro_contract.py
tool/verify_mathpro_contract_report.json
tool/verify_mathpro_contract_report.md
```

## Audit docs added

```text
docs/audit/V172_Q50R2_REAL_FLUTTER_LOG_REPAIR_AUDIT_REPORT.md
docs/audit/V172_Q50R2_CHANGED_FILES_MANIFEST.md
```

## Protected files intentionally untouched

```text
lib/features/keyboard/key_config.dart
lib/features/keyboard/math_keyboard.dart
lib/features/keyboard/bottom_dock.dart
lib/features/keyboard/long_press_popup.dart
lib/features/keyboard/premium_key.dart
lib/features/workspace/math_label.dart
lib/features/workspace/template_tray.dart
lib/app/app_shell.dart
lib/features/solution/solution_steps_panel.dart
lib/features/graph/graph_card.dart
lib/features/history/history_controller.dart
lib/features/history/history_panel.dart
```
