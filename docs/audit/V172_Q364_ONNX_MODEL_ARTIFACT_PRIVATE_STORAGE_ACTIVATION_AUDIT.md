# V172-Q364 — ONNX Model Artifact Private Storage Activation Audit

Q364 prepares the explicit-invocation ONNX model artifact private-storage activation bridge for PP-FormulaNet-S.

## Scope

- Adds a native MethodChannel method `onnxModelArtifactPrivateStorageActivation` on `mathpro/ocr_runtime_bridge`.
- Accepts an explicit `sourcePath` argument only when the bridge is invoked.
- Verifies the source ONNX file size and SHA256 before copy.
- Copies to app-private storage through a temporary file and atomic rename policy.
- Reports private-storage readiness only after the target size and SHA256 match.

## Non-scope

- Does not bundle `pp_formulanet_s.onnx` into the project ZIP.
- Does not auto-copy at startup/camera/workspace.
- Does not execute model-load, dummy call, image-to-LaTeX, OCR review, workspace import, Solve, Graph, Solution, or History.
- Does not claim Flutter, Android, ONNX Runtime, model-load, image-to-LaTeX, OCR, store, or release PASS.

## Red lines

Only `MainActivity.kt` changes intentionally for the explicit private-storage activation bridge. UI, keyboard, MORE/template tray, long-press, MathLive production, workspace UI, Graph, Solution, History, splash/icon, solver/evaluator, Gradle, pubspec, and AndroidManifest remain protected.
