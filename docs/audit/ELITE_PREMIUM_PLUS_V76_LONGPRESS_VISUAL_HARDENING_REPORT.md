# MathPro Elite Premium Plus V76 — Long-Press Visual Consistency Hardening

## Scope
V76 is a targeted hardening pass on top of V75. It does not add solver/CAS behavior and does not change keyboard layout, tab order, solution panel behavior, MORE/Ans/=/↵ semantics, or graph/history logic.

## Target
The V74/V75 line introduced long-press visual normalization, but a deeper source audit found one remaining risk: mathematical long-press glyphs were still wrapped in a general `FittedBox`, which can scale simple glyphs such as `∫` and longer glyphs such as `d²/dx²(□)` differently. This could re-create the user-reported issue where long-press expressions appear at inconsistent optical sizes.

## Implementation
- Mathematical long-press options now render through `MathLabel` centered directly inside a fixed chip content box.
- `FittedBox` is reserved for plain text labels only and uses `BoxFit.scaleDown`, not upscaling.
- The `_mathishChipLabels` coverage list was expanded so every symbolic/template long-press option in `KeyConfig.longPressMap` uses the math chip renderer path.
- Added `test/v76_longpress_visual_consistency_test.dart` to statically lock this contract.

## Production files changed
- `lib/features/keyboard/long_press_popup.dart`
- `pubspec.yaml`

## Test/audit files changed
- `test/v76_longpress_visual_consistency_test.dart`
- `docs/audit/ELITE_PREMIUM_PLUS_V76_*`

## Locked behavior preserved
- No solution panel change.
- No solver/CAS added.
- No keyboard row/key position change.
- No tab order change.
- No long-press option cleanup beyond renderer coverage.
- No MORE/Ans/=/↵ behavior change.

## Runtime test status
Flutter/Dart are not available in the packaging environment, so no local `flutter analyze`, `flutter test`, or `flutter run` PASS is claimed.
