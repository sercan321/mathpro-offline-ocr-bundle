# V172-Q278 — Real Runtime Integration Evidence Lock Audit

Q278 is a gate-only evidence lock after Q277R3. It prepares the project for a possible future Q279 dependency trial by recording the evidence that must exist before any real PP-FormulaNet-S runtime integration can start.

## Scope

- Lock required evidence for official PP-FormulaNet-S model source, production artifact URL, expected SHA256, license compatibility, model size, runtime path, ABI matrix, Android toolchain compatibility, latency budget, peak-memory budget, private app-storage plan, checksum-before-ready, atomic move after checksum, offline-ready after verified private artifact, editable MathLive review, explicit user approval, and direct solve/Graph/Solution/History blocks.
- Preserve Q277R3 as the source baseline.
- Keep Q279 as a future dependency-trial-only phase.

## Explicit non-goals

- no Paddle runtime
- no PaddleOCR dependency
- no native/JNI bridge implementation
- no MethodChannel runtime binding
- no model binary
- no production model URL binding
- no production download enablement
- no real network downloader
- no image-to-LaTeX inference
- no OCR/runtime/release PASS claim

## Protected surface status

Q278 does not change keyboard layout, MORE/template tray, long-press lists, MathLive production HTML/bridge/surface, Graph, Solution, History, AppShell, workspace, camera shell runtime, splash/icon, Android manifest, MainActivity, camera dependencies, or Android toolchain.

## Runtime safety boundary

Camera output remains review-first only:

Camera -> crop/scan-frame -> OCR candidate envelope -> editable MathLive review -> explicit user approval -> workspace import prepared.

Direct camera solve, Graph, Solution, History, automatic solve, review-bypass import, fake OCR PASS, and fake runtime PASS remain blocked.
