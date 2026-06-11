# V172-Q325 Changed Files

Phase: `V172-Q325-EXPLICIT-RUNTIME-DEPENDENCY-COORDINATE-SELECTION-BUILD-TRIAL-GATE`

## Added Files

- `lib/features/camera/gauss_runtime_dependency_coordinate_selection_build_trial_gate_q325_policy.dart`
- `lib/features/camera/gauss_runtime_dependency_coordinate_selection_build_trial_gate_q325.dart`
- `test/v172_q325_runtime_dependency_coordinate_selection_build_trial_gate_test.dart`
- `tool/verify_runtime_dependency_coordinate_selection_build_trial_gate_v172_q325.mjs`
- `docs/audit/V172_Q325_RUNTIME_DEPENDENCY_COORDINATE_SELECTION_BUILD_TRIAL_GATE_AUDIT.md`
- `docs/audit/V172_Q325_CHANGED_FILES.md`

## Modified Files

- `assets/mathlive/manifest.json`
- `README.md`
- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
- Q313R3-Q324 successor-aware tests/verifiers where needed.

## Protected Runtime File Intentionally Modified

- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`

Reason: added `runtimeDependencyCoordinateSelection` default-off bridge envelope method only. It records the explicit native runtime candidate and build-trial block without adding dependencies, native libraries, model loaders, runtime startup, dummy execution, or inference.

## Protected Runtime Files Not Modified

- `pubspec.yaml`
- `android/app/src/main/AndroidManifest.xml`
- Android Gradle files
- keyboard layout files
- MORE/template tray
- long-press lists
- MathLive production bridge/surface
- workspace panel
- camera capture shell
- Graph
- Solution
- History
- AppShell/main
- splash/icon
- solver/evaluator
