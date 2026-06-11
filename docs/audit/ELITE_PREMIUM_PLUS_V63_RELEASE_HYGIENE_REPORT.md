# V63 Release Hygiene Report

## Package hygiene rules
The full package excludes build/runtime/cache artifacts:

- `build/`
- `.dart_tool/`
- `.gradle/`
- `.idea/`
- `__pycache__/`
- `.pytest_cache/`
- `.pyc`

## Packaging status
Fresh extraction and ZIP integrity checks were performed in the packaging environment. No Flutter SDK was available, so runtime compilation was not claimed.

## Required local verification
Run on the development machine:

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```
