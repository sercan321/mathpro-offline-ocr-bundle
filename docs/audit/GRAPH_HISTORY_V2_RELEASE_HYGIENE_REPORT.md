# MathPro Graph/History V2 Release Hygiene Report

## ZIP hygiene policy

Excluded from release archive:

- `build/`
- `.dart_tool/`
- `.gradle/`
- `.idea/`
- `__pycache__/`
- `*.pyc`
- `.pytest_cache/`
- temporary extraction folders

## Delivery shape

- Full project ZIP: complete Flutter project, not a patch.
- Meta ZIP: audit/report/test-manifest documents only.

## Honesty note

Flutter/Dart command execution was not possible in this container because both `flutter` and `dart` commands are unavailable. The package must be verified on the user's Flutter machine with the commands in `docs/audit/RUN_INSTRUCTIONS.md` or the final response.
