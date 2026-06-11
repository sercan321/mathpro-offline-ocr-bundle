# V172-Q221 Graph Mini Panel Layout Simplification Audit Report

## Scope

Q221 is a graph mini-panel UI simplification phase. It removes visible mini-panel clutter and makes the graph canvas the primary visual focus.

## Implemented

- Removed the mini-panel text action rail from `GraphCard`.
- Removed large visible Domain/Range pills from the mini-panel.
- Added compact bottom info row with x/y readout and window summary.
- Added floating canvas zoom controls.
- Added responsive/tight layout behavior so the graph preview scales into the available panel height instead of clipping.

## Not changed

Keyboard, MORE, long-press, MathLive production editor, History, Solution, splash/startup, launcher icon, AppShell, solver and Graph runtime semantics were not changed.

## Evidence boundary

Assistant-side Flutter/Dart is unavailable in this environment, so Flutter analyze/test/run and Android real-device PASS are not claimed.
