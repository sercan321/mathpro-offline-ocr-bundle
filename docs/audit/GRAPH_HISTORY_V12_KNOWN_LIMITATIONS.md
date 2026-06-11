# Graph + Premium History V12 Known Limitations

- Flutter/Dart SDK was not available in the delivery environment, so analyzer, widget tests, and real-device run were not executed here.
- The graph evaluator is still a lightweight explicit-function evaluator, not a full symbolic/numeric CAS.
- Implicit graphs such as `x² + y² = 1` remain intentionally deferred to a future advanced graph mode.
- Pinch/pan/trace behavior must still be validated manually on the target Android device.
- History persistence must be validated with a real app close/reopen cycle on the device.
- V12 hardens regression tests and evidence; it is not a replacement for `flutter analyze`, `flutter test`, and `flutter run`.
