# V172-Q234R3 Graph Surface Color Hierarchy Flutter Log Final Hygiene Audit

Q234R3 responds to the user's Q234R2 log showing four remaining analyzer info items and one remaining Q222 widget-test failure. It is not a new graph rendering phase and does not rewrite the Q234 3D surface renderer.

Closed items:

- `long_press_popup.dart` line-157 analyzer info is closed with `const minLeft = edgeInset;` only.
- Q234 graph color hierarchy widget test constructors are made const.
- Q222 Graph Settings Apply interaction now uses `dragUntilVisible` against the sheet `SingleChildScrollView`, hardening the widget test after the Q234 color picker made the sheet taller.
- Q234R2 test/verifier expectations are updated from stale `scrollUntilVisible` wording to the actual Q234R3 hit-test hardened path.

Protected-file note: `lib/features/keyboard/long_press_popup.dart` is touched only for analyzer const cleanup. Long-press inventory/order, key layout, popup policy constants, anchor behavior, input routing, MORE, MathLive, Workspace, Graph renderer, Solution, History, AppShell, and Android startup behavior are not changed.

No Flutter analyze/test/run or Android visual PASS is claimed by this package; user-side rerun is required.
