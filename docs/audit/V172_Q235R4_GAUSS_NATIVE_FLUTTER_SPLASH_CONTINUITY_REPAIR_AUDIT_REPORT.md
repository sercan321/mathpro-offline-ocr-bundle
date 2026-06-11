# V172-Q235R4 GAUSS Native-to-Flutter Splash Continuity Repair

## Trigger
The user reported that Q235R3 shows the splash for roughly half a second, then a dark screen appears again.

## Root cause
Native splash is now present, but Android removes it quickly. Without a Flutter-held poster bridge, the app can expose a dark frame while AppShell/PlatformView surfaces initialize.

## Repair
- Keep Q235R3 native splash hard binding.
- Restore Flutter `GaussStartupSplash(child: MathProAppShell())`.
- Increase splash poster duration to 2400 ms.
- Do not Stack AppShell behind the splash; AppShell mounts only after the splash poster completes.
- Keep `BoxFit.contain`; do not use `BoxFit.cover`.
- Keep visible GAUSS decode fallback.

## Non-changes
Keyboard, long-press, MORE, MathLive, Graph runtime, Workspace, Result panel, Solution, History, solver, AndroidManifest, launcher icon assets, and splash artwork content were not changed.

## PASS claims
No assistant-side Flutter analyze/test/run or Android real-device PASS is claimed.
