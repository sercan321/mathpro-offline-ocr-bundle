# V172-Q281 — Private Artifact Load Real Smoke Audit

## Scope

Q281 adds a package-side private artifact load smoke gate for the future PP-FormulaNet-S runtime path.

This is not a real OCR runtime phase. It defines the required private app storage artifact evidence, expected/actual SHA256 envelope, checksum-before-load gate, atomic-move evidence, model-format probe plan, dummy-input-only smoke boundary, timeout/cancellation budget, memory-pressure policy, and review-only/user-approval boundaries before any later Q282 runtime smoke.

## Explicit non-goals

- no Paddle runtime
- no PaddleOCR dependency
- no JNI binding
- no native Android runtime handler
- no MethodChannel runtime binding
- no PP-FormulaNet-S model binary
- no production model URL
- no production downloader
- no real private artifact file load in Q281
- no model-format probe execution in Q281
- no image-to-LaTeX inference
- no OCR PASS claim
- no Camera/OCR runtime PASS claim
- no release PASS claim

## Protected surface result

The Q281 verifier checks protected hashes for keyboard, MORE/template tray, long-press, MathLive production route, Graph, Solution, History, AppShell, workspace, splash, Android toolchain, Android manifest, MainActivity, and camera capture shell. Q281 is intended to preserve all of them unchanged.

## Safety boundary

Camera/OCR output remains review-only. Editable MathLive review and explicit user approval remain mandatory before any workspace import. Direct solve, Graph, Solution, and History writes remain blocked.
