# V172-Q315 Changed Files

## Phase

V172-Q315-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE

## Modified Files

- `assets/mathlive/manifest.json`
- `README.md`
- `test/v172_q314_real_ocr_implementation_readiness_artifact_acquisition_plan_test.dart`
- `test/v172_q313r3_flutter_test_successor_aware_hygiene_repair_test.dart`
- `test/v172_q313r2_flutter_analyze_info_hygiene_test.dart`
- `test/v172_q313r1_flutter_log_repair_q295_path_escape_q152_successor_aware_test.dart`
- `tool/verify_real_ocr_implementation_readiness_artifact_acquisition_plan_v172_q314.mjs`
- `tool/verify_flutter_test_successor_aware_hygiene_repair_v172_q313r3.mjs`
- `tool/verify_flutter_analyze_info_hygiene_v172_q313r2.mjs`
- `tool/verify_flutter_log_repair_q295_path_escape_q152_successor_aware_v172_q313r1.mjs`
- Relevant Q301-Q313 verifier files made Q315 successor-aware when they already had Q314 successor awareness.

## Added Files

- `lib/features/camera/gauss_controlled_model_artifact_download_hash_capture_q315_policy.dart`
- `lib/features/camera/gauss_controlled_model_artifact_download_hash_capture_q315.dart`
- `test/v172_q315_controlled_model_artifact_download_hash_capture_test.dart`
- `tool/capture_pp_formulanet_s_artifact_hash_v172_q315.mjs`
- `tool/verify_controlled_model_artifact_download_hash_capture_v172_q315.mjs`
- `docs/audit/V172_Q315_CONTROLLED_MODEL_ARTIFACT_DOWNLOAD_HASH_CAPTURE_AUDIT.md`
- `docs/audit/V172_Q315_CHANGED_FILES.md`

## Protected Runtime Files Not Modified

- `pubspec.yaml`
- `android/app/src/main/AndroidManifest.xml`
- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
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
- `lib/features/solution/solution_step_models.dart`
- `lib/features/history/history_panel.dart`
- `lib/features/history/history_controller.dart`
- `lib/app/app_shell.dart`
- `lib/main.dart`
- `lib/app/gauss_splash_screen.dart`

## Explicit Non-Changes

- No model binary is included.
- No Paddle/PaddleOCR/Paddle Lite/ONNX/TFLite dependency is added.
- No downloader dependency is added.
- No MethodChannel/JNI/native runtime binding is added.
- No camera image is sent to OCR runtime.
- No OCR result is imported into MathLive or workspace.
- No automatic solve, Graph, Solution, or History side effect is added.
