# V172-Q358 ONNX Dummy Input Runtime Call Guard / Preflight Audit

Phase: `V172-Q358-ONNX-DUMMY-INPUT-RUNTIME-CALL-GUARD-PREFLIGHT`
Source phase: `V172-Q357-ONNX-REAL-MODEL-LOAD-SMOKE-BRIDGE-PREFLIGHT-EXECUTION`

Q358 adds a default-off guarded bridge surface for the next dummy input runtime-call milestone. It does not run dummy inference automatically and it does not perform OCR.

## Scope

- Preserve Q354 ONNX Runtime Android dependency coordinate: `com.microsoft.onnxruntime:onnxruntime-android:1.26.0`.
- Preserve Q357 model-load smoke bridge.
- Add `onnxDummyInputRuntimeCall` as a guarded/default-off method on `mathpro/ocr_runtime_bridge`.
- Keep the 308 MB ONNX model outside the project ZIP.
- Keep image-to-LaTeX, editable MathLive review, workspace import, Solve/Graph/Solution/History blocked.

## Explicit non-claims

No Flutter analyze/test/run PASS is claimed by this package. No Android real-device PASS, ONNX Runtime PASS, model-load PASS, dummy runtime-call PASS, image-to-LaTeX PASS, or OCR PASS is claimed.
