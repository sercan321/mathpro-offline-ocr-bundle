# V172 Q337 Changed Files

## Modified Files

- `assets/mathlive/manifest.json`
- `README.md`
- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
- selected successor-aware tests/verifiers from Q313R1 through Q336

## Added Files

- `lib/features/camera/gauss_native_package_hash_evidence_acceptance_explicit_bundle_approval_gate_q337_policy.dart`
- `lib/features/camera/gauss_native_package_hash_evidence_acceptance_explicit_bundle_approval_gate_q337.dart`
- `test/v172_q337_native_package_hash_evidence_acceptance_explicit_bundle_approval_gate_test.dart`
- `tool/verify_native_package_hash_evidence_acceptance_explicit_bundle_approval_gate_v172_q337.mjs`
- `docs/audit/V172_Q337_NATIVE_PACKAGE_HASH_EVIDENCE_ACCEPTANCE_EXPLICIT_BUNDLE_APPROVAL_GATE_AUDIT.md`
- `docs/audit/V172_Q337_CHANGED_FILES.md`

## Protected Runtime Files Not Modified

- `pubspec.yaml`
- `android/app/src/main/AndroidManifest.xml`
- Gradle files
- keyboard layout / MORE / long-press files
- MathLive production bridge files
- workspace, graph, solution, history, splash, icon, solver/evaluator files

## Protected Runtime File Modified With Disclosure

- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
  - Reason: added `nativePackageHashEvidenceAcceptanceExplicitBundleApproval` default-off bridge envelope method.
  - Runtime scope: no native binary load, no Paddle Lite instantiate, no OCR inference.
