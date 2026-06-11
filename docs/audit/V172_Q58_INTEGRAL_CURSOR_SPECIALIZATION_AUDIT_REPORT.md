# V172-Q58 Integral Cursor Specialization Audit Report

Q58 is a P6-locked cursor/editor geometry phase. It does not create a new keyboard, does not change MORE, does not alter long-press popup behavior, and does not touch app shell, MathLabel, template tray, Solution, Graph, or History.

## Scope

Q58 specializes the existing MathPro cursor motor for integral templates only:

- integral upper limit
- integral lower limit
- integral body
- integral differential
- differential `d|□` leading-rail behavior
- suppression of detached linear fallback inside integral hit regions

## Runtime wiring

- `IntegralCursorSpecializationPolicy` centralizes integral-only role guards.
- `SlotGeometryBundleAuthority` delegates integral hitRect, placeholderRect, leadingRailRect, innerTextRect, baseline, hit slop, and minimum touch size refinements to Q58.
- `StructuralIntentResolverPolicy` uses Q58 role bonus, lane penalty, and nearest radius for integral intent selection.
- `EditorInteractionLayer` suppresses detached linear fallback inside integral regions.

## Protected surfaces

The following surfaces remained protected: keyboard layout, key faces, MORE tray, long-press popup, app shell, MathLabel, template tray, Solution, Graph, and History.

## Honest limits

Q58 does not claim Flutter analyze PASS, Flutter test PASS, real-device PASS, full native math rendering, stable AST slot to SVG node identity, or final Photomath/Wolfram +95 completion. Real-device evidence remains required.
