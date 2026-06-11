# Phase 2 Keyboard Behavior Audit

## React Native blueprint sources used

- `src/config/editorConfig.js`
- `src/components/BottomDock.js`
- `src/components/Controls.js`
- `src/components/PremiumKey.tsx`

## Flutter files carrying the Phase 2 behavior

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/services/haptics_service.dart`

## Preserved behavior decisions

- Long-press availability is driven by `KeyConfig.getLongPressOptions()`.
- The popup filters out the pressed key itself, matching the React Native reference behavior.
- Popup appears inside the bottom dock area before the keyboard shell, matching the reference structural placement.
- Popup closes on option selection.
- Popup closes on tab change.
- Long-press haptic is medium impact.
- Tap haptic is light impact.
- Haptic failures are swallowed so input does not fail when haptics are unavailable.

## Not yet implemented

- Deep editor command execution.
- Real expression mutation.
- Template insertion from long-press options.
- Structural node creation.

Those are Phase 3 and Phase 7 responsibilities.
