# V172-Q251 / Camera Math OCR End-to-End Court Audit

## Scope

Q251 is the camera math OCR end-to-end court after Q250. It is intentionally a guard and evidence-contract phase. It does not add real OCR runtime, does not add Paddle/PaddleOCR dependency, does not bundle PP-FormulaNet-S model bytes, does not bind a production model URL, and does not claim real OCR PASS.

## Implemented

- Added `GaussCameraMathOcrEndToEndCourtPolicy`.
- Added `GaussCameraMathOcrEndToEndCourt`.
- Added Q251 tests.
- Added Q251 static verifier.
- Updated manifest and README metadata.
- Preserved the user-selected primary OCR engine: PP-FormulaNet-S.
- Preserved Text OCR fallback as text fallback only.
- Preserved MathLive editable review-first rule.
- Preserved explicit user approval before any workspace-import-prepared state.

## Required Court Chain

1. camera capture
2. crop / scan-frame
3. Q248 deferred model readiness
4. Q249 review-only adapter envelope
5. Q250 editable MathLive review draft
6. explicit user approval
7. workspace-import-prepared court state only after approval

## Blocked Behaviors

- no direct workspace import
- no direct solve
- no direct Graph
- no direct Solution
- no direct History
- no production MathLive bridge call
- no PP-FormulaNet-S real inference
- no Paddle runtime
- no model binary in base APK

## Real-Device Evidence Categories Reserved

simpleArithmetic, quadraticExpression, fraction, squareRoot, indefiniteIntegral, definiteIntegral, primeDerivative, leibnizDerivative, limit, sigma, matrix, lowLight, skewedCapture, mildBlur, notebookLinesOrShadow.

## Protected Surfaces

Q251 is intended to preserve keyboard, MORE, long-press, MathLive production editor, Graph, Solution, History, AppShell, `main.dart`, Android manifest, MainActivity, camera dependency line, Kotlin plugin, AGP line, camera shell runtime, Q248 deferred model runtime, Q249 adapter contract, and Q250 MathLive review import contract. The verifier checks these surfaces.

## Honest Boundary

Q251 is static/verifier ready only. Flutter analyze/test/run, Android real-device behavior, PP-FormulaNet-S inference, model download, and actual OCR recognition are not claimed without real logs/evidence.

Marker summary: V172-Q251-CAMERA-MATH-OCR-END-TO-END-COURT, Q251, PP-FormulaNet-S, camera capture, crop/scan-frame, Q248, Q249, Q250, editable MathLive review, user approval, no Paddle runtime, no model binary, no real OCR PASS.

## Successor Verifier Hygiene

Q251 updates the Q250 verifier metadata check so Q250 accepts Q251 as the active `cameraOcrLatestPhase` successor. This is verifier hygiene only; it does not modify Q250 runtime behavior.
