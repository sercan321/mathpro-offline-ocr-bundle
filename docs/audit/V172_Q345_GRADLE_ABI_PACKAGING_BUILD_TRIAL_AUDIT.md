# V172-Q345 Gradle / ABI Packaging Build Trial Audit

Phase: `V172-Q345-GRADLE-ABI-PACKAGING-BUILD-TRIAL`

Q345 is a narrow Android packaging phase after Q344's approved Paddle Lite native binary bundle. It adds the minimal Gradle local-jar dependency needed for `android/app/libs/PaddlePredictor.jar` to participate in the Android app module packaging/classpath, while preserving the Q344 `jniLibs` native ABI layout.

## Scope

- Keep the Q344 approved native binary files and hashes unchanged.
- Declare `implementation files('libs/PaddlePredictor.jar')` in `android/app/build.gradle`.
- Use the Android Gradle Plugin default `src/main/jniLibs` source set for `arm64-v8a` and `armeabi-v7a` native libraries.
- Do not add `System.loadLibrary`, Paddle Lite Predictor instantiation, model loading, runtime startup, dummy runtime calls, image-to-LaTeX inference, OCR review, or workspace import.

## Protected surfaces

Workspace, keyboard, MORE/template tray, long-press, MathLive production bridge/editor, Graph, Solution, History, splash/icon, solver/evaluator, `MainActivity.kt`, `AndroidManifest.xml`, `pubspec.yaml`, and root Gradle/settings files are intentionally unchanged. The only protected-surface mutation is the explicit Q345 `android/app/build.gradle` packaging dependency change.

## Honest boundary

Assistant-side Flutter/Android SDK execution is unavailable in this environment. Q345 therefore does not claim `flutter analyze`, `flutter test`, `flutter run`, Android packaging PASS, real-device PASS, Paddle Lite runtime PASS, or OCR PASS. User-side Flutter/Android logs are required.
