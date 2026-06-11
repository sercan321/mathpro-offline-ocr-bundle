# MathPro V61 — Editor Slot / Cursor Precision Audit

## Scope
V61 is a focused UI/editor interaction repair. It does not add or expand the solution engine.

## User-reported issues targeted
- Structural placeholder boxes (`□`) were still difficult or impossible to tap in some expressions.
- The caret/cursor did not feel Photomath-grade and was hard to move to the intended position.
- Linear input text appeared visually above the caret/cursor in the expression surface.
- Solution area must remain untouched because the user has a separate plan for it.

## Runtime changes
- `lib/features/editor/render/editor_interaction_layer.dart`
  - Added drag-aware pointer handling for slot/caret updates.
  - Added linear placeholder fallback hit-testing, so visible `□` placeholders can be selected even when approximate structural geometry misses.
  - Added natural slot ordering for mapping expression placeholder order to registry entries.
- `lib/features/editor/selection_controller.dart`
  - Added public linear caret positions and placeholder index helpers.
  - Reduced structural snap radius so caret movement feels less sticky.
  - Adjusted inline caret center line to better match visible expression baseline.
- `lib/features/workspace/editor_viewport.dart`
  - Reduced vertical canvas mismatch.
  - Disabled editor panning for normal/slot expressions so drag gestures prioritize caret/slot precision.
  - Nudged math rendering to align with the caret line.
- `lib/features/formula_engine/slot_hit_testing.dart`
  - Increased nearest fallback radius for mobile slot selection.
- `lib/features/formula_engine/slot_interaction_calibration_policy.dart`
  - Increased function/placeholder target size and slop for easier tapping.

## Explicit non-goals
- No solution engine / CAS work.
- No changes to Solution Steps layout or behavior.
- No keyboard layout changes.
- No key position changes.
- No long-press option list changes.

## Verification required on user machine
Run:

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

Manual checks:
- Tap every `□` in `9□ = □; □ = □`.
- Drag caret across `8955` and verify precise placement.
- Tap inside `d/dx(88□)` and verify the argument slot can be selected.
- Confirm text and cursor share a coherent vertical line.
- Confirm Solution Steps panel remains visually unchanged.
