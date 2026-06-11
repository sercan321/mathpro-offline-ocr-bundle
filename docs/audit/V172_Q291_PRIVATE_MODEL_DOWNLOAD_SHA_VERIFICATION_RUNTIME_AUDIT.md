# V172-Q291 — Private Model Download & SHA Verification Runtime Audit

## Scope

Q291 installs the private model download and SHA verification runtime contract for the future PP-FormulaNet-S path. It is deliberately conservative: the official artifact URL and expected 64-hex SHA256 are still not locked, so this phase does not start a real download and does not accept any model for runtime use.

## Runtime Boundary

Q291 defines the future private-artifact lifecycle only:

1. User consent and Wi-Fi/large-download policy must be satisfied.
2. Download must target application-private temporary storage only.
3. Expected SHA256 must be known before any artifact can become ready.
4. Actual SHA256 must be computed after download.
5. Actual SHA256 must match expected SHA256.
6. Only then may an atomic move promote the artifact into the verified private path.
7. Partial/corrupt downloads must be cleaned up.
8. Offline-ready may be true only after a verified private artifact exists.
9. Runtime may never use an unverified model.

## Explicitly Not Implemented

- No real network download worker.
- No production model URL binding.
- No model binary in the base app.
- No Paddle runtime.
- No PaddleOCR dependency.
- No JNI/native runtime implementation.
- No MethodChannel runtime binding.
- No private artifact load.
- No runtime invocation.
- No image-to-LaTeX inference.
- No OCR PASS, model download PASS, SHA verification PASS, runtime PASS, store-ready PASS, or release PASS.

## Protected Surfaces

Keyboard layout, MORE/template tray, long-press lists, MathLive production route, Graph, Solution, History, AppShell, workspace runtime, camera shell runtime, AndroidManifest, MainActivity, splash/icon, solver/evaluator, camera dependencies, and Android toolchain remain unchanged.

## Camera/OCR Safety Boundary

Camera/OCR output remains review-first. Even after future model verification, OCR candidates must open editable MathLive review and require explicit user approval before any workspace import. Direct Solve, Graph, Solution, or History writes from camera output remain blocked.
