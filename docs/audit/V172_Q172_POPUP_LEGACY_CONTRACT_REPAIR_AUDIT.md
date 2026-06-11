# V172-Q172 Popup Legacy Contract Repair Audit

Q172 repairs the user-side Flutter test failures caused by Q171 over-compacting the long-press popup envelope.

## Root cause

Q171 lowered long-press popup sizing below legacy no-clip regression thresholds. User-side `flutter test` reported failures around chip height and panel envelope values.

## Repair

- `longPressChipHeight` restored to `88.0`.
- `longPressPanelMinHeight` restored to `116.0`.
- `longPressPanelMaxHeight` restored to `120.0`.
- Q170 popup test contradiction updated so it no longer expects the invalid <=76 compact value.
- Protected keyboard layout/order and long-press option order were not changed.

## Non-claims

This package does not claim assistant-side Flutter analyze/test/run PASS and does not claim Android premium PASS without device evidence.
