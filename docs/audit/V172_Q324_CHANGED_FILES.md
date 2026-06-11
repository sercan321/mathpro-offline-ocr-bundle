# V172-Q324 Changed Files

## Phase

`V172-Q324-APPROVED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG`

## Modified Files

- `assets/mathlive/manifest.json`
- `README.md`
- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
- Q313R1–Q323 successor-aware tests/verifiers as needed for Q324 active phase compatibility.

## Added Files

- `lib/features/camera/gauss_approved_runtime_dependency_trial_q324_policy.dart`
- `lib/features/camera/gauss_approved_runtime_dependency_trial_q324.dart`
- `test/v172_q324_approved_runtime_dependency_trial_test.dart`
- `tool/verify_approved_runtime_dependency_trial_v172_q324.mjs`
- `docs/audit/V172_Q324_APPROVED_RUNTIME_DEPENDENCY_TRIAL_AUDIT.md`
- `docs/audit/V172_Q324_CHANGED_FILES.md`

## Protected Runtime File Intentionally Modified

- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`

Reason: add default-off approved runtime dependency trial envelope method only.

Runtime impact: no runtime dependency is added, no model loader is added, no startup is executed, no dummy call is executed, no image-to-LaTeX inference is executed, no MathLive review is opened, and no workspace import occurs.

## Protected Runtime Files Not Modified

- `pubspec.yaml`
- `android/app/src/main/AndroidManifest.xml`
- Android Gradle files
- keyboard layout files
- MORE/template tray files
- long-press files
- MathLive production route and bridge files
- workspace runtime files
- camera capture shell
- Graph
- Solution
- History
- AppShell
- `lib/main.dart`
- splash/icon files
- solver/evaluator files

## Model Artifact Hygiene

No `inference.pdiparams`, PP-FormulaNet-S model archive, `MathProOcrArtifacts` folder, APK, AAB, build output, `.dart_tool`, `.gradle`, `node_modules`, or nested ZIP is included.
