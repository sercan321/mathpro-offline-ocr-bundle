# V172-Q364 Changed Files

## Added

- `lib/features/camera/gauss_onnx_model_artifact_private_storage_activation_q364_policy.dart`
- `lib/features/camera/gauss_onnx_model_artifact_private_storage_activation_q364.dart`
- `test/v172_q364_onnx_model_artifact_private_storage_activation_test.dart`
- `tool/verify_onnx_model_artifact_private_storage_activation_v172_q364.mjs`
- `docs/audit/V172_Q364_ONNX_MODEL_ARTIFACT_PRIVATE_STORAGE_ACTIVATION_AUDIT.md`
- `docs/audit/V172_Q364_CHANGED_FILES.md`

## Modified

- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt` — intentional explicit-invocation-only private-storage activation bridge.
- `assets/mathlive/manifest.json` — Q364 metadata only; active product/OCR phase remains Q363.
- `README.md` — Q364 release note.

## Not changed

- Gradle, pubspec, AndroidManifest.
- Keyboard, MORE/template tray, long-press.
- MathLive production editor, workspace UI.
- Graph, Solution, History.
- Splash/icon and solver/evaluator surfaces.
- Model artifacts are not bundled.
