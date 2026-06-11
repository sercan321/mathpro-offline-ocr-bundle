# V172-Q323 Changed Files

## Added Files

- `lib/features/camera/gauss_runtime_dependency_model_loader_decision_q323_policy.dart`
- `lib/features/camera/gauss_runtime_dependency_model_loader_decision_q323.dart`
- `test/v172_q323_runtime_dependency_model_loader_decision_test.dart`
- `tool/verify_runtime_dependency_model_loader_decision_v172_q323.mjs`
- `docs/audit/V172_Q323_RUNTIME_DEPENDENCY_MODEL_LOADER_DECISION_AUDIT.md`
- `docs/audit/V172_Q323_CHANGED_FILES.md`

## Modified Files

- `assets/mathlive/manifest.json`
- `README.md`
- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
- Successor-aware Q313R1–Q322 test/verifier metadata where needed.

## Protected Runtime File Intentionally Modified

- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`

Reason: add default-off runtime dependency/model loader decision envelope method only. No runtime dependency, model loader, startup, dummy call, image-to-LaTeX inference, MathLive review, workspace import, or OCR PASS claim was added.

## Protected Runtime Files Not Modified

- `pubspec.yaml`
- `android/app/src/main/AndroidManifest.xml`
- Gradle files
- Keyboard / MORE / long-press files
- MathLive production bridge
- Workspace panel
- Camera capture shell
- Graph / Solution / History
- AppShell / main.dart
- Splash / icon
