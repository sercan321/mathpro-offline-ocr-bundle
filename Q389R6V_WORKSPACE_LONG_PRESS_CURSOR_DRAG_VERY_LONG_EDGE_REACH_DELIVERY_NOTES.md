# Q389R6V — Workspace Long-Press Cursor Drag Very-Long Edge Reach Repair

## Device feedback

Q389R6U fixed the main long-press cursor drag behavior: the caret can be held and moved with the finger. The remaining defect is specific to very long expressions: while dragging near the left edge, the caret could not be driven all the way to the absolute beginning.

## Repair

Q389R6V keeps the Flutter external bridge and MathLive native caret authority, but changes edge behavior from scroll-only to deterministic directional offset walking. While a drag session is active and the pointer is inside the left/right edge zone, the bridge now advances `mf.position` toward offset `0` or `lastOffset` in bounded steps. This no longer depends solely on DOM `scrollLeft` or on repeatedly hit-testing the same visible client coordinate.

Q389R6V also prevents drag-end from re-hit-testing the final edge coordinate. The last valid caret position is preserved, which avoids overwriting an already-walked edge position with a stale visible-edge hit-test result.

## Safety

- No keyboard layout/key order changes.
- No Dart keyboard dispatch queue changes.
- No JS-side keyboard command queue changes.
- No graph/OCR/Android native/solver changes.
- No legacy Flutter cursor overlay.
- No document-level `touchmove` / `pointermove` fallback.

## Runtime files changed

- `assets/mathlive/mathlive_prod_bridge.js`
- `assets/mathlive/main_editor_prod.html`

## Policy / verifier files added

- `lib/features/workspace/workspace_long_press_cursor_drag_external_edge_reach_policy_q389r6v.dart`
- `tool/verify_workspace_long_press_cursor_drag_very_long_edge_reach_q389r6v.mjs`
