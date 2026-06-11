# V172-Q330 Changed Files

## Modified Files

- `assets/mathlive/manifest.json`
- `README.md`
- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
- `test/v172_q329_native_package_hash_evidence_review_binary_bundle_approval_gate_test.dart`
- `tool/verify_native_package_hash_evidence_review_binary_bundle_approval_gate_v172_q329.mjs`

## Added Files

- `lib/features/camera/gauss_binary_bundle_trial_jnilibs_paddlepredictor_default_off_q330_policy.dart`
- `lib/features/camera/gauss_binary_bundle_trial_jnilibs_paddlepredictor_default_off_q330.dart`
- `test/v172_q330_binary_bundle_trial_jnilibs_paddlepredictor_default_off_test.dart`
- `tool/verify_binary_bundle_trial_jnilibs_paddlepredictor_default_off_v172_q330.mjs`
- `docs/audit/V172_Q330_BINARY_BUNDLE_TRIAL_JNILIBS_PADDLEPREDICTOR_DEFAULT_OFF_AUDIT.md`
- `docs/audit/V172_Q330_CHANGED_FILES.md`

## Protected Runtime File Intentionally Modified

- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`

Reason: add the default-off `binaryBundleTrialDefaultOff` bridge envelope method only.

Runtime effect: no binary bundle, no `System.loadLibrary`, no Paddle Lite instantiation, no model loader, no runtime startup, no image-to-LaTeX, no MathLive review, no workspace import, and no OCR PASS.

## Protected Runtime Files Not Modified

- `pubspec.yaml`
- `android/app/src/main/AndroidManifest.xml`
- Gradle files
- keyboard layout/source
- MORE/template tray
- long-press lists
- MathLive production bridge
- workspace panel
- camera capture shell
- Graph
- Solution
- History
- AppShell
- splash/icon
- solver/evaluator
