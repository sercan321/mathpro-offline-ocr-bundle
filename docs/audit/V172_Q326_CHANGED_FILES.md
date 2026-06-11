# V172 Q326 Changed Files

## Phase

V172-Q326-NATIVE-LIBRARY-BUILD-TRIAL-APPROVAL-ABI-PACKAGING-PREFLIGHT

## Modified Files

- `assets/mathlive/manifest.json`
- `README.md`
- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
- `test/v172_q321_dummy_input_runtime_call_test.dart`
- `test/v172_q322_first_image_to_latex_inference_envelope_test.dart`
- `test/v172_q323_runtime_dependency_model_loader_decision_test.dart`
- `test/v172_q324_approved_runtime_dependency_trial_test.dart`
- `test/v172_q325_runtime_dependency_coordinate_selection_build_trial_gate_test.dart`
- `tool/verify_dummy_input_runtime_call_v172_q321.mjs`
- `tool/verify_first_image_to_latex_inference_envelope_v172_q322.mjs`
- `tool/verify_runtime_dependency_model_loader_decision_v172_q323.mjs`
- `tool/verify_approved_runtime_dependency_trial_v172_q324.mjs`
- `tool/verify_runtime_dependency_coordinate_selection_build_trial_gate_v172_q325.mjs`

## Added Files

- `lib/features/camera/gauss_native_library_build_trial_approval_abi_packaging_preflight_q326_policy.dart`
- `lib/features/camera/gauss_native_library_build_trial_approval_abi_packaging_preflight_q326.dart`
- `test/v172_q326_native_library_build_trial_approval_abi_packaging_preflight_test.dart`
- `tool/verify_native_library_build_trial_approval_abi_packaging_preflight_v172_q326.mjs`
- `docs/audit/V172_Q326_NATIVE_LIBRARY_BUILD_TRIAL_APPROVAL_ABI_PACKAGING_PREFLIGHT_AUDIT.md`
- `docs/audit/V172_Q326_CHANGED_FILES.md`

## Protected Runtime File Intentionally Modified

- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`

Reason: add `nativeLibraryBuildTrialPreflight` default-off bridge envelope method only.

## Protected Runtime Files Not Modified

- `pubspec.yaml`
- `android/app/src/main/AndroidManifest.xml`
- Gradle files
- keyboard layout files
- MORE/template tray files
- long-press files
- MathLive production bridge files
- workspace panel
- camera capture shell
- Graph
- Solution
- History
- AppShell
- main.dart
- splash/icon assets
- solver/evaluator files

## Runtime/Binary Hygiene

Q326 does not add `.so`, `.aar`, `jniLibs`, model binaries, runtime dependencies, model loaders, runtime startup, dummy execution, image-to-LaTeX inference, MathLive review, or workspace import.
