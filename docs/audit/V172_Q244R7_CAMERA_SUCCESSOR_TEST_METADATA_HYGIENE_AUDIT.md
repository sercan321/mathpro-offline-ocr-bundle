# V172-Q244R7 Camera Successor Test Metadata Hygiene Repair

## Scope
Q244R7 repairs user-side Flutter test failures caused by stale Q239/Q240/Q243 tests that still required `camera: 0.11.0` after Q244R6 correctly moved the Android build to the pre-CameraX `camera: 0.10.6` plus `camera_android: 0.10.9+3` line.

## Trigger
User-side `flutter test` failed because multiple stale tests expected only `camera: 0.11.0` even though the active build-compatible camera dependency is now `camera: 0.10.6`.

## Runtime impact
No camera runtime behavior was changed. No pubspec, AndroidManifest, Android Gradle, Kotlin, keyboard, MORE, long-press, MathLive production, Graph, Solution, History, splash, or launcher icon behavior was changed.

## Safety
OCR runtime remains absent. Camera output still cannot directly solve, graph, write history, or import into the workspace without MathLive review gates.
