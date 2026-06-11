# V172-K — Gesture Router Without Loupe Audit Report

## Scope

V172-K routes editor gestures without adding an editor loupe. The goal is to keep MathPro's cursor premium through direct tap precision rather than magnifier UI.

## Implemented

- Added `lib/features/formula_engine/editor_gesture_router_policy.dart`.
- Short expressions keep instant tap-down cursor placement.
- Long/navigable expressions use tap-up cursor placement so horizontal drags can pan without first moving the cursor.
- Drag caret updates remain enabled only when viewport navigation is not active.
- Transform-driven tap suppression is centralized through `EditorGestureRouterPolicy.transformTapSuppressionDuration()`.
- `EditorInteractionLayer` now accepts explicit `selectOnTapDown` / `selectOnTapUp` wiring.
- No editor long-press menu, editor loupe, Pay/Payda/Üs labels, or green slot overlay was added.

## Protected Contract

The following areas were not intentionally changed:

- Keyboard layout
- MORE behavior
- Ans behavior
- `=` equality symbol behavior
- `↵` evaluation/enter behavior
- Keyboard long-press maps and ordering
- Graph
- History
- Solution Steps panel

## Evidence

- `tool/verify_mathpro_contract.py` completed without hard failures.
- `paintVisibleSlotOverlay: true` was not found in `lib/`.
- `onLongPress`, `loupe`, `Payda`, and `paintVisibleSlotOverlay: true` were not found in `lib/features/editor/render/editor_interaction_layer.dart`.
- V172-K regression tests were added to `test/core_editor_regression_test.dart`.

## Limits

Flutter/Dart were not available in the assistant environment, so `flutter pub get`, `flutter analyze`, `flutter test`, and real-device `flutter run` were not executed here. This phase must be treated as conditional until the user runs the standard Flutter command block.
