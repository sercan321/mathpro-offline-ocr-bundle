# Phase 7 Slot Engine Hardening Audit

## What changed

Phase 7 did not claim a final perfect editor engine. It hardened the Phase 6 structural foundation in four concrete areas:

1. **Central calibration policy**
   - Added `SlotInteractionCalibrationPolicy`.
   - Slot min target sizes and hit slop now live in one source.

2. **Stable slot priority ordering**
   - `SlotRegistry.build()` now sorts by priority, then deterministic role order, then ID.
   - This reduces nondeterministic primary-slot selection when multiple slots share the same priority.

3. **Canvas-safe layout boxes**
   - Approximate slot rectangles are clamped through the calibration policy.
   - This prevents structural hit zones from exceeding the current editor canvas.

4. **Self-check catalog**
   - Added `SlotEngineSelfCheck` for the current structural smoke templates.
   - It checks registry presence, rect count parity, non-empty rects, and canvas bounds.

## Covered structural families

- Fraction numerator/denominator
- Square root value
- Indexed root index/value
- Power base/exponent
- Integral body/differential/upper/lower
- Sum/product upper/lower/body
- Limit variable/target/body
- Function argument
- Matrix cells

## Still not final

The slot engine still uses approximate boxes. Production-grade precision requires renderer-derived bounds or real-device coordinate calibration.
