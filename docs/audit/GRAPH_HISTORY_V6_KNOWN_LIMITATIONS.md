# MathPro Graph / History V6 — Known Limitations

## Verification limitation

Flutter and Dart were not installed in the delivery environment, so analyzer/test/device gates were not executed here.

## History limitations

- History uses `shared_preferences`, suitable for small local history. Larger future history/search/sync should move to a structured store such as Hive/Isar/MMKV-like architecture.
- Swipe-to-delete is still not implemented; current deletion is available through long press actions and clear-all.
- The drawer close gesture is upward swipe. Further real-device testing is needed to fine-tune gesture competition with nested list scrolling on all Android devices.

## Graph limitations preserved from previous phases

- The graph evaluator is lightweight and explicit-function focused, not a full CAS.
- Implicit graphing such as `x² + y² = 1` remains deferred.
- Advanced graph analysis such as roots/minima/maxima labels remains future work.
