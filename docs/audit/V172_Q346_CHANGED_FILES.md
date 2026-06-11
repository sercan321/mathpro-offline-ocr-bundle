# V172-Q346 Changed Files

## Added

- `lib/features/camera/gauss_native_library_load_smoke_q346_policy.dart`
- `lib/features/camera/gauss_native_library_load_smoke_q346.dart`
- `test/v172_q346_native_library_load_smoke_test.dart`
- `tool/verify_native_library_load_smoke_v172_q346.mjs`
- `docs/audit/V172_Q346_NATIVE_LIBRARY_LOAD_SMOKE_AUDIT.md`
- `docs/audit/V172_Q346_CHANGED_FILES.md`

## Modified

- `assets/mathlive/manifest.json`
  - Advanced `cameraOcrLatestPhase` and `activeProductDevelopmentLatestPhase` to Q346.
  - Added the `v172Q346NativeLibraryLoadSmoke` envelope.

- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
  - Added the guarded, default-off `nativeLibraryLoadSmoke` bridge method.
  - Does not automatically load the native library on startup.
  - Does not instantiate Paddle Lite or execute model/runtime/OCR work.

- `test/v172_q344_binary_bundle_successor_test_helper.dart`
  - Added Q346 as a valid Q344-or-later bundled binary successor.
  - Added a helper to allow the Q346 guarded native load-smoke bridge while still blocking Predictor/model/inference execution.

- Existing OCR/runtime successor-aware tests and selected verifiers
  - Updated to accept Q346 as the active post-bundle/native-load-smoke successor phase.

- `README.md`
  - Added the Q346 phase note.

## Binary Inventory Unchanged From Q344

- `android/app/libs/PaddlePredictor.jar`
- `android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so`
- `android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so`

## Not Changed

- `pubspec.yaml`
- `android/app/src/main/AndroidManifest.xml`
- root Gradle/settings files
- workspace UI
- keyboard/MORE/long-press
- MathLive production bridge/editor
- Graph
- Solution
- History
- splash/icon
- solver/evaluator
