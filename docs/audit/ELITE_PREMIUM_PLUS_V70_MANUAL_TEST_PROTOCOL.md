# MathPro V70 — Manual Test Protocol

Run after installing the package on a real Android device.

## Atomic Delete

1. Insert `sin(□)`, press backspace while the empty argument slot is active. Expected: the entire `sin(□)` structure disappears; no `sin(`, `sin`, `si`, or `s` remains.
2. Insert `ln(□)`, press backspace while the empty argument slot is active. Expected: the entire `ln(□)` structure disappears.
3. Enter or restore `tan(cos(ln(9)))`, place the caret at the far right, press backspace. Expected: the recognized nested function structure is deleted atomically rather than becoming partial text.

## Operator Replacement

1. Type `9`, then `×`, then `+`. Expected: expression becomes `9+`, not `9×+`.
2. Type `9`, then `+`, then `÷`. Expected: expression becomes `9÷`, not `9+÷`.
3. Type `9`, then `÷`, then `−`. Expected: expression becomes `9-`, not `9÷-`.

## Percent Visibility

1. Press `%`. Expected: `%` is visible in the editor, not a blank gap.
2. Type `99%`. Expected: the percent sign remains visible and does not hide the expression after it.

## Regression Guard

- Short normal input should still allow ordinary one-character backspace.
- Long expression pan/caret behavior from V69 should remain intact.
- Solution panel layout should remain unchanged.
