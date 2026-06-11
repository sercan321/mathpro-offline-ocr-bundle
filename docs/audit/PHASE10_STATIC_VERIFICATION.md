# MathPro Flutter Phase 10 — Static Verification

## Checks performed in packaging environment

- Full package generated, not a patch package.
- ZIP açılabilirlik check must be performed after archive creation.
- Keyboard source files compared byte-for-byte against Phase 9.
- Relative Dart import paths checked by script.
- Package import drift checked for `mathpro_flutter_phase12`.
- P0 `legacy deriveSlotRects(size_param: ...)` regression checked.
- Stale user-facing `legacy Phase-3 evaluator` message checked in source code.
- Dirty ZIP paths checked: `build/`, `.dart_tool/`, `.gradle/`, `__pycache__`, `.pyc`, `.pytest_cache`.

## Runtime not performed

Flutter/Dart SDK was not available in the packaging environment. The following were not executed:

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

Runtime PASS requires these commands on a real machine.
