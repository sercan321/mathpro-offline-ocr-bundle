# V172-Q132R2 — Renderer Root Coordinate Caret Repair Audit

## Scope

Q132R2 is a runtime geometry repair for the existing main editor cursor path. It does not switch MathLive into the main editor, does not delete the legacy cursor engine, and does not mutate protected keyboard, MORE, long-press, AppShell, Graph, History, or Solution surfaces.

## Defect repaired

User real-device observation showed that the visible editor still behaved like the old cursor motor: caret anchors could be far from the visible structural boxes and tapping structural areas remained difficult. The root cause is that MathJax/WebView geometry messages reported SVG coordinates inside the centered WebView root, while the Flutter cursor/hit-test layer consumed those normalized coordinates as if they belonged to the entire editor canvas.

## Change

`RendererGeometrySnapshot` now stores the MathJax root width/height and maps SVG/content/element rectangles into the actual centered WebView root rectangle inside the editor canvas before `MathLayoutEngine`, `RenderMappedSlotHitTest`, `TrueGlyphLevelCaretStopPolicy`, and `EditorCaretOverlay` consume them.

## Non-goals

- No MathLive default/main editor switch.
- No legacy cursor deletion.
- No Graph/History/Solution runtime write activation.
- No keyboard, MORE, long-press, AppShell, MathLabel, TemplateTray, GraphCard, History, or Solution UI mutation.
- No cursor PASS, release PASS, or Photomath/Wolfram +95 claim.

## Evidence boundary

Package-side verifier/static checks can prove the coordinate mapping contract exists. Real-device confirmation is still required to claim the visual cursor issue is closed.
