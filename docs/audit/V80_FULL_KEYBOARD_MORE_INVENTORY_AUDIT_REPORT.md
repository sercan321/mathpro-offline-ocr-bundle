# MathPro V80 — Full Keyboard + MORE Inventory Audit

## Scope

This phase does not add a solver. It hardens the UI/input layer so visible math tokens are routed through a single audit surface before later engine migration phases.

Inspected public surfaces:

- all visible keyboard labels from every tab
- all long-press map keys and options
- all MORE panel categories and chips
- template insertion expressions
- high-risk display/internal-token boundaries for log, trig, subscript, power, matrix/vector, and calculus templates

## Non-negotiable preserved contracts

- Tab order is unchanged: `Temel`, `Cebir`, `Kalkülüs`, `Kompleks`, `Lineer Cebir`
- Frozen basic core is unchanged: `C ⌫ % ÷ / 7 8 9 × / 4 5 6 − / 1 2 3 + / MORE 0 . Ans`
- `MORE` remains `MORE`
- `Ans` remains the bottom-right base-tab answer key
- `↵` remains evaluate
- `=` remains equality input
- Root long-press remains `['√□', '∛□', '□√□']`
- Integral long-press remains `['∫□dx', '∫ₐᵇ', '∬', '∭', '∮']`

## Real fixes in this phase

1. Added `MathKeyInventory` as a central static audit surface for keyboard/long-press/MORE labels.
2. Added a regression test suite for full public-label inventory and public programmer-token leakage.
3. Cleaned MORE trig labels so visible options use mathematical notation:
   - `cot(□)`
   - `cot⁻¹(□)`
   - `coth(□)`
   - `sec(□)`
   - `csc(□)`
4. Kept legacy aliases such as `acot`/`acot(□)` internally supported but removed them from the public MORE UI surface.
5. Added parser/serializer support for `cot`, `cot⁻¹`, `sec`, `csc`, and `coth` function templates.
6. Repaired power long-press insertions so `□²`, `□³`, and `□ⁿ` route through power templates with editable/structural slots instead of raw postfix-only text.
7. Added high-risk parse checks for subscript, log-base, inverse trig, cot/sec/csc, root, fraction, matrix, and vector templates.

## Current honest boundary

This is not the final Photomath/Wolfram-grade editor engine. It is the full inventory/audit gate and the next structural cleanup step. The remaining larger work is still the full node/layout/hit-test/cursor engine migration for every advanced family.

No local `flutter analyze`, `flutter test`, or `flutter run` result is claimed in this package because the assistant environment has no Flutter SDK.
