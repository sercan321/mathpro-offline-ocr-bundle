# ELITE_PREMIUM_PLUS V75 — Manual Device Test Protocol

Run:

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

## Visual / interaction checks

1. Long-press root, y, integral, limit, Σ, f(□), log, trig keys.
2. Confirm all long-press cards use consistent size, baseline, padding, and optical centering.
3. Cebir: tap the equation-system template; verify two-line system display.
4. Kalkülüs: tap limit template; verify `lim` with `x→□` underneath.
5. Σ long-press: verify `seri` card is absent and series labels are present.
6. Tap Taylor/Maclaurin/Binom; verify workspace receives mathematical formulas, never text-call labels.
7. Confirm solution steps panel was not visually or behaviorally changed.
8. Confirm keyboard positions, MORE, Ans, `=`, and `↵` remain stable.
