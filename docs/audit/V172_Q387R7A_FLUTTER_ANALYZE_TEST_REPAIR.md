# V172-Q387R7A — Flutter Analyze/Test Repair

This repair responds to user-side Flutter analyze/test evidence after the Q387R7 package.

Fixed items:

- `test/v172_q387r4_paddle_lite_nb_production_source_binding_test.dart` no longer uses a `const` input object around the local `placeholder` variable. This removes the `invalid_constant` analyzer error.
- `test/v172_q387_paddle_lite_nb_model_format_decision_gate_test.dart` now expects the stronger native guard condition that includes `q387R1NbArtifactReady` before `MobileConfig.setModelFromFile(.nb)` can be attempted.
- Q387R2/Q387R3/Q387R4 test fixtures use `const` declarations where the analyzer requested them.
- `GaussDeferredMathOcrModelManifest.sizeBytes` is non-nullable because the source policy value is a non-null `int`.

Scope preserved:

- No keyboard/Q382, MORE, long-press, MathLive caret, Graph, History, Solution/Solver, AndroidManifest, Gradle ABI, splash/startup, ONNX Runtime, or model-bundling behavior was changed.
- No OCR, camera, Flutter build, Android device, APK/AAB size, or real-device PASS is claimed by this repair.
