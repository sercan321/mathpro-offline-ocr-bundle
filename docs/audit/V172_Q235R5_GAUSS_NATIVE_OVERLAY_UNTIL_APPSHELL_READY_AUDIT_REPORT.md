# V172-Q235R5 GAUSS Native Overlay Until AppShell Ready Audit Report

## Trigger
The user reported: small splash appears, then normal splash appears, then a dark screen appears, then the app opens.

## Root cause
Native splash and Flutter poster were not enough to cover the period where AppShell/PlatformView surfaces become visible. A native Android overlay above FlutterView is needed to cover all Flutter/PlatformView layers until AppShell is actually ready.

## Repair
- `MainActivity.kt` installs a full-screen native overlay using `gauss_splash_screen_native`.
- The overlay is above FlutterView and uses `FIT_CENTER`.
- Flutter sends `releaseNativeSplash` only after the AppShell child frame.
- Native overlay remains for at least 6500 ms and at most 14000 ms.
- Existing native splash background and Flutter poster behavior are preserved.

## Non-changes
Splash artwork content, launcher icon assets, keyboard, long-press, MORE, MathLive, Graph runtime, Workspace, Result panel, Solution, History, solver, AndroidManifest were not changed.

## PASS claims
No assistant-side Flutter analyze/test/run or real-device PASS is claimed.
