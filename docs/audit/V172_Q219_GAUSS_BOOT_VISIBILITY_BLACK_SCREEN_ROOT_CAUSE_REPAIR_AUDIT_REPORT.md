# V172-Q219 GAUSS Boot Visibility / Black Screen Root-Cause Repair

## Scope
Q219 responds to the real-device report that Q218 still showed only a black screen. This is not a splash visual-polish phase. The active Flutter splash overlay is disabled from the production boot route so the app boots directly into `MathProAppShell` and the next real-device run can prove whether the remaining black screen is splash-related or AppShell/MathLive/WebView/runtime-related.

## Changes
- `lib/app/mathpro_app.dart`: removed active `GaussStartupSplash` wrapper and booted directly into `MathProAppShell`.
- Added Q219 policy, test, and verifier.
- Updated splash verifier/test contracts to accept Q219 as the active boot-visibility successor.
- Android native splash remains safe dark/background-only; Android 12+ icon slot does not use the full GAUSS bitmap.

## Non-changes
Launcher icon, supplied splash artwork, keyboard, MORE, long-press, Graph runtime behavior, History, Solution, MathLive production editor/bridge, solver, cursor, and app shell implementation were not changed.

## Evidence status
Static verifier/fresh-extract only. Flutter analyze/test/run and Android real-device PASS are not claimed by the assistant.
