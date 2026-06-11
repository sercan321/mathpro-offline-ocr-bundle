# V172-B Tap-to-Cursor Accuracy Audit Report

## Phase

V172-B — Tap-to-Cursor Accuracy v1 / single-argument function continuity.

## Baseline Rechecked

Before applying V172-B, the V172-A repair was rechecked in the extracted package:

- `lib/features/workspace/editor_caret_overlay.dart` exists.
- `lib/features/workspace/editor_viewport.dart` imports and mounts `EditorCaretOverlay` between `MathRenderSurface` and `EditorInteractionLayer`.
- The legacy green slot box path remains disabled for production; V172-B does not set `paintVisibleSlotOverlay=true`.
- Keyboard, MORE, long-press, Graph, History, and Solution panel runtime files were not edited in this phase.

## Runtime Change

Single open `functionArgument` slots now preserve typing inside the function parentheses after the first inserted character.

Example target behavior:

```text
sin(□)
3  -> sin(3|)
0  -> sin(30|)
0  -> sin(300|)
```

The cursor is represented as a linear caret immediately before the closing parenthesis after the first character is inserted. This is a deliberately narrow repair for V172-B and does not claim that the full CursorAnchor/LayoutBox engine is complete.

## Files Changed

- `lib/state/calculator_controller.dart`
- `lib/features/editor/selection_controller.dart`
- `test/core_editor_regression_test.dart`
- `README.md`
- `pubspec.yaml`
- `docs/audit/V172_B_TAP_TO_CURSOR_ACCURACY_AUDIT_REPORT.md`
- `docs/audit/V172_B_CHANGED_FILES_MANIFEST.md`
- `docs/audit/V172_B_SELF_CHECK_REPORT.md`

## Contract Preservation

V172-B does not change:

- keyboard layout
- key order
- tab order
- MORE categories
- long-press option order
- Graph runtime behavior
- History runtime behavior
- Solution panel behavior
- evaluator or solver scope

## New Regression Coverage

Added tests in `test/core_editor_regression_test.dart`:

- `MathPro V172-B keeps single-argument function typing inside parentheses`
- `MathPro V172-B resolves every visible digit gap in a filled function argument`

These tests are designed to catch the exact regression where `sin(□)` becomes `sin(3)|` instead of `sin(3|)` after the first input.

## Verification Limit

Flutter and Dart are not installed in this execution environment. No local `flutter analyze`, `flutter test`, or `flutter run` PASS is claimed here. The package must be verified on a Flutter-enabled machine using the commands listed in the README.
