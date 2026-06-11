# V172-Q50 P6-Locked +95 Cursor Candidate Freeze Audit Report

## Outcome

CONDITIONAL PASS — Q50 freezes the P6-locked +95 cursor candidate matrix and evidence gates. It does not claim real-device +95 PASS.

## Active Package Identity

```yaml
description: MathPro Flutter phase 17 - V172-Q50 P6-locked +95 cursor candidate freeze.
version: 0.172.78+172
```

## Scope

Q50 is a release-candidate freeze phase on top of Q49. It does not add a new keyboard, MORE panel, long-press popup, app shell, Graph, History, Solution, solver, loupe, or visible slot overlay. It freezes:

- Q34-Q50 cursor lineage.
- Core cursor scenario matrix.
- Required 20 attempts / 19 correct per scenario threshold.
- Overall 0.95 success-rate gate.
- Real Flutter analyze/test and physical device QA evidence gates.
- P6 protected-file boundary.

## Protected UI Boundary

The following files must remain P6-locked and were not intentionally touched in Q50:

```text
lib/features/keyboard/key_config.dart
lib/features/keyboard/math_keyboard.dart
lib/features/keyboard/bottom_dock.dart
lib/features/keyboard/long_press_popup.dart
lib/features/keyboard/premium_key.dart
lib/features/workspace/math_label.dart
lib/features/workspace/template_tray.dart
lib/app/app_shell.dart
lib/features/solution/solution_steps_panel.dart
lib/features/graph/graph_card.dart
lib/features/history/history_controller.dart
lib/features/history/history_panel.dart
```

## Frozen Core Scenario Matrix

```text
√□
x^□
x_□
log_□(□)
9/6
12/345
123456789
cos(99666655)
sin(300)
ln(123456)
ln(ln(8))
sin(cos(300))
√(sin(x)+log₂(500))
sin(300)+cos(400)+log₂(500)+√(600)
```

## Evidence Rule

Q50 may be called a candidate freeze. It must not be called final +95 unless all of the following are present:

```text
`flutter analyze` successful user log
`flutter test` successful user log
flutter run -d 23106RN0DA real-device evidence
Pixel QA evidence across the frozen 14 scenarios
20 attempts per scenario
at least 19 correct selections per scenario
at least 0.95 overall success rate
```

## Honest Limit

The assistant environment did not provide Flutter/Dart execution. Therefore this package cannot honestly claim Flutter analyze/test/run PASS or real-device +95 PASS from assistant-side execution.
