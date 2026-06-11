# V172-Q235R7 Android 12 Small Splash Icon Elimination Audit Report

## Trigger
The user reported that the splash artwork first appears small, then appears normal/full-size. The remaining small→large transition is caused by Android 12+'s `windowSplashScreenAnimatedIcon` icon slot.

## Repair
- Restored Android 12+ `windowSplashScreenAnimatedIcon` to `@drawable/splash_transparent_icon`.
- Kept the full GAUSS artwork in the native overlay above FlutterView.
- Preserved Q235R6 ready-signal-only release: no max timeout and no timer-based forced hide.
- Updated stale tests that expected `@drawable/gauss_splash_v31_icon`.

## Non-changes
Splash artwork content, launcher icon assets, native overlay full artwork, keyboard, long-press, MORE, MathLive, Graph runtime, Workspace, Result panel, Solution, History, solver, AndroidManifest, and Q235R6 ready-signal-only release behavior were not changed.

## PASS claims
No assistant-side Flutter analyze/test/run or real-device PASS is claimed.
