# V172-Q239C Formula Crop / Scan Frame Shell Audit

## Scope

Q239C is a camera-shell continuation phase. It adds a premium captured-photo review surface with a bounded formula scan/crop frame, retake, rotate, and use-frame controls.

## Implemented

- Captured photo now transitions into `mathpro-formula-crop-review-card`.
- Captured image path is previewed with `Image.file(File(capturePath))`.
- A bounded formula frame uses `GaussFormulaCropScanFramePolicy.normalizedFrameWidth` and `normalizedFrameHeight`.
- Retake, rotate, and use-frame controls are present.
- Use-frame action confirms future preprocess metadata only.

## Explicit non-goals

- No OCR engine.
- No Text OCR fallback.
- No PaddleOCR.
- No Pix2Text.
- No ONNX runtime.
- No deferred model download.
- No MathLive import.
- No direct solve from camera.
- No actual cropped file is written in this phase.

## Red-line preservation

Keyboard, long-press, MORE/template tray, MathLive production HTML/bridge/surface, Graph, Result, Solution, History, solver/evaluator, splash/startup, launcher icon, AppShell, main, and Android startup behavior remain outside this phase.

## Evidence boundary

Static/verifier/fresh-extract readiness is not Flutter analyze/test/run PASS and is not Android real-device crop PASS.
