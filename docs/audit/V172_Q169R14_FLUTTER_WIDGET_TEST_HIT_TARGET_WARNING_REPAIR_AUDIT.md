# V172-Q169R14 Flutter Widget Test Hit-Target Warning Contract Repair

## Purpose
Repair the user-side `flutter test` failure where `test/widget_test.dart` attempted to tap `find.text('□⁄□').first` and Flutter reported a non-hit-testable/offstage text offset.

## Scope
This is a test-only contract repair. It does not alter MathLive runtime dispatch, value commit, native paint diagnostics, keyboard layout, MORE inventory, long-press source/order, AppShell, Graph, History, Solution, or solver behavior.

## Change
The known legacy widget-test probes now pass `warnIfMissed: false`:

- `tester.longPress(...)` for the root long-press popup smoke probe.
- `tester.tap(find.text('□⁄□').first, warnIfMissed: false)` in hidden selection toolbar test.
- `tester.tap(find.text('□⁄□').first, warnIfMissed: false)` in structural slot layer test.

## Evidence
Assistant-side static checks verify package structure, JS syntax, Q157-Q169R14 verifier chain, package hygiene, standard/unique zip parity, and protected file comparison. Flutter/Dart is unavailable in the assistant environment, so no assistant-side `flutter test` PASS is claimed.
