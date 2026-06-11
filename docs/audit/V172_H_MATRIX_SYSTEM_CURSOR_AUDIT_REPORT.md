# V172-H Matrix / System Editor Cursor Audit Report

V172-H continues the Premium Math Cursor Engine track from the incoming V172-G package. This phase is deliberately limited to matrix/vector cell and system-equation cursor addressing. It does not claim full +95 cursor completion, solver completion, calculus/ODE cursor completion, renderer-derived MathJax bounds, or long-press loupe completion.

## Pre-Phase Verification

Before V172-H edits, the package was checked for these facts:

- V172-A `lib/features/workspace/editor_caret_overlay.dart` exists.
- `EditorViewport` still wires `EditorCaretOverlay` between the math render surface and interaction layer.
- V172-B function-continuity tests remain present.
- V172-C `CursorAnchor` code remains present.
- V172-D fraction / power / subscript tests remain present.
- V172-E log / root / nested-function tests remain present.
- V172-F long-expression auto-scroll tests remain present.
- V172-G structural-deletion tests remain present.
- `paintVisibleSlotOverlay: true` was not introduced in production code.
- The old green `mathpro-active-slot-highlight` path remains disabled for production.

## Runtime Changes

- `MatrixCellNavigationPolicy` was promoted to `mathpro-v172h-matrix-system-cursor-address-policy` and now exposes `StructuralGridAddress` for matrix, vector and system-equation fields.
- `TemplateSlotNavigationPolicy` now uses the same structural grid comparator for same-node matrix/system entries.
- `SlotRegistry` system slots now receive row-major priorities (`left_0`, `right_0`, `left_1`, `right_1`) instead of an all-left then all-right focus order.
- `EditorCommands` now resolves `matrixCell`, `systemLeft`, and `systemRight` roles explicitly when selecting/replacing/backspacing filled structural fields.
- Long-expression cursor-follow and hit-test priority policies now treat system left/right fields like matrix cells for visibility and tap-priority purposes.

## Added Regression Tests

V172-H adds regression coverage in `test/core_editor_regression_test.dart`:

1. `MathPro V172-H keeps matrix and vector cells as row-major cursor anchors`
2. `MathPro V172-H keeps system equations row-major instead of all-left then all-right`
3. `MathPro V172-H self-check keeps prior cursor phases and green overlay disabled`

## Protected Areas

V172-H did not edit the frozen keyboard, MORE, long-press, bottom dock, graph, history, or solution-panel files. These were compared against the incoming V172-G package.

## Honest Scope

V172-H is not a full +95 cursor engine. It is a controlled cursor-addressing phase for matrix, vector, and system-equation structures.
