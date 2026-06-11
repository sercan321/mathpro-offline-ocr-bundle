# MathPro V78 — Manual Device Test Protocol

Run on the target Android device after `flutter run -d 23106RN0DA`.

## Series linked placeholder tests
1. Open the Taylor series template.
2. Fill the first variable slot with `x`; all visible Taylor `x` slots should fill together.
3. Fill the first remaining index/order slot with `n`; all visible Taylor `n` / order / factorial / exponent slots should fill together.
4. Fill the first center slot with `a`; all Taylor center slots should fill together.
5. Repeat for Binom: fill `x`, `α`, and `n`; each group should propagate.
6. Repeat for Geometrik: fill `n`, `a`, and `r`; both sides of the formula should update.
7. Verify the formula remains mathematical, not `Taylor(□)` / `Binom(□)` text.

## Regression checks
- Long-press visual consistency from V76 remains intact.
- Fraction and absolute-value long-press remain disabled.
- Factorial long-press remains only `□C□` and `□P□`.
- Solution Steps panel remains unchanged.
- Keyboard layout and tab order remain unchanged.
