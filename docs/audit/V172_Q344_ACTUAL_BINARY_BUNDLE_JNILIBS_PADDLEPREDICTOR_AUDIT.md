# V172-Q344 Actual Binary Bundle jniLibs + PaddlePredictor Audit

Phase: `V172-Q344-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR`

## Scope

Q344 is the first real native binary bundle phase for the PP-FormulaNet-S / Paddle Lite Android route. It copies the user-provided, Q328-hashed Paddle Lite Android native package files into the Android project:

- `android/app/libs/PaddlePredictor.jar`
- `android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so`
- `android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so`

The optional `x86_64` ABI is not bundled because it was not supplied.

## Evidence Accepted

Q344 consumes the Q328 external native package hash evidence and records a package-side copy in:

- `docs/evidence/V172_Q344_ACCEPTED_Q328_NATIVE_LIBRARY_PACKAGE_HASH_EVIDENCE.json`
- `docs/evidence/V172_Q344_BUNDLED_NATIVE_BINARY_HASHES.json`

## Runtime Non-Goals

Q344 does not add or execute:

- `System.loadLibrary`
- Paddle Lite `PaddlePredictor` instantiation
- model loader
- runtime startup
- dummy runtime call
- image-to-LaTeX inference
- editable MathLive OCR review
- workspace import
- OCR PASS claim
- Android real-device PASS claim

## Red-Line Preservation

Q344 does not intentionally modify workspace, keyboard, MORE/template tray, long-press, MathLive production bridge/editor, Graph, Solution, History, splash/icon, solver/evaluator, `pubspec.yaml`, Gradle, AndroidManifest, or MainActivity.

## Next Phase

The next phase is Q345 — Gradle / ABI Packaging Build Trial. Q345 must verify whether the bundled `.jar` and `.so` files are packaged and build-compatible on the user device. Q345 may require a surgical Gradle adjustment only if real build evidence shows it is needed.
