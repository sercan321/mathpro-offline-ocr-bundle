# V61.1 Changed Files Manifest

## Runtime files changed

- `lib/features/editor/render/editor_interaction_layer.dart`
  - Added linear placeholder anchored effective slot rects.
  - Enlarged mobile placeholder fallback behavior.
  - Active slot highlight now uses effective placeholder rects.

- `lib/features/editor/selection_controller.dart`
  - Added public `inlineExpressionCenterY` calibration.
  - Updated inline caret optical center behavior.
  - Slightly adjusted placeholder glyph width estimate.

- `lib/features/formula_engine/slot_hit_testing.dart`
  - Increased nearest fallback radius for mobile slot hit testing.
  - Updated hit-test version string.

- `lib/features/workspace/editor_viewport.dart`
  - Adjusted expression render vertical offset for better text/caret optical alignment.

## Metadata/docs changed

- `pubspec.yaml`
- `README.md`
- `docs/audit/ELITE_PREMIUM_PLUS_V61_1_EDITOR_INTERACTION_REPAIR_AUDIT_REPORT.md`
- `docs/audit/ELITE_PREMIUM_PLUS_V61_1_CHANGED_FILES_MANIFEST.md`
- `docs/audit/ELITE_PREMIUM_PLUS_V61_1_RELEASE_HYGIENE_REPORT.md`

## Non-changed sacred areas

- Keyboard topology was not changed.
- Solution Steps layout/visual behavior was not changed.
- Solver/CAS was not changed.
