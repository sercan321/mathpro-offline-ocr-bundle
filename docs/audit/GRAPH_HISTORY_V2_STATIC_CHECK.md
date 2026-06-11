# MathPro Graph/History V2 Static Check

## Environment limitation

This execution container does not include Flutter or Dart CLIs. Therefore the following commands could not be executed here:

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

No PASS is claimed for those commands.

## Performed checks

- Opened and inspected the provided full ZIP.
- Verified `lib/features/graph/` exists.
- Verified `lib/features/history/` exists.
- Verified old `mathpro-history-handle` runtime surface is not reintroduced.
- Verified keyboard source files were not modified in V2.
- Verified package hygiene excludes generated cache/build folders.
- Added regression tests for graph eligibility, graph evaluator, and history serialization.

## Keyboard freeze hashes after V2

The following files are unchanged from the loaded Graph/History V1 ZIP:

```text
1f512b6d96a528a0363d00b2d9ac9006ca3f10e9892f7f2a10b513af1d380144  lib/features/keyboard/key_config.dart
f4f2a9acdc226cdc9838a265a96f2539a5b9ecf1f4feccd5fbb76745370b7ad2  lib/features/keyboard/math_keyboard.dart
e2063efc93b7b7470ba5940db8da1a49ded633cd8c31619f2659132c82d243a7  lib/features/keyboard/bottom_dock.dart
a7f7c8a0d2c6df9efa02cb984f9109f090992e944145f124d8c258059d3f7d75  lib/features/keyboard/long_press_popup.dart
```
