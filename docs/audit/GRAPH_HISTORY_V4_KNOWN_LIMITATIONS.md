# Graph / Premium History V4 — Known Limitations

- Flutter/Dart SDK was not available in the delivery environment; `flutter analyze`, `flutter test`, and `flutter run` must be executed on the user's Flutter machine.
- The graph evaluator is still a lightweight explicit-function evaluator, not a full CAS or symbolic engine.
- Implicit graphing such as `x² + y² = 1` remains intentionally deferred.
- Fullscreen supports gesture pan, pinch zoom and button zoom, but advanced multi-curve tools, root/extrema markers and symbolic domain annotations are not yet implemented.
- History persistence uses `shared_preferences`, suitable for small local history. A heavier local database can be considered later if history becomes large.
