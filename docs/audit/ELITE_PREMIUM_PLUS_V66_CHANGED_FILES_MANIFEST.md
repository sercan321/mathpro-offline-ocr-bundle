# V66 Changed Files Manifest

## Runtime
- `lib/features/editor/selection_controller.dart`
  - V66 caret/render-band optical alignment policy.
  - Compatibility version string containing `phase6-token-aware`.
  - Public phase-6 snap-radius contract restored while internal precision snap remains tight.
- `lib/features/workspace/editor_viewport.dart`
  - Math renderer is positioned in a measured editor band using `inlineRenderBandRect`.
  - Render surface isolated with `RepaintBoundary`.
- `lib/features/editor/render/editor_interaction_layer.dart`
  - Active slot focus feedback polished.
- `lib/features/formula_engine/slot_hit_testing.dart`
  - V66 version lock.
- `lib/features/formula_engine/slot_interaction_calibration_policy.dart`
  - V66 version lock.

## Tests / Audit
- `test/core_editor_regression_test.dart`
  - V66 optical alignment and hit-test version regression lock added.
- `README.md`
  - V66 phase notes appended.
- `pubspec.yaml`
  - Version bumped to `0.66.0+66`.
- `docs/audit/ELITE_PREMIUM_PLUS_V66_*`
  - Audit, manifest, hygiene and hash reports.

## Explicitly Preserved
- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/logic/evaluator_bridge.dart`
- `lib/features/solution/solution_step_models.dart`
