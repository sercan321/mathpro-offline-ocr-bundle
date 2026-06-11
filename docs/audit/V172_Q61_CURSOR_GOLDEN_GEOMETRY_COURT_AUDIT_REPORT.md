# V172-Q61 Cursor Golden Geometry Court Audit Report

Q61 introduces an automatic cursor geometry court for the existing MathPro cursor motor. It is not a real-device PASS and it does not claim Photomath/Wolfram completion.

## Scope

- Validate active-empty-slot `|□` leading rail invariants.
- Ensure the caret does not overlap the placeholder box.
- Ensure the caret does not detach from the placeholder edge.
- Preserve filled-slot inner text caret behavior.
- Establish 20-attempt / 19-correct / 0.95 synthetic threshold rules for later tap courts.

## Protected surfaces

Keyboard, key faces, MORE, long-press popup, app shell, MathLabel, template tray, Solution, Graph and History remain protected and unchanged by Q61.

## Honest limit

Q61 is a code-level golden geometry court. Flutter analyze/test and real-device Pixel QA are still required before any +95 cursor PASS claim.
