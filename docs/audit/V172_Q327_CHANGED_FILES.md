# V172-Q327 Changed Files

## Modified Files

- `assets/mathlive/manifest.json`
- `README.md`
- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
- `tool/verify_native_library_build_trial_approval_abi_packaging_preflight_v172_q326.mjs`
- `tool/verify_runtime_dependency_coordinate_selection_build_trial_gate_v172_q325.mjs`
- selected Q313R1–Q326 tests/verifiers for Q327 successor-awareness hygiene

## Added Files

- `lib/features/camera/gauss_native_library_source_package_approval_abi_matrix_lock_q327_policy.dart`
- `lib/features/camera/gauss_native_library_source_package_approval_abi_matrix_lock_q327.dart`
- `test/v172_q327_native_library_source_package_approval_abi_matrix_lock_test.dart`
- `tool/verify_native_library_source_package_approval_abi_matrix_lock_v172_q327.mjs`
- `docs/audit/V172_Q327_NATIVE_LIBRARY_SOURCE_PACKAGE_APPROVAL_ABI_MATRIX_LOCK_AUDIT.md`
- `docs/audit/V172_Q327_CHANGED_FILES.md`

## Protected Runtime File Intentionally Modified

- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`

Reason: Q327 adds only the default-off `nativeLibrarySourcePackageApproval` bridge envelope method for source-package and ABI matrix lock evidence. It does not call a runtime, does not load a library, and does not run inference.

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

Q327 does not add:

- `.so`
- `.aar`
- `.jar`
- `android/app/src/main/jniLibs`
- `android/app/libs`
- model binaries
- APK/AAB/build outputs

## Runtime Claims

No OCR, runtime, image-to-LaTeX, Android real-device, store, or release PASS is claimed in Q327.
