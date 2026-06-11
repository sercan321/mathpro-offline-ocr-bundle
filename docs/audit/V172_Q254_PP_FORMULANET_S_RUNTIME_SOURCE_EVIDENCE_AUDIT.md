# V172-Q254 PP-FormulaNet-S Runtime Source Evidence Gate

Phase: `V172-Q254-PP-FORMULANET-S-RUNTIME-SOURCE-EVIDENCE-GATE`  
Source phase: `V172-Q253-ANDROID-TOOLCHAIN-MODERNIZATION`  
Source package SHA256: `329d317c4462c5d3d3e28660ab3e0d9fb19e50b8d72cc7990e59fce821f00cd7`

## Purpose

Q254 is the first post-Q253 preparation gate for real PP-FormulaNet-S runtime work. It records the official model/source evidence obligations before any runtime, downloader, or inference binding is allowed.

This phase deliberately does **not** add Paddle runtime, PaddleOCR dependency, plain text OCR dependency, ONNX runtime, model binaries, production model URL, background download worker, or image-to-LaTeX inference. It does **not** claim OCR PASS.

## Official source evidence required

This is the Q254 official source evidence gate.

The next real runtime phase must prove:

- official PaddleOCR Formula Recognition documentation for `PP-FormulaNet-S`,
- official PaddleX Formula Recognition documentation for `PP-FormulaNet-S`,
- official PaddlePaddle model repository evidence,
- Apache-2.0/license evidence suitable for distribution review,
- model storage-size evidence,
- expected SHA256 before download,
- actual SHA256 verification after download,
- private app storage plan,
- offline-after-install behavior,
- Android runtime feasibility,
- latency and memory budget,
- editable MathLive review and explicit user approval before workspace import.

## Preserved safety rules

- PP-FormulaNet-S remains the selected primary math OCR candidate.
- Text OCR fallback remains fallback only.
- Camera output cannot directly import into workspace.
- Camera output cannot directly solve, Graph, write Solution, or write History.
- OCR candidate must pass editable MathLive review first.
- User approval is mandatory before workspace import.
- Model bytes stay outside the base APK.

## Q253 Flutter test metadata hygiene

Q253 intentionally modernized AGP from `8.3.2` to `8.6.1`. Q254 also updates stale Flutter tests from Q244R8 through Q252 so they accept the Q253 successor AGP line instead of failing on an obsolete hard expectation. This is test metadata hygiene only and does not change runtime behavior.

## Dürüst sınır

Q254 is static/verifier evidence only. Flutter analyze/test/run, Android real-device build, PP-FormulaNet-S model download, and real OCR inference must be proven on a real environment.

## Marker summary

Q254 keeps no Paddle runtime, no model binary, no production inference, editable MathLive review, user approval, Q253 successor state, PP-FormulaNet-S official source, Apache-2.0, model storage, SHA256, and Android runtime feasibility gates intact.
