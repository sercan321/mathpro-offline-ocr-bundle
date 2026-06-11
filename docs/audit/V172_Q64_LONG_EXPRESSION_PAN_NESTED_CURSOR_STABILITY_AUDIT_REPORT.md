# V172-Q64 Long Expression Pan Nested Cursor Stability Audit Report

Q64 adds an automated long-expression / pan / nested cursor stability court after Q63. It hardens the existing cursor engine for long formulas, nested templates and tap-vs-pan conflict without changing keyboard, MORE, long-press, app shell, MathLabel, template tray, Solution, Graph or History.

## Implemented

- `LongExpressionPanNestedCursorStabilityPolicy` added.
- `EditorViewport` now uses `SlotGeometryBundleAuthority` for active structural visibility targets.
- Active empty structural targets use bundle `leadingRailRect`, preserving `|□` behavior.
- Long/nested expressions force navigation eligibility for stress candidates.
- Q64 test/verifier metadata added.

## Honest limit

Q64 is not a real-device +95 PASS. It is an automated/static court phase before the next real-device cursor checkpoint.
