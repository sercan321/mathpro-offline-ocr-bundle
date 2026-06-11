# V172-C CursorAnchor Audit Report

## Scope

V172-C introduces the canonical cursor-address contract for MathPro's Premium Math Cursor Engine track.

This phase does not claim the full +95 cursor engine is complete. It only moves the editor toward a math-addressed cursor model so future phases can stop relying only on raw visual caret indices.

## Previous Phase Recheck

Before applying V172-C, the package was rechecked for the prior phases:

- V172-A `lib/features/workspace/editor_caret_overlay.dart` exists.
- `EditorViewport` still paints `EditorCaretOverlay` between `MathRenderSurface` and `EditorInteractionLayer`.
- `paintVisibleSlotOverlay=true` was not introduced.
- V172-B regression tests remain present in `test/core_editor_regression_test.dart`.
- The old green `mathpro-active-slot-highlight` key remains only in the legacy disabled path and V172-A test assertion.

## Runtime Change

A new canonical model was added:

```text
lib/features/editor/cursor_anchor.dart
```

It supports:

- `CursorAnchor.linear(...)`
- `CursorAnchor.slot(...)`
- `CursorAnchorKind.linear`
- `CursorAnchorKind.structuralSlot`
- `CursorAffinity.before/after`

`MathEditorController.buildSnapshot` now resolves a `cursorAnchor` in the `EditorInteractionContext` for linear and structural slot selections.

`EditorCaretOverlay` now prefers the canonical anchor first, while keeping compatibility fallbacks for legacy raw selection fields.

`EditorViewport` also consults the anchor for active target centering.

## Non-Changes

V172-C does not change:

- keyboard layout
- key order
- tab order
- MORE categories
- long-press option order
- Graph
- History
- Solution panel
- evaluator / solver capability
- old green slot overlay production state

## Regression Coverage Added

- `MathPro V172-C exposes a canonical linear CursorAnchor for text caret taps`
- `MathPro V172-C exposes a canonical structural CursorAnchor for active slots`
- `MathPro V172-C premium caret overlay follows CursorAnchor first`

## Remaining Work

Future phases must use this anchor contract to implement true LayoutBox precision, renderer-synced hit-test, fraction/power/subscript/log/root slot precision, matrix/system cursor behavior, calculus/ODE slot behavior, structural deletion, auto-scroll and long-press loupe.
