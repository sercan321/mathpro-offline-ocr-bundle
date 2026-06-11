# V172-Q256 PP-FormulaNet-S Artifact Manifest and SHA Lock Audit

Phase: `V172-Q256-PP-FORMULANET-S-ARTIFACT-MANIFEST-AND-SHA-LOCK`
Source phase: `V172-Q255-PP-FORMULANET-S-MODEL-DOWNLOAD-WORKER-GUARD`
Source package SHA256: `4fa66118e537afdc2b962b148a60c7a22c58752562eb10cbe110dcbdbff51343`

## Scope

Q256 is a static artifact-manifest and SHA-lock gate for the user-selected `PP-FormulaNet-S` engine. It prepares the fields and verifier gates required before a later real downloader can be enabled.

## What Q256 intentionally does not do

- no production model URL is bound
- no real network download worker is implemented
- no model binary is bundled in the base APK
- no Paddle or PaddleOCR dependency is added
- no image-to-LaTeX inference is run
- no camera result is sent directly to workspace, solve, Graph, Solution, or History
- no OCR, model download, Flutter, Android, premium-final, or release PASS is claimed

## Required future evidence

- official artifact manifest
- artifact source label
- artifact version label
- license label
- model storage-size budget
- expected SHA256 locked from the official artifact
- SHA256 must be exactly 64 hexadecimal characters
- checksum mismatch blocks ready state
- Android runtime feasibility budget
- latency and memory budget
- editable MathLive review
- explicit user approval before workspace import

## Protected surfaces

Keyboard layout, MORE, long-press, MathLive production route, Workspace runtime, camera shell runtime, Graph, Solution, History, AndroidManifest, MainActivity, AGP/Kotlin/Gradle/camera dependencies, Q248/Q249/Q250/Q251/Q252/Q254/Q255 runtime files were not modified.

## Honest boundary

This phase is static/verifier/fresh-extract ready only. Real Flutter analyze/test/run, Android device behavior, PP-FormulaNet-S model download, and PP-FormulaNet-S inference must be proven externally.

Q256 marker hygiene: SHA lock, productionDownloadEnabled: false, no production model URL, no model binary, no Paddle runtime, editable MathLive review, user approval.

Q256 exact verifier markers: artifact manifest, SHA lock, 64 hexadecimal, checksum mismatch, productionDownloadEnabled: false, no production model URL, no model binary, no Paddle runtime, editable MathLive review, user approval.
