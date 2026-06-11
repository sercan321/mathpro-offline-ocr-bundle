# V172-Q244R8 Changed Files

Functional Android build compatibility change:

- `android/settings.gradle`

Policy / test / verifier / audit / metadata:

- `lib/features/camera/gauss_camera_kotlin_metadata_compatibility_policy.dart`
- `test/v172_q244r8_camera_kotlin_metadata_compatibility_test.dart`
- `tool/verify_camera_kotlin_metadata_compatibility_v172_q244r8.mjs`
- `docs/audit/V172_Q244R8_CAMERA_KOTLIN_METADATA_COMPATIBILITY_AUDIT.md`
- `docs/audit/V172_Q244R8_CHANGED_FILES.md`
- `assets/mathlive/manifest.json`
- `README.md`
- `pubspec.yaml` comment metadata only

Successor-verifier hygiene so older camera compatibility verifiers accept the Q244R8 Kotlin 2.1.0 successor state instead of failing on the earlier Q244R4/Q244R5/Q244R6 Kotlin 1.9.22 assumption:

- `tool/verify_camera_precamerax_camera2_build_compatibility_v172_q244r6.mjs`
- `tool/verify_camera_android_camera2_published_version_hygiene_v172_q244r5.mjs`
- `tool/verify_camera_android_camera2_compatibility_v172_q244r4.mjs`
