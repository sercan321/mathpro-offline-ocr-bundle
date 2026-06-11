# MathPro Graph/History V2 Known Limitations

- The graph evaluator is still a lightweight explicit-function evaluator, not the final symbolic/numeric math engine.
- Implicit equations such as `x² + y² = 1` are deliberately classified as future advanced graph mode.
- Fullscreen pan works by drag gesture over the graph surface; there is not yet a dedicated multi-touch pinch-zoom engine.
- History persistence uses `shared_preferences`, appropriate for small local history. A future heavy history system can migrate to Hive/Isar/MMKV-like storage.
- The current package was statically repaired in an environment without Flutter/Dart CLI access, so device validation must be run locally.
