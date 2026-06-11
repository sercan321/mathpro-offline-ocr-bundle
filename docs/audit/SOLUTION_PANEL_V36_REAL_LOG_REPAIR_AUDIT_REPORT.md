# MathPro V36 — Real Log Repair Audit Report

## Scope
This package is a targeted repair after the user-provided real Flutter log for V35 showed analyzer issues and widget test failures.

## User log failures addressed
- `flutter analyze` reported 3 `prefer_const_constructors` infos in `test/widget_test.dart`.
- `flutter test` failed with repeated `RenderFlex overflowed ... workspace_panel.dart:229` errors.
- Solution panel tests failed because `mathpro-solution-steps-panel` was not mounted under constrained workspace heights.
- Phase 6 drag test failed because drag did not toggle expanded state reliably.
- Phase 7 regression test incorrectly expected visible text `Lineer Cebir`, while the locked bottom dock displays it as `Lineer`.

## Runtime changes
- `workspace_panel.dart`
  - Removed parent-level animated height mutation from `mathpro-question-answer-card-slot`; the slot now uses exact allocated height to prevent Flex overflow during workspace transitions.
  - Adjusted solution panel effective height calculation so a medium panel can mount when enough space exists, even if the ratio target is below the minimum medium height on short workspaces.
- `solution_steps_panel.dart`
  - Converted the panel to a StatefulWidget only to track one drag gesture safely.
  - Added distance-based drag commit plus low velocity fallback, preventing test/device drags from being ignored while avoiding repeated toggles in one gesture.

## Test changes
- Fixed the three const-constructor analyzer infos by making inline `SolutionStepsSnapshot` fixtures const.
- Corrected the Phase 7 keyboard label assertion from `Lineer Cebir` to visible label `Lineer` without touching keyboard runtime code.

## Protected areas
Unchanged compared with V35:
- keyboard config/layout/runtime files
- graph card runtime
- history panel runtime
- app shell runtime

## Honesty note
Flutter/Dart are not available in the assistant container, so no local `flutter analyze`, `flutter test`, or `flutter run` success is claimed. The package is a targeted source-level repair based on the real user log.
