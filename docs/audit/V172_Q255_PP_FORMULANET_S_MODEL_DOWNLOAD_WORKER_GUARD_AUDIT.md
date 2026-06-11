# V172-Q255 PP-FormulaNet-S Model Download Worker Guard Audit

## Phase

V172-Q255-PP-FORMULANET-S-MODEL-DOWNLOAD-WORKER-GUARD

## Source phase

V172-Q254-PP-FORMULANET-S-RUNTIME-SOURCE-EVIDENCE-GATE

## Scope

Q255 is a guard-only model download worker contract for the user-selected PP-FormulaNet-S OCR path. It prepares safety gates for a later real downloader without binding a production URL, without implementing network transfer, without bundling model binaries, without adding Paddle/PaddleOCR runtime dependencies, and without running image-to-LaTeX inference.

## Required future worker gates

- official PP-FormulaNet-S source evidence remains verified
- expected SHA256 recorded before any download
- actual SHA256 verified after download
- download goes into a private temporary app file
- model artifact is atomically promoted only after checksum pass
- partial downloads are deleted on failure
- corrupt artifacts are deleted on checksum mismatch
- unverified models never enter ready state
- offline-after-install ready state is explicit
- network policy requires user consent or Wi-Fi guard
- base APK remains free of PP-FormulaNet-S model binaries
- production model URL cannot be bound without checksum evidence
- editable MathLive review remains mandatory
- explicit user approval is required before workspace import

## Explicit non-goals

- no Paddle runtime
- no PaddleOCR dependency
- no model binary
- no production model URL
- no real network download worker
- no image-to-LaTeX inference
- no direct workspace import
- no direct solve
- no direct Graph
- no direct Solution
- no direct History
- no OCR PASS claim
- no Flutter/Android PASS claim

## Protected behavior

Keyboard, MORE, long-press, MathLive production editor, workspace runtime, camera shell runtime, Graph, Solution, History, AppShell, Android Manifest, MainActivity, splash, launcher icon, camera dependency, AGP/Kotlin/Gradle versions are not changed by Q255.

## Honest status

Static/verifier/fresh-extract ready only. Real Flutter analyze/test/run, Android device behavior, real model download, real SHA verification, real PP-FormulaNet-S inference, and real OCR quality remain future evidence.

Audit marker: download worker guard, expected SHA256, actual SHA256, private temporary, atomic move, partial, corrupt, offline-after-install, no production model URL, no model binary, no Paddle runtime, editable MathLive review, user approval, Q254.
