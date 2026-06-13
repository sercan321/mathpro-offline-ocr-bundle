# Q389R6D — Graph Open Expression Enter Refresh

## Goal

When the graph preview is already open, changing the MathLive expression and pressing Enter must refresh the graph in-place. The user should not need to close and reopen the graph panel to see `cos(x)` after graphing `sin(x)`.

## Implemented behavior

- Enter/evaluate now calls a graph refresh path after the normal calculation/history flow.
- The refresh runs only if the graph preview is already visible.
- The new graph expression is pulled from the MathLive production envelope, not from a stale controller fallback.
- The existing graph panel is updated in-place through `_applyGraphUpdate`.
- The current 2D/3D render mode is preserved.
- Existing display toggles are preserved: trace, grid, axes, critical points, roots, extrema, intercepts, and graph color.
- The viewport resets to the new expression's safe default so `sin(x) → x^2 - 4` does not inherit a stale zoom/window.
- If the new expression is not graphable or still has open slots, the stale graph is cleared instead of leaving the old graph on screen.

## Red lines preserved

- Keyboard layout/order untouched.
- MathLive bridge untouched.
- OCR/camera untouched.
- Android native untouched.
- Solver/CAS untouched.
- Workspace layout math untouched.
- No per-keystroke graph refresh was added.

## Manual acceptance tests

1. Open graph for `sin(x)` in 2D, change expression to `cos(x)`, press Enter. The graph updates to `cos(x)` without closing the panel.
2. Open graph for `sin(x)` in 3D, change expression to `cos(x)`, press Enter. 3D mode remains active and the graph updates.
3. Open graph for `sin(x)`, enable a marker tooltip, change expression to `x^2 - 4`, press Enter. Old tooltip/markers reset and the new graph appears.
4. Open graph for `sin(x)`, type an invalid/non-graphable expression, press Enter. The old graph does not remain misleadingly visible.
5. Verify keyboard regression: `C → 88888 → 7777` still produces `888887777`.
