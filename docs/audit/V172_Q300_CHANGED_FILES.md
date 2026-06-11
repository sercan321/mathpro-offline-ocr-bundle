# V172-Q300 — Changed Files

## Added

- `lib/features/camera/gauss_release_candidate_freeze_policy.dart`
- `lib/features/camera/gauss_release_candidate_freeze.dart`
- `test/v172_q300_release_candidate_freeze_test.dart`
- `tool/verify_release_candidate_freeze_v172_q300.mjs`
- `docs/audit/V172_Q300_RELEASE_CANDIDATE_FREEZE_AUDIT.md`
- `docs/audit/V172_Q300_CHANGED_FILES.md`

## Modified

- `assets/mathlive/manifest.json`
- `README.md`

## Modified For Successor Awareness Only

- `tool/verify_store_release_candidate_audit_v172_q299.mjs`
- `tool/verify_full_real_camera_ocr_regression_v172_q298.mjs`
- `tool/verify_approved_ocr_workspace_import_real_runtime_v172_q297.mjs`
- `tool/verify_ocr_result_editable_mathlive_review_real_runtime_v172_q296.mjs`
- `tool/verify_first_real_image_to_latex_inference_v172_q295.mjs`
- `tool/verify_first_real_dummy_input_runtime_call_v172_q294.mjs`
- `tool/verify_first_real_runtime_startup_smoke_v172_q293.mjs`
- `tool/verify_real_private_artifact_load_smoke_v172_q292.mjs`
- `tool/verify_private_model_download_sha_verification_runtime_v172_q291.mjs`
- `tool/verify_native_runtime_handler_skeleton_android_binding_v172_q290.mjs`
- `tool/verify_runtime_dependency_actual_trial_default_off_v172_q289.mjs`
- `tool/verify_real_ocr_artifact_source_intake_v172_q288.mjs`
- `tool/verify_store_readiness_camera_ocr_release_audit_test_doc_section_repair_v172_q287r2.mjs`
- `tool/verify_store_readiness_camera_ocr_release_audit_log_repair_v172_q287r1.mjs`
- `tool/verify_store_readiness_camera_ocr_release_audit_v172_q287.mjs`
- `tool/verify_full_camera_ocr_runtime_premium_regression_v172_q286.mjs`
- `tool/verify_camera_ocr_runtime_premium_regression_tap_latency_cadence_v172_q277r3.mjs`

## Explicitly Not Modified

- Keyboard layout/order/source files
- MORE/template tray
- Long-press lists and popup runtime
- MathLive production editor route/bridge
- Camera shell runtime
- Workspace runtime
- Graph/Solution/History runtime files
- AppShell/main runtime
- AndroidManifest/MainActivity
- Splash/icon assets and startup runtime
- `pubspec.yaml`, camera dependencies, Android Gradle/Kotlin toolchain
- Solver/evaluator behavior

## Runtime Claim Boundary

Q300 does not add OCR runtime, Paddle/PaddleOCR, JNI, MethodChannel binding, model binary, production download, image-to-LaTeX inference, release build, Play Store submission, or any OCR/store/release PASS claim.
