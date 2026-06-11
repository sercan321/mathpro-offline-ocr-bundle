# V172-Q321 Dummy Input Runtime Call Audit

## Phase

`V172-Q321-DUMMY-INPUT-RUNTIME-CALL`

## Source Phase

`V172-Q320-RUNTIME-STARTUP-SMOKE-ON-DEVICE`

## Scope

Q321 adds a default-off `dummyRuntimeCall` envelope to the existing Android `mathpro/ocr_runtime_bridge` channel.

The method is intentionally blocked because no runtime dependency or native model loader is bound yet.

## Native Bridge Method

- Channel: `mathpro/ocr_runtime_bridge`
- Method: `dummyRuntimeCall`
- Status: `DUMMY_RUNTIME_CALL_BLOCKED_NO_RUNTIME_DEPENDENCY_DEFAULT_OFF`

## Real Q315 Artifact Evidence

- Model: `PP-FormulaNet-S`
- Artifact: `inference.pdiparams`
- Expected SHA256: `b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489`
- User-side actual SHA256: `b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489`
- Size: `231675001`
- Stored outside project root: `true`
- Runtime accepted: `false`

## MainActivity Change

`android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt` was intentionally modified to add only the default-off dummy runtime call envelope.

## Explicit Non-Claims

- Runtime dependency added: `false`
- Runtime startup executed: `false`
- Dummy runtime call attempted: `false`
- Dummy runtime call executed: `false`
- Dummy runtime call passed: `false`
- Model loaded: `false`
- Image-to-LaTeX inference executed: `false`
- Editable MathLive review opened: `false`
- Workspace import executed: `false`
- OCR PASS claimed: `false`
- Android real-device PASS claimed by assistant: `false`

## Hard Blocks

- No Paddle/PaddleOCR dependency in Q321.
- No ONNX/TFLite dependency in Q321.
- No JNI/native model loader in Q321.
- No actual dummy runtime execution without selected runtime dependency.
- No image-to-LaTeX inference.
- No editable MathLive review.
- No workspace import.
- No OCR or real-device PASS claim without actual user log/video.
