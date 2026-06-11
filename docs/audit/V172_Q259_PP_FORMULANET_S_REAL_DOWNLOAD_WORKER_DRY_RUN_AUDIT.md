# V172-Q259 PP-FormulaNet-S Real Download Worker Dry-Run Audit

## Phase

`V172-Q259-PP-FORMULANET-S-REAL-DOWNLOAD-WORKER-DRY-RUN`

## Source baseline

`V172-Q258-PP-FORMULANET-S-PRODUCTION-ARTIFACT-RESOLVER-GATE`  
Source ZIP SHA256: `80725a3ac4c9cb4f066cef94795bc1f1f6e8235b870e509591d3cb49feaf5f8b`

## Scope

Q259 is a dry-run guard only. It defines the safety contract for a future real download worker before any production model URL, real network download, model bytes, Paddle runtime, or OCR inference is enabled.

## Added

- `lib/features/camera/gauss_pp_formulanet_s_real_download_worker_dry_run_policy.dart`
- `lib/features/camera/gauss_pp_formulanet_s_real_download_worker_dry_run.dart`
- `test/v172_q259_pp_formulanet_s_real_download_worker_dry_run_test.dart`
- `tool/verify_pp_formulanet_s_real_download_worker_dry_run_v172_q259.mjs`
- `docs/audit/V172_Q259_PP_FORMULANET_S_REAL_DOWNLOAD_WORKER_DRY_RUN_AUDIT.md`
- `docs/audit/V172_Q259_CHANGED_FILES.md`

## Guarded behavior

- Private temporary app-storage only.
- Partial/corrupt dry-run cleanup required.
- Checksum mismatch must block ready state.
- Atomic move can be simulated only after checksum pass.
- Failed/retry state must remain distinct from ready.
- Offline-ready is dry-run only in Q259.
- Model unavailable blocks scan-to-OCR.
- Editable MathLive review remains mandatory.
- Explicit user approval remains mandatory before workspace import.

## Not implemented

- No production artifact URL.
- No real network downloader.
- No model binary.
- No Paddle or PaddleOCR dependency.
- No plain text OCR dependency.
- No image-to-LaTeX inference.
- No direct workspace import / solve / Graph / Solution / History from camera.

## Honest QA boundary

Fresh-extract/static verifier checks passed in the assistant environment. Flutter/Dart/Android SDK are not available here, so no Flutter analyze/test/run, Android, model download, or OCR PASS is claimed.
