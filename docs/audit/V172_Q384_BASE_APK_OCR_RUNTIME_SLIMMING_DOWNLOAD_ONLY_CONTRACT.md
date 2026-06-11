# V172-Q384 — Base APK OCR Runtime Slimming / Download-Only Contract

## Purpose

Q384 removes the ONNX Runtime Android trial dependency from the base Android package. The camera and model-download UI remain available, but the base APK/AAB must not bundle ONNX Runtime or OCR model artifacts.

## Contract

- Base app keeps calculator, camera entry, model-download/review flow, and private-storage checks.
- Base app does not bundle `.onnx`, `.nb`, `.pdmodel`, `.pdiparams`, `.tflite`, or model weight artifacts.
- ONNX Runtime Android AAR is removed from `android/app/build.gradle`.
- MainActivity no longer compile-links `ai.onnxruntime` classes.
- ONNX-based execution bridge methods remain safe and return blocked/download-only evidence instead of attempting real runtime execution.
- PaddlePredictor.jar and existing Paddle Lite JNI files are preserved in this phase; moving Paddle runtime out of the base APK is a later explicit decision, not part of Q384.

## Protected Areas

No keyboard, MathLive editor behavior, MORE tray inventory, long-press list, Graph, History, Solution, AndroidManifest, Gradle plugin, splash, icon, or startup behavior is intentionally changed.

## Verification

Run:

```powershell
node tool/verify_base_apk_ocr_runtime_slimming_download_only_contract_v172_q384.mjs
```

Then build release APK/AAB and compare size:

```powershell
flutter clean
flutter pub get
flutter build apk --release --target-platform android-arm64 --analyze-size
flutter build appbundle --release --target-platform android-arm64 --analyze-size
```
