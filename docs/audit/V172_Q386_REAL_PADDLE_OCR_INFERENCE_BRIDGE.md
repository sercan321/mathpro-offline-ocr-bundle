# V172-Q386 — Real Paddle OCR Inference Bridge

## Scope

Q386 is the first native bridge phase that attempts the real Paddle Lite path after the Q384/Q385 download-only model and runtime delivery chain:

- use the Q384R1/Q385R4 private-storage model path,
- keep Q384R2 Paddle inference directory preflight,
- load the base `libpaddle_lite_jni.so` runtime only when OCR is explicitly invoked,
- instantiate `PaddlePredictor` through the bundled `PaddlePredictor.jar`,
- decode the captured/cropped image,
- build the adaptive tensor using the existing Q380 tensor pipeline,
- run the predictor if model load succeeds,
- reuse the Q380 output decoder,
- open only the editable review flow when a real candidate is decoded.

## Safety limits

Q386 does **not** claim OCR PASS, Android real-device PASS, release build PASS, or APK/AAB size PASS. It does not invent a LaTeX candidate. If Paddle Lite cannot load the currently downloaded PP-FormulaNet-S artifact, Q386 returns a blocked evidence payload instead of a fake result.

The current downloaded artifact format is still `paddle-inference-directory` (`config.json`, `inference.json`, `inference.yml`, `inference.pdiparams`). Paddle Lite `MobileConfig.setModelFromFile(...)` may require an optimized `.nb` / compatible model file. Therefore Q386 records `q386-paddle-lite-model-load-failed-or-artifact-format-incompatible` when the runtime rejects the artifact.

## Protected surfaces

Q386 does not touch keyboard/Q382 ordering, keyboard layout/order/labels, MORE/template tray, long-press inventory, MathLive editor/caret authority, Graph, History, Solution/Solver semantics, Gradle/ABI policy, AndroidManifest permissions, splash/icon, or app startup.

## Evidence added

- Dart policy: `lib/features/camera/gauss_camera_ocr_real_paddle_inference_bridge_q386.dart`
- Flutter test: `test/v172_q386_camera_ocr_real_paddle_inference_bridge_test.dart`
- Native bridge: `realPaddleOcrInferenceBridgeQ386`
- Q380 integration marker: `q380-q386-real-paddle-inference-bridge`
- Verifier: `tool/verify_camera_ocr_real_paddle_inference_bridge_v172_q386.mjs`

## Required user-side validation

No OCR/image-to-LaTeX/Android real-device PASS is claimed by this package. Q386 still requires user-side logs before any success claim:

```powershell
flutter analyze
flutter test
flutter run -d 23106RN0DA
flutter build apk --release --target-platform android-arm64 --analyze-size
flutter build appbundle --release --target-platform android-arm64 --analyze-size
```

Real device validation must check model download, OCR bridge evidence, blocked reason if model format is incompatible, and Q382 ordering (`C → 88888 → 7777 = 888887777`).
