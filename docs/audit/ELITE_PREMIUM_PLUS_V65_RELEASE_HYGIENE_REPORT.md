# MathPro V65 — Release Hygiene Report

## Package hygiene intent

The full package must exclude generated and temporary artifacts:

- `build/`
- `.dart_tool/`
- `.gradle/`
- `.idea/`
- `__pycache__/`
- `.pyc`
- `.pytest_cache/`

## Safety boundaries

V65 does not change:

- keyboard layout
- key positions
- tab order
- MORE / Ans / = / ↵ behavior
- long-press option lists
- solution panel layout or behavior
- solver/CAS/evaluator logic

## Required final validation

The package requires real Flutter validation on the user's machine. The assistant environment did not contain Flutter/Dart, so no runtime PASS is claimed.
