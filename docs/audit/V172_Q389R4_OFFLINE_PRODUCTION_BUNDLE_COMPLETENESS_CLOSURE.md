# V172-Q389R4_OFFLINE — Production Bundle Completeness Closure

This phase keeps the camera OCR project on the device-only/offline line.
It does not reintroduce backend OCR, ML Kit, text OCR fallback, endpoint image upload, ONNX Runtime, or bundled model bytes.

## Intent

Q389R3 connected the app to the offline installer/runtime path. Q389R4 tightens the production bundle contract so `Modeli indir` can only accept a complete PP-FormulaNet_plus offline formula OCR package:

- Paddle Lite `.nb` model file
- decoder/tokenizer/vocab sidecar
- preprocess/shape/metadata sidecar
- HTTPS download URLs
- exact SHA256 for every file
- exact sizeBytes for every file
- source revision
- conversion provenance

A bare `.nb` is not enough. A package without decoder/preprocess metadata is rejected before it can be marked ready.

## Protected surfaces

Unchanged:

- Q382 keyboard ordering
- keyboard layout / key order / MORE / template tray / long-press
- Graph / Solution / History / solver runtime
- MathLive caret authority
- AndroidManifest
- Gradle
- splash / icon / startup

## No PASS claim

This package does not claim real OCR PASS or Android device PASS. Real camera OCR closure still requires a real hosted PP-FormulaNet_plus `.nb` bundle and device logs showing:

1. `Modeli indir` installs the complete bundle.
2. Network is disabled after install.
3. Camera image produces a LaTeX candidate from the local device runtime.
4. Review screen receives the candidate.
5. User approval imports it into workspace.
