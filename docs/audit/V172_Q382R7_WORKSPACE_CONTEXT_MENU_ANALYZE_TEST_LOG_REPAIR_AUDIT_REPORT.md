# V172-Q382R7 — Workspace Context Menu Analyze/Test Log Repair Audit

## Scope
Q382R7 is a surgical repair on top of Q382R6 based on user-side logs.

It fixes:
- `flutter analyze` warning in `gauss_camera_ocr_runtime_finalization_q381.dart` by removing an unnecessary cast.
- `flutter analyze` info in `workspace_math_action.dart` by removing the redundant `foundation.dart` import.
- `flutter analyze` info in `v172_q381_camera_ocr_runtime_finalization_test.dart` by removing the unnecessary local `final` function tear-off variable.
- Legacy Q355 test expectation around `OnnxTensor` / `runInference(` so later ONNX bridge phases remain successor-aware.
- Legacy Q378 OCR review text expectation so it accepts the current review-first no-auto-solve wording.
- Q382 unsupported-intent solution copy so stale/generic results remain suppressed and the test-visible message contains `sahte sonuç gösterilmiyor`.

## Non-goals
- No new solver engine.
- No fake factor/root/trig/calculus result.
- No keyboard/MORE/long-press edits.
- No MathLive production HTML/JS bridge asset edits.
- No Q381R1 OCR native bridge/runtime edits.
- No Graph/History/splash/icon/Gradle/pubspec/AndroidManifest edits.

## Honest boundary
Assistant-side Flutter/Android SDK is unavailable, so no assistant-side `flutter analyze`, `flutter test`, `flutter run`, Android real-device, or OCR PASS is claimed.
