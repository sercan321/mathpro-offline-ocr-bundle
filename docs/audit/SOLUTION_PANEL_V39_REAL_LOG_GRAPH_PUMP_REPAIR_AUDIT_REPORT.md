# MathPro Solution Panel V39 — Real Log Graph/Pump Repair Audit

## Classification
Targeted repair package based on the user's V38 real Flutter log. This is not a new feature phase and does not expand the original seven-phase prompt.

## Real log trigger
The user's V38 run showed:
- `flutter analyze`: `No issues found`
- `flutter test`: failed with 2 failures
- First failure: `pumpAndSettle timed out` in `MathPro solution steps panel opens in-workspace without mutating keyboard or history`
- Second failure: `GraphPainter._drawAxes` threw `ArgumentError: Invalid argument(s): 16.0` while painting `mathpro-graph-surface` under very small height constraints (`h<=36.0`), then another `pumpAndSettle timed out`

## Repair scope
Changed runtime file:
- `lib/features/graph/graph_painter.dart`

Changed test file:
- `test/widget_test.dart`

Changed metadata:
- `pubspec.yaml`
- V39 audit docs

## Implementation summary
1. Added a defensive graph axis-label guard in `GraphPainter._drawAxes`:
   - If the plot area is too small for labels, graph still draws background/grid/axes/curve safely but skips non-compact labels.
   - Added `_clampAxisLabel(...)` to prevent `double.clamp` from receiving an inverted range when graph surface height is extremely small.
2. Replaced test-only `pumpAndSettle(...)` calls in the two real-log failing tests with deterministic fixed pumps:
   - This avoids waiting forever on unrelated repeating UI animations such as editor/caret shimmer while still allowing the 220–320ms solution-panel motion to settle.

## Protected surface status
No keyboard layout/config files were edited.
No graph card layout or graph model behavior was edited.
No history panel files were edited.
No solution panel UI content files were edited.
No app shell state contract was edited.
No three-dot menu behavior was added.
No solver/math engine was added.

## Honesty note
Flutter/Dart are not available in this execution environment, so no local `flutter analyze`, `flutter test`, or `flutter run` PASS is claimed. The user must rerun the Flutter commands on their machine.
