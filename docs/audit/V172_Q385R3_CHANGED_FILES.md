# V172-Q385R3 Changed Files

## Modified

- `lib/features/camera/gauss_deferred_math_ocr_model_manager.dart`
- `lib/features/camera/gauss_camera_ocr_deferred_model_download_q384r1.dart`
- `lib/features/camera/gauss_mathlive_ocr_review_surface.dart`
- `README.md`
- `assets/mathlive/manifest.json`

## Added

- `lib/features/camera/gauss_camera_ocr_download_session_recovery_retry_ux_hardening_q385r3.dart`
- `test/v172_q385r3_camera_ocr_download_session_recovery_retry_ux_hardening_test.dart`
- `tool/verify_camera_ocr_download_session_recovery_retry_ux_hardening_v172_q385r3.mjs`
- `docs/audit/V172_Q385R3_CAMERA_OCR_DOWNLOAD_SESSION_RECOVERY_RETRY_UX_HARDENING.md`
- `docs/audit/V172_Q385R3_CHANGED_FILES.md`

## Audit hygiene note

Q385R2 verifier execution can refresh generated `tool/reports/*.json` report files. Those reports are not runtime source files and do not change application behavior. Q385R3 documents this explicitly so auditor diff reviews do not confuse generated report refreshes with runtime scope expansion.

## What this phase fixes

- process-local active install guard
- immediate retry after interrupted download/process death
- throttled active progress persistence
- awaited progress callback persistence to avoid stale async overwrites
- retry button copy (`Tekrar indir`)
- generated `tool/reports` audit hygiene documentation

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
- AndroidManifest permissions
- Gradle ABI policy
- Splash/icon/startup flow

No OCR inference, ONNX Runtime, bundled model file, keyboard/Q382, MORE, Graph, History, Solution, or Solver behavior was changed.
