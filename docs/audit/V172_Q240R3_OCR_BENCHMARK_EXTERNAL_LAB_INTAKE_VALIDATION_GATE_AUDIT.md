# V172-Q240R3 — OCR Benchmark External Lab Intake / Validation Gate Audit

Q240R3 adds a validation gate for future external OCR benchmark reports. It is still evidence plumbing only.

## Scope

- Adds Dart intake validator classes for external lab report shape and safety flags.
- Adds JSON evidence templates for accepted/blocked intake expectations.
- Adds Flutter test coverage for valid, unsafe, weak, and template cases.
- Adds Node verifier for static contract and red-line protection.

## Explicitly not in scope

- No PaddleOCR runtime.
- No Pix2Text runtime.
- No ONNX runtime.
- No plain text OCR dependency.
- No model binary.
- No production model URL.
- No background download worker.
- No MathLive production bridge call.
- No workspace import.
- No direct solve/evaluate/graph/history from camera.
- No benchmark winner selection.

## Safety rule

A future external lab report may only enter winner-adapter review if it has enough samples, offline proof, license proof, no unsafe action keys, directSolveAllowed=false, and mathLiveReviewRequired=true.
