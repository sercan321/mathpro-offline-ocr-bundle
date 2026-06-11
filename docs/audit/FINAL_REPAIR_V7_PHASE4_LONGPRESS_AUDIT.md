# MathPro Final Repair V7 — Phase 4 Long-Press Popup Audit

## Scope
Phase 4 focused only on the long-press popup overlay and bounded integral popup rendering.

## Changed files
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/workspace/math_label.dart`
- `test/core_editor_regression_test.dart`
- `test/widget_test.dart`

## Protected files unchanged from V6
- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`

## Implemented behavior
- Long-press popup now uses a fixed premium panel envelope: min height 116, max height 126.
- Popup options render inside a stable horizontal overlay surface instead of relying on a tight shrinking list container.
- Popup chip height is locked to 88dp.
- Bounded integral `∫ₐᵇ` chip width is locked to 104dp.
- The `∫ₐᵇ` glyph itself was enlarged to 88x72 with a 52sp integral mark and larger limit boxes.
- The chip stack uses `clipBehavior: Clip.none` to reduce visual clipping risk.
- Integral long-press map remains unchanged from V6: `∫`, `∫ₐᵇ`, `∮`; the caller still filters the pressed key itself, so visible popup options are `∫ₐᵇ` and `∮`.
- `∬` is still not present in the integral long-press map.

## What was not changed
- Keyboard layout.
- Keyboard tabs.
- MORE / Ans / ↵ / = behavior.
- BottomDock size/inset logic from V6.
- MathKeyboard implementation.

## Test status
Flutter SDK is not available in this execution environment, so `flutter analyze`, `flutter test`, and `flutter run` were not executed here. PASS is not claimed.

## Required local verification
Run on the user's machine:

```powershell
flutter clean
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

## Manual checks
- Long-press `∫`.
- Verify visible options: `∫ₐᵇ` and `∮`.
- Verify `∫ₐᵇ` is not clipped.
- Verify `∬` is not visible.
- Verify popup does not push keyboard/workspace layout.
