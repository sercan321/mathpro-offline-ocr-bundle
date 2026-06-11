# V172-Q387R4 — Paddle Lite .nb Production Source Binding Gate

Q387R4 is the source-binding gate between Q387R3 acquisition/conversion evidence and the Q387R2 download/install worker. It does not bind a fake URL, does not invent SHA256, does not claim OCR inference, and does not package a model binary.

## What changed

- Added `GaussPaddleLiteNbProductionSourceBindingQ387R4Gate.evaluate`.
- Converts accepted Q387R3 acquisition evidence into `GaussQ387R2PaddleLiteNbSource` only when all production-source conditions pass.
- Requires explicit reviewer approval and production hosting.
- Rejects placeholder/local/test hosts, including `example.com`, `localhost`, `.invalid`, `.test`, and `.local`.
- Rejects non-HTTPS URLs and URLs that do not end in `.nb`.
- Keeps Q388 real inference blocked until a real bound source exists.

## Honest status

No official pre-optimized PP-FormulaNet-S `.nb` artifact was bound in Q387R4. Public sources identify PP-FormulaNet-S and Paddle Lite conversion/deployment flows, but this package still has no verified production `.nb` URL, SHA256, size, and conversion provenance. Therefore the correct runtime state remains blocked, not fake-success.

Expected blocked reasons include:

- `q387r4-acquisition-evidence-required`
- `q387r4-explicit-reviewer-approval-required`
- `q387r4-production-hosting-required`
- `q387r4-placeholder-domain-rejected`
- `q387r4-non-https-production-url-rejected`
- `q387r4-download-url-must-end-with-nb`

## Scope protection

No keyboard layout/order/labels, MORE/template tray, long-press inventory, MathLive caret authority, Graph, History, Solution/Solver, splash/startup, AndroidManifest, Gradle ABI policy, ONNX Runtime, or base APK/AAB model-bundling contract is changed.
