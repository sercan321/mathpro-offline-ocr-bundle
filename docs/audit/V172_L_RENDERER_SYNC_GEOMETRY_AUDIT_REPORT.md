# V172-L Renderer-Sync Geometry Calibration Audit

## Scope
V172-L introduces deterministic renderer-sync geometry calibration for MathPro cursor hit-test/caret behavior without adding an editor loupe or claiming real SVG/MathJax bounds extraction.

## Implemented
- Added `lib/features/formula_engine/renderer_sync_geometry_policy.dart`.
- Routed `RenderMappedSlotHitTest` final visual rects through `RendererSyncGeometryPolicy.calibrateVisualRect`.
- Routed long-expression caret visibility rails through `RendererSyncGeometryPolicy.caretRailForSlot`.
- Added regression tests for no-loupe renderer-sync honesty, matrix/system non-flattening, and caret rail policy reuse.

## Preserved
- Keyboard layout unchanged.
- MORE / Ans / = / ↵ unchanged.
- Keyboard long-press maps unchanged.
- Graph / History / Solution unchanged.
- No `paintVisibleSlotOverlay: true` production path was added.
- No editor loupe or long-press menu was added.

## Honest Limitations
- This is deterministic calibration, not actual renderer-extracted MathJax/SVG glyph bounds.
- Flutter analyze/test were not run in this environment because Flutter/Dart are unavailable.
- Real device pixel QA is still required.
