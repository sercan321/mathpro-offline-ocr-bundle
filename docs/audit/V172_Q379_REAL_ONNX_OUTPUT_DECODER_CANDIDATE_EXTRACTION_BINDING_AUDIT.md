# V172-Q379 Real ONNX Output Decoder / Candidate Extraction Binding Audit

Q379 repairs the Q378/Q375 gap where the camera flow reached OCR review but the native image-to-LaTeX evidence still returned an empty `candidateLatex` with `outputDecodingImplemented=false`.

## Scope

- Adds a generic native ONNX output decoder path for readable string output, ASCII/Unicode codepoint output, and token-id output when a private vocabulary file exists next to the private ONNX model.
- Binds Q367 inference output to `candidateLatex`, `candidateConfidence`, `candidateSource`, `candidateAlternatives`, and decoder diagnostics.
- Adds Q379 Dart policy/result/test/verifier files.
- Keeps editable MathLive review and explicit approval mandatory before workspace import.

## Safety

- Does not invent LaTeX if ONNX output is unreadable.
- Does not bundle the 308 MB ONNX model.
- Does not auto-run OCR from startup, camera open, workspace, Solve, Graph, Solution, or History.
- Does not auto-import workspace and does not trigger Solve/Graph/Solution/History.
- Does not claim OCR PASS without real device evidence.

## Intentional file changes

- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt` for explicit Q379 decoder bridge and native output extraction helpers.
- Q379 Dart policy/result, test, verifier, audit, manifest, and README metadata.

Protected UI/runtime red-line files outside this explicit decoder path remain unchanged.
