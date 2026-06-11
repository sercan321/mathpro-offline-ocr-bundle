# V172-G Structural Deletion Scoped Backspace Audit Report

## Scope

V172-G continues the Premium Math Cursor Engine work from the incoming V172-F package. The uploaded package was verified as V172-F (`0.172.5+172`) before editing, so V172-H was not started or claimed. This phase implements the missing V172-G structural-deletion step first.

## Previous Phase Verification

Before and after V172-G edits, these facts were checked:

- V172-A `lib/features/workspace/editor_caret_overlay.dart` exists.
- V172-A `EditorViewport` still wires the overlay between the Math render surface and interaction layer.
- V172-B function argument continuity tests remain present.
- V172-C `CursorAnchor` code remains present.
- V172-D fraction / power / subscript slot precision tests remain present.
- V172-E log / root / nested function tests remain present.
- V172-F long-expression auto-scroll tests remain present.
- Production `paintVisibleSlotOverlay: true` was not introduced.
- The old green slot highlight path was not re-enabled as the production cursor feedback.

## Runtime Changes

### `lib/features/editor/editor_commands.dart`

Added `StructuralSlotBackspaceEdit` and `EditorCommands.backspaceSelectedSlotPayload(...)`.

The new command deletes one character inside a selected filled structural slot using the slot-local caret offset before falling back to whole-slot clearing. It is deliberately scoped to selected filled slots such as:

- function argument: `sin(300|)` -> `sin(30|)`
- fraction denominator: `12⁄34|5` -> `12⁄3|5`
- power exponent: `x^(12|)` -> `x^(1|)`

### `lib/state/calculator_controller.dart`

Backspace now calls `backspaceSelectedSlotPayload(...)` before `clearSelectedSlot(...)` when a filled structural slot is active. After editing, `_focusStructuralSlotByRole(...)` attempts to restore focus to the same slot role and preserve the corrected local caret offset.

## Regression Tests Added

Added V172-G regression coverage in `test/core_editor_regression_test.dart`:

1. `MathPro V172-G deletes inside filled structural slots before clearing nodes`
2. `MathPro V172-G controller keeps Backspace scoped to the active slot`
3. `MathPro V172-G self-check keeps the green slot overlay disabled`

## Protected Contract

V172-G did not edit the frozen keyboard, MORE, long-press, bottom dock, graph, history, or solution-panel files.

## Explicit Non-Claims

V172-G is not claimed as:

- complete +95 cursor engine
- renderer-synchronized MathJax/SVG hit-test completion
- matrix/system cursor completion
- calculus/ODE cursor completion
- long-press loupe completion
- real-device visual PASS
- local Flutter analyze/test/run PASS
