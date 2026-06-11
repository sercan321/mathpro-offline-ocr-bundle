# V64 Changed Files Manifest

Runtime changed/added files:

- `lib/features/formula_engine/template_slot_navigation_policy.dart` — new shared slot ordering/navigation policy.
- `lib/features/formula_engine/render_mapped_slot_hit_test.dart` — render-mapped slot ordering now uses shared policy.
- `lib/features/formula_engine/slot_hit_testing.dart` — enlarged mobile finger target/fallback constants.
- `lib/features/editor/render/editor_interaction_layer.dart` — uses shared slot ordering and stronger premium active-slot focus ring.
- `lib/features/editor/editor_commands.dart` — exposes selected slot placeholder ordinal for safe next-slot focus.
- `lib/state/calculator_controller.dart` — after slot insertion, focuses next visible open slot using V64 policy.
- `pubspec.yaml` — version bumped to 0.64.0+64.
- `README.md` — V64 notes appended.
