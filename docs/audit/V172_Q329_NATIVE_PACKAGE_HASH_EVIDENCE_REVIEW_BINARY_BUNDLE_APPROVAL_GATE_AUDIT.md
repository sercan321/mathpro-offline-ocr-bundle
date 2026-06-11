# V172-Q329 — Native Package Hash Evidence Review / Binary Bundle Approval Gate

## Scope

Q329 adds a default-off native package hash evidence review and binary bundle approval gate for the PP-FormulaNet-S OCR runtime track.

The new Android bridge method is:

- Channel: `mathpro/ocr_runtime_bridge`
- Method: `nativePackageHashEvidenceReview`
- Status: `NATIVE_PACKAGE_HASH_EVIDENCE_REVIEW_BLOCKED_PENDING_USER_NATIVE_PACKAGE_HASH_EVIDENCE_DEFAULT_OFF`

## Evidence state

Q329 does not accept native binary files because no user-provided Q328 native package hash evidence JSON has been supplied to this phase.

Required future external evidence remains:

- `../MathProOcrNativePackages/Paddle_Lite_Android/q328_native_library_package_hash_evidence.json`
- per-file SHA256 for `PaddlePredictor.jar`
- per-file SHA256 for `arm64-v8a/libpaddle_lite_jni.so`
- per-file SHA256 for `armeabi-v7a/libpaddle_lite_jni.so`
- optional per-file SHA256 for `x86_64/libpaddle_lite_jni.so`

## Hard blocks preserved

Q329 intentionally does not:

- bundle `.so`, `.jar`, or `.aar` files
- create `android/app/src/main/jniLibs`
- create `android/app/libs`
- mutate Gradle
- mutate `pubspec.yaml`
- mutate `AndroidManifest.xml`
- load a native library
- instantiate Paddle Lite
- add a native model loader
- start a runtime
- execute a dummy runtime call
- execute image-to-LaTeX inference
- open MathLive review
- import workspace
- claim OCR, Android real-device, store, or release PASS

## Protected file declaration

`android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt` is intentionally modified only to add the default-off `nativePackageHashEvidenceReview` envelope method. The change is a protected-file mutation and must stay explicitly reported.

## Next phase gate

Q330 may only perform a binary bundle trial if all of the following exist:

- Q329 user-side `flutter analyze` and `flutter test` are clean
- Q328 native package hash evidence JSON is supplied
- required native package file hashes are reviewed
- user explicitly approves binary bundle trial
- rollback plan is defined before `jniLibs` or `android/app/libs` mutation
