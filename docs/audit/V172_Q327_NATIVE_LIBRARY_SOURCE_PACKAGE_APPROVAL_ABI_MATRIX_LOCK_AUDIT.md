# V172-Q327 — Native Library Source Package Approval / ABI Matrix Lock Audit

## Phase

`V172-Q327-NATIVE-LIBRARY-SOURCE-PACKAGE-APPROVAL-ABI-MATRIX-LOCK`

## Source phase

`V172-Q326-NATIVE-LIBRARY-BUILD-TRIAL-APPROVAL-ABI-PACKAGING-PREFLIGHT`

## Scope

Q327 locks the future Android native-library source package and ABI matrix for the PP-FormulaNet-S OCR runtime path without bundling any native or Java binary package files.

The approved candidate remains a Paddle Lite Android native-library path, but the actual package is still pending explicit user approval and per-file SHA256 evidence before any binary is committed.

## Native bridge method

Channel:

`mathpro/ocr_runtime_bridge`

Method:

`nativeLibrarySourcePackageApproval`

Status:

`NATIVE_LIBRARY_SOURCE_PACKAGE_APPROVAL_ABI_MATRIX_LOCKED_NO_BINARY_BUNDLE_DEFAULT_OFF`

## Locked candidate files

Future candidate package files, not bundled in Q327:

- `PaddlePredictor.jar`
- `arm64-v8a/libpaddle_lite_jni.so`
- `armeabi-v7a/libpaddle_lite_jni.so`

Modern Paddle Lite shared-library candidate is also recorded as evidence context only:

- `libpaddle_lite_api_shared.so`

## ABI matrix

- `arm64-v8a` — required primary real-device ABI
- `armeabi-v7a` — optional legacy ABI
- `x86_64` — emulator-only candidate

## Deliberate hard blocks

Q327 intentionally does not:

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

Reason: add a default-off source-package approval / ABI matrix lock envelope method only.

## Evidence requirements before Q328 binary bundle trial

Before any `.so`, `.jar`, `jniLibs`, `android/app/libs`, Gradle, or native loader mutation, the next phase must require:

- official Paddle Lite/PaddleOCR source package URL or self-compiled output path
- license marker
- per-file SHA256 for jar and each `.so`
- explicit ABI approval
- rollback plan
- fresh Flutter build/test logs after any binary package mutation

## Runtime status

`runtimeDependencyAdded=false`

`nativeLibraryBundled=false`

`jarBundled=false`

`jniLibsDirectoryCreated=false`

`runtimeStartupExecuted=false`

`realImageToLatexInferenceExecuted=false`

`ocrPassClaimed=false`
