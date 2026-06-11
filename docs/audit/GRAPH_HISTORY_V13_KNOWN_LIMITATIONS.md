# GRAPH_HISTORY_V13 — Known Limitations

This package is a Graph + Premium History closure package, not a full symbolic math engine release.

Known limitations:

1. Flutter/Dart commands were not run in the delivery environment because the SDK is not installed.
2. Real-device Android navigation bar / gesture / overflow checks still require `flutter run -d 23106RN0DA`.
3. Graph evaluator remains a lightweight explicit-function evaluator, not a full CAS.
4. Implicit graphs such as `x² + y² = 1` remain deferred to advanced graph mode.
5. Pinch zoom and pan are implemented for fullscreen graph, but real-device gesture feel still needs physical validation.
6. History persistence uses `shared_preferences` as a conscious V9 product decision; future storage may migrate to Hive/Isar/MMKV-style storage if history data grows.

No known limitation changes the frozen keyboard contract.
