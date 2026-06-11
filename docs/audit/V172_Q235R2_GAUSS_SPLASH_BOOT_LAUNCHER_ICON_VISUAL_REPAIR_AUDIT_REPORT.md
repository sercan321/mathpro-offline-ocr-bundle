# V172-Q235R2 GAUSS Splash Boot + Launcher Icon Visual Repair

## Trigger
The user reported that Q235R1 still showed a black splash/startup screen and the launcher icon looked over-zoomed/unreadable.

## Splash repair
- User-provided splash artwork remains the source.
- `BoxFit.contain` remains active.
- The splash no longer stacks over a simultaneously mounted `MathProAppShell`.
- `MathProAppShell` mounts only after the bounded splash timer completes.
- A visible GAUSS fallback is included if the splash image decode fails.
- No first-frame deferral was added.

## Launcher icon repair
- User-provided icon reference is used directly for the launcher PNG route.
- `mipmap-anydpi-v26/ic_launcher.xml` and `ic_launcher_round.xml` were removed to avoid adaptive icon zoom/crop behavior.
- AndroidManifest still references `@mipmap/ic_launcher` and `@mipmap/ic_launcher_round`.

## Non-changes
Keyboard, long-press, MORE, MathLive, Graph runtime, Workspace, Result panel, Solution, History, solver, `main.dart`, AndroidManifest, and startup theme XMLs were not changed.

## PASS claims
No assistant-side Flutter analyze/test/run or real-device PASS is claimed.
