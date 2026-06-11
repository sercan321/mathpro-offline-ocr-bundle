# V172-Q318 — Private Model Download / Storage Real Implementation Audit

Phase: `V172-Q318-PRIVATE-MODEL-DOWNLOAD-STORAGE-REAL-IMPLEMENTATION`

Source phase: `V172-Q317-ANDROID-NATIVE-BRIDGE-MINIMAL-HEALTHCHECK-BEHIND-FLAG`

## User-provided Q315 artifact evidence preserved

- Model: `PP-FormulaNet-S`
- Artifact: `inference.pdiparams`
- Expected SHA256: `b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489`
- Actual SHA256 provided by user: `b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489`
- SHA match: `true`
- Size: `231675001`
- User-side artifact path: `C:\Users\user\Desktop\MathProOcrArtifacts\PP-FormulaNet-S\inference.pdiparams`
- Project ZIP contains model artifact: `false`
- Runtime accepted: `false`

## Q318 implementation scope

Q318 extends the existing default-off OCR native bridge with private app-storage healthcheck methods only:

- Channel: `mathpro/ocr_runtime_bridge`
- Method: `privateStorageInfo`
- Method: `verifyPrivateStorageArtifact`
- Status: `PRIVATE_MODEL_STORAGE_HEALTHCHECK_AVAILABLE_DEFAULT_OFF`
- App-private target directory: `filesDir/ocr_models/PP-FormulaNet-S`
- Artifact file: `inference.pdiparams`

The implementation can resolve/create the app-private model directory and can compute SHA256 if the artifact exists there. It does not copy the desktop artifact into app storage, does not download a model inside the app, and does not accept the artifact for runtime use.

## Protected file modification disclosure

`android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt` is intentionally modified in Q318.

Reason: add default-off private model storage path and SHA healthcheck methods only.

Runtime effect: MethodChannel can return private storage path/hash evidence. It does not start OCR runtime, does not load a model, and does not run inference.

## Explicit non-goals

Q318 does not:

- add Paddle/PaddleOCR/Paddle Lite/ONNX/TFLite dependencies,
- change `pubspec.yaml`, Gradle, or `AndroidManifest.xml`,
- add an in-app network downloader/background worker,
- bundle model binary files in the base project ZIP,
- add JNI/native model loader implementation,
- accept the model for runtime,
- start runtime,
- perform dummy runtime calls,
- run image-to-LaTeX inference,
- open editable MathLive review,
- import to workspace,
- claim OCR PASS,
- claim Android real-device PASS.

## Required next evidence before Q319

Q319 must not claim private artifact load success unless real device evidence proves:

1. Q318 app builds and runs.
2. `privateStorageInfo` returns a private app path.
3. If an artifact is placed in that private path, `verifyPrivateStorageArtifact` returns the expected SHA256.
4. Runtime acceptance remains false until a later explicit load phase.
