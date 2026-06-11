# V172-Q336 Changed Files

## Modified Files

- `assets/mathlive/manifest.json`
- `README.md`
- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
- selected Q313R1-Q335 successor-aware tests/verifiers

## Added Files

- `lib/features/camera/gauss_native_package_hash_evidence_capture_q328_json_intake_q336_policy.dart`
- `lib/features/camera/gauss_native_package_hash_evidence_capture_q328_json_intake_q336.dart`
- `test/v172_q336_native_package_hash_evidence_capture_q328_json_intake_test.dart`
- `tool/intake_q328_native_package_hash_evidence_v172_q336.mjs`
- `tool/verify_native_package_hash_evidence_capture_q328_json_intake_v172_q336.mjs`
- `docs/audit/V172_Q336_NATIVE_PACKAGE_HASH_EVIDENCE_CAPTURE_Q328_JSON_INTAKE_AUDIT.md`
- `docs/audit/V172_Q336_CHANGED_FILES.md`

## Protected Runtime Files Modified With Explicit Reason

- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
  - Reason: added the default-off `nativePackageHashEvidenceCaptureQ328JsonIntake` bridge envelope method.
  - Runtime impact: no native binary load, no Paddle Lite instantiation, no model load, no OCR inference, no workspace import.

## Protected Runtime Files Not Modified

- `pubspec.yaml`
- `android/app/src/main/AndroidManifest.xml`
- Gradle files
- keyboard layout/source files
- MORE/template tray
- long-press lists
- MathLive production bridge
- workspace panel
- camera capture shell runtime
- Graph/Solution/History/AppShell/main/splash/icon/solver surfaces

## Still Blocked

- `.so` bundle
- `.jar` bundle
- `.aar` bundle
- `jniLibs` creation
- `android/app/libs` creation
- Gradle/pubspec/AndroidManifest mutation
- `System.loadLibrary`
- Paddle Lite instantiation
- runtime startup
- image-to-LaTeX
- OCR PASS
