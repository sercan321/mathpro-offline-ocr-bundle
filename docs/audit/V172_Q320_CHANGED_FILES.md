# V172-Q320 Changed Files

## Added Files

- `lib/features/camera/gauss_runtime_startup_smoke_on_device_q320_policy.dart`
- `lib/features/camera/gauss_runtime_startup_smoke_on_device_q320.dart`
- `test/v172_q320_runtime_startup_smoke_on_device_test.dart`
- `tool/verify_runtime_startup_smoke_on_device_v172_q320.mjs`
- `docs/audit/V172_Q320_RUNTIME_STARTUP_SMOKE_ON_DEVICE_AUDIT.md`
- `docs/audit/V172_Q320_CHANGED_FILES.md`

## Modified Files

- `assets/mathlive/manifest.json`
- `README.md`
- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
- successor-aware tests/verifiers for Q313R1 through Q319

## Protected Runtime File Intentionally Modified

- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`

Reason: add default-off runtime startup smoke preflight method only; no runtime dependency or model loader.

## Protected Runtime Files Not Modified

- `pubspec.yaml`
- `android/app/src/main/AndroidManifest.xml`
- Gradle files
- keyboard layout/source files
- MORE/template tray
- long-press popup/list behavior
- MathLive production route and bridge
- workspace panel
- camera capture shell runtime
- Graph
- Solution
- History
- AppShell
- `lib/main.dart`
- splash/icon assets
- solver/evaluator

## Explicitly Not Added

- Paddle/PaddleOCR dependency
- Paddle Lite dependency
- ONNX Runtime dependency
- TFLite dependency
- JNI/native model loader
- model binary or model archive
- runtime startup execution
- dummy runtime call
- image-to-LaTeX inference
- editable MathLive review
- workspace import
- OCR/Android/store/release PASS claim
