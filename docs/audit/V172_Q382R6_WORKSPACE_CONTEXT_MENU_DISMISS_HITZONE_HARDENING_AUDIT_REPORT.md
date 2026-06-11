# V172-Q382R6 Workspace Context Menu Dismiss / Hit-Zone Hardening Audit

## Scope
Surgical repair over Q382R5. The phase addresses remaining workspace expression context-menu UX/runtime risks:

- Android back should dismiss the floating context-menu overlay before route navigation.
- Expression context-menu safe hit-zone should be easier to long-press on a real device while preserving MathLive caret/slot long-press behavior.
- Expression edits should clear selected-action / all-expression-target state deterministically with `setState`.
- Static/widget-contract tests and verifier markers should cover the new behavior.

## Implemented

- `WorkspaceExpressionContextMenu.show` now registers a `LocalHistoryEntry` for the overlay and removes the overlay through the existing remove-once guard.
- The safe hit-zone was increased from 38x30 to 54x38 and remains positioned in the non-MathLive expression utility zone.
- AppShell now uses `_clearWorkspaceContextStateForExpressionEdit()` on keyboard and MathLive expression-edit paths so chips clear with a rebuild instead of relying on a later snapshot rebuild.
- Q382R6 manifest, policy, tests, verifier, README, and audit documents were added.

## Preserved

- Unproven solver-backed math intents remain disabled.
- Unsupported actions do not produce fake results.
- Q381R1 OCR review-first / explicit user approval / no direct auto Solve-Graph-Solution-History rules are unchanged.
- Keyboard, MORE/template tray, long-press, MathLive production assets, Graph, History, solver/evaluator, splash/icon, Gradle, pubspec, AndroidManifest, and native OCR code are untouched.

## Evidence boundary

Static verification only. Flutter/Dart/Android SDK was not available in the assistant environment, so this package does not claim `flutter analyze`, `flutter test`, `flutter run`, real-device context-menu PASS, or OCR PASS.
