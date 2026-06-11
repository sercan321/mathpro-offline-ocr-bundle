# V172-Q257 PP-FormulaNet-S Download Orchestrator UI Guard Audit

Phase: V172-Q257-PP-FORMULANET-S-DOWNLOAD-ORCHESTRATOR-UI-GUARD
Source phase: V172-Q256-PP-FORMULANET-S-ARTIFACT-MANIFEST-AND-SHA-LOCK
Source package SHA256: c243d6a54c2b0ce217a7f983a683669794b0b7eb80080a672462f6db1d328364

## Scope

Q257 is a UI guard only. It defines the premium download-orchestrator state/copy/safety contract for the selected PP-FormulaNet-S math OCR candidate after Q256 artifact-manifest/SHA-lock gating.

## What Q257 Adds

- `notInstalled`, `queued`, `downloading`, `verifying`, `ready`, `failed`, `updateAvailable`, and `disabledByUser` UI state contract.
- User consent and Wi-Fi/unmetered-network policy copy requirements.
- Downloading/progress and verifying/checksum copy requirements.
- Checksum mismatch error copy and failed/retry copy requirements.
- Ready state must say editable MathLive review is still required.
- Model unavailable state must block scan-to-OCR behavior.
- Direct workspace import, solve, Graph, Solution, and History remain blocked.

## What Q257 Does Not Add

- No production model URL.
- No real network downloader.
- No PP-FormulaNet-S model binary.
- No Paddle or PaddleOCR dependency.
- No plain text OCR dependency.
- No ONNX or Pix2Text runtime.
- No image-to-LaTeX inference.
- No direct workspace import.
- No direct solve, Graph, Solution, or History from camera.

## Required Future Evidence

A future real downloader/runtime phase still requires official artifact URL, exact expected SHA256, actual SHA256 after download, private app storage evidence, atomic promotion evidence, Android runtime feasibility, latency/memory evidence, Flutter/Android build logs, and real-device behavior proof.

## Verifier

Run:

```bash
node tool/verify_pp_formulanet_s_download_orchestrator_ui_guard_v172_q257.mjs
```

Expected result: `PP_FORMULANET_S_DOWNLOAD_ORCHESTRATOR_UI_GUARD_Q257_STATIC_READY_BUT_REAL_DOWNLOADER_RUNTIME_AND_FLUTTER_RETEST_REQUIRED`.
