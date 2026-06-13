# Q389R6W R2 — Remaining Legacy Test Successor Repair

This package only repairs the two remaining successor-awareness test expectations reported after Q389R6W-R1.

## What changed

- `test/v172_q357_onnx_real_model_load_smoke_bridge_preflight_execution_test.dart`
  - Accepts both the legacy Q357 ONNX smoke model size and the Q389R6B PP-FormulaNet_plus-S ONNX successor model size.
  - Keeps the no-model-bundling guard intact.

- `test/v172_q384r1_camera_ocr_deferred_model_download_activation_test.dart`
  - Accepts both the legacy PP-FormulaNet-S primary SHA and the Q389R6B PP-FormulaNet_plus-S ONNX manifest SHA.
  - Keeps download-only, no direct-solve, no model-bundling checks intact.

- `tool/verify_q389r6w_r2_remaining_legacy_test_successor_repair.mjs`
  - Static verifier for the above repair.

## What did not change

- No model bytes were bundled.
- No fake OCR pass is claimed.
- No phone/device pass is claimed.
- No Flutter analyze/test pass is claimed by this package.
- Keyboard, MathLive, Graph, Solution, History, and UI layout are untouched by this repair.
