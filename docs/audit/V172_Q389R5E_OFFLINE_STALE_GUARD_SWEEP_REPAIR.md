# V172-Q389R5E — Offline stale guard sweep repair

## Scope

Q389R5E repairs the remaining user-side Flutter test failure pattern after Q389R5D. The failing legacy tests were not detecting a real OCR runtime regression; they were still using broad string bans such as `PaddleOCR`, `PaddleLite`, and `OnnxRuntime` against `MainActivity.kt`. Later offline-only Paddle Lite phases legitimately keep class-name/status/evidence strings, while still blocking automatic startup, direct model load, direct inference, fake OCR candidates, and model bytes in the base app.

## Repairs

- Q317-Q325 MainActivity guard tests now forbid executable/runtime markers only: `PaddleOCR(`, `PaddleLite(`, `OnnxRuntime(`, `loadModel(`, `runInference(`.
- Q389R5D Q329-Q334 `MobileConfig(` successor-aware guard repair is preserved.
- Q385R2 ready copy continues to mention both primary SHA verification and sidecar presence/size checks.
- No OCR model bytes are added to the base app.
- No backend, ML Kit, text OCR fallback, server upload, fake candidate, direct OCR-to-workspace import, or Graph/Solution/History auto-execution is introduced.

## Non-claims

This phase does not claim Flutter analyze/test/run PASS, Android device PASS, model-download PASS, or real camera OCR PASS. Those require user-side Flutter logs and later real `.nb` bundle/device evidence.
