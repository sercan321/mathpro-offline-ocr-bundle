# Q389R6P — Flutter Test Final Hotfix

This package follows Q389R6O after user-side evidence showed:

- `flutter analyze` completed with `No issues found!`.
- `flutter test` had one remaining failing test: `graph_history_regression_test.dart`, graph settings Apply test.

## Surgical change

The graph settings regression test no longer uses `tester.tap()` on the bottom-sheet Apply widget. Flutter's widget test hit testing was brittle because the button sits inside a scrollable/bottom-sheet layout. The test now directly invokes the `ElevatedButton.onPressed` callback while preserving the same assertions:

- invalid `xMin >= xMax` must reject and keep `applied == null`;
- valid viewport values must call `onApply` and produce the expected x/y window.

## Runtime surfaces intentionally untouched

- Graph settings runtime UI is untouched.
- Graph 2D/3D runtime code is untouched.
- MathLive bridge/runtime code is untouched.
- Keyboard layout/dispatch is untouched.
- OCR/Android native code is untouched.
- Solver/CAS is untouched.

## Evidence boundary

This package was produced in an environment without Flutter/Dart. It does not claim local `flutter analyze`, `flutter test`, `flutter build`, or device PASS. User-side Flutter evidence is required.
