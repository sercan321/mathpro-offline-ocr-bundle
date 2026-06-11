# MathPro V73 — Manual Device Test Protocol

Baseline package: `MathProFlutterPhase17_ELITE_PREMIUM_PLUS_V72_LONGPRESS_MORE_CLEANUP_FULL.zip`.
V73 runtime delta: none. V73 adds final audit/regression documentation only.

## Required local commands

Run these on the real Flutter machine/device before calling the build PASS:

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

## Manual UI/interaction checks

1. Width rail: workspace, solution panel, and keyboard must share the same outer width.
2. Long expression: enter a long numeric expression and pan left/right inside the expression area.
3. Nested expression: enter nested `ln(ln(ln(□)))`, nested roots, and fraction-like templates; pan and tap visible slots.
4. Slot tapping: every visible `□` in workspace must have a forgiving tap target, not a pixel-perfect target.
5. Atomic delete: insert `ln(□)`, `sin(□)`, `log(□)` and delete at template boundary; no `ln(`, `ln`, `l`, `si`, `s`, `lo`, or `l` remnants may remain.
6. Percent: tap `%`; a visible `%` must appear in the expression/render output.
7. Operators: tap `9 × +`; final expression must be `9 +`, not `9 × +`.
8. Inverse trig optics: `asin/acosh/atan` style options must appear as `sin⁻¹`, `cos⁻¹`, `tan⁻¹` / hyperbolic equivalents where applicable.
9. Log optics: `log₁₀(□)`, `log₂(□)`, and `log_□(□)` must render with close base alignment and tappable body/base slots.
10. Root optics: `√□`, `∛□`, and indexed root must look like math, with close root/body spacing.
11. Long-press cleanup: fraction must not open a long-press menu.
12. Long-press cleanup: absolute value must not open a long-press menu.
13. Factorial long-press must show only `□C□` and `□P□`.
14. Solution panel: existing panel behavior/layout must be unchanged.
15. Keyboard contract: no key positions, tab order, MORE, Ans, `=`, or `↵` behavior changed.

## Pass rule

V73 cannot be called runtime PASS until the local commands and real-device checks above are complete.
