# MathPro V65 — Local Verification Protocol

Run:

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

Manual editor interaction checks:

1. Create or insert `9□ = □; □ = □`.
2. Tap all four `□` boxes 10 times each.
3. Fill the first box and confirm focus advances to the next open box.
4. Create `d/dx(88□)` and tap the remaining `□` 10 times.
5. Type `8955` and move cursor to `8|955`, `89|55`, `895|5`, and `8955|`.
6. Confirm no solution panel visual/layout behavior changed.
7. Confirm keyboard layout, tabs, MORE, Ans, `=`, `↵`, and long-press lists are unchanged.

Pass target: at least 9/10 correct attempts per scenario and no compile/analyze/test blockers.
