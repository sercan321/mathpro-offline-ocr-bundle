# V172 Q382R24R1 — Stale Test Expectation Repair

## Scope

This is a test-expectation repair over the Q382R24 keyboard latency closure candidate. It does not change production Flutter, MathLive JavaScript, keyboard layout, MORE/template tray, Graph, Solution, History, OCR/camera runtime, AndroidManifest, Gradle, or MainActivity behavior.

## Why

User-side `flutter test` reported `+1474 -3`. The visible failures were stale exact-string tests:

- `test/v172_q239a_workspace_camera_entry_button_test.dart` still expected `_openCameraCaptureShell(context)` even though the production camera route now passes `onApprovedLatexImport: onApprovedOcrWorkspaceImport`.
- `test/v172_q277r3_camera_ocr_runtime_premium_regression_tap_latency_cadence_test.dart` still expected an unconditional synthetic Dart `_emitState` echo even though Q382R24 suppresses it behind `MathLiveKeyboardLatencyClosureQ382R24Policy.syntheticDartEchoSuppressedForKeyboardCommands`.

## Modified

- `test/v172_q239a_workspace_camera_entry_button_test.dart`
- `test/v172_q277r3_camera_ocr_runtime_premium_regression_tap_latency_cadence_test.dart`
- `tool/verify_stale_test_expectation_repair_v172_q382r24r1.mjs`
- `docs/audit/V172_Q382R24R1_STALE_TEST_EXPECTATION_REPAIR.md`

## Explicitly Not Modified

- `lib/`
- `assets/mathlive/`
- `android/`
- keyboard layout/order/labels
- long-press inventories
- MORE/template tray
- Graph/Solution/History behavior
- OCR/camera runtime behavior
- MathLive production bridge behavior
- solver/evaluator semantics

## Honesty Boundary

This repair updates stale tests only. It does not claim `flutter test` success, `flutter analyze` success, real-device latency PASS, OCR PASS, or release PASS unless those commands are executed on a Flutter-capable environment and the logs are provided.
