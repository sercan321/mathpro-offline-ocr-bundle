# V172-Q329 Changed Files

## Modified Files

- `assets/mathlive/manifest.json`
- `README.md`
- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
- Q313R1–Q328 relevant successor-aware tests/verifiers where needed to accept Q329 as the active camera/OCR development phase.

## Added Files

- `lib/features/camera/gauss_native_package_hash_evidence_review_binary_bundle_approval_gate_q329_policy.dart`
- `lib/features/camera/gauss_native_package_hash_evidence_review_binary_bundle_approval_gate_q329.dart`
- `test/v172_q329_native_package_hash_evidence_review_binary_bundle_approval_gate_test.dart`
- `tool/verify_native_package_hash_evidence_review_binary_bundle_approval_gate_v172_q329.mjs`
- `docs/audit/V172_Q329_NATIVE_PACKAGE_HASH_EVIDENCE_REVIEW_BINARY_BUNDLE_APPROVAL_GATE_AUDIT.md`
- `docs/audit/V172_Q329_CHANGED_FILES.md`

## Protected Runtime File Intentionally Modified

- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`

Reason: add the default-off `nativePackageHashEvidenceReview` Android bridge envelope method only.

Runtime effect: no native library load, no Paddle Lite instantiation, no model loader, no runtime startup, no dummy execution, no image-to-LaTeX inference, no MathLive review, no workspace import, and no OCR PASS claim.

## Protected Runtime Files Not Modified

- `pubspec.yaml`
- `android/app/src/main/AndroidManifest.xml`
- Gradle files
- keyboard files
- MORE/template tray
- long-press files
- MathLive production bridge/surface files
- workspace panel
- camera capture shell
- Graph
- Solution
- History
- AppShell
- `lib/main.dart`
- splash/icon files
- solver/evaluator files

## Binary Hygiene

No `.so`, `.jar`, `.aar`, `jniLibs`, or `android/app/libs` package artifacts are added in Q329.
