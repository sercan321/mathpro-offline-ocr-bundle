# V172-Q314 — Real OCR Implementation Readiness / Artifact Acquisition Plan

Phase: `V172-Q314-REAL-OCR-IMPLEMENTATION-READINESS-ARTIFACT-ACQUISITION-PLAN`

Source phase: `V172-Q313R3-FLUTTER-TEST-SUCCESSOR-AWARE-HYGIENE-REPAIR`

## Purpose

Q314 moves the Camera/OCR track from repeated guard creation toward real implementation readiness, but it intentionally remains a package-side readiness and artifact-acquisition plan. It records the exact decision boundary for obtaining the real PP-FormulaNet-S artifact, computing a real SHA256 in Q315, and deferring any dependency/runtime/native bridge mutation until evidence exists.

## What Q314 Adds

- Q314 policy envelope for real OCR implementation readiness.
- Q314 static evaluator returning a const readiness result.
- Q314 Flutter test coverage for readiness, manifest advancement, no dependency mutation, and protected-surface disclosure.
- Q314 verifier for manifest state, no fake OCR/runtime claims, no model binary bundling, no runtime dependency, no MethodChannel/JNI/native handler, and protected hash preservation.
- Q313R1/Q313R2/Q313R3 tests and relevant verifier chain entries are made Q314-successor-aware so the full test suite can advance past Q313R3 without stale active-phase failures.

## Artifact/Runtime Decision State

Selected engine remains `PP-FormulaNet-S`.

Recorded source locators:

- `hf://PaddlePaddle/PP-FormulaNet-S`
- `bos://paddle-model-ecology.bj.bcebos.com/paddlex/official_inference_model/paddle3.0.0/PP-FormulaNet-S_infer.tar`

Q314 does not download the artifact. The expected SHA256 remains `PENDING_Q315_CONTROLLED_DOWNLOAD_HASH_CAPTURE`, and the actual SHA256 state remains `NOT_DOWNLOADED_IN_Q314`.

## Hard Blocks Preserved

Q314 blocks:

- runtime dependency addition before Q315 real artifact/SHA/size evidence;
- MainActivity or AndroidManifest mutation before an explicit bridge phase;
- MethodChannel runtime binding before a default-off healthcheck phase;
- camera image submission before dummy-call evidence;
- workspace import before editable MathLive review and explicit user approval.

## What Q314 Does Not Do

Q314 does not add Paddle, PaddleOCR, ONNX Runtime, TFLite, JNI, native handler implementation, MethodChannel runtime binding, model binary, model download worker, private storage implementation, private artifact load, runtime startup, dummy runtime call, image-to-LaTeX inference, editable MathLive review UI launch, workspace import, auto-solve, auto-graph, or Solution/History writes.

Q314 does not mutate keyboard layout, MORE/template tray, long-press lists, MathLive production route/bridge/surface, camera shell runtime, workspace runtime, Graph, Solution, History, AppShell/main, AndroidManifest, MainActivity, splash/icon, solver/evaluator, `pubspec.yaml`, camera dependencies, or Android toolchain.

## Dürüst Sınır

Assistant-side Flutter/Dart/Android SDK execution is unavailable in this environment, so this package does not claim assistant-side `flutter analyze`, `flutter test`, `flutter run`, Android real-device, OCR, runtime, store-ready, or release PASS. Q313R3 user-side `flutter analyze` and `flutter test` were previously reported clean by the user, but Q314 must still be validated by the user on their own machine.
