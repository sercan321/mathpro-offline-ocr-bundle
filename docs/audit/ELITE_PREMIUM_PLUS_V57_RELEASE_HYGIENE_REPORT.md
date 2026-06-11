# V57 Release Hygiene Report

## Packaging rule

Full clean project ZIP only. No patch-only package.

## Excluded from package

- `build/`
- `.dart_tool/`
- `.gradle/`
- `.idea/`
- `__pycache__/`
- `.pyc`
- `.pytest_cache/`
- temporary/interpreter artifacts

## Verification

Archive integrity and hygiene checks are performed after packaging. Flutter/Dart commands must be run on the user's machine because Flutter is not installed in this environment.
