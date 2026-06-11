# V172-Q389R5C OFFLINE CLOUD MODEL BUNDLE BUILDER

Purpose: remove the user's manual model/tool hunt by adding a GitHub Actions workflow that attempts to build the real Android Paddle Lite `.nb` Formula OCR bundle in CI.

Boundary:
- Backend remains forbidden.
- ML Kit and text OCR fallback remain forbidden.
- Model binaries are not bundled into the Flutter APK/ZIP.
- The workflow only produces a downloadable production bundle artifact/release for the existing `Modeli indir` installer path.
- OCR PASS is not claimed until a real phone downloads the bundle, verifies manifest SHA/size, runs offline inference, opens review, and imports to workspace after approval.

Workflow:
1. Downloads the official `PaddlePaddle/PP-FormulaNet_plus-L` snapshot by default.
2. Acquires `paddle_lite_opt` for Linux from the Paddle-Lite release assets, or uses the explicit URL input when auto-discovery fails.
3. Runs `tool/q389r5a_offline_formula_ocr_bundle_factory.mjs` to create the `.nb` model and required manifest.
4. Uploads `q389r5c-offline-formula-ocr-bundle` as a workflow artifact.
5. Optionally publishes all generated files to a GitHub Release so the manifest file has stable HTTPS download URLs.

Why this phase exists: Q389R5B could help acquire prerequisites, but still asked the user to understand model paths and tool locations. Q389R5C shifts that work into CI while keeping the device-only offline Formula OCR contract intact.
