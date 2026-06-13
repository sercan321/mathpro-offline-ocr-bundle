# Q389R6O — Flutter Test Remaining Hotfix

This package is a narrow repair after the user-side Q389R6N log.

Confirmed from the user log:
- `flutter analyze` reported `No issues found`.
- `flutter test` still failed in three places: graph settings Apply test hit-test handling, Q276 pubspec-wide OCR runtime marker guard, and Q277 pubspec-wide OCR runtime marker guard.

Changes:
- `test/graph_history_regression_test.dart` now targets the actual `ElevatedButton` with label `Apply`, not the outer keyed wrapper that missed hit testing in the widget harness.
- `pubspec.yaml` no longer contains stale OCR runtime audit wording that Q276/Q277 scan as forbidden runtime markers.
- `test/v172_q387r7d_paddle_lite_nb_flutter_test_legacy_successor_repair_test.dart` is updated so it no longer requires pubspec-level historical OCR runtime wording.
- `test/q389r6m_analyze_test_hardening_round2_contract_test.dart` is aligned with the corrected Apply-button tap strategy and pubspec-wide runtime marker policy.

Protected surfaces not touched:
- keyboard layout and dispatch
- MathLive command queue and cursor drag runtime
- Graph runtime UI behavior
- OCR runtime implementation
- Android native files
- Solver/CAS

Flutter analyze/test/build/run are not claimed by this package. User-side logs remain the source of truth.
