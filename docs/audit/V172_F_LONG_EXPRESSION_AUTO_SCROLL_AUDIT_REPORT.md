# V172-F Long Expression Pan + AutoScroll Audit Report

## Scope

V172-F continues the Premium Math Cursor Engine track after V172-A/B/C/D/E. This phase is deliberately limited to long-expression navigation and caret-follow targeting. It does not claim full +95 cursor completion, solver completion, MathJax renderer-derived bounds, matrix/system cursor completion, calculus cursor completion, or long-press loupe completion.

## Runtime Changes

- `LongExpressionNavigationPolicy.slotCaretVisibilityTarget(...)` was added so auto-scroll can follow the active caret rail inside a filled structural slot instead of treating the whole slot rectangle as the target.
- `LongExpressionNavigationPolicy.version` was advanced to `mathpro-v172f-long-expression-navigation-caret-follow-v3` while preserving the historic `long-expression-navigation` marker expected by older contract tests.
- `EditorViewport._activeCanvasTarget(...)` now derives a caret-specific target for active structural slots using the current `CursorAnchor` offset / selection caret index and the slot-local payload length.
- `EditorViewport._ensureCanvasTargetVisible(...)` now includes `cursorAnchor.auditLabel`, `caretIndex`, and `linearCaretIndex` in the visibility signature so moving within the same slot can trigger a fresh auto-scroll evaluation.

## Previous Phase Checks

Before and after this phase, the following were checked:

- V172-A `editor_caret_overlay.dart` is still present.
- `EditorViewport` still wires `EditorCaretOverlay` between `MathRenderSurface` and `EditorInteractionLayer`.
- V172-B function-continuity tests remain present.
- V172-C `CursorAnchor` remains present.
- V172-D filled fraction/power/subscript tests remain present.
- V172-E log/root/nested-function tests remain present.
- `paintVisibleSlotOverlay=true` was not introduced in production code.
- The legacy green `mathpro-active-slot-highlight` production path remains disabled.

## Added Regression Coverage

Added tests in `test/core_editor_regression_test.dart`:

- `MathPro V172-F builds a caret-specific visibility target inside filled structural slots`
- `MathPro V172-F auto-scrolls toward the structural caret rail, not just the coarse slot`
- `MathPro V172-F keeps cursor anchor offset in EditorViewport visibility signature`

## Protected Surfaces

V172-F did not edit the frozen keyboard, MORE, long-press, bottom dock, graph, history, or solution-panel files. Their hashes are recorded in `V172_F_SELF_CHECK_REPORT.md`.

## Truth Boundary

V172-F improves auto-scroll and long-expression caret-follow targeting. It does not complete renderer-synchronized hit-testing, structural deletion, matrix/system editing, calculus/ODE cursor editing, or long-press loupe.
