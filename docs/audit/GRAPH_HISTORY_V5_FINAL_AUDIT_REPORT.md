# MathPro Graph / History V5 — Final Audit Report

## Scope

Faz 5 hardens the Graph Settings Sheet after the V3 painter pass and V4 fullscreen graph pass.

The goal was not to alter the calculator surface or keyboard. The goal was to make graph settings real, validated, premium-looking, and connected to graph preview/fullscreen state without leaving dead UI.

## Completed work

### Graph Settings Sheet

- Reworked the sheet into a premium bottom sheet with:
  - compact live graph preview,
  - validated numeric fields for `x min`, `x max`, `y min`, `y max`,
  - preset chips for standard, trigonometric, positive-x, and constant-around viewports,
  - grid / axes / trace toggles,
  - curve color choices,
  - reset behavior,
  - user-facing error state for invalid values.

### Shared Viewport Policy

Added `GraphViewportPolicy` to avoid duplicated validation rules across preview and fullscreen graph paths.

It rejects:

- NaN / infinite values,
- reversed min/max values,
- too narrow viewports,
- too wide viewports,
- extremely large absolute values that would make labels and sampling unreadable.

### App Shell / Fullscreen Integration

- Preview graph settings now sanitize updates before applying.
- Fullscreen graph settings and gesture zoom/pan state now sanitize through the same policy.
- Preview zoom now sanitizes its generated viewport.

## Keyboard preservation

The following files were not modified:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`

Observed SHA256 values:

```text
1f512b6d96a528a0363d00b2d9ac9006ca3f10e9892f7f2a10b513af1d380144  lib/features/keyboard/key_config.dart
f4f2a9acdc226cdc9838a265a96f2539a5b9ecf1f4feccd5fbb76745370b7ad2  lib/features/keyboard/math_keyboard.dart
e2063efc93b7b7470ba5940db8da1a49ded633cd8c31619f2659132c82d243a7  lib/features/keyboard/bottom_dock.dart
a7f7c8a0d2c6df9efa02cb984f9109f090992e944145f124d8c258059d3f7d75  lib/features/keyboard/long_press_popup.dart
```

## Honest verification status

The delivery environment does not contain Flutter or Dart:

```text
flutter: command not found
dart: command not found
```

Therefore this package is not marked as analyzer/test/device PASS by the assistant. It requires local verification with:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

## Static outcome

Static checks performed in the delivery environment:

- V4 ZIP extracted successfully.
- Graph/history module presence confirmed.
- V3 Graph Painter changes remained present.
- V4 Fullscreen Graph changes remained present.
- Keyboard freeze hashes remained unchanged.
- Modified Dart files passed crude brace-balance verification.
- Runtime source scan found no `onPressed: null` or `onTap: null` callback stubs.
- Runtime source scan found no old `mathpro-history-handle` surface.
- Release ZIP was created without forbidden cache/build artifacts.
