# V76 Release Hygiene Report

The release package excludes:

- `build/`
- `.dart_tool/`
- `.gradle/`
- `.idea/`
- `__pycache__/`
- `*.pyc`
- `.pytest_cache/`

Zip integrity is checked after packaging.
