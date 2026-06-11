# MathPro V61 — Release Hygiene Report

## Package hygiene target
The release ZIP must exclude generated and transient artifacts:
- `build/`
- `.dart_tool/`
- `.gradle/`
- `.idea/`
- `__pycache__/`
- `.pyc`
- `.pytest_cache/`

## Local assistant limitation
Flutter/Dart SDK is not installed in the assistant container, so no local `flutter analyze`, `flutter test`, or `flutter run` PASS is claimed.

## Required user-side validation
```bash
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```
