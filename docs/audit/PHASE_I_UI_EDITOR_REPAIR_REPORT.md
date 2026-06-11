# MathPro Phase I — UI / Editor Repair Report

## Scope
This package addresses the five user-reported issues after Phase H:

1. Expression/question workspace felt too narrow.
2. Expression should start from the center and expand outward instead of behaving like a left-starting text field.
3. Keyboard bottom edge must sit above the Android navigation bar without overlap.
4. Caret looked acceptable but could not be moved to arbitrary expression positions; caret baseline was slightly low.
5. Integral long-press popup should remove double integral; definite integral should present as a true upper/lower limit template.

## Changed implementation areas

- `lib/features/workspace/workspace_panel.dart`
  - Increased editor viewport allocation.
  - Reduced non-essential vertical compression around result/tray blocks.

- `lib/features/workspace/editor_viewport.dart`
  - Introduced centered canvas transform for the expression surface.
  - Added wider center-origin canvas for pan/zoom without making the first expression appear right-shifted.
  - Added linear caret rendering for filled expressions with no open slot.

- `lib/features/editor/render/editor_interaction_layer.dart`
  - Preserved slot hit-testing.
  - Added tap-to-linear-caret fallback when no slot is hit or no editable slot exists.

- `lib/features/editor/selection_controller.dart`
  - Added linear caret geometry and nearest insertion-point estimation.
  - Adjusted caret vertical baseline for both slot and plain expression caret.

- `lib/state/calculator_state.dart`
  - Added `linearCaretIndex` to represent caret position in filled expressions.

- `lib/state/calculator_controller.dart`
  - Added `selectTextCaret`.
  - Text/template insertion and backspace now respect linear caret position when no active slot is selected.

- `lib/features/keyboard/bottom_dock.dart`
  - Added Android navigation inset handling to keep keyboard above the nav/gesture bar.

- `lib/features/keyboard/key_config.dart`
  - Removed `∬` only from the integral long-press options as explicitly requested.
  - Did not change tab names, key locations, MORE, Ans, ↵, or = behavior.

- `lib/features/workspace/math_label.dart`
  - Added a compact bounded-integral glyph with upper/lower boxes for `∫ₐᵇ` key/chip rendering.

- `test/core_editor_regression_test.dart`
  - Added regression coverage for integral long-press contract and center-origin linear caret geometry.

## Red lines preserved

- Keyboard tab structure unchanged.
- Key grid order unchanged.
- MORE unchanged.
- Ans unchanged.
- ↵ remains evaluate/enter.
- = remains literal equality text insert.
- Long-press map changed only for the explicit integral request: `∬` removed from `∫` popup.
- No debug labels were added to user UI.

## Local verification status

This execution environment has no Flutter/Dart SDK, so I could not run:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

Static package checks performed here:

- ZIP hygiene check: no `build/`, `.dart_tool/`, `.gradle/`, `__pycache__/`, `.pyc`, `.pytest_cache` included.
- Source-level changed-file review completed.
- Internal debug/user-facing string grep reviewed.

## Required user-side verification

Run:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

Then manually check:

1. Expression area is visibly taller/wider.
2. First expression appears centered.
3. Long expressions remain center-origin and can be panned/zoomed.
4. Keyboard bottom row sits above Android navigation controls without overlap.
5. In filled expressions such as `tan(cos(ln(9)))`, tapping different horizontal positions moves the caret.
6. Caret no longer visually sags below the math baseline.
7. Integral long-press no longer shows `∬`.
8. Definite integral popup/key glyph shows upper/lower boxes and insertion remains `∫_{□}^{□}(□)d□`.
