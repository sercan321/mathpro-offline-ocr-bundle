# V172-Q330 — Binary Bundle Trial: jniLibs + PaddlePredictor Default-Off Audit

## Phase

`V172-Q330-BINARY-BUNDLE-TRIAL-JNILIBS-PADDLEPREDICTOR-DEFAULT-OFF`

## Scope

Q330 is a binary-bundle trial gate, not a binary-bundle execution phase. It records the intended Android targets for a future Paddle Lite package while keeping the trial blocked until Q328 native package hash evidence and explicit user approval are provided.

## Added Native Bridge Envelope

Channel: `mathpro/ocr_runtime_bridge`

Method: `binaryBundleTrialDefaultOff`

Status: `BINARY_BUNDLE_TRIAL_BLOCKED_PENDING_NATIVE_PACKAGE_HASH_EVIDENCE_AND_USER_APPROVAL_DEFAULT_OFF`

## Planned Future Bundle Targets Only

- `android/app/libs/PaddlePredictor.jar`
- `android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so`
- `android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so`

These files are not bundled in Q330.

## Hard Blocks

- No `.so`, `.jar`, or `.aar` bundled.
- No `jniLibs` directory created.
- No `android/app/libs` directory created.
- No Gradle mutation.
- No `pubspec.yaml` mutation.
- No AndroidManifest mutation.
- No `System.loadLibrary`.
- No Paddle Lite instantiation.
- No model loader.
- No runtime startup.
- No dummy runtime execution.
- No image-to-LaTeX inference.
- No MathLive review.
- No workspace import.
- No OCR, Android real-device, store, or release PASS claim.

## Required Before Q331 Binary Bundle Execution

- Q330 user-side `flutter analyze` and `flutter test` logs.
- Q328 native package hash evidence JSON from outside the project root.
- Per-file SHA256 evidence reviewed for required native package files.
- Explicit user approval for creating `android/app/libs` and `android/app/src/main/jniLibs`.
- Rollback plan before binary bundle mutation.
