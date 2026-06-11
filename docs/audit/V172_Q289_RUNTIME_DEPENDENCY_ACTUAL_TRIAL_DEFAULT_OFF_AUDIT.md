# V172-Q289 — Runtime Dependency Actual Trial Behind Default-Off Flag

## Scope

Q289 is a conservative dependency-trial court after Q288. Q288 recorded the official PP-FormulaNet-S source candidate, but the real artifact SHA256 is still pending. Therefore Q289 does **not** add Paddle, PaddleOCR, JNI, MethodChannel runtime binding, model binaries, production downloads, or image-to-LaTeX inference.

## Decision

The default-off runtime dependency trial contract is installed, but the actual dependency remains blocked until all of the following are real:

- real artifact source and SHA256 evidence,
- license compatibility for distribution,
- Android ABI/runtime package compatibility,
- memory and latency budget on a real device,
- rollback path,
- real-device runtime smoke evidence,
- editable MathLive review and explicit user approval,
- direct solve/Graph/Solution/History blocks.

## Runtime Boundary

- No `pubspec.yaml` OCR runtime dependency was added.
- No model binary was bundled.
- No production URL/download worker was enabled.
- No Camera/OCR runtime behavior changed.
- No OCR PASS, Camera/OCR runtime PASS, store-ready PASS, or release PASS is claimed.

## Protected Surfaces

Keyboard, MORE/template tray, long-press, MathLive production route, Graph, Solution, History, AppShell, Workspace, Camera shell, AndroidManifest, MainActivity, splash/icon, solver/evaluator are unchanged.

## User-side Retest Required

Because this repository is delivered from a non-Flutter assistant environment, the user must still run:

- `flutter clean`
- `flutter pub get`
- `flutter analyze`
- `flutter test`
- `flutter run -d 23106RN0DA`
