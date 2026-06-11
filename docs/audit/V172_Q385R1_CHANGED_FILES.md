# V172-Q385R1 Changed Files

## Modified

- `lib/features/camera/gauss_camera_ocr_deferred_model_download_q384r1.dart`
- `lib/features/camera/gauss_deferred_math_ocr_model_manager.dart`
- `test/v172_q384r1_camera_ocr_deferred_model_download_activation_test.dart`
- `test/v172_q239d_deferred_math_ocr_model_manager_test.dart`
- `test/v172_q239e_mathlive_ocr_review_surface_test.dart`
- `test/v172_q244r1_camera_regression_flutter_hygiene_test.dart`
- `tool/verify_camera_ocr_deferred_model_download_activation_v172_q384r1.mjs`
- `docs/audit/V172_Q385_CHANGED_FILES.md`
- `docs/audit/V172_Q385_PADDLE_RUNTIME_ABI_TRIM_AND_DELIVERY_GUARD.md`
- `README.md`

## Added

- `lib/features/camera/gauss_paddle_runtime_abi_trim_test_download_guard_repair_q385r1.dart`
- `test/v172_q385r1_paddle_runtime_abi_trim_test_download_guard_repair_test.dart`
- `tool/verify_paddle_runtime_abi_trim_test_download_guard_repair_v172_q385r1.mjs`
- `docs/audit/V172_Q385R1_PADDLE_RUNTIME_ABI_TRIM_TEST_AND_DOWNLOAD_GUARD_REPAIR.md`
- `docs/audit/V172_Q385R1_CHANGED_FILES.md`

## Clarifications

- INTERNET permission was introduced by Q384R1 for the real deferred model download.
- Q385 did not add a new permission beyond Q384R1.
- armeabi-v7a source fallback remains present but is not packaged by Q385 release abiFilters.

## Not modified intentionally

- Keyboard layout/order/labels
- KeyConfig inventory
- MORE/template tray inventory/order
- Long-press inventory/order
- MathLive editor/caret authority
- Q382 ordering pipeline
- Graph
- History
- Solution/Solver semantics
- OCR inference/runtime execution
- ONNX Runtime dependency
- Bundled model files
- Splash/icon/startup flow

No OCR inference, ONNX Runtime, bundled model file, keyboard/Q382, MORE, Graph, History, Solution, or Solver behavior was changed.
