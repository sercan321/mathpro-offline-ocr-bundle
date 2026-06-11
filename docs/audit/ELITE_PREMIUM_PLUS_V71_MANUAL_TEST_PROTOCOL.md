# MathPro V71 — Manual Test Protocol

Run on the real Android device after `flutter run -d 23106RN0DA`.

1. Long-press `x`; verify `x₁`, `x₂`, `x□` style options look tight and mathematical, not widely spaced.
2. Tap/long-press `√□`; verify square root, cube root, and editable-index root are rendered with a compact radical and close body slot.
3. In MORE > Trig, inspect `asin(□)`, `acos(□)`, `atan(□)`; they should visually read as `sin⁻¹(□)`, `cos⁻¹(□)`, `tan⁻¹(□)`.
4. In MORE/long-press log options, inspect `log₁₀(□)`, `log₂(□)`, `log□(□)`; log base should sit close to `log` and body slot should not be detached.
5. Insert inverse trig into workspace; rendered expression should not appear as raw `asin`/`acos`/`atan` plain text.
6. Re-run V69/V70 manual checks: long-expression pan, nested slot tap, atomic delete, operator replacement, visible `%`.
7. Confirm solution steps panel layout/content is unchanged.
8. Confirm keyboard key positions and tab order are unchanged.
