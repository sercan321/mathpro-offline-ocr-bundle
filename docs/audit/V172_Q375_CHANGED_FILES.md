# V172-Q375 Changed Files

## Modified
- `README.md`
- `assets/mathlive/manifest.json`
- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`

## Added
- `lib/features/camera/gauss_real_ocr_execution_output_decoder_closure_q375_policy.dart`
- `lib/features/camera/gauss_real_ocr_execution_output_decoder_closure_q375.dart`
- `test/v172_q375_real_ocr_execution_output_decoder_closure_test.dart`
- `tool/verify_real_ocr_execution_output_decoder_closure_v172_q375.mjs`
- `docs/audit/V172_Q375_REAL_OCR_EXECUTION_OUTPUT_DECODER_CLOSURE_AUDIT.md`
- `docs/audit/V172_Q375_CHANGED_FILES.md`

## Protected Runtime/UI Files Not Modified
- `android/app/build.gradle`
- `pubspec.yaml`
- `android/app/src/main/AndroidManifest.xml`
- keyboard layout/order files
- MORE/template tray files
- long-press files
- MathLive production route files
- workspace UI files
- Graph files
- Solution files
- History files
- splash/icon files
- solver/evaluator files

## MainActivity Change Disclosure
`MainActivity.kt` changed intentionally only to add explicit bridge method `realOcrExecutionOutputDecoderClosure` and Q375 constants/helper logic. It does not auto-run OCR, does not mutate workspace, and does not trigger Solve/Graph/Solution/History.
