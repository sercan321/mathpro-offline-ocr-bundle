# V172-Q375 Real OCR Execution / Output Decoder Closure Audit

## Scope
Q375 adds an explicit-only real OCR output decoder closure on top of Q374 readiness aggregation and the Q367 image-to-LaTeX inference bridge.

## Added
- Native bridge method `realOcrExecutionOutputDecoderClosure` on `mathpro/ocr_runtime_bridge`.
- Dart policy/result/decoder helper for safe candidate extraction.
- Manifest metadata for Q375.
- Verifier and Flutter test for Q375.

## Safety Contract
- Preserves Q363 as active product/OCR release gate.
- Does not auto-run from startup, camera, workspace, Solve, Graph, Solution, or History.
- Does not import workspace directly.
- Requires editable MathLive review before import.
- Requires explicit user approval before workspace import.
- Does not invent LaTeX if model output is not readable.
- Does not claim OCR PASS, image-to-LaTeX PASS, Android PASS, store PASS, or release PASS.

## ONNX Artifact Policy
The 308 MB ONNX model is not bundled in this package. Runtime use still depends on the externally provided and SHA-verified private-storage artifact.
