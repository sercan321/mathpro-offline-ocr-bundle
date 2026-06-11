# MathPro V38 Real Log Layout Repair Audit Report

## Scope
Targeted repair after the user's V37 real Flutter log.
This is not a new feature phase. It only addresses the reported V37 failures:
- `flutter analyze` already passed with `No issues found`.
- `flutter test` failed with `+104 -3`.
- Main runtime failure: `RenderFlex overflowed by 124 pixels on the bottom` at `lib/features/workspace/workspace_panel.dart:229:20`.
- Test failure: solution panel remained mounted after close at `test/widget_test.dart:603`.
- Test failure: compact viewport expected `Lineer` even though the tab rail is horizontal/lazy.
- Test failure: graph + solution regression could not find `mathpro-solution-steps-button` because compact graph preview card height hid the action row.

## Runtime Changes
Changed only `lib/features/workspace/workspace_panel.dart`:
1. Removed the parent `AnimatedSwitcher`/`SizeTransition` wrapper around the solution panel mount slot.
2. Replaced it with deterministic conditional layout: card height + gap + solution panel height now sum inside the bounded workspace each frame.
3. Kept the panel's internal premium fade/slide/settle motion in `SolutionStepsPanel` intact.
4. Lowered compact card action visibility threshold from 124px to 96px so graph-preview compact layouts still keep top action icons mounted.
5. Removed now-unused private motion constants from `_WorkspaceMotion`.

## Test Changes
Changed only `test/widget_test.dart`:
1. Used `pumpAndSettle` after close actions so tests do not assert during route/app animation settling.
2. Removed the invalid compact-viewport expectation that the lazily mounted horizontal `Lineer` tab chip must always be visible at 390px width.
3. No keyboard expectations were changed for `MORE`, `Ans`, `↵`, or core visible tabs.

## Protected Areas
Not changed:
- `lib/features/keyboard/*`
- `lib/features/graph/graph_card.dart`
- `lib/features/history/history_panel.dart`
- `lib/app/app_shell.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/features/solution/solution_step_models.dart`

## Truth Status
Flutter/Dart is not available in the assistant container. No local `flutter analyze`, `flutter test`, or `flutter run` PASS is claimed.
