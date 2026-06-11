# MathPro FINAL REPAIR V8 — Release Hygiene Report

## ZIP Hygiene

Excluded from release package:

- `build/`
- `.dart_tool/`
- `.gradle/`
- `__pycache__/`
- `.pyc`
- `.pytest_cache`
- temporary extraction folders

## Static Hygiene

```text
missing_dart_import_targets=0
dirty_cache_artifacts=0
runtime_history_shared_prefs_hits=0
```

## Flutter Command Evidence

Not run in this environment because Flutter/Dart SDK is unavailable.

Required user-side commands:

```powershell
flutter clean
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```
