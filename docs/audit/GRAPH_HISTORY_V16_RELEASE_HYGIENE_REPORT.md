# GRAPH_HISTORY_V16_RELEASE_HYGIENE_REPORT

Forbidden artifact scan target:
- `build/`
- `.dart_tool/`
- `.gradle/`
- `__pycache__/`
- `.pytest_cache/`
- `.pyc`
- temporary/interpreter artifacts

Result: no forbidden artifacts are intended to be packaged.

Runtime source change: none in V16.
