# V172-Q228R4 Solution Steps Premium Copy / Graph Settings Test Hygiene

Q228R4 is a test-contract micro repair after the user-side Q228R3 `flutter test` log showed one remaining failure in `graph_history_regression_test.dart` line 172.

## Change

- Replaced stale expectation for `ValueKey('mathpro-mini-graph-surface')` inside `GraphSettingsSheet` with the current settings-sheet contract key `ValueKey('mathpro-graph-settings-window-fields')`.

## Non-goals

- No runtime graph behavior change.
- No keyboard, MORE, long-press, MathLive, History, AppShell, Android startup, solver, or workspace behavior change.
- No claim of Flutter analyze/test/run PASS without user-side logs.
