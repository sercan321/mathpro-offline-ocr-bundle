# MathPro V36 — Release Hygiene Report

## Package hygiene target
Full project zip only. No patch-only delivery.

## Excluded artifacts
The release zip excludes common generated/cache folders and Python/interpreter residues:
- `build/`
- `.dart_tool/`
- `.gradle/`
- `.idea/`
- `.git/`
- `__pycache__/`
- `*.pyc`
- `.pytest_cache/`

## Runtime honesty
No local Flutter execution was possible in the assistant container. The user must verify on their machine:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```
