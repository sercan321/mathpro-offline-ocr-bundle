# Premium Keyboard V19 Release Hygiene Report

Clean ZIP hygiene target:

- No `build/`
- No `.dart_tool/`
- No `.gradle/`
- No `.idea/`
- No `__pycache__/`
- No `.pyc`
- No `.pytest_cache/`
- No temporary editor files

The final ZIP was produced from the cleaned project tree and verified with `zip -T`.
