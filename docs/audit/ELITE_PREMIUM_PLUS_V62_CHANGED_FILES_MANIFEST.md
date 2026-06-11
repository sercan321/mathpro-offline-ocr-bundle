# V62 Changed Files Manifest

## Runtime files changed
- `lib/features/formula_engine/render_mapped_slot_hit_test.dart` — new render-mapped slot rect resolver.
- `lib/features/editor/render/editor_interaction_layer.dart` — uses render-mapped slot rects for tap/pan selection.
- `lib/features/formula_engine/visible_renderer_policy.dart` — raw placeholder expressions now expose slot overlays.
- `lib/features/formula_engine/slot_hit_testing.dart` — V62 hit-test constants and target radius.
- `lib/features/formula_engine/slot_interaction_calibration_policy.dart` — mobile hit-target calibration for placeholder/function slots.
- `lib/features/editor/selection_controller.dart` — caret optical line/height recalibration.
- `lib/features/workspace/editor_viewport.dart` — math render surface offset recalibration.

## Metadata/docs changed
- `pubspec.yaml`
- `README.md`
- `docs/audit/ELITE_PREMIUM_PLUS_V62_*`

## Protected files intentionally not changed
- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/logic/evaluator_bridge.dart`
- `lib/features/solution/solution_step_models.dart`
