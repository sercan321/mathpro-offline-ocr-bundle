# V172-Q307 — Private Artifact Load Real Device Smoke Gate

Q307 adds a package-side/default-off gate for the future PP-FormulaNet-S verified private artifact load smoke on a real Android device.

This phase is intentionally static. It does **not** open a real model file, does **not** probe model format, does **not** start native runtime, does **not** call MethodChannel, does **not** run image-to-LaTeX inference, and does **not** claim OCR/runtime/model-load PASS.

## Required future evidence before private artifact load smoke can be accepted

- Q306 verified private artifact path recorded.
- Q306 expected/actual SHA256 match.
- Q306 atomic move succeeded.
- App-private verified artifact path.
- Artifact byte length recorded.
- Model format probe plan and result.
- Real Android device load log.
- Load timeout and memory-pressure policy.
- Rollback/cleanup plan.
- Editable MathLive review and explicit user approval remain mandatory before any future workspace import.

## Protected surfaces

Keyboard, MORE/template tray, long-press lists, MathLive production HTML/bridge/surface, Graph, Solution, History, AppShell, Workspace runtime, Camera shell runtime, AndroidManifest, MainActivity, splash/icon, solver/evaluator, pubspec, camera dependency, and Android toolchain are not changed in Q307.

## Honest boundary

Q307 is a static/verifier/fresh-extract gate only. Real `flutter analyze`, `flutter test`, `flutter run`, Android artifact-load smoke, runtime startup, and OCR behavior must be proven later on the user's machine/device.
