# V172-D Cursor Slot Precision Audit Report

## Phase
V172-D — Fraction / Power / Subscript Slot Precision

## Scope
This phase continues the Premium Math Cursor Engine track. It does **not** claim that the full +95 cursor engine is complete. It only hardens the first structural slot families required for premium cursor behavior:

- filled fractions (`12⁄345`)
- filled powers (`x^(12)`)
- filled subscripts (`x₈`, `x_8`, `x_(89)`)
- slot-local cursor offsets beyond binary 0/1 edges

## Previous Phase Recheck
Before V172-D changes, the package was checked for:

- V172-A `EditorCaretOverlay` file present.
- `EditorViewport` still wires `MathRenderSurface → EditorCaretOverlay → EditorInteractionLayer`.
- `paintVisibleSlotOverlay=true` not present.
- Old `mathpro-active-slot-highlight` production path not re-enabled.
- V172-B function-continuity tests still present.
- V172-C `CursorAnchor` model still present.
- Locked keyboard, MORE, long-press, Graph, History and Solution files unchanged versus V172-C baseline.

## Runtime Changes

### CursorAnchor
`CursorAnchor.slot` no longer clamps structural offsets to 0..1. This preserves local offsets for filled slots such as denominator offset 2 inside `345`.

### Selection Controller
`MathProSelectionController` now preserves non-negative slot-local caret indexes instead of forcing every structural selection to 0/1.

### EditorInteractionLayer
Slot hit testing now chooses caret index using the visible slot rect and a slot-local payload extent. This makes filled slots less binary and prepares fraction/power/subscript editing for real cursor placement.

### EditorCaretOverlay
The premium caret overlay now uses the selected slot payload length as `childCount` when painting the caret inside filled slots.

### SlotRegistry
Filled subscripts are now real addressable slots. `x₈` no longer becomes a dead/fixed atom from the cursor perspective.

### EditorCommands
Subscript slot roles are preserved when clearing/replacing selected subscript slots.

## Added Regression Coverage

- `MathPro V172-D keeps filled fraction power and subscript slots addressable`
- `MathPro V172-D preserves slot-local caret offsets instead of binary slot edges`

## Explicit Non-Claims

- No full Photomath/Wolfram-level cursor engine completion is claimed.
- No renderer-derived MathJax/SVG geometry sync is claimed.
- No long-press loupe is claimed.
- No matrix/system/differential-equation cursor completion is claimed in this phase.
- No Flutter analyze/test/run PASS is claimed from this environment.
