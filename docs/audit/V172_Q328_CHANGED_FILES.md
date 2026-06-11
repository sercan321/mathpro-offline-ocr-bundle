# V172-Q328 Changed Files

## Modified Files

- `assets/mathlive/manifest.json`
- `README.md`
- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
- selected Q314–Q327 tests/verifiers for Q328 successor-awareness hygiene

## Added Files

- `lib/features/camera/gauss_native_library_package_file_hash_intake_no_bundle_evidence_gate_q328_policy.dart`
- `lib/features/camera/gauss_native_library_package_file_hash_intake_no_bundle_evidence_gate_q328.dart`
- `test/v172_q328_native_library_package_file_hash_intake_no_bundle_evidence_gate_test.dart`
- `tool/capture_paddle_lite_native_package_hashes_v172_q328.mjs`
- `tool/verify_native_library_package_file_hash_intake_no_bundle_evidence_gate_v172_q328.mjs`
- `docs/audit/V172_Q328_NATIVE_LIBRARY_PACKAGE_FILE_HASH_INTAKE_NO_BUNDLE_EVIDENCE_GATE_AUDIT.md`
- `docs/audit/V172_Q328_CHANGED_FILES.md`

## Protected Runtime File Intentionally Modified

- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`

Reason: Q328 adds only the default-off `nativeLibraryPackageFileHashIntake` bridge envelope method for native package hash-evidence intake. It does not load a native library, does not bundle binary package files, does not start a runtime, and does not run inference.

## Protected Runtime Files Not Modified

- `pubspec.yaml`
- `android/app/src/main/AndroidManifest.xml`
- Android Gradle files
- keyboard layout/source files
- MORE/template tray
- long-press popup/source lists
- MathLive production editor route/bridge/surface
- workspace panel
- camera capture shell runtime
- Graph
- Solution
- History
- AppShell
- `lib/main.dart`
- splash/icon surfaces
- solver/evaluator

## Binary Package Hygiene

Q328 does not add:

- `.so`
- `.aar`
- `.jar`
- `android/app/src/main/jniLibs`
- `android/app/libs`
- model binaries
- APK/AAB/build outputs

## Hash Evidence Scope

Q328 adds `tool/capture_paddle_lite_native_package_hashes_v172_q328.mjs` so native package file hashes can be captured from an external folder:

`../MathProOcrNativePackages/Paddle_Lite_Android`

The evidence JSON is also written outside the project root and no binary package file is committed into the project ZIP.

## Runtime Claims

No OCR, runtime, image-to-LaTeX, Android real-device, store, or release PASS is claimed in Q328.
