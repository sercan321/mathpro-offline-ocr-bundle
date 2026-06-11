# V172-Q317 Android Native Bridge Minimal Healthcheck Behind Flag Audit

## Phase

`V172-Q317-ANDROID-NATIVE-BRIDGE-MINIMAL-HEALTHCHECK-BEHIND-FLAG`

## Source phase

`V172-Q316-RUNTIME-DEPENDENCY-FEASIBILITY-TRIAL-BEHIND-DEFAULT-OFF-FLAG`

## User-side evidence accepted into this phase

The user provided Q315 controlled artifact hash evidence:

- Artifact: `inference.pdiparams`
- Artifact path: `C:\Users\user\Desktop\MathProOcrArtifacts\PP-FormulaNet-S\inference.pdiparams`
- Default storage policy: `../MathProOcrArtifacts/PP-FormulaNet-S`
- Expected SHA256: `b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489`
- Actual SHA256: `b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489`
- SHA match: `true`
- Size bytes: `231675001`
- Artifact stored outside project root: `true`
- Runtime accepted: `false`

## What Q317 changes

Q317 adds a minimal Android `MethodChannel` healthcheck in `MainActivity.kt`:

- Channel: `mathpro/ocr_runtime_bridge`
- Methods: `ping`, `healthCheck`
- Status: `NATIVE_BRIDGE_HEALTHCHECK_AVAILABLE_DEFAULT_OFF`

This is a protected runtime file change and is intentionally declared.

## What Q317 does not do

Q317 does not:

- add Paddle/PaddleOCR/Paddle Lite/ONNX/TFLite dependencies,
- change `pubspec.yaml`, Gradle files, or `AndroidManifest.xml`,
- add JNI/native model handler implementation,
- accept the model artifact for runtime use,
- load the model,
- start an OCR runtime,
- run a dummy runtime call,
- run image-to-LaTeX inference,
- open editable MathLive review,
- import OCR output into workspace,
- write Graph/Solution/History,
- claim OCR PASS,
- claim Android real-device PASS.

## Reason for protected MainActivity change

`MainActivity.kt` is intentionally modified only to expose a rollback-safe, default-off native bridge healthcheck. The channel returns a static safety envelope that explicitly reports all runtime/OCR execution flags as `false`.

## Next phase boundary

Next phase should not jump directly to OCR inference. Q318 should implement private model download/storage or artifact availability plumbing only after Q317 user-side Flutter analyze/test and, preferably, a real-device healthcheck log.
