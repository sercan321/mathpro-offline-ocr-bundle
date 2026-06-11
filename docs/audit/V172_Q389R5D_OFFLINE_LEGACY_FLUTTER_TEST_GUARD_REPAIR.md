# V172-Q389R5D OFFLINE LEGACY FLUTTER TEST GUARD REPAIR

Q389R5D repairs the second Flutter test regression log reported after Q389R5C.

The failing tests were not proving a real runtime/OCR failure. They were old guard tests that still treated successor evidence strings such as `MobileConfig` as forbidden, even though later offline Paddle Lite phases legitimately keep class-name evidence for `.nb` model loading without auto-starting inference.

## Repairs

- Q326 now forbids executable `PaddleOCR(` / `OnnxRuntime(` constructor or API-call markers instead of broad historical evidence strings.
- Q329, Q330, Q331, Q332, Q333, and Q334 now forbid `MobileConfig(` rather than the broad `MobileConfig` class-name evidence string.
- Q329-Q334 also forbid executable `PaddleOCR(` / `OnnxRuntime(` markers, plus direct `loadModel(` and `runInference(` calls.
- Q385R2 ready copy restores both required honesty phrases:
  - `ana model dosyası SHA256`
  - `yan dosyalar varlık ve boyut`

## Boundaries preserved

This phase does not add backend OCR, ML Kit, text OCR fallback, server image upload, bundled model bytes, fake LaTeX candidates, automatic workspace import, automatic Graph/Solution/History execution, or any Q382 keyboard ordering changes.

Q389R5D still does **not** claim OCR PASS, Android device PASS, Flutter analyze PASS, or Flutter test PASS from the package itself. Those require user-side Flutter/device logs.
