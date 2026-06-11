# V172-Q277R1 (V172-Q277R1-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION-FLUTTER-LOG-REPAIR) Changed Files

## Modified

- `lib/features/camera/gauss_mathlive_ocr_review_surface.dart`
  - Removed the duplicated misplaced `GaussMathLiveOcrReviewDraft.fromQ250Import` factory from `GaussMathLiveOcrReviewSheet`.
  - Restored the historical Q239D safety phrase while preserving user-approval safety copy.
- `lib/features/camera/gauss_deferred_model_download_runtime.dart`
  - Added `const` to the analyzer-reported readiness result constructor.
- `test/v172_q252_camera_ocr_premium_final_regression_test.dart`
- `test/v172_q254_pp_formulanet_s_runtime_source_evidence_test.dart`
- `test/v172_q256_pp_formulanet_s_artifact_manifest_sha_lock_test.dart`
- `test/v172_q257_pp_formulanet_s_download_orchestrator_ui_guard_test.dart`
- `test/v172_q258_pp_formulanet_s_production_artifact_resolver_gate_test.dart`
- `test/v172_q259_pp_formulanet_s_real_download_worker_dry_run_test.dart`
- `test/v172_q260_pp_formulanet_s_real_model_download_integration_gate_test.dart`
- `test/v172_q261_pp_formulanet_s_runtime_feasibility_adapter_test.dart`
- `test/v172_q262_pp_formulanet_s_runtime_prototype_bridge_gate_test.dart`
- `test/v172_q263_pp_formulanet_s_runtime_prototype_smoke_evidence_template_test.dart`
  - Exclude generated `/build/` and `/.dart_tool/` outputs from model-binary artifact scans so Flutter test-generated `AssetManifest.bin` is not treated as a bundled OCR model.
- `assets/mathlive/manifest.json`
  - Added Q277R1 repair envelope and updated latest Camera/OCR phase marker.
- `README.md`
  - Added Q277R1 repair note.
- `tool/verify_camera_ocr_runtime_premium_regression_v172_q277.mjs`
  - Made Q277 verifier successor-aware for Q277R1 latest marker.

## Added

- `test/v172_q277r1_camera_ocr_runtime_premium_regression_log_repair_test.dart`
- `tool/verify_camera_ocr_runtime_premium_regression_log_repair_v172_q277r1.mjs`
- `docs/audit/V172_Q277R1_CAMERA_OCR_RUNTIME_PREMIUM_REGRESSION_FLUTTER_LOG_REPAIR_AUDIT.md`
- `docs/audit/V172_Q277R1_CHANGED_FILES.md`

## Not changed

- Keyboard layout/order, MORE/template tray inventory/order, long-press lists, MathLive production HTML/bridge/surface, Graph, Solution, History, AppShell, main, splash/icon, workspace runtime, camera capture shell runtime, solver/evaluator, Android manifest, MainActivity, camera dependency versions, and Android toolchain versions.
