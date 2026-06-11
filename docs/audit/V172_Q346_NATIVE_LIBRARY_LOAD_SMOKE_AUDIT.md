# V172-Q346 Native Library Load Smoke Audit

Q346 is the native library load-smoke bridge phase after Q345 Gradle/ABI packaging.

## Scope

Q346 adds a guarded, default-off Android OCR bridge method:

- Channel: `mathpro/ocr_runtime_bridge`
- Method: `nativeLibraryLoadSmoke`
- Library name: `paddle_lite_jni`

The bridge is intentionally not invoked automatically during app startup. The feature flag remains default-off, and this package does not claim native library load success, Flutter PASS, Android real-device PASS, Paddle Lite runtime PASS, or OCR PASS.

## Preserved Q344/Q345 Binary Inputs

- `android/app/libs/PaddlePredictor.jar`
- `android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so`
- `android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so`

`x86_64` remains absent because the user did not provide an x86_64 library package.

## Intentional Protected Runtime Change

`android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt` changed intentionally to add the guarded default-off `nativeLibraryLoadSmoke` envelope. It does not instantiate Paddle Lite, load a model, run startup, execute a dummy call, run image-to-LaTeX inference, open OCR review UI, or import to workspace.

## Non-Goals

Q346 does not:

- add `PaddlePredictor` instantiation
- add model loader/model load
- execute runtime startup
- execute dummy runtime call
- execute image-to-LaTeX inference
- open editable MathLive OCR review
- import OCR output to workspace
- change Gradle, pubspec, or AndroidManifest
- change workspace, keyboard, MORE, long-press, MathLive production, Graph, Solution, History, splash, icon, or solver surfaces
- claim OCR, Android real-device, Flutter analyze/test/run, or store/release PASS

## Next Phase

Q347 should only proceed after user-side Q346 Flutter analyze/test/run evidence is clean. Q347 is expected to be Paddle Lite Predictor instantiate smoke, not model loading or OCR inference.
