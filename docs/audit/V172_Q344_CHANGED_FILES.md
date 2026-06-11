# V172-Q344 Changed Files

## Modified

- `assets/mathlive/manifest.json`
- `README.md`
- Q326-Q343R2 test files were made Q344-successor-aware for the new legitimate bundled binary state.

## Added

- `android/app/libs/PaddlePredictor.jar`
- `android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so`
- `android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so`
- `docs/evidence/V172_Q344_ACCEPTED_Q328_NATIVE_LIBRARY_PACKAGE_HASH_EVIDENCE.json`
- `docs/evidence/V172_Q344_BUNDLED_NATIVE_BINARY_HASHES.json`
- `lib/features/camera/gauss_actual_binary_bundle_jnilibs_paddlepredictor_q344_policy.dart`
- `lib/features/camera/gauss_actual_binary_bundle_jnilibs_paddlepredictor_q344.dart`
- `test/v172_q344_binary_bundle_successor_test_helper.dart`
- `test/v172_q344_actual_binary_bundle_jnilibs_paddlepredictor_test.dart`
- `tool/verify_actual_binary_bundle_jnilibs_paddlepredictor_v172_q344.mjs`
- `docs/audit/V172_Q344_ACTUAL_BINARY_BUNDLE_JNILIBS_PADDLEPREDICTOR_AUDIT.md`
- `docs/audit/V172_Q344_CHANGED_FILES.md`

## Protected Runtime/UI Files Not Modified

- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
- `android/app/src/main/AndroidManifest.xml`
- `pubspec.yaml`
- Gradle files
- workspace, keyboard, MORE/template tray, long-press, MathLive production bridge/editor, Graph, Solution, History, splash/icon, solver/evaluator surfaces

## Binary State

Q344 intentionally bundles only the approved Paddle Lite Android files:

- `android/app/libs/PaddlePredictor.jar`
- `android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so`
- `android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so`

No `.aar`, APK, AAB, build output, cache, or optional `x86_64` binary is included.

## Runtime State

No native library load, Paddle Lite predictor instantiate, model load, runtime startup, image-to-LaTeX inference, OCR review, workspace import, OCR PASS, or Android real-device PASS is claimed in Q344.
