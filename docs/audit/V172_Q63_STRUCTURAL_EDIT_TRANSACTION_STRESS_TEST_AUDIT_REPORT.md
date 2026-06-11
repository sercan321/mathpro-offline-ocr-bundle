# V172-Q63 Structural Edit Transaction Stress Test Audit Report

## Scope

Q63 adds an automated stress court for structural edit transactions after Q60 introduced the transaction normalizer and Q62 added synthetic tap intent coverage.

## Protected Surfaces

The following surfaces remain protected and out of scope:

- keyboard layout and key faces
- MORE tray
- long-press popup
- app shell
- MathLabel and template tray
- Solution, Graph and History

## Added Runtime/Test Contract

- `lib/features/formula_engine/structural_edit_transaction_stress_court_policy.dart`
- `test/v172_q63_structural_edit_transaction_stress_court_test.dart`

## Stress Court Rule

Each core transaction scenario is evaluated through repeated transaction-source variants. The expected result is 20/20 safe normalization for each scenario.

Forbidden final examples:

- `9/`
- `/6`
- `sin()`
- `cos()`
- `ln()`
- `log()`
- `√()`
- `³√()`
- broken integral differential endings such as `∫(9)d`

Expected restored examples:

- `9⁄□`
- `□⁄6`
- `sin(□)`
- `cos(□)`
- `ln(□)`
- `log(□)`
- `√(□)`
- `³√(□)`
- `∫(9)d□`

## Honest Limit

Q63 is still a static/automated stress-test phase. It does not prove real-device Photomath/Wolfram +95 behavior. Real-device checkpoint evidence is still required after the planned court phases.
