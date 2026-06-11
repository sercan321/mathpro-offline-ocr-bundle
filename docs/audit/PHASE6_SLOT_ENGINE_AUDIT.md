# Phase 7 Slot Engine Audit

## Added engine pieces

- Logical `MathNode` model
- Template-aware `NodeFactory`
- Slot registry with role/priority/min-touch metadata
- Approximate layout engine
- Slot hit-test profiles
- Layout-coordinate caret helper
- Editor interaction overlay
- Active slot state in calculator state/controller

## Supported initial structural families

- Fraction numerator / denominator
- Square root value
- Indexed root index / value
- Power base / exponent
- Integral body / differential, plus upper/lower for definite integral
- Sum/product upper/lower/body
- Limit variable/target/body
- Function argument
- Matrix cells

## Honest limitation

The current overlay uses deterministic approximate rectangles. It is not yet a renderer-extracted bounding-box system. A later hardening pass must calibrate or replace approximate boxes using actual visual bounds from the selected renderer.
