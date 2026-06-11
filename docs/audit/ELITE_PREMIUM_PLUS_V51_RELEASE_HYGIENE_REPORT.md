# V51 Release Hygiene Report

## Package hygiene target

The V51 full zip must not include:

- `build/`
- `.dart_tool/`
- `.gradle/`
- `.idea/`
- `__pycache__/`
- `.pyc`
- `.pytest_cache/`
- temporary worktree outputs

## Verification note

Zip integrity and hygiene checks are performed from the packaging script. Flutter/Dart test execution is not available in this container.

## Required user-side commands

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```
