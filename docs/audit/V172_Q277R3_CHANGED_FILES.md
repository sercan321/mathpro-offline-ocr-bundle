# V172-Q277R3 Changed Files

## Added

- `lib/features/mathlive/mathlive_production_tap_latency_cadence_policy.dart`
- `test/v172_q277r3_camera_ocr_runtime_premium_regression_tap_latency_cadence_test.dart`
- `tool/verify_camera_ocr_runtime_premium_regression_tap_latency_cadence_v172_q277r3.mjs`
- `docs/audit/V172_Q277R3_CAMERA_OCR_RUNTIME_PREMIUM_REGRESSION_TAP_LATENCY_CADENCE_AUDIT.md`
- `docs/audit/V172_Q277R3_CHANGED_FILES.md`

## Modified

- `lib/features/mathlive/mathlive_main_editor_surface.dart`
  - Imports the Q277R3 tap latency cadence policy.
- `lib/features/mathlive/mathlive_production_editor_surface.dart`
  - protected surface changed intentionally.
  - The serial production command tail no longer waits for Flutter state echo after each accepted key dispatch.
  - The redundant Dart-side post-dispatch refresh after every key is disabled; JS bridge state remains the canonical state source.
- `assets/mathlive/manifest.json`
  - Adds the Q277R3 phase envelope and latest Camera/OCR runtime premium regression marker.
- `README.md`
  - Adds Q277R3 release note.
- `tool/verify_camera_ocr_runtime_premium_regression_analyzer_hygiene_v172_q277r2.mjs`
- `tool/verify_camera_ocr_runtime_premium_regression_log_repair_v172_q277r1.mjs`
- `tool/verify_camera_ocr_runtime_premium_regression_v172_q277.mjs`
- `tool/verify_camera_ocr_real_end_to_end_device_court_v172_q276.mjs`
- `tool/verify_approved_ocr_workspace_import_gate_v172_q275.mjs`
- `tool/verify_ocr_result_mathlive_real_review_binding_v172_q274.mjs`
- `tool/verify_pp_formulanet_s_image_to_latex_prototype_gate_v172_q273.mjs`
  - Successor-aware verifier metadata updated for Q277R3.

## Explicitly Not Modified

- Keyboard layout/source files.
- MORE/template tray.
- Long-press source/list files.
- `assets/mathlive/mathlive_prod_bridge.js`.
- Graph/Solution/History UI/runtime files.
- AppShell.
- Splash/icon files.
- Camera capture shell.
- Solver/evaluator.
- Android Manifest/MainActivity/toolchain/camera dependencies.
