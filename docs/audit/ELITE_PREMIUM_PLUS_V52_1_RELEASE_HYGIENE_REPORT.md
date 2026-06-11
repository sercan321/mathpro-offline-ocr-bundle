# MathPro V52.1 — Release Hygiene Report

## Package intent

V52.1 is a targeted repair for the real user-side compile/analyze log after V52.

## No-go files/directories

The release package must not include:

- `build/`
- `.dart_tool/`
- `.gradle/`
- `.idea/`
- `__pycache__/`
- `*.pyc`
- `.pytest_cache/`

## Verification statement

Zip integrity and hygiene are checked from the packaging environment. Flutter commands are not claimed because Flutter/Dart are unavailable in the packaging environment.

Required user-side commands:

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```
