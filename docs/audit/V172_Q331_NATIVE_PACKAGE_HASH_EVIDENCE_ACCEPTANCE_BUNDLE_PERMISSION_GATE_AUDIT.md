# V172-Q331 Native Package Hash Evidence Acceptance / Bundle Permission Gate Audit

## Phase

V172-Q331-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-BUNDLE-PERMISSION-GATE

## Scope

This phase records a default-off acceptance gate for Paddle Lite native package hash evidence before any binary bundle trial may occur.

Q331 does **not** add Paddle Lite binaries, JARs, AARs, `jniLibs`, Gradle changes, pubspec dependencies, Android manifest permissions, `System.loadLibrary`, a model loader, runtime startup, dummy execution, image-to-LaTeX inference, MathLive review, workspace import, OCR PASS, Android real-device PASS, store PASS, or release PASS.

## Native bridge envelope

Channel:

```text
mathpro/ocr_runtime_bridge
```

Method:

```text
nativePackageHashEvidenceAcceptance
```

Status:

```text
NATIVE_PACKAGE_HASH_EVIDENCE_ACCEPTANCE_BLOCKED_PENDING_USER_NATIVE_PACKAGE_HASH_EVIDENCE_DEFAULT_OFF
```

The method exists only as a blocked envelope. It records that per-file SHA256 evidence from Q328 is still required before any binary bundle permission can be granted.

## Required future evidence

External evidence policy:

```text
../MathProOcrNativePackages/Paddle_Lite_Android
```

Evidence JSON:

```text
q328_native_library_package_hash_evidence.json
```

Required files:

```text
PaddlePredictor.jar
arm64-v8a/libpaddle_lite_jni.so
armeabi-v7a/libpaddle_lite_jni.so
```

Optional emulator file:

```text
x86_64/libpaddle_lite_jni.so
```

## Protected file disclosure

Q331 intentionally modifies:

```text
android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt
```

Reason: add only the default-off `nativePackageHashEvidenceAcceptance` bridge method.

## Runtime boundary

All runtime execution remains blocked:

- no native package files are provided to the project
- no binary bundle permission is granted
- no runtime dependency is added
- no model loader is available
- no runtime startup is attempted
- no image-to-LaTeX inference is attempted
- no OCR result is produced
- no MathLive review opens
- no workspace import happens

## Verification

Verifier:

```text
tool/verify_native_package_hash_evidence_acceptance_bundle_permission_gate_v172_q331.mjs
```

Flutter/Dart/Android SDK were not available in the assistant environment, so Flutter analyze/test/run PASS is not claimed by this package.
