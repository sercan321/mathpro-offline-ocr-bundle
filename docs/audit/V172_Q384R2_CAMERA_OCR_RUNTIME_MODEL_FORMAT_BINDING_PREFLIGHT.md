# V172-Q384R2 — Camera OCR Runtime / Model Format Binding Preflight

## Scope

This phase is a surgical continuation of Q384R1. It aligns the user-downloaded PP-FormulaNet-S model artifact with the native camera OCR bridge without claiming production OCR inference.

## What changed

- Added a Q384R2 Dart policy file for the runtime/model-format binding contract.
- Added a native MethodChannel preflight method: `deferredPaddleModelRuntimeBindingPreflight`.
- Added native verification for the Q384R1 installed Paddle inference directory:
  - `config.json`
  - `inference.json`
  - `inference.yml`
  - `inference.pdiparams`
- Added primary `inference.pdiparams` SHA256 verification against the Q384R1 locked hash.
- Updated the Q380/Q381 review flow so Q384R1-installed model artifacts are treated as Paddle inference directory artifacts, not missing ONNX files.
- Preserved the download-only contract: no ONNX Runtime was reintroduced and no model binary was bundled into the base project.

## What this phase does not claim

- No production OCR inference PASS.
- No Paddle predictor model-load PASS.
- No real-device PASS.
- No Workspace auto-import.
- No Solve, Graph, Solution, or History side effect.
- No keyboard/Q382 change.

## Expected user-visible behavior

If the model is not installed, the review flow still blocks safely and asks for model download.

If the Q384R1 model is installed and verified, the review flow should no longer present the core block as `private-storage-onnx-model-missing`; it should report that the model files are ready but runtime execution is still blocked until the runtime binding/execution phase is proven.

## Next phase

Q385 should decide whether Paddle Lite runtime remains bundled, is ABI-trimmed, or is moved into an on-demand runtime pack / Play Feature Delivery module. Actual inference must not be claimed until native runtime load, model load, tensor preprocessing, output decoding, and real-device evidence exist.
