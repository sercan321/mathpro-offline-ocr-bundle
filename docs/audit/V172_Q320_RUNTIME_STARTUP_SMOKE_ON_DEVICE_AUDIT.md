# V172-Q320 — Runtime Startup Smoke On Device Audit

## Scope

Q320 adds a default-off runtime startup smoke **preflight** method to the existing Android `mathpro/ocr_runtime_bridge` channel.

## Native method

- Channel: `mathpro/ocr_runtime_bridge`
- Method: `runtimeStartupSmoke`
- Status: `RUNTIME_STARTUP_SMOKE_BLOCKED_NO_RUNTIME_DEPENDENCY_DEFAULT_OFF`

## Evidence carried forward

- Q315 model artifact SHA evidence provided by user: `true`
- Expected SHA256: `b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489`
- User-local SHA matched expected: `true`
- Size: `231675001`
- Artifact was stored outside project root: `true`
- Runtime accepted: `false`

## Intentional protected file change

`android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt` was intentionally changed only to add the `runtimeStartupSmoke` preflight response. This is not a runtime implementation.

## Hard blocks

Q320 does not add Paddle/PaddleOCR/Paddle Lite/ONNX/TFLite dependencies, JNI/native model loading, model binary bundling, runtime startup, dummy runtime call, image-to-LaTeX inference, editable MathLive review, workspace import, OCR PASS, Android real-device PASS, or release/store PASS.

## Dürüst sınır

Q320 can prove the bridge method exists and returns a safe envelope. It cannot prove actual runtime startup because no runtime dependency or model loader is bound in this package.
