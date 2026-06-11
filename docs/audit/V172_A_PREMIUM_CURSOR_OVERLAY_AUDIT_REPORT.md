# V172-A Premium Cursor Overlay Audit Report

## Scope

V172-A is the first controlled phase of the MathPro Premium Math Cursor Engine track. It repairs the visible cursor blocker without pretending that the full cursor engine is finished.

## Baseline Finding

The previous editor already computed an inline caret rectangle through `MathProCaretController.inlineCaretRectForExpression(...)`, but `EditorViewport` did not paint that caret. `EditorInteractionLayer` still contained an older `_SlotBox` / `_BlinkingSlotCaret` branch, but that path was intentionally disabled by `paintVisibleSlotOverlay = false` to avoid drawing legacy green focus boxes over the MathJax/WebView surface.

## Implementation

Added `EditorCaretOverlay` as a separate visual-only widget between `MathRenderSurface` and `EditorInteractionLayer`.

The new stack order is:

1. `MathRenderSurface` — visible MathJax/WebView math.
2. `EditorCaretOverlay` — thin blinking production caret only.
3. `EditorInteractionLayer` — hit testing and selection routing only.

## Guardrails

- Did not set `paintVisibleSlotOverlay=true`.
- Did not revive `_SlotBox` as production feedback.
- Did not change keyboard layout, key order, MORE, long-press ordering, Graph, History, Solution, or evaluator behavior.
- Did not claim full tap-to-cursor precision, long-press loupe, CursorAnchor, or renderer-sync completion.

## Added Regression Test

`test/widget_test.dart` now includes:

`MathPro V172-A paints a premium caret without reviving the green slot overlay`

The test asserts that the premium caret overlay/line exists for a linear caret state and that `mathpro-active-slot-highlight` is not present.

## Known Remaining Work

V172-A does not solve the full Premium Math Cursor Engine. Remaining phases must address:

- Tap-to-cursor accuracy for numbers and function arguments.
- Canonical `CursorAnchor` model.
- Fraction/power/subscript/log/root slot precision.
- Long expression pan plus auto-scroll.
- Structural deletion.
- Matrix/system/differential-equation cursor slots.
- Long-press loupe and drag cursor.
- Renderer geometry synchronization.

## Verification Status

Static package inspection was performed in this environment. Flutter/Dart SDK commands could not be executed here because `flutter` and `dart` are not installed in the container. The user must run:

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```
