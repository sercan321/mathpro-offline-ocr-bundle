# Q389R6N — Analyze Compile Hotfix

This package repairs a real user-side analyzer regression introduced by Q389R6M.

## Real user-side failure repaired

`test/q389r6m_analyze_test_hardening_round2_contract_test.dart` accidentally used `$sign` and `$absN` inside a normal Dart string literal. Dart interpreted those tokens as undefined identifiers during `flutter analyze`.

Q389R6N converts those expectations to raw string literals so the test checks the source text literally without creating analyzer identifiers.

## Additional stale-contract repair

Q389R6M restored an ONNX historical audit marker but accidentally included the substring legacy inference runtime keyword in a pubspec comment. Several legacy OCR contract tests correctly reject that substring anywhere in `pubspec.yaml`.

Q389R6N keeps the harmless `ONNX` historical pivot marker but removes legacy inference runtime keyword from pubspec comments and keeps runtime dependencies unchanged.

## Protected surfaces

No keyboard layout, Dart keyboard dispatch, MathLive command queue, Android native, OCR runtime implementation, solver/CAS, or graph runtime UI behavior was changed.

Flutter analyze/test/build/run are not claimed by this package without user-side logs.
