# V172-Q356R1 — ONNX Runtime Android Build Evidence Intake / Model-Load Unlock Guard

Q356R1 follows Q356 and installs a stricter evidence-intake guard before any ONNX model-load execution code may be added.

## Why this phase exists

Q354 introduced the real Android dependency:

```gradle
implementation 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0'
```

Q356 correctly blocked model-load smoke because user-side `flutter pub get`, `flutter analyze`, `flutter test`, and `flutter run -d 23106RN0DA` logs were not available. Q356R1 keeps that block explicit and records the exact evidence that must be reviewed before a future model-load bridge can be added.

## Guard status

Status: `ONNX_RUNTIME_ANDROID_BUILD_EVIDENCE_INTAKE_INSTALLED_MODEL_LOAD_UNLOCK_REMAINS_BLOCKED_PENDING_REAL_USER_LOGS`.

Required user logs:

- `flutter pub get`
- `flutter analyze`
- `flutter test`
- `flutter run -d 23106RN0DA`

## Explicit non-goals

Q356R1 does not add ONNX Runtime Java/Kotlin calls, does not modify `MainActivity.kt`, does not modify Gradle/pubspec/AndroidManifest beyond preserving Q354 state, does not bundle/copy/load the 308 MB ONNX model, does not verify SHA on-device, does not run runtime startup/dummy calls/inference/OCR, does not open MathLive review, does not import workspace, and does not claim Flutter/Android/ONNX/model-load/OCR PASS.

## Protected red-line surfaces

Keyboard, MORE/template tray, long-press, MathLive production, workspace, Graph, Solution, History, splash/icon, solver/evaluator, `pubspec.yaml`, `AndroidManifest.xml`, Gradle, and `MainActivity.kt` remain unchanged from Q356 except metadata/test/verifier successor-awareness surfaces.
