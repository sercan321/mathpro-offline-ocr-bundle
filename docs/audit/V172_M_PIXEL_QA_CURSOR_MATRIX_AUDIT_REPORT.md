# V172-M Pixel QA Cursor Matrix Audit Report

## Scope

V172-M adds a source-controlled no-loupe pixel QA cursor matrix for the Premium Math Cursor Engine. It does not add a loupe, does not add an editor long-press menu, and does not claim real-device PASS.

## Runtime Addition

- `lib/features/formula_engine/pixel_qa_cursor_matrix_policy.dart`

The policy defines the minimum expressions and cursor role families that must be real-device checked before any +95 / Photomath-grade cursor claim.

## Covered Expressions

- `123456`
- `sin(300)`
- `ln(ln(8))`
- `3/4`
- `12/345`
- `x²`
- `x₈`
- `log₂(5)`
- `√(123)`
- `∫₀¹ x² dx`
- `d²y/dx²`
- `[1 2; 3 4]`
- `{2x+y=5; x-y=1}`
- `y'' + 3y' + 2y = 0`
- `sin(300)+cos(400)+log₂(500)+√(600)`

## Guardrails

- `realDevicePassClaimed = false`
- `editorLoupeRequired = false`
- `editorLongPressMenuRequired = false`
- `greenDebugOverlayAllowed = false`

## Honest Status

This is a source/test matrix gate, not a real-device visual QA result. Flutter/Dart were not available in the execution environment, so no Flutter analyze/test PASS is claimed.
