# V172-Q389R2_OFFLINE — Device-only Formula OCR full closure

This phase retires the mistaken Q389R2 backend branch from the active camera OCR path and restores the project contract: device-only Formula OCR, no ML Kit, no backend, no endpoint, no server image upload, no fake LaTeX, and no model binary in the base APK/ZIP.

Implemented package-side closure:

- Q378 no longer imports or calls the backend client.
- The camera flow routes only to the native Paddle Lite Formula OCR bridge.
- `Modeli indir` routes to `installDeviceOnlyFormulaOcrBundleQ389R2Offline`.
- The installer accepts only a verified offline Formula OCR runtime bundle manifest.
- The bundle must include a Paddle Lite `.nb` model plus required decoder/vocabulary/metadata sidecars with SHA256, size, source revision, and conversion provenance.
- The native bridge now allows a verified `.nb` model path without requiring the old Paddle inference directory preflight to pass.
- Decoder vocabulary discovery accepts PP-FormulaNet_plus sidecar names and JSON/array vocab formats.

No OCR PASS is claimed by this package. Real closure still requires a real produced/hosted offline bundle, followed by device log evidence that `Modeli indir` installs it, airplane-mode camera OCR runs, LaTeX reaches review, and explicit approval imports to workspace.
