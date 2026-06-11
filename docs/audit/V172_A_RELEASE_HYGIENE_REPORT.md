# V172-A Release Hygiene Report

## Package Hygiene Targets

The final ZIP must exclude generated/interpreter/build residue, including:

- `build/`
- `.dart_tool/`
- `.gradle/`
- `.idea/`
- `__pycache__/`
- `.pyc`
- `.pytest_cache/`
- temporary log/output files
- nested old ZIP/APK/AAB files

## Verification Notes

This environment does not include Flutter or Dart, so no local `flutter analyze`, `flutter test`, or `flutter run` PASS is claimed.

Required user-side verification:

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

## Contract Preservation

V172-A preserves the locked keyboard, MORE, long-press ordering, Graph, History and Solution contracts. The package contains a focused cursor visibility repair, not a solver or full cursor-engine completion claim.
