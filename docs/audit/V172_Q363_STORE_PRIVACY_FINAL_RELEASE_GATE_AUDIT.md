# V172-Q363 Store / Privacy / Final Release Gate Audit

## Phase

`V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE`

## Scope

Q363 is the final simplified static release gate for the current Camera/OCR/ONNX path. It consolidates store/privacy/data-safety/release gating without claiming that the app is store-ready or release-ready.

## What Q363 Requires Before Any Future Release Claim

- Real user-side Flutter evidence: `flutter pub get`, `flutter analyze`, `flutter test`, and `flutter run`.
- Real Android evidence for ONNX Runtime dependency resolution and app launch.
- Real model-load, dummy runtime-call, image-to-LaTeX, editable MathLive review, and approved workspace import evidence.
- Accuracy, performance, latency, memory, thermal, and multi-device evidence.
- Camera permission, offline OCR, private model storage, storage cleanup, and data-safety review.

## Guarded Red Lines

- Direct OCR-to-workspace import remains blocked.
- Direct OCR-to-Solve/Graph/Solution/History remains blocked.
- Editable MathLive review remains mandatory before import.
- Explicit user approval remains mandatory before import.
- The 308 MB ONNX model is not bundled in the project ZIP.
- No store-ready, release-ready, premium-final, OCR, ONNX Runtime, model-load, or Android PASS is claimed.

## Runtime Effect

No runtime execution is added by Q363. No native bridge is added. No UI route is opened. No model is copied, loaded, or invoked.
