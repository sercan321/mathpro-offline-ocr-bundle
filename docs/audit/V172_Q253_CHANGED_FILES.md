# V172-Q253 Changed Files

Runtime Android toolchain file:

- `android/settings.gradle`

Added Q253 files:

- `lib/features/camera/gauss_android_toolchain_modernization_policy.dart`
- `lib/features/camera/gauss_android_toolchain_modernization.dart`
- `test/v172_q253_android_toolchain_modernization_test.dart`
- `tool/verify_android_toolchain_modernization_v172_q253.mjs`
- `docs/audit/V172_Q253_ANDROID_TOOLCHAIN_MODERNIZATION_AUDIT.md`
- `docs/audit/V172_Q253_CHANGED_FILES.md`

Metadata/docs updated:

- `assets/mathlive/manifest.json`
- `README.md`
- `tool/verify_camera_ocr_premium_final_regression_v172_q252.mjs`
- `tool/verify_camera_kotlin_metadata_compatibility_v172_q244r8.mjs`

No keyboard, MORE, long-press, MathLive production editor, Graph, Solution, History, splash, launcher icon, AndroidManifest, MainActivity, camera shell runtime, OCR runtime, model binary, or solver/evaluator file was intentionally modified.

Successor-aware verifier hygiene updated because Q253 intentionally changes `android/settings.gradle` from AGP 8.3.2 to AGP 8.6.1:

- `tool/verify_camera_ocr_premium_final_regression_v172_q252.mjs`
- `tool/verify_camera_math_ocr_end_to_end_court_v172_q251.mjs`
- `tool/verify_ocr_mathlive_review_import_v172_q250.mjs`
- `tool/verify_ocr_runtime_adapter_v172_q249.mjs`
- `tool/verify_deferred_model_download_runtime_v172_q248.mjs`
- `tool/verify_winner_engine_selection_v172_q247.mjs`
- `tool/verify_ocr_engine_real_benchmark_package_v172_q246.mjs`
- `tool/verify_camera_real_device_evidence_closure_v172_q245.mjs`
- `tool/verify_camera_kotlin_metadata_compatibility_v172_q244r8.mjs`
- `tool/verify_camera_precamerax_camera2_build_compatibility_v172_q244r6.mjs`
