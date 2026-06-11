# V172-Q52 Active Empty Slot Leading-Rail Caret Repair Closure

## Scope

Q52 is a narrow cursor-geometry phase. It enforces the active empty-slot `|□` law after the user clarified that the caret should stand immediately before the placeholder square, not inside it and not on the default exit side.

## Implemented

- Added `ActiveEmptySlotLeadingRailCaretPolicy`.
- Wired `EditorCaretOverlay` so empty active structural slots bypass the generic exit/entry rail and use the Q52 leading rail.
- Preserved filled-slot digit/content caret stops.
- Kept Q51 structural placeholder restoration intact.
- Kept protected keyboard, MORE, long-press, app shell, MathLabel, template tray, Solution, Graph, and History files unchanged.

## Honest limits

- No real Flutter analyze/test/run was executed in the assistant environment.
- No real-device +95 PASS is claimed.
- Q52 does not solve every integral/root/fraction/function optical role geometry issue; Q53 owns role-specific polish and device regression closure.
- This is not a full native math renderer and does not claim stable AST slot → SVG node identity.

## Expected metadata

```yaml
version: 0.172.82+172
description: MathPro Flutter phase 17 - V172-Q52 active empty slot leading-rail caret repair.
```
