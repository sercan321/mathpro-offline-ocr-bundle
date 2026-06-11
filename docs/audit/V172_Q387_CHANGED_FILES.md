# V172-Q387 Changed Files

## Added

- `lib/features/camera/gauss_paddle_lite_nb_model_format_decision_gate_q387.dart`
- `test/v172_q387_paddle_lite_nb_model_format_decision_gate_test.dart`
- `tool/verify_paddle_lite_nb_model_format_decision_v172_q387.mjs`
- `docs/audit/V172_Q387_PADDLE_LITE_NB_MODEL_FORMAT_DECISION_GATE.md`
- `docs/audit/V172_Q387_CHANGED_FILES.md`

## Modified

- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
  - Adds Q387 constants and native evidence fields.
  - Inventories `MobileConfig` model-loading APIs.
  - Blocks the current Paddle inference directory from blind `setModelFromFile(inference.pdiparams)` model loading.
  - Allows only a present `.nb` model file to proceed through `setModelFromFile`.
  - Adds user-facing copy for Q387 blocked reasons.
  - Recycles the resized bitmap created in Q380 tensor preprocessing.

- `assets/mathlive/manifest.json`
  - Adds `cameraOcrPaddleLiteNbModelFormatDecisionLatestPhase`.
  - Adds `v172Q387PaddleLiteNbModelFormatDecisionGate`.

- `tool/verify_camera_ocr_runtime_risk_repair_v172_q381r1.mjs`
  - Makes the legacy memory verifier successor-aware for the Q386/Q387 tensor path.
  - Accepts decoded bitmap recycle plus resized bitmap recycle instead of requiring the retired exact `decoded` local-variable snippet.

- `README.md`
  - Adds Q387 audit summary and verification command.

## Protected surfaces not changed

- Keyboard layout/order/labels
- KeyConfig inventory
- MORE/template tray inventory/order
- Long-press inventory/order
- MathLive caret authority
- Graph
- History
- Solution/Solver semantics
- Splash/icon/startup flow
- ONNX Runtime dependency
- Base APK/AAB model bundle policy
