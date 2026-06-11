# V172-Q305 — Private Model Download Worker Real Implementation Gate Audit

## Scope

Q305 defines the default-off private model download worker gate for the future PP-FormulaNet-S runtime path.

The phase records the future worker contract only:

- app-private temporary artifact path
- verified private artifact path
- expected SHA256 requirement
- progress envelope
- checksum mismatch error boundary
- user consent and Wi-Fi / metered-network policy
- atomic move after checksum pass
- partial/corrupt download cleanup policy
- rollback boundary

## Critical Boundary

Q305 does **not** enable production download. Q302 has not produced a verified expected/actual SHA pair, so a downloader must not accept any artifact yet.

## Runtime / OCR Status

- No Paddle runtime added.
- No PaddleOCR dependency added.
- No network/background downloader dependency added.
- No `pubspec.yaml` mutation.
- No AndroidManifest mutation.
- No MainActivity mutation.
- No production download.
- No real model download.
- No SHA verification PASS.
- No private artifact load.
- No runtime startup.
- No image-to-LaTeX inference.
- No editable MathLive review launch.
- No workspace import.
- No OCR PASS.

## Protected Surface Result

Keyboard, MORE/template tray, long-press, MathLive production route/bridge/surface, Graph, Solution, History, AppShell, workspace runtime, camera shell runtime, splash/icon, AndroidManifest, MainActivity, solver/evaluator, camera dependencies, and Android toolchain are intentionally unchanged.

## Required Before Any Real Worker Enablement

- Controlled download log
- Expected SHA256 locked
- Actual SHA256 computed
- Expected/actual SHA256 match
- Official artifact source reviewed
- License reviewed
- Model size budget reviewed
- Private app storage path reviewed
- User consent copy reviewed
- Wi-Fi/metered network policy reviewed
- Atomic move after checksum policy reviewed
- Partial/corrupt download cleanup policy reviewed
- Rollback plan
- Default-off feature flag

## Honest Evidence Limit

This package is static/verifier/fresh-extract evidence only. Flutter analyze/test/run and real Android/device behavior must be proven by user-side logs.
