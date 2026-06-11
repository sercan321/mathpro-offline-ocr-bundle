# V172-Q384R1 — Camera OCR Deferred Model Download Activation

## Scope

This phase activates the real user-initiated PP-FormulaNet-S model download path for the camera OCR screen while preserving the Q384 base APK slimming contract.

## What changed

- The camera review sheet `Modeli indir` action no longer stops at a SharedPreferences-only queued state.
- A Q384R1 download worker was added for real streamed HTTP download into app-private storage.
- The worker downloads the pinned PP-FormulaNet-S Paddle inference artifacts from a pinned Hugging Face revision:
  - `config.json`
  - `inference.json`
  - `inference.yml`
  - `inference.pdiparams`
- The primary model artifact `inference.pdiparams` is SHA256-locked to:
  - `b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489`
- Files are downloaded to `.part` temp paths, verified, and atomically moved into app-private storage.
- The persisted model snapshot can transition through queued/downloading/verifying/ready/failed states.
- The review UI shows a progress bar and user-facing failure messages.
- `INTERNET`, `http`, `crypto`, and `path_provider` were added only for the deferred download path.

## What did not change

- No model binary is bundled into the base ZIP/APK/AAB.
- ONNX Runtime is not re-added to the base Android build.
- Q384's download-only OCR runtime contract remains active.
- Q384R1 does not claim real OCR inference PASS.
- Q384R1 does not implement Paddle/ONNX runtime execution.
- Workspace import still requires editable review and explicit user approval.
- Solver, Graph, Solution, History, keyboard, MORE, long-press, splash, launcher icon, and Q382 ordering are untouched.

## Runtime limitation

Q384R1 verifies and installs the model artifact. Real image-to-LaTeX execution is still blocked by the existing Q384 runtime-pack contract until a later runtime binding/dynamic-pack phase.
