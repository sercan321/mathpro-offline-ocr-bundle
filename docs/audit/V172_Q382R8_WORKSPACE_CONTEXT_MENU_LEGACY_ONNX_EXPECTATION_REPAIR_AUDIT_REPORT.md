# V172-Q382R8 Workspace Context Menu Legacy ONNX Expectation Repair Audit

Phase: `V172-Q382R8-WORKSPACE-CONTEXT-MENU-LEGACY-ONNX-EXPECTATION-REPAIR`

## Scope

This repair addresses user-side `flutter test` failures where legacy Q352/Q353/Q354 tests still rejected later ONNX bridge symbols in `MainActivity.kt` after the default-off Q357+ runtime bridge chain existed.

## What changed

- Q352 `OnnxTensor`, `pp_formulanet_s.onnx`, and `runInference(` expectations are now guarded by the existing Q357-or-later successor phase check.
- Q353 `OnnxTensor` expectation is now guarded by the existing Q357-or-later successor phase check.
- Q354 `OnnxTensor` expectation is now guarded by the existing Q357-or-later successor phase check.
- Q382 policy/test/manifest markers were added for this test-repair phase.

## What did not change

- No workspace context-menu runtime behavior changed.
- No keyboard/MORE/long-press behavior changed.
- No MathLive production HTML/JS bridge assets changed.
- No Q381R1 OCR native runtime/camera flow changed.
- No Graph/History/Solution panel behavior changed.
- No solver/evaluator engine changed.
- No Gradle/pubspec/AndroidManifest/splash/icon changes.
- No Flutter/Android/OCR PASS is claimed without user-side logs.
