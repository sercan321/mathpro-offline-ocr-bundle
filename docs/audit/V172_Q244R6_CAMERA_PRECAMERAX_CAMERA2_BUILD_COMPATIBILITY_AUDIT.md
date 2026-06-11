# V172-Q244R6 Camera Pre-CameraX Camera2 Build Compatibility Repair Audit

## Trigger

User-side `flutter run` after Q244R5 reached `flutter pub get`, `flutter analyze`, and `flutter test`, but Android build failed in `:camera_android:compileDebugJavaWithJavac` because `camera_android 0.10.8+18` still referenced the removed `PluginRegistry.Registrar` symbol on the user's Flutter toolchain.

## Surgical repair

Q244R6 changes only camera dependency compatibility metadata:

- `camera: 0.11.0` -> `camera: 0.10.6`
- `camera_android: 0.10.8+18` -> `camera_android: 0.10.9+3`

The selected direction avoids the `camera 0.11.0` CameraX transitive build path and avoids the old Camera2 plugin line that still contained Registrar compatibility code.

## Explicit non-goals

- No AGP upgrade.
- No Kotlin upgrade.
- No OCR runtime.
- No Text OCR fallback / PaddleOCR / Pix2Text / ONNX.
- No model binary, model URL, or background worker.
- No MathLive production bridge call.
- No direct solve / Graph / History / Solution from camera.
- No keyboard, MORE, long-press, Graph, Solution, History, splash, launcher icon, AppShell, MainActivity runtime mutation.

## Evidence boundary

Assistant-side environment has no Flutter/Dart, so no Flutter analyze/test/run PASS is claimed. This package requires user-side `flutter pub get`, `flutter analyze`, `flutter test`, and `flutter run` retest.
