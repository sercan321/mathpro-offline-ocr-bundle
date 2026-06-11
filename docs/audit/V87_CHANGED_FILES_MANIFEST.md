# V87 Changed Files Manifest

- `pubspec.yaml` — bumped to `0.87.0+870`.
- `lib/features/editor/node_factory.dart` — added matrix/vector cell metadata, generic filled-bracket parsing, and cell-aware constructors.
- `lib/features/editor/matrix_cell_navigation_policy.dart` — new row-major matrix/vector cell navigation contract.
- `lib/features/formula_engine/template_slot_navigation_policy.dart` — matrix cells now sort row-major within the same matrix/vector node.
- `lib/features/formula_engine/render_mapped_slot_hit_test.dart` — matrix/vector cells preserve 2D structural layout instead of being flattened to inline placeholder positions.
- `lib/features/formula_engine/slot_interaction_calibration_policy.dart` — matrix cell mobile touch calibration increased.
- `lib/logic/premium_math_key_specs.dart` — `0 matris` now maps to a structural zero matrix.
- `test/v87_matrix_vector_cell_editor_contract_test.dart` — added matrix/vector parse, slot, hit-test and key-spec contract tests.
