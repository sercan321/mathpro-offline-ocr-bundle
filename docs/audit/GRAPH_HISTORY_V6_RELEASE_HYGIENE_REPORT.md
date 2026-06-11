# MathPro Graph / History V6 — Release Hygiene Report

## Package hygiene rule

The release package must not include build/cache/interpreter artifacts.

Forbidden paths scanned:

- `build/`
- `.dart_tool/`
- `.gradle/`
- `__pycache__/`
- `.pyc`
- `.pytest_cache/`
- temporary editor files

## Result

No forbidden build/cache artifacts were intentionally included in the V6 full ZIP.

## Runtime source checks

- No old crude `mathpro-history-handle` runtime surface was introduced.
- No runtime `onPressed: null` or `onTap: null` placeholders were found.
- No keyboard file was changed.

## Required local verification

Because Flutter/Dart are unavailable in the delivery environment, the release still requires local verification:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```
