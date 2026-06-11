# V172-Q239B — Camera Permission + Capture Shell Audit

## Scope

Q239B turns the Q239A workspace camera entry into a real in-app camera capture shell. The phase is intentionally limited to camera permission, preview, and still-photo capture plumbing.

## Implemented

- `pubspec.yaml` declares the official Flutter `camera` package as `camera: ^0.11.0`.
- `android/app/src/main/AndroidManifest.xml` declares `android.permission.CAMERA`.
- Android camera hardware is marked optional through `android.hardware.camera.any` with `android:required="false"` so the calculator remains installable on devices without a camera.
- `lib/features/camera/gauss_camera_capture_shell.dart` adds `GaussCameraCaptureShell`.
- Workspace camera action now routes to `GaussCameraCaptureShell`.
- The shell includes a premium dark/teal preview frame, capture control, camera switch control, torch control, permission/error states, and a captured-photo confirmation sheet.

## Explicitly not implemented

- No OCR engine.
- No Text OCR fallback.
- No PaddleOCR.
- No Pix2Text.
- No ONNX runtime.
- No deferred model download.
- No crop/preprocess pipeline.
- No MathLive import.
- No direct solve/evaluator path from camera output.

## Protected surface statement

Keyboard, long-press, MORE/template tray, MathLive production HTML/bridge/surface, Graph, Result, Solution, History, solver/evaluator, splash resources, launcher icon resources, AppShell, main entrypoint, and MainActivity behavior remain outside this phase.

`AndroidManifest.xml` is intentionally changed only to declare camera permission/optional camera feature required by Q239B.

## Honest evidence boundary

Assistant-side Flutter/Dart/Android execution is unavailable in the packaging environment. This package does not claim `flutter analyze`, `flutter test`, `flutter run`, or Android real-device camera PASS. User-side logs and real-device camera screenshots/video remain required.
