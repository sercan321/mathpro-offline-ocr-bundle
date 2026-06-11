# MathPro V68 — Release Hygiene Report

The final package must exclude build outputs and interpreter/cache artifacts. Checked at packaging time: `build/`, `.dart_tool/`, `.gradle/`, `.idea/`, `__pycache__/`, `*.pyc`, `.pytest_cache/`.
