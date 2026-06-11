# MathPro V45.2 — Real Log Overflow + Long-Press Contract Repair Audit

## Input truth

The user provided a real Flutter test/run log after V45.1. The log still showed:

- `A RenderFlex overflowed by 1.8 pixels on the bottom.`
- Error location: `lib/features/keyboard/bottom_dock.dart:111`
- Locked profile failure: `layout should not overflow at Size(360.0, 740.0)`
- Long-press popup contract failures:
  - Expected bounded integral chip width `>= 104`
  - Actual `92.0`

## Repair scope

V45.2 is a targeted repair, not a feature phase.

Changed runtime files:

1. `lib/features/keyboard/bottom_dock.dart`
   - Added `layoutRoundingGuard = 3.0` when calculating available keyboard grid content height.
   - This reserves a tiny invisible sub-pixel safety gutter so the Column does not overflow by 1.8px on short/locked profiles.
   - This does not change key topology, row order, tab order, or keyboard semantics.

2. `lib/features/keyboard/long_press_popup.dart`
   - Restored `LongPressPopup.boundedIntegralChipWidth` from `92.0` to `108.0`.
   - This satisfies the existing locked regression contract requiring `>= 104`.
   - It does not change long-press option contents.

3. `pubspec.yaml`
   - Version updated to `0.45.2+452`.

4. `README.md` and this audit documentation were updated.

## Frozen contract preservation

Not changed:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- key topology
- tab order
- long-press option source-of-truth
- `MORE`
- `Ans`
- `=`
- `↵`

## Local validation status

Flutter/Dart SDK was not available in the assistant container. Therefore no local `flutter analyze`, `flutter test`, or `flutter run` PASS is claimed.

Container-only checks performed:

- zip integrity check
- package hygiene check
- critical file hash check
- source diff inspection

## User-side required commands

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```
