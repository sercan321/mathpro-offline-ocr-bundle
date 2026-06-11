# V172-Q317 Changed Files

## Modified Files

- `assets/mathlive/manifest.json`
- `README.md`
- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
- `test/v172_q313r1_flutter_log_repair_q295_path_escape_q152_successor_aware_test.dart`
- `test/v172_q313r2_flutter_analyze_info_hygiene_test.dart`
- `test/v172_q313r3_flutter_test_successor_aware_hygiene_repair_test.dart`
- `test/v172_q314_real_ocr_implementation_readiness_artifact_acquisition_plan_test.dart`
- `test/v172_q315_controlled_model_artifact_download_hash_capture_test.dart`
- `test/v172_q315r1_controlled_model_artifact_download_hash_capture_flutter_test_repair_test.dart`
- `test/v172_q316_runtime_dependency_feasibility_trial_default_off_test.dart`
- `tool/verify_android_native_runtime_bridge_implementation_gate_v172_q304.mjs`
- `tool/verify_approved_ocr_workspace_import_runtime_binding_gate_v172_q312.mjs`
- `tool/verify_controlled_model_artifact_download_hash_capture_flutter_test_repair_v172_q315r1.mjs`
- `tool/verify_controlled_model_artifact_download_hash_capture_v172_q315.mjs`
- `tool/verify_dummy_input_real_runtime_call_gate_v172_q309.mjs`
- `tool/verify_first_real_image_to_latex_inference_gate_v172_q310.mjs`
- `tool/verify_flutter_analyze_info_hygiene_v172_q313r2.mjs`
- `tool/verify_flutter_log_repair_q295_path_escape_q152_successor_aware_v172_q313r1.mjs`
- `tool/verify_flutter_test_successor_aware_hygiene_repair_v172_q313r3.mjs`
- `tool/verify_full_camera_ocr_real_device_regression_gate_v172_q313.mjs`
- `tool/verify_ocr_candidate_editable_mathlive_review_ui_binding_gate_v172_q311.mjs`
- `tool/verify_private_artifact_load_real_device_smoke_gate_v172_q307.mjs`
- `tool/verify_private_model_download_worker_real_implementation_gate_v172_q305.mjs`
- `tool/verify_real_ocr_implementation_readiness_artifact_acquisition_plan_v172_q314.mjs`
- `tool/verify_real_pp_formulanet_s_artifact_url_sha_lock_v172_q302.mjs`
- `tool/verify_runtime_dependency_feasibility_trial_default_off_v172_q316.mjs`
- `tool/verify_runtime_dependency_real_trial_default_off_v172_q303.mjs`
- `tool/verify_runtime_startup_real_device_smoke_gate_v172_q308.mjs`
- `tool/verify_sha_verification_atomic_move_real_runtime_gate_v172_q306.mjs`

## Added Files

- `lib/features/camera/gauss_android_native_bridge_minimal_healthcheck_q317_policy.dart`
- `lib/features/camera/gauss_android_native_bridge_minimal_healthcheck_q317.dart`
- `test/v172_q317_android_native_bridge_minimal_healthcheck_behind_flag_test.dart`
- `tool/verify_android_native_bridge_minimal_healthcheck_behind_flag_v172_q317.mjs`
- `docs/audit/V172_Q317_ANDROID_NATIVE_BRIDGE_MINIMAL_HEALTHCHECK_BEHIND_FLAG_AUDIT.md`
- `docs/audit/V172_Q317_CHANGED_FILES.md`

## Protected Runtime File Intentionally Modified

- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`

Reason: default-off OCR runtime bridge MethodChannel ping and healthCheck only.

Scope: channel `mathpro/ocr_runtime_bridge`, methods `ping` and `healthCheck`, static healthcheck envelope only.

Runtime effect: no OCR runtime startup, no model load, no inference, no workspace import.

## Protected Runtime Files Not Modified

- `pubspec.yaml`
- `android/app/src/main/AndroidManifest.xml`
- Gradle files
- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/workspace/template_tray.dart`
- `assets/mathlive/main_editor_prod.html`
- `assets/mathlive/mathlive_prod_bridge.js`
- `lib/features/mathlive/mathlive_production_editor_surface.dart`
- `lib/features/workspace/workspace_panel.dart`
- `lib/features/camera/gauss_camera_capture_shell.dart`
- `lib/features/graph/graph_card.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/features/history/history_panel.dart`
- `lib/app/app_shell.dart`
- `lib/main.dart`
- `lib/app/gauss_splash_screen.dart`

## Explicit non-claims

- OCR PASS not claimed.
- Android real-device PASS not claimed.
- Runtime startup PASS not claimed.
- Image-to-LaTeX PASS not claimed.
- Workspace import PASS not claimed.
