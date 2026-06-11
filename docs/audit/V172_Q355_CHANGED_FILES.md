# V172-Q355 Changed Files

## Added

- `lib/features/camera/gauss_onnx_model_private_storage_sha_verification_q355_policy.dart`
- `lib/features/camera/gauss_onnx_model_private_storage_sha_verification_q355.dart`
- `test/v172_q355_onnx_model_private_storage_sha_verification_test.dart`
- `tool/verify_onnx_model_private_storage_sha_verification_v172_q355.mjs`
- `docs/audit/V172_Q355_ONNX_MODEL_PRIVATE_STORAGE_SHA_VERIFICATION_AUDIT.md`
- `docs/audit/V172_Q355_CHANGED_FILES.md`

## Modified

- `assets/mathlive/manifest.json`
- `README.md`
- Legacy successor-aware verifier/test files from the Q336-Q354 chain so they accept Q355 as the current successor phase.

## Intentionally unchanged

- `android/app/build.gradle` remains exactly at the Q354 dependency-trial state; Q355 adds no new dependency.
- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
- `android/app/src/main/AndroidManifest.xml`
- `pubspec.yaml`
- Keyboard, MORE/template tray, long-press, MathLive production, workspace, Graph, Solution, History, splash/icon, solver/evaluator protected surfaces.

## No bundled model artifacts

Q355 does not add or bundle `*.onnx`, `*.nb`, `*.pdmodel`, `*.pdiparams`, `*.tflite`, `*.safetensors`, or model cache artifacts.
