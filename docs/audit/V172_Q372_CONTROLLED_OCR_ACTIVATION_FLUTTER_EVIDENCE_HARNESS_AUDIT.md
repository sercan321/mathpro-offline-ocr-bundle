# V172-Q372 Controlled OCR Activation Flutter Evidence Harness Audit

## Phase

`V172-Q372-CONTROLLED-OCR-ACTIVATION-FLUTTER-EVIDENCE-HARNESS`

## Scope

Q372 adds a Flutter-side explicit evidence harness for the Q371 native bridge:

- Channel: `mathpro/ocr_runtime_bridge`
- Native method: `controlledOcrActivationRuntimeEvidenceCapture`
- Harness version: `q372-controlled-ocr-activation-flutter-evidence-harness-v1`

The harness prepares arguments for Q364 private-storage activation, Q365 model-load smoke, Q366 dummy runtime call, Q367 image-to-LaTeX inference, Q368 editable MathLive review handoff, and Q369 approved workspace import envelope.

## Safety

Q372 does not auto-run OCR from startup, camera, workspace, Solve, Graph, Solution, or History.

Q372 does not directly import OCR into workspace and does not trigger Solve/Graph/Solution/History.

Editable MathLive review and explicit user approval remain required before any workspace import.

## Protected surfaces

Q372 intentionally does not modify:

- `MainActivity.kt`
- `android/app/build.gradle`
- `pubspec.yaml`
- `android/app/src/main/AndroidManifest.xml`
- keyboard/MORE/long-press files
- MathLive production files
- workspace UI
- Graph/Solution/History
- splash/icon
- solver/evaluator surfaces

## Runtime claims

Q372 does not claim Flutter, Android, model-load, dummy-call, image-to-LaTeX, OCR, store, or release PASS.
