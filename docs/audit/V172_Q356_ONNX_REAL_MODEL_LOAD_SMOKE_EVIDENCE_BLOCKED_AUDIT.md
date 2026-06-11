# V172-Q356 — ONNX Real Model Load Smoke Evidence Blocked Audit

## Scope

Q356 records that ONNX real model-load smoke is the next runtime milestone, but keeps it blocked because the user has not yet provided Q354/Q355 `flutter pub get`, `flutter analyze`, `flutter test`, and Android run logs after the ONNX Runtime Android dependency was introduced.

## What changed

- Added Q356 policy/result Dart guard files.
- Added Q356 Flutter test metadata guard.
- Added Q356 Node verifier.
- Advanced `cameraOcrLatestPhase` and `activeProductDevelopmentLatestPhase` to `V172-Q356-ONNX-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED`.
- Added manifest envelope `v172Q356OnnxRealModelLoadSmokeEvidenceBlocked`.
- Updated successor-aware legacy verifier/test chain to accept Q356 as an active successor phase.

## What did not change

- No ONNX Runtime Java/Kotlin model-load call.
- No `MainActivity.kt` mutation.
- No Gradle/pubspec/AndroidManifest mutation beyond preserving Q354 Gradle dependency state.
- No ONNX model bundled into the project ZIP.
- No app-private model copy.
- No on-device SHA verification.
- No model load.
- No dummy input runtime call.
- No image-to-LaTeX inference.
- No OCR review UI.
- No workspace import.
- No Solve/Graph/Solution/History mutation.
- No OCR PASS, model-load PASS, ONNX Runtime Android PASS, or Android PASS claim.

## Red-line verification intent

Q356 must preserve UI and production-editor red lines: keyboard, MORE/template tray, long-press, MathLive production route, workspace, Graph, Solution, History, splash/icon, solver/evaluator, pubspec, AndroidManifest, Gradle, and MainActivity. Q354's ONNX Runtime Gradle dependency remains carried forward unchanged.

## Next gate

If user-side dependency build logs pass, the next phase may open a default-off model-load smoke bridge preflight. If user-side logs fail, the next phase must be a surgical dependency/build repair instead of OCR.
