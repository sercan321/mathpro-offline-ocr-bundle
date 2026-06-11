# V172-Q316 — Runtime Dependency Feasibility Trial Behind Default-Off Flag Audit

## Scope

Q316 is a runtime-dependency feasibility preflight for the PP-FormulaNet-S OCR path. It follows Q315R1, where the user reported clean Flutter analyzer and tests.

## Decision

`NO_RUNTIME_DEPENDENCY_ADDED_IN_Q316_STATIC_PREFLIGHT`

No dependency was added because the Q315 local artifact hash evidence was not provided to the assistant in this turn. Q316 records that a real runtime dependency trial is blocked until:

- Q315 controlled artifact download evidence exists.
- The local `inference.pdiparams` SHA256 matches the published `b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489` hash.
- The artifact remains outside the project root.
- The user explicitly approves pubspec/Gradle/runtime dependency mutation.
- The dependency remains behind a default-off feature flag.
- A rollback plan exists before Android build-system changes.

## Runtime Surfaces

Unchanged:

- `pubspec.yaml`
- Android Gradle files
- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
- `android/app/src/main/AndroidManifest.xml`
- MathLive production bridge and surface
- Workspace panel
- Camera capture shell
- Keyboard, MORE, long-press, bottom dock
- Graph, Solution, History
- AppShell and `main.dart`
- Splash and launcher icon assets

## Explicit Non-Claims

Q316 does not claim:

- Paddle/PaddleOCR dependency added
- ONNX/TFLite dependency added
- downloader dependency added
- model artifact accepted for runtime
- native runtime startup
- dummy runtime call
- real image-to-LaTeX inference
- editable MathLive review
- workspace import
- Android real-device PASS
- OCR PASS
- release/store PASS

## Next Gate

Q317 may only become a real native bridge healthcheck phase after Q315 hash evidence and explicit dependency approval are reviewed. If that evidence remains absent, the correct next step is a Q316R repair/evidence-intake phase, not blind runtime dependency mutation.
