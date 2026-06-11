# V172-Q347 Paddle Lite Predictor Instantiate Smoke Audit

## Scope

Q347 adds a guarded/default-off `paddleLitePredictorInstantiateSmoke` method to the existing `mathpro/ocr_runtime_bridge` channel.

## What changed

- Added Q347 Dart policy/result contract.
- Added Q347 widget/static test.
- Added Q347 verifier.
- Advanced `cameraOcrLatestPhase` and `activeProductDevelopmentLatestPhase` to `V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE`.
- Added a guarded MainActivity bridge method for Paddle Lite Predictor instantiate smoke.

## What did not change

- No model loader.
- No model load.
- No runtime startup.
- No dummy runtime call.
- No image-to-LaTeX inference.
- No OCR review UI.
- No workspace import.
- No OCR PASS claim.
- No Android real-device PASS claim.
- No keyboard/MORE/long-press/MathLive/Graph/Solution/History/splash/icon mutation.
- No pubspec, AndroidManifest, or Gradle mutation.

## Binary inventory preserved

- `android/app/libs/PaddlePredictor.jar`
- `android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so`
- `android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so`

`x86_64` remains absent because it was not supplied in the accepted Q328 native package evidence.

## Protected file disclosure

`android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt` changed intentionally to add only the guarded/default-off Q347 bridge envelope.

## Honest boundary

Q347 does not prove native library load success, Predictor instantiate success, model load, runtime startup, OCR, image-to-LaTeX, or camera equation reading. Those require user-side Android logs and later phases.
