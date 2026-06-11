# V172-Q156 MathLive Popup Envelope Final Rebalance Audit

## Scope

Q156 is a narrow Flutter-test contract repair after user-side Q155 evidence showed only two remaining `flutter test` failures. Both failures came from legacy bounded-integral long-press popup envelope thresholds:

- `LongPressPopup.boundedIntegralChipWidth` was `96.0`, below the required `>= 104`.
- `LongPressPopup.panelMinHeight` was `90.0`, below the required `>= 116`.

## Implementation

Changed only the visual-fit policy constants in `lib/features/keyboard/premium_popup_fit_policy.dart`:

- `longPressPanelMinHeight`: `90.0` → `116.0`
- `longPressBoundedIntegralChipWidth`: `96.0` → `104.0`
- Added `envelopeFinalRebalancePhase = 'V172-Q156'`

The Q150 compact visual policy remains active:

- `longPressPanelMaxHeight = 120.0`
- `longPressChipHeight = 88.0`
- `longPressChipGap = 8.0`
- MORE tray compact sizing remains unchanged.

## Explicit Non-Changes

Q156 does not change:

- keyboard layout
- key order
- MORE inventory or category order
- long-press option order
- MathLive template mappings
- Graph UI
- History UI
- Solution UI
- solver behavior
- real-device pass status
- Photomath/Wolfram pass status

## Evidence Status

Package-side static verification passed in the assistant environment. Flutter/Dart is not available in the assistant environment, so `flutter analyze`, `flutter test`, and `flutter run` are not claimed by the assistant.
