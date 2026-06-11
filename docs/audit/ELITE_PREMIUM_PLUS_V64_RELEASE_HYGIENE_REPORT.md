# V64 Release Hygiene Report

Packaging excludes common generated/interpreter/build residue:

- `build/`
- `.dart_tool/`
- `.gradle/`
- `.idea/`
- `__pycache__/`
- `.pyc`
- `.pytest_cache/`

Full package zip and meta zip were created from a clean staging directory.
