# Phase 5 Render Decision Audit

## Decision

Phase 5 uses `flutter_math_fork` as the first Flutter-native premium math render layer.

## Reason

The current React Native reference uses WebView + inline KaTeX. That is a valid render strategy, but Flutter rewrite should first attempt a native Flutter render path because:

- it avoids a permanent WebView dependency in the editor surface,
- it integrates more naturally with Flutter layout constraints,
- it is better positioned for Phase 7 custom overlay/caret experiments,
- it keeps the editor surface inside Flutter's widget tree.

## Guardrail

This is not claimed as final PASS. The renderer choice must still be visually checked on a real Android device/emulator against these expressions:

- `√x`
- `√(x+1)`
- `√√x`
- `³√8`
- `□⁄□`
- `x²`
- `xⁿ`
- `∫ₐᵇ(□)dx`
- `limₓ→ₐ⁻(□)`
- `Σ(□)`
- `Π(□)`
- `2×2`
- `3×3`

## Fallback policy

If TeX rendering fails, `MathRenderSurface` falls back to the previous plain visual text instead of crashing. This is a safety fallback, not a hidden success claim.

## Not done in Phase 5

- WebView + KaTeX benchmark was not run in this environment.
- Real device visual comparison was not run.
- Slot/caret/hit-test was not implemented.
- Structural AST editing was not implemented.
