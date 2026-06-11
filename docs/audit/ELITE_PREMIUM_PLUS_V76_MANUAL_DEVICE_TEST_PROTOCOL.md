# V76 Manual Device Test Protocol

Run:

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

Manual UI checks:

1. Long-press `√□`: `√□`, `∛□`, `□√□` should appear optically consistent, not different scales.
2. Long-press `∫□dx`: `∫□dx`, `∫ₐᵇ`, `∬`, `∭`, `∮` should have consistent optical weight and should not be clipped.
3. Long-press `y`: `y′`, `y″`, `y‴`, `y⁽□⁾`, `dy/dx`, `d²y/dx²` should be centered and not shrink inconsistently.
4. Long-press `lim`: limit options should show professional compact limit notation and remain readable.
5. Long-press `sin/cos/tan`: direct, inverse, hyperbolic, inverse-hyperbolic variants should align consistently.
6. Long-press `Σ`: text labels such as Taylor/Maclaurin may remain text labels in the popup, but insertion must still produce mathematical formulas in the expression area.
7. Confirm no keyboard key moved and no solution steps panel behavior changed.
