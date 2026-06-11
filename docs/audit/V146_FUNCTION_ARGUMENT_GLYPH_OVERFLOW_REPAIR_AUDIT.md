# V146 Function Argument Glyph Overflow Repair Audit

## Scope

V146 is a targeted repair for the real Flutter test log reporting repeated `A RenderFlex overflowed by 16 pixels on the right` exceptions from `lib/features/workspace/math_label.dart` around `_FunctionArgumentGlyph`.

The fix intentionally avoids keyboard layout, tab order, MORE, Ans, =, ↵, long-press ordering, Graph, History, Solution, EditorViewport, and EditorInteractionLayer changes.

## Root Cause

`_FunctionArgumentGlyph` placed a natural-width `Row` directly inside a fixed compact box. In keycap/chip surfaces the parent constraint can be as small as 80x34. Function labels plus parentheses and slot boxes can naturally exceed that width, and Flutter reports a `RenderFlex` overflow before outer transforms/fitted layers can visually compensate.

## Repair

The glyph now keeps the fixed outer box dimensions but wraps the internal natural-width row in a local `FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.center)`. This keeps the mathematical function preview centered and premium while ensuring the row is scaled within its own compact bounds rather than overflowing horizontally.

## Preserved Contracts

- Keyboard positions unchanged.
- Tab order unchanged.
- MORE unchanged.
- Ans unchanged.
- `=` remains equality, not evaluation.
- `↵` remains evaluate/enter.
- Long-press order unchanged.
- Graph UI unchanged.
- History UI unchanged.
- Solution panel UI unchanged.
- EditorViewport layout unchanged.
- EditorInteractionLayer unchanged.
- MathJax SVG-only commit preserved with `enableAssistiveMml: false` and `math.replaceChildren(visualSvg)`.

## Validation Performed In This Environment

- Zip extraction inspected.
- Source-level repair applied only to `_FunctionArgumentGlyph` in `math_label.dart`.
- Metadata updated to V146.
- V146 audit docs and regression/source contract test added.
- Protected file hashes checked before and after; protected files remained byte-identical.
- Package hygiene checked for build/cache/interpreter artifacts.

## Not Claimed

Flutter was not available in this execution environment, so the following were not run here:

- `flutter pub get`
- `flutter analyze`
- `flutter test`
- `flutter run -d 23106RN0DA`

No Flutter PASS is claimed by this audit file.
