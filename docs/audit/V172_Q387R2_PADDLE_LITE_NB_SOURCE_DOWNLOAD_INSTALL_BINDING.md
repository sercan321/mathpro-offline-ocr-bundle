# V172-Q387R2 — Paddle Lite `.nb` Source / Download Install Binding

## Purpose

Q387 proved that the Android Paddle Lite line must not load the old Paddle inference-directory artifact as if it were a mobile optimized model. Q387R1 defined the mandatory evidence contract for a real `.nb` artifact. Q387R2 adds the actual download/install worker for that future verified `.nb` artifact, while still refusing to invent a production URL/SHA/size.

## What changed

- Added `GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy`.
- Added `GaussQ387R2PaddleLiteNbSource` intake model.
- Added `GaussQ387R2PaddleLiteNbDownloadInstallWorker.installFromVerifiedSource(...)`.
- The worker first runs the Q387R1 evidence gate.
- It downloads only HTTPS `.nb` candidates with SHA256, expected size, and conversion provenance.
- It writes the native manifest expected by Q387R1: `q387r1_paddle_lite_nb_manifest.json`.
- It writes the install audit manifest: `q387r2_paddle_lite_nb_install_manifest.json`.
- It keeps `productionNbDownloadUrlBound = false` because no verified PP-FormulaNet-S `.nb` artifact is present in this package.

## Explicit non-claims

- No production `.nb` URL is claimed.
- No production `.nb` SHA256 is claimed.
- No OCR inference PASS is claimed.
- No Android device PASS is claimed.
- No APK/AAB size PASS is claimed.
- No model binary is bundled in the base app.
- ONNX Runtime is not reintroduced.
- Keyboard/Q382, MORE, Graph, History, and Solution/Solver are not touched.

## Why this matters

PaddleOCR’s mobile deployment documentation describes Paddle-Lite model optimization and notes that if a `.nb` model is already prepared, the optimization step can be skipped. Q387R2 prepares MathPro/Gauss to accept that verified `.nb` artifact without ever shipping it inside the base APK/AAB.

## Next phase

Q387R3 or Q388 should only proceed after a real `.nb` artifact is produced or found with:

- HTTPS URL
- 64-character SHA256
- expected byte size
- conversion/source provenance
- device-side install evidence
