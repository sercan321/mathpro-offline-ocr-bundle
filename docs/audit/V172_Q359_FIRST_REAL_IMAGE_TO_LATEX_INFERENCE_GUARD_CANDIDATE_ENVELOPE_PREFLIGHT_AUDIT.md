# V172-Q359 — First Real Image-to-LaTeX Inference Guard / Candidate Envelope Preflight Audit

Q359 advances the ONNX OCR/runtime track from Q358 dummy-input runtime-call guard to a default-off first real image-to-LaTeX inference guard and candidate-envelope preflight.

This phase does **not** execute image-to-LaTeX inference. It only installs a guarded MethodChannel contract that can report the candidate-envelope schema and prerequisite status. The bridge is not invoked by startup, camera, workspace, Solve, Graph, Solution, or History flows.

## Preserved sources

- Q354 dependency: `com.microsoft.onnxruntime:onnxruntime-android:1.26.0`
- Q355 expected ONNX artifact: `pp_formulanet_s.onnx`
- Expected size: `308743097` bytes
- Expected SHA256: `6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a`
- Q357 model-load bridge: preserved
- Q358 dummy runtime-call guard: preserved

## Explicit non-claims

- No Flutter/Dart/Android SDK run in assistant environment.
- No Android real-device PASS.
- No ONNX Runtime PASS.
- No model-load PASS.
- No dummy runtime-call PASS.
- No image-to-LaTeX PASS.
- No OCR PASS.
- No editable MathLive review runtime PASS.
- No workspace import PASS.

## Red-line statement

Q359 intentionally changes `MainActivity.kt` only for the default-off `onnxFirstImageToLatexInferenceGuard` bridge. Keyboard, MORE/template tray, long-press, MathLive production, workspace UI, Graph, Solution, History, splash/icon, solver/evaluator, pubspec, AndroidManifest, and Gradle are not changed in this phase.
