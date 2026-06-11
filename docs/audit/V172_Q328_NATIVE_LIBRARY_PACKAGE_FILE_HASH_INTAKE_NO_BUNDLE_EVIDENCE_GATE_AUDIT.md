# V172-Q328 — Native Library Package File Hash Intake / No-Bundle Evidence Gate Audit

## Phase

`V172-Q328-NATIVE-LIBRARY-PACKAGE-FILE-HASH-INTAKE-NO-BUNDLE-EVIDENCE-GATE`

## Source phase

`V172-Q327-NATIVE-LIBRARY-SOURCE-PACKAGE-APPROVAL-ABI-MATRIX-LOCK`

## Scope

Q328 prepares the native library package file hash evidence gate for the PP-FormulaNet-S OCR runtime path. It does not bundle native libraries or Java archives into the Flutter/Android project.

The selected runtime candidate remains the Paddle Lite Android native-library/manual package path, but all binary package files are still blocked until explicit user approval, per-file SHA256 evidence, rollback planning, and fresh Flutter build/test/run evidence are available.

## Native bridge method

Channel:

`mathpro/ocr_runtime_bridge`

Method:

`nativeLibraryPackageFileHashIntake`

Status:

`NATIVE_LIBRARY_PACKAGE_FILE_HASH_INTAKE_BLOCKED_NO_NATIVE_PACKAGE_HASH_EVIDENCE_DEFAULT_OFF`

## External evidence folder

Default external evidence/input folder:

`../MathProOcrNativePackages/Paddle_Lite_Android`

Evidence JSON:

`q328_native_library_package_hash_evidence.json`

The Q328 capture script refuses to read/write evidence inside the project root.

## Required package files for future evidence

Q328 expects hash evidence for these future files, but does not bundle them:

- `PaddlePredictor.jar`
- `arm64-v8a/libpaddle_lite_jni.so`
- `armeabi-v7a/libpaddle_lite_jni.so`

Optional emulator-only evidence:

- `x86_64/libpaddle_lite_jni.so`

## Deliberate hard blocks

Q328 intentionally does not:

- bundle `.so`, `.aar`, or `.jar` files
- create `android/app/src/main/jniLibs`
- create `android/app/libs`
- mutate `pubspec.yaml`
- mutate Gradle files
- mutate `AndroidManifest.xml`
- instantiate Paddle Lite
- call `System.loadLibrary`
- convert the model with Paddle Lite opt
- load a model
- start runtime
- execute dummy runtime call
- run image-to-LaTeX inference
- open editable MathLive review
- import to workspace
- claim OCR, runtime, Android real-device, store, or release PASS

## Protected runtime file intentionally modified

`android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`

Reason: add a default-off native package hash-evidence intake envelope method only.

## Evidence requirements before Q329 binary bundle trial

Before any `.so`, `.jar`, `jniLibs`, `android/app/libs`, Gradle, or native loader mutation, the next phase must require:

- Q328 Flutter analyze/test user log
- Q328 real-device run log if available
- external native package hash evidence JSON
- per-file SHA256 for the jar and each required `.so`
- explicit binary bundle approval
- rollback plan before any Gradle/native loader mutation

## Runtime status

`runtimeDependencyAdded=false`

`nativeLibraryBundled=false`

`jarBundled=false`

`jniLibsDirectoryCreated=false`

`perFileSha256EvidenceCaptured=false`

`nativePackageHashEvidenceAccepted=false`

`runtimeStartupExecuted=false`

`realImageToLatexInferenceExecuted=false`

`ocrPassClaimed=false`
