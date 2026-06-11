# MathPro Flutter Phase 3 — State Behavior Audit

## New behavior layer

Phase 3 adds a small Flutter state layer:

- `CalculatorState`
- `CalculatorAction`
- `CalculatorController`
- `KeyHandlers`
- `EvaluatorBridge`

## Key behavior rules

- `C`: clears expression and result while preserving last answer.
- `⌫`: removes the last inserted token.
- `Ans`: inserts the latest answer as visible text.
- `MORE`: toggles a lightweight template tray state.
- `=`: inserts literal `=` into the expression.
- `↵`: invokes Phase 3 basic evaluation.

## Evaluation scope

The legacy Phase-3 evaluator only supports finite numeric arithmetic with:

- digits
- decimal point
- parentheses
- `+`
- `−` / `-`
- `×`
- `÷`
- `%`

It does not evaluate symbolic math, functions, integrals, roots, matrices, vectors, or CAS expressions yet.

Unsupported expressions are not faked as successful calculations.
