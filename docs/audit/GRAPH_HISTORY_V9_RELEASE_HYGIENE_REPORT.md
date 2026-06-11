# MathPro Graph / Premium History V9 — Release Hygiene Report

## Forbidden artifacts

The final package must not include:

- `build/`
- `.dart_tool/`
- `.gradle/`
- `__pycache__/`
- `.pyc`
- `.pytest_cache/`
- temporary extraction folders

## Packaging policy

- Full project ZIP is delivered.
- Meta/audit ZIP is delivered separately.
- No patch-only package is delivered.
- Keyboard-critical files are preserved.
