# MathPro V78 — Release Hygiene Report

The release package must exclude:

- `build/`
- `.dart_tool/`
- `.gradle/`
- `.idea/`
- `__pycache__/`
- `*.pyc`
- `.pytest_cache/`

Flutter/Dart are not available in this environment, so runtime PASS is not claimed here.
