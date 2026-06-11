# V172-Q318 Changed Files

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
- `test/v172_q317_android_native_bridge_minimal_healthcheck_behind_flag_test.dart`
- Q301-Q317 related verifier scripts updated only for Q318 successor-awareness and protected hash continuity.

## Added Files

- `lib/features/camera/gauss_private_model_download_storage_real_implementation_q318_policy.dart`
- `lib/features/camera/gauss_private_model_download_storage_real_implementation_q318.dart`
- `test/v172_q318_private_model_download_storage_real_implementation_test.dart`
- `tool/verify_private_model_download_storage_real_implementation_v172_q318.mjs`
- `docs/audit/V172_Q318_PRIVATE_MODEL_DOWNLOAD_STORAGE_REAL_IMPLEMENTATION_AUDIT.md`
- `docs/audit/V172_Q318_CHANGED_FILES.md`

## Protected Runtime File Intentionally Modified

- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`

Reason: add default-off private model storage path and SHA healthcheck methods only.

Scope:

- Adds `privateStorageInfo` and `verifyPrivateStorageArtifact` MethodChannel branches under the existing `mathpro/ocr_runtime_bridge` channel.
- Resolves `filesDir/ocr_models/PP-FormulaNet-S/inference.pdiparams`.
- Computes SHA256 only when the artifact exists and the verification method is called.
- Keeps runtime dependency/model load/inference/workspace import disabled.

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

## Explicitly Not Added

- Paddle/PaddleOCR/Paddle Lite/ONNX/TFLite dependencies
- App network download worker
- Model binary/archive
- JNI/native model loader
- Runtime startup
- Dummy runtime call
- Image-to-LaTeX inference
- Editable MathLive review launch
- Workspace import
- OCR PASS or Android real-device PASS claim
