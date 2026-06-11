# V158 Operator and Delimiter Render Node Migration Audit

## Scope

V158 migrates the remaining public primitive operator and delimiter labels out of plain text fallback rendering.

Migrated operator labels:

`+ − × ÷ % = < > ≤ ≥ ≠ ≈ ≡ ± ·`

Migrated delimiter labels:

`( ) [ ] , ;`

## Implementation Contract

- Operators parse to `MathNodeKind.operatorToken`.
- Delimiters parse to `MathNodeKind.delimiter`.
- Operator nodes carry `renderNode: OperatorNode`.
- Delimiter nodes carry `renderNode: DelimiterNode`.
- The frozen keyboard layout, key order, tab order, MORE label, long-press order, Graph, History, Solution, EditorViewport and EditorInteractionLayer remain untouched.

## Non-Scope

V158 does not redesign UI, move keys, change Graph/History/Solution, or claim physical device PASS.

## Required User-Side Verification

```bash
flutter clean
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

The assistant environment did not run Flutter; no Flutter PASS is claimed from this package alone.
