# V172-Q294 — First Real Dummy Input Runtime Call Audit

## Phase

V172-Q294-FIRST-REAL-DUMMY-INPUT-RUNTIME-CALL

## Source Phase

V172-Q293-FIRST-REAL-RUNTIME-STARTUP-SMOKE

## Purpose

Q294 adds the guarded contract for the first future PP-FormulaNet-S dummy-input runtime call. This is a gate-only phase. It defines the deterministic dummy input fixture boundary, request/result envelopes, evidence fields, timeout/cancellation/memory policies, and failure taxonomy that must exist before any future native runtime call is accepted.

## Runtime Boundary

Q294 does not invoke MethodChannel, does not invoke JNI, does not start or call a native runtime, does not send a dummy input to Paddle/PaddleOCR, does not parse a runtime response, and does not run image-to-LaTeX inference. The package remains default-off and evidence-gated.

## Required Future Evidence

- Q293 first real runtime startup smoke evidence.
- Verified private artifact path.
- Expected and actual SHA256 match.
- Model format probe evidence.
- MethodChannel binding evidence.
- Native handler evidence.
- Deterministic dummy input fixture ID and payload hash.
- Android ABI evidence.
- Timeout, cancellation, and memory-pressure evidence.
- Real-device dummy-call evidence log.
- Editable MathLive review remains mandatory.
- Explicit user approval remains mandatory before workspace import.

## Forbidden Actions Preserved

- No Paddle runtime added.
- No PaddleOCR dependency added.
- No JNI/native handler implementation added.
- No MethodChannel runtime binding added.
- No model binary bundled in the base app.
- No production download enabled.
- No camera image used as dummy input.
- No image-to-LaTeX inference executed.
- No OCR output written directly to workspace.
- No direct solve, Graph, Solution, or History from camera/OCR output.
- No OCR PASS, runtime PASS, store-ready PASS, or release PASS claim.

## Protected Surface Result

Q294 is limited to new package-side camera/OCR guard files, manifest metadata, README/audit documentation, and successor-aware verifier hygiene. Protected UI/runtime files remain hash-identical to Q293.
