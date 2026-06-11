# V158 Changed Files Manifest

## Changed Files

- `lib/features/editor/math_node.dart`
- `lib/features/editor/node_factory.dart`
- `lib/features/editor/tex_serializer.dart`
- `lib/logic/mathpro_package_contract.dart`
- `pubspec.yaml`
- `README.md`
- `test/v157_primitive_render_node_migration_test.dart`
- `test/v158_operator_delimiter_node_migration_test.dart`
- `docs/audit/V158_OPERATOR_DELIMITER_NODE_MIGRATION_AUDIT.md`
- `docs/audit/V158_CHANGED_FILES_MANIFEST.md`
- `docs/audit/V158_OPERATOR_DELIMITER_NODE_COVERAGE.csv`

## Protected Files Intentionally Not Changed

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/graph/graph_card.dart`
- `lib/features/history/history_panel.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/features/workspace/editor_viewport.dart`
- `lib/features/editor/render/editor_interaction_layer.dart`

## Purpose

Move public operator and delimiter labels into explicit AST render node kinds without changing the frozen keyboard or major UI surfaces.
