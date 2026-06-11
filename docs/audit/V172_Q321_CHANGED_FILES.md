# V172-Q321 Changed Files

## Added Files

- `lib/features/camera/gauss_dummy_input_runtime_call_q321_policy.dart`
- `lib/features/camera/gauss_dummy_input_runtime_call_q321.dart`
- `test/v172_q321_dummy_input_runtime_call_test.dart`
- `tool/verify_dummy_input_runtime_call_v172_q321.mjs`
- `docs/audit/V172_Q321_DUMMY_INPUT_RUNTIME_CALL_AUDIT.md`
- `docs/audit/V172_Q321_CHANGED_FILES.md`

## Modified Files

- `assets/mathlive/manifest.json`
- `README.md`
- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
- successor-aware tests/verifiers for Q320 and selected Q319/Q318 lineage checks

## Protected Runtime File Intentionally Modified

- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`

Reason: add default-off dummy runtime call envelope method only; no runtime dependency, model loader, or inference.

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
- actual dummy runtime execution
- image-to-LaTeX inference
- editable MathLive review
- workspace import
- OCR/Android/store/release PASS claim
