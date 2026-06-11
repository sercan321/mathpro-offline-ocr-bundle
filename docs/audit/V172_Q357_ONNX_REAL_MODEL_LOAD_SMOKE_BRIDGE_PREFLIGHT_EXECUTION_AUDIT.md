# V172-Q357 ONNX Real Model-Load Smoke Bridge Preflight / Execution Audit

Phase: `V172-Q357-ONNX-REAL-MODEL-LOAD-SMOKE-BRIDGE-PREFLIGHT-EXECUTION`

## Scope

Q357 adds a default-off `mathpro/ocr_runtime_bridge` method named `onnxRealModelLoadSmoke`. The bridge contains guarded ONNX Runtime model-load smoke logic but does not auto-run. It is isolated to `MainActivity.kt` and metadata/test/verifier guard files.

## Explicit non-goals

- No 308 MB ONNX model is bundled.
- No model is copied to app-private storage by this package.
- No model-load is attempted automatically.
- No runtime startup, dummy call, image-to-LaTeX inference, OCR review, workspace import, Solve, Graph, Solution, or History execution is added.
- No Flutter/Android/model-load/OCR PASS is claimed.

## Protected files

`MainActivity.kt` changed intentionally for the default-off bridge only. UI, keyboard, MORE, long-press, MathLive production, workspace UI, Graph, Solution, History, splash/icon, solver/evaluator, pubspec, Gradle, and AndroidManifest remain out of scope.
