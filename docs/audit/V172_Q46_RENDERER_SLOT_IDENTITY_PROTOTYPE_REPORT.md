# V172-Q46 Renderer Slot Identity Prototype Report

## Scope
Q46 adds renderer element-rect telemetry and candidate slot-identity refinement to the existing P6-locked cursor track. It does not change keyboard, MORE, long-press, app layout, MathLabel, Graph, History, or Solution surfaces.

## Honest capability boundary
- `trueAstSlotToSvgNodeIdentityClaimed = false`
- `fakePerSlotIdentityAllowed = false`
- MathJax reports SVG expression envelope plus candidate element rectangles.
- Deterministic slot geometry may be nudged toward renderer element candidates.
- This is not final AST slot id -> SVG node id mapping.

## Cursor impact target
Q46 is intended to reduce mismatch between deterministic slot rects and actual MathJax rendered content before later true glyph-level caret phases.

## P6 lock
Protected P6 visual/keyboard files must remain byte-identical. Any change is a release reject.
