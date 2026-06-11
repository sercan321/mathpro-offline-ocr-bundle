# V172-Q274 OCR Result → MathLive Real Review Binding Audit

## Scope
Q274 records the review-binding contract that future PP-FormulaNet-S image-to-LaTeX candidates must use before any workspace import. It is a static gate only.

## Guarantees
- Q273 candidate envelopes are preserved before review binding.
- The review draft must be editable in MathLive.
- Primary candidate, alternatives, confidence, warnings, engine metadata, and image/crop metadata remain available.
- Workspace import may only be prepared after explicit user approval.
- Direct workspace import, direct solve, direct Graph, direct Solution, and direct History remain blocked.

## Non-goals
- No Paddle runtime.
- No PaddleOCR dependency.
- No JNI/native bridge implementation.
- No MethodChannel runtime binding.
- No model binary.
- No production model URL.
- No real network download worker.
- No real image-to-LaTeX inference.
- No OCR PASS claim.

## Protected surfaces
Keyboard, MORE/template tray, long-press, MathLive production editor, Graph, Solution, History, AppShell, AndroidManifest, MainActivity, splash, workspace panel, pubspec, Android toolchain, camera shell, and Q260-Q273 guard files remain unchanged.

Phase marker: V172-Q274-OCR-RESULT-MATHLIVE-REAL-REVIEW-BINDING
