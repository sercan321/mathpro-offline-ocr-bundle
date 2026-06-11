# V172-Q235R3 GAUSS Native Splash Hard Binding Repair

## Trigger
The user reported repeated black startup/splash and no usable calculator after Q235R2. Static inspection showed Android native startup resources were still effectively black-only.

## Repair
- `launch_background.xml` now binds the full native splash bitmap.
- `values-v31/styles.xml` uses a branded non-transparent Android 12 splash icon.
- `NormalTheme` uses `@drawable/launch_background` during handoff.
- `MathProApp` boots directly to `MathProAppShell`, avoiding Flutter overlay blocking.

## Non-changes
Keyboard, long-press, MORE, MathLive, Graph runtime, Workspace, Result panel, Solution, History, solver, AndroidManifest, launcher icon assets, and splash artwork content were not changed.

## PASS claims
No assistant-side Flutter analyze/test/run or Android real-device PASS is claimed.
