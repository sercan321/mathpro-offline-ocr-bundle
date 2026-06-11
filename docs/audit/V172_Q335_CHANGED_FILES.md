# V172-Q335 Changed Files

## Modified Files

- `assets/mathlive/manifest.json`
- `README.md`
- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
- Q313R1–Q334 selected tests/verifiers made Q335 successor-aware where needed.

## Added Files

- `lib/features/camera/gauss_native_package_hash_evidence_collection_user_side_native_package_intake_q335_policy.dart`
- `lib/features/camera/gauss_native_package_hash_evidence_collection_user_side_native_package_intake_q335.dart`
- `test/v172_q335_native_package_hash_evidence_collection_user_side_native_package_intake_test.dart`
- `tool/prepare_paddle_lite_native_package_intake_v172_q335.mjs`
- `tool/verify_native_package_hash_evidence_collection_user_side_native_package_intake_v172_q335.mjs`
- `docs/audit/V172_Q335_NATIVE_PACKAGE_HASH_EVIDENCE_COLLECTION_USER_SIDE_NATIVE_PACKAGE_INTAKE_AUDIT.md`
- `docs/audit/V172_Q335_CHANGED_FILES.md`

## Protected Runtime Files Not Modified

- `pubspec.yaml`
- `android/app/src/main/AndroidManifest.xml`
- Gradle files
- Keyboard/MORE/long-press files
- MathLive production bridge/surface
- Workspace, Graph, Solution, History, AppShell, splash, icon, solver/evaluator runtime files

## Protected Runtime File Intentionally Modified

- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`

Reason: add default-off `nativePackageHashEvidenceCollectionIntake` bridge envelope only. No binary, runtime, model loader, or OCR behavior was added.
