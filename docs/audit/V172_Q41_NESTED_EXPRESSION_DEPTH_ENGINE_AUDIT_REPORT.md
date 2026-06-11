# V172-Q41 Nested Expression Depth Engine Audit Report

Q41 keeps the P6 keyboard, key faces, MORE tray, long-press popup, app shell, MathLabel, Solution, Graph, and History surfaces locked. It only adds a nested-expression depth resolver to the existing cursor hit-test stack.

## Honest scope

- This is not a fake Photomath/Wolfram final PASS.
- This is not renderer-glyph identity mapping.
- The purpose is to prevent broad parent hit targets from stealing taps from deeper valid child slots in nested expressions.

## Target expressions

- `ln(ln(8))`
- `sin(cos(300))`
- `√(sin(x)+log₂(500))`

## P6 locked files

Keyboard, key faces, MORE, long-press, app shell, MathLabel, Solution, Graph, and History files must remain byte-identical to the P6 baseline.
