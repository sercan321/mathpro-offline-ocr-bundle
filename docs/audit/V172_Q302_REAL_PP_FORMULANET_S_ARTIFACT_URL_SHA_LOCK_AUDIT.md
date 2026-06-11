# V172-Q302 — Real PP-FormulaNet-S Artifact URL + SHA Lock Audit

Q302 is a contract-only source/SHA evidence phase after Q301. It records the official PP-FormulaNet-S source locators while keeping SHA256 explicitly pending until a future controlled download can compute and verify the real artifact hash.

## Evidence Recorded

- Selected engine: `PP-FormulaNet-S`.
- Hugging Face repository locator: `hf://PaddlePaddle/PP-FormulaNet-S`.
- Official PaddleOCR/BOS inference artifact locator: `bos://paddle-model-ecology.bj.bcebos.com/paddlex/official_inference_model/paddle3.0.0/PP-FormulaNet-S_infer.tar`.
- Official PaddleOCR/BOS training artifact locator: `bos://paddle-model-ecology.bj.bcebos.com/paddlex/official_pretrained_model/PP-FormulaNet-S_pretrained.pdparams`.
- Recorded license: `apache-2.0`.
- Documented model storage size: `224 MB`.
- Expected SHA256: `PENDING_CONTROLLED_DOWNLOAD_HASH_VERIFICATION`.
- Actual SHA256: `NOT_DOWNLOADED_IN_Q302`.

## Honest SHA Boundary

Q302 does **not** download the model artifact, does **not** compute a SHA256, does **not** invent an expected SHA256, and does **not** accept any artifact for runtime use.

A future real-download phase must provide:

- controlled download log,
- private temporary file path,
- actual SHA256 of the downloaded artifact,
- expected/actual SHA256 match,
- artifact byte size,
- checksum-pass-before-atomic-move evidence,
- final private app-storage path,
- offline-ready evidence after verification.

## Explicitly Not Added

- No Paddle runtime.
- No PaddleOCR dependency.
- No JNI binding.
- No MethodChannel runtime binding.
- No native runtime handler implementation.
- No model binary.
- No production download worker.
- No private artifact load.
- No runtime startup.
- No image-to-LaTeX inference.
- No editable MathLive review opening.
- No workspace import.
- No automatic Solve / Graph / Solution / History.
- No OCR PASS, Camera/OCR runtime PASS, store-ready PASS, or release PASS.

## Protected Surfaces

Keyboard, MORE/template tray, long-press lists, MathLive production route and bridge, Graph, Solution, History, AppShell, workspace runtime, camera shell runtime, AndroidManifest, MainActivity, splash/icon, solver/evaluator, `pubspec.yaml`, camera dependencies, and Android toolchain remain protected and unchanged.
