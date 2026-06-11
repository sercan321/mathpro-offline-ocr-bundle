# MathPro V77 Manual Device Test Protocol

Run locally:

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

Manual checks:
1. Open Σ long-press and verify Taylor/Maclaurin/Geometrik/Binom/eˣ/sin/cos/ln/arctan series are still selectable.
2. Tap Taylor. The editor must show a mathematical series formula, not `Taylor(□)`.
3. Tap each visible `□` in the Taylor formula. Each visible box must be selectable.
4. Fill the first Taylor box. Focus should advance to the next visible series slot.
5. Repeat for Maclaurin, Binom, Geometrik, eˣ, sin, cos, ln, and arctan series.
6. Verify long expressions can still be panned/inspected from V69.
7. Verify solution panel was not visually changed.
8. Verify keyboard layout, MORE, Ans, `=`, and `↵` behavior remain unchanged.
