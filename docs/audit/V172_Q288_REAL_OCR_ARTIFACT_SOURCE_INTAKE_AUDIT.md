# V172-Q288 Real OCR Artifact Source Intake Audit

## Phase

V172-Q288-REAL-OCR-ARTIFACT-SOURCE-INTAKE

## Source Phase

V172-Q287R2-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT-TEST-DOC-SECTION-REPAIR

## Purpose

Q288 records official PP-FormulaNet-S artifact source candidates before any real OCR runtime integration. It is an evidence/intake phase only: it identifies source candidates, records license and size/model-format evidence, and freezes the acceptance requirements that must be satisfied before a future runtime/dependency/download phase can treat the artifact as ready.

## Recorded Source Candidates

- Primary candidate: Hugging Face model repository `PaddlePaddle/PP-FormulaNet-S`.
- Mirror/download candidate: PaddleOCR/PaddleX BOS official inference tar path `PP-FormulaNet-S_infer.tar`.
- License evidence recorded as `apache-2.0`.
- Public source evidence reports PP-FormulaNet-S as the efficient PP-FormulaNet variant using `PP-HGNetV2-B4`.
- Public source evidence reports approximate storage/performance characteristics, but Q288 does not accept a runtime artifact until the project computes and records a real SHA256 from a downloaded artifact.

## Acceptance Requirements Before Runtime

- Download candidate artifact only in a future isolated/default-off step.
- Compute and record the real SHA256 before any ready state.
- Verify license compatibility for app distribution.
- Confirm Android runtime path and ABI support before adding dependency/runtime code.
- Confirm latency and peak-memory budget on real device.
- Keep the model out of the base APK.
- Use private app storage, checksum-before-ready, and atomic move after checksum.
- Preserve editable MathLive review and explicit user approval.
- Keep direct Solve / Graph / Solution / History blocked for camera output.

## Runtime Boundary

Q288 adds no Paddle runtime, no PaddleOCR dependency, no native handler, no MethodChannel runtime binding, no model binary, no production URL binding, no production downloader, and no image-to-LaTeX inference. It does not claim OCR PASS, Camera/OCR runtime PASS, store-ready PASS, release PASS, or Android real-device PASS.

## Protected Surface Boundary

Keyboard layout, MORE/template tray, long-press lists, MathLive production route, Graph, Solution, History, AppShell, workspace runtime, camera shell runtime, splash/icon, Android manifest/activity, camera dependencies, Android toolchain, solver, and evaluator behavior remain unchanged.
