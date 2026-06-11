# V172-Q272-PP-FORMULANET-S-FIRST-RUNTIME-SMOKE-PROTOTYPE

## Scope
Q272 adds a first runtime smoke prototype gate for PP-FormulaNet-S. This is a smoke-contract package only: no Paddle runtime, no PaddleOCR dependency, no JNI/native bridge implementation, no MethodChannel runtime binding, no model binary, no production URL/download worker, and no image-to-LaTeX inference are added.

## Source phase
V172-Q271-PP-FORMULANET-S-PRIVATE-ARTIFACT-LOAD-PROTOTYPE

## Required gates
- Q271 private artifact load prototype remains present and no-runtime/no-inference.
- Private artifact access envelope, accepted artifact SHA, model-format probe plan, runtime path candidate, bridge protocol candidate, dummy input envelope, and runtime startup envelope must be documented.
- Timeout/cancellation, memory pressure, latency, peak-memory, and smoke error taxonomy must be defined.
- Runtime feature flag must remain default-off and runtime must not be enabled by default.
- Editable MathLive review and explicit user approval remain mandatory before workspace import.
- Direct solve, Graph, Solution, and History writes from camera/OCR remain blocked.

## Explicit non-claims
- No real runtime smoke PASS.
- No PP-FormulaNet-S inference PASS.
- No OCR PASS.
- No Flutter analyze/test/run PASS.
- No Android real-device PASS.
