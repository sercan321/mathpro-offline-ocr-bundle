# V172-Q235R6R1 GAUSS Native Overlay Ready-Signal-Only Test Hygiene Audit Report

## Trigger
User-side `flutter test` failed because the stale Q235R5 test still expected `minNativeSplashVisibleMs = 6500L` and `maxNativeSplashVisibleMs = 14000L` in `MainActivity.kt`.

## Repair
- Updated `test/v172_q235r5_gauss_native_overlay_until_appshell_ready_test.dart` to accept Q235R6 successor behavior.
- Added a Q235R6R1 hygiene policy/test/verifier.
- Preserved Q235R6 runtime: no hard native splash timeout, release only via Flutter ready signal.

## Non-changes
No splash artwork, launcher icon, keyboard, long-press, MORE, MathLive, Graph runtime, Workspace, Solution, History, solver, AndroidManifest, or Q235R6 runtime `MainActivity.kt` behavior was changed.

## PASS claims
No assistant-side Flutter analyze/test/run or real-device PASS is claimed.
