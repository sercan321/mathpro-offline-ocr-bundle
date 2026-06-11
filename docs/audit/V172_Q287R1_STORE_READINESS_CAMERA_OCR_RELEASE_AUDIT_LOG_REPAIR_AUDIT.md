# V172-Q287R1 — Store-Readiness Camera/OCR Release Audit Flutter Log Repair

## Scope

Q287R1 is a surgical repair phase created from the user's real `flutter analyze` and `flutter test` log after Q287.

It repairs only:

1. `test/v172_q277r3_camera_ocr_runtime_premium_regression_tap_latency_cadence_test.dart` malformed Q277R3 test string/parenthesis syntax.
2. `lib/features/mathlive/mathlive_production_editor_surface.dart` unused `_keepCaretVisible` analyzer warning by keeping the existing helper referenced on first MathLive production mount only.

## Protected Surface Disclosure

`lib/features/mathlive/mathlive_production_editor_surface.dart` is a protected file and was intentionally touched for analyzer hygiene. The change is restricted to first-runtime-mount caret visibility maintenance and does not add per-key latency work.

No keyboard layout, MORE/template tray, long-press list, Graph, Solution, History, AppShell, workspace, camera shell, Android manifest, MainActivity, splash/icon, solver, camera dependency, or Android toolchain behavior was changed.

## Runtime Boundary

Q287R1 does not add Paddle runtime, PaddleOCR dependency, JNI binding, native Android handler, MethodChannel runtime binding, PP-FormulaNet-S model binary, production model URL, production downloader, image-to-LaTeX inference, real workspace import runtime, Play Store submission, AAB/APK release build, OCR PASS, store-ready PASS, or release PASS.

## Required User Retest

The package still requires user-side:

```powershell
flutter analyze
flutter test
flutter run -d 23106RN0DA
```
