# GRAPH / HISTORY V7 — Final Audit Report

## Decision
CONDITIONAL PASS for source packaging only.

This environment does not include Flutter/Dart, so runtime build gates remain unverified here. Do not treat this as final product PASS until `flutter pub get`, `flutter analyze`, `flutter test`, and device launch pass on the development machine.

## What changed

V7 focuses on the History Item System:

- Typed item system: `Hesap`, `Grafik`, `Hata`.
- Premium item card visual hierarchy: type badge, expression block, result/error line, metadata, actions.
- Graph history entries expose mini graph preview, range metadata and trace status.
- Error entries expose failure reason in a red premium error banner.
- Valid calculation results can be reused through `Sonucu kullan`.
- Long-press action sheet mirrors available item capabilities.
- Search and dedupe are now based on explicit item metadata rather than scattered expression/result checks.

## Preserved prior phases

- V3 graph painter hardening preserved.
- V4 fullscreen graph hardening preserved.
- V5 graph settings hardening preserved.
- V6 premium history drawer hardening preserved.
- Keyboard frozen-source hashes preserved.

## Keyboard contract

The following frozen files were not modified:

```text
lib/features/keyboard/key_config.dart
lib/features/keyboard/math_keyboard.dart
lib/features/keyboard/bottom_dock.dart
lib/features/keyboard/long_press_popup.dart
```

The known baseline SHA256 hashes remain:

```text
1f512b6d96a528a0363d00b2d9ac9006ca3f10e9892f7f2a10b513af1d380144  lib/features/keyboard/key_config.dart
f4f2a9acdc226cdc9838a265a96f2539a5b9ecf1f4feccd5fbb76745370b7ad2  lib/features/keyboard/math_keyboard.dart
e2063efc93b7b7470ba5940db8da1a49ded633cd8c31619f2659132c82d243a7  lib/features/keyboard/bottom_dock.dart
a7f7c8a0d2c6df9efa02cb984f9109f090992e944145f124d8c258059d3f7d75  lib/features/keyboard/long_press_popup.dart
```

## Manual verification required

Run on the user's Flutter environment:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

Then manually verify:

- History hidden on launch.
- History opens from icon / drag.
- Calculation item shows `Hesap` and `Sonucu kullan`.
- Graph item shows `Grafik`, mini preview, range metadata and `Grafiği Aç`.
- Error item shows `Hata` with red error banner.
- Long-press menu actions work.
- Keyboard layout and bottom docking remain unchanged.
