# V172-E Log / Root / Nested Function Cursor Audit Report

## Scope

V172-E continues the Premium Math Cursor Engine track with a deliberately narrow scope:

- log base / argument slot precision
- indexed-root index / radicand slot precision
- nested function depth-aware slot priority
- no keyboard, MORE, long-press, Graph, History or Solution redesign

## Runtime Findings Before Change

- V172-A visible `EditorCaretOverlay` existed and remained wired in `EditorViewport`.
- V172-B function-continuity tests existed.
- V172-C `CursorAnchor` model existed.
- V172-D filled fraction / power / subscript precision tests existed.
- `paintVisibleSlotOverlay=true` was not present as production code.
- Legacy `_SlotBox` remained present only as a dormant path guarded by `paintVisibleSlotOverlay`.

## V172-E Runtime Changes

### `slot_registry.dart`

- Bumped slot-registry version to `mathpro-core-editor-v172e-log-root-nested-slot-registry-v1`.
- Increased indexed-root index priority/min-touch profile so the tiny root index receives stable focus before the larger radicand.
- Increased log-base priority/min-touch profile so `logBase` is prioritized before the argument.
- Changed `MathNodeKind.logBase` filled-slot policy so `base` and `arg` remain independently addressable even when the sibling slot is still open.
- Added `MathNodeKind.indexedRoot` filled-slot policy so both `index` and `value` remain addressable after filling.

### `editor_commands.dart`

- Added role restoration for `sqrt.value`, `indexedRoot.index`, and `indexedRoot.value` in `clearSelectedSlot` / slot role lookup paths.
- Added fallback role mapping for `index` and `value` slot ids.

### `selection_controller.dart`

- Updated `MathProCaretController.version` to include `v172e-log-root-nested-slots`.

### `editor_interaction_layer.dart`

- Removed a stale duplicated collection-if line around `_SlotBox` without enabling visible slot overlay.

## Regression Coverage Added

Added V172-E regression tests in `test/core_editor_regression_test.dart`:

1. `MathPro V172-E keeps log base and argument independently addressable`
2. `MathPro V172-E keeps indexed-root index and radicand cursor targets alive`
3. `MathPro V172-E keeps nested function slots depth-aware instead of flattening taps`

## Non-Claims

This phase does not claim:

- full +95 cursor engine completion
- renderer-derived MathJax/SVG geometry sync
- long-press loupe
- matrix/system cursor completion
- calculus/differential-equation cursor completion
- local Flutter analyze/test/run PASS
