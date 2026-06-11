# MathPro Premium Keyboard V28 — Release Hygiene Report

## Package type

Full project ZIP, not patch-only.

## Excluded dirty artifacts

The final ZIP excludes:

- `build/`
- `.dart_tool/`
- `.gradle/`
- `.idea/`
- `__pycache__/`
- `*.pyc`
- `.pytest_cache/`
- temporary work folders

## Integrity

ZIP integrity was checked after packaging.

## Flutter execution status

Flutter/Dart are not available in the assistant container. No local Flutter PASS is claimed. Required user-side commands:

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```
