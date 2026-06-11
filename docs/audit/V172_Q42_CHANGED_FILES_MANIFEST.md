# V172-Q42 Changed Files Manifest

Production cursor changes:

- `lib/features/formula_engine/drag_to_move_cursor_stability_policy.dart` added.
- `lib/features/editor/render/editor_interaction_layer.dart` updated to use Q42 drag-stability suppression state.
- `lib/features/formula_engine/editor_gesture_router_policy.dart` updated with Q42 availability marker only.
- `lib/logic/mathpro_package_contract.dart` metadata advanced to Q42.

Metadata/audit/test changes:

- `pubspec.yaml` advanced to `0.172.69+172`.
- `README.md` prepended with Q42 release notes.
- `test/v172_q42_drag_to_move_cursor_stability_test.dart` added.
- `tool/verify_mathpro_contract.py` updated with Q42 static gate.
- Q42 audit docs added under `docs/audit/`.

P6 locked UI files remain byte-identical to the provided P6 baseline.
