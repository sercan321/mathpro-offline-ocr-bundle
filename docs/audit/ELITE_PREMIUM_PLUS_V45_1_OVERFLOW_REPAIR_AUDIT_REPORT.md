# MathPro Elite Premium Plus V45.1 — Compact Tab Overflow Repair Audit Report

## Scope

V45.1 is a targeted real-device repair package. It responds to the user-provided screenshot showing:

```text
BOTTOM OVERFLOWED BY 1.8 PIXELS
```

The overflow appeared on the expanded Kalkülüs keyboard after the V45 Elite Premium Plus visual pass.

## Root Cause

The compact keyboard layout for very short Android screens grants the tab header slot a height of `26dp`.

V45's visible tab chip remained hard-coded to `28dp`:

```dart
height: 28,
```

On compact screens, the chip could therefore be taller than its allocated `SizedBox(height: layout.tabHeaderHeight)`, causing a small RenderFlex overflow close to the bottom of the dock.

## Repair

`BottomDock` now passes a calculated `chipHeight` from `_KeyboardLayout` to `_ShellTabs` and `_TabChip`.

The new rule is:

```dart
double get tabChipHeight => math.min(28.0, tabHeaderHeight);
```

This preserves the intended 28dp tab chip on normal/large devices, while compact 26dp tab headers use a 26dp chip and no longer overrun their slot.

## Product Law Preservation

The repair does **not** change:

- key order,
- tab order,
- long-press contracts,
- `MORE`,
- `Ans`,
- `=`,
- `↵`,
- graph/history behavior,
- solution panel behavior,
- parser/evaluator logic.

## Changed Runtime Files

- `lib/features/keyboard/bottom_dock.dart`

## Documentation / Version Files

- `pubspec.yaml`
- `README.md`
- `docs/audit/ELITE_PREMIUM_PLUS_V45_1_OVERFLOW_REPAIR_AUDIT_REPORT.md`
- `docs/audit/ELITE_PREMIUM_PLUS_V45_1_OVERFLOW_REPAIR_CHANGED_FILES_MANIFEST.md`
- `docs/audit/ELITE_PREMIUM_PLUS_V45_1_OVERFLOW_REPAIR_RELEASE_HYGIENE_REPORT.md`

## Test Status

Flutter/Dart are not installed in this packaging environment. No fake PASS is claimed.

Required user-side commands:

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```
