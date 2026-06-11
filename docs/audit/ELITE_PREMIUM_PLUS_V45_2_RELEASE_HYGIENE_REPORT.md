# MathPro V45.2 — Release Hygiene Report

## Package policy

Full clean project zip only. No patch-only delivery.

## Exclusion policy

The release package must not contain:

- `build/`
- `.dart_tool/`
- `.gradle/`
- `.idea/`
- `__pycache__/`
- `*.pyc`
- `.pytest_cache/`
- temporary repair folders

## Runtime truth

Flutter/Dart SDK was not available in the assistant container. No local Flutter PASS is claimed.

## Required target-machine validation

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```
