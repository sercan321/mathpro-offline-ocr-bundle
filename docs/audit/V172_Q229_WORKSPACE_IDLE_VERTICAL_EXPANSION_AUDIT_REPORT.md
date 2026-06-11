# V172-Q229 Workspace Idle Vertical Expansion / Dead Gap Reclaim Audit

## Scope
- Reclaim normal/idle workspace vertical dead gap above the keyboard.
- Preserve keyboard, MathLive production editor, MORE/template tray, Solution Steps mechanics, Graph runtime, History, AppShell coordination, Android startup, and solver/evaluator behavior.

## Runtime source changes
- `lib/features/workspace/workspace_panel.dart`
  - Added `idleExpansion` scoped to `graphExpression == null && !templateTrayOpen && !showSolutionPanel`.
  - Added idle-only card height policy that fills the available card slot proportionally and removes the old idle max-348 cap only for normal/idle state.
  - Reduced idle vertical margins so the reclaimed space becomes workspace surface instead of a black band.
  - Increased idle result panel flex from 2 to 3 only when the idle card is tall enough.
- `lib/features/workspace/workspace_idle_vertical_expansion_policy.dart`
  - Guard-only policy documentation.

## Graph import hygiene
`lib/features/graph/graph_card.dart` was reviewed. The `graph_painter.dart` import is kept because `_GraphValueFormatter` uses `GraphExpressionEvaluator`; therefore it is not unused in this baseline.

## Explicit non-changes
Keyboard, MathLive production files, MORE/template tray, Solution Steps runtime/model files, Graph runtime files, History, AppShell, main.dart, Android startup/splash, and solver/evaluator logic were not changed.

## Honest boundary
Flutter/Dart are not available in the assistant container. No `flutter analyze`, `flutter test`, `flutter run`, Android device PASS, or visual PASS is claimed here.
