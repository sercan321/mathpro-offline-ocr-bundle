# V172-Q361 — Camera/OCR Runtime Execution Bridge Audit

Phase: `V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE`
Source: `V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT`

Q361 adds a default-off bridge contract that ties together the prior guarded OCR runtime milestones:

- Q357 ONNX model-load smoke bridge.
- Q358 dummy input runtime-call guard.
- Q359 image-to-LaTeX candidate-envelope preflight.
- Q360 editable MathLive review and approved import contract.

## Guarded behavior

- The Q361 bridge is explicit-invocation only.
- The package keeps `q361FeatureEnabled=false`.
- No startup, camera, workspace, Solve, Graph, Solution, or History path auto-runs OCR runtime execution.
- Editable MathLive review and explicit user approval remain mandatory before import.

## Deliberately not done

- No ONNX model is bundled or copied.
- No model-load, dummy call, image-to-LaTeX inference, review UI, or workspace import is executed by the package.
- No OCR, Android, model-load, dummy-call, image-to-LaTeX, review, import, or release PASS is claimed.

## Protected surface statement

Q361 intentionally changes `MainActivity.kt` only for the default-off `cameraOcrRuntimeExecutionBridge` method. It does not change Gradle, pubspec, AndroidManifest, keyboard, MORE/template tray, long-press, MathLive production, workspace UI, Graph, Solution, History, splash/icon, or solver/evaluator surfaces.
