# V172-Q228R2 — Solution Steps Premium Copy Analyzer/Test Hygiene Audit

Q228R2 is a micro repair after Q228R1 user logs showed `flutter analyze` failed on an unresolved `GraphExpressionEvaluator` reference in `graph_card.dart`, analyzer hygiene issues in the solution panel/settings/test files, and stale Q209/Q210 graph static test expectations.

## Runtime scope

- Solution copy/runtime behavior from Q228 is preserved.
- Q227 single-surface solution panel behavior is preserved.
- No keyboard, MORE, long-press, MathLive production editor/bridge, History, AppShell, Android startup, or solver/evaluator behavior is changed.
- Graph visual/runtime behavior is not redesigned; only a missing import and stale graph test markers were repaired.

## Changed runtime sources

- `lib/features/graph/graph_card.dart`: imports `graph_painter.dart` so `_GraphValueFormatter` can use `GraphExpressionEvaluator`.
- `lib/features/graph/graph_settings_sheet.dart`: const constructor hygiene for analyzer info cleanup.
- `lib/features/solution/solution_steps_panel.dart`: removed unused palette constants and const-folded the accent local.

## Changed tests/verifiers

- `test/v172_q209_real_3d_graph_surface_foundation_test.dart`: replaces stale Q209 markers with Q225-compatible mini-panel markers.
- `test/v172_q210_graph_3d_route_fullscreen_binding_test.dart`: replaces stale Q210 preview markers with Q225-compatible preview markers.
- `test/v172_q226_result_status_inside_result_panel_test.dart`: const-folds a test declaration.
- `tool/verify_solution_steps_premium_copy_test_hygiene_v172_q228r2.mjs`: Q228R2 static guard.
- Q227/Q228 verifiers accept the Q228R2 analyzer/test hygiene successor hashes for graph files.

## Honest limit

Flutter/Dart were unavailable in the assistant environment, so no assistant-side `flutter analyze`, `flutter test`, `flutter run`, Android, premium visual, or release PASS is claimed.
