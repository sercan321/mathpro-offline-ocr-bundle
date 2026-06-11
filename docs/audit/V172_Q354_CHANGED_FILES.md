# V172-Q354 Changed Files

## Added

- `docs/audit/V172_Q354_CHANGED_FILES.md`
- `docs/audit/V172_Q354_ONNX_RUNTIME_ANDROID_DEPENDENCY_ABI_BUILD_TRIAL_AUDIT.md`
- `lib/features/camera/gauss_onnx_runtime_android_dependency_abi_build_trial_q354.dart`
- `lib/features/camera/gauss_onnx_runtime_android_dependency_abi_build_trial_q354_policy.dart`
- `test/v172_q354_onnx_runtime_android_dependency_abi_build_trial_test.dart`
- `tool/verify_onnx_runtime_android_dependency_abi_build_trial_v172_q354.mjs`

## Modified

- `README.md`
- `assets/mathlive/manifest.json`
- `android/app/build.gradle`
- Legacy successor-aware verifier/test helper files from Q336 through Q353 so Q354 is accepted as the active successor phase.

## Intentional Protected Change

- `android/app/build.gradle`

Reason: Q354 is the dependency / ABI build trial phase and therefore must add the selected Android ONNX Runtime dependency coordinate.

## Not Modified

- Keyboard layout/order
- MORE/template tray
- Long-press lists
- MathLive production route
- Workspace expression editor
- Graph
- Solution
- History
- Splash/icon
- Solver/evaluator
- `pubspec.yaml`
- `android/app/src/main/AndroidManifest.xml`
- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`

## Runtime/OCR Boundary

No model-load, runtime startup, dummy input call, image-to-LaTeX inference, OCR review UI, workspace import, OCR PASS, Android real-device PASS, store PASS, or release PASS is introduced by Q354.
