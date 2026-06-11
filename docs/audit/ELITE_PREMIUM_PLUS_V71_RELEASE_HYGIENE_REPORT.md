# MathPro V71 — Release Hygiene Report

## Hygiene rules

The release package must exclude:

- `build/`
- `.dart_tool/`
- `.gradle/`
- `.idea/`
- `__pycache__/`
- `*.pyc`
- `.pytest_cache/`
- temporary/interpreter artifacts

## Static status

Packaging script performs dirty-entry scan before final zip creation.

## Test truth

Flutter/Dart are not installed in the current environment. No local `flutter analyze`, `flutter test`, or `flutter run` PASS is claimed.
