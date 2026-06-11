# MathPro Flutter Phase 9 — Reference Regression Audit

## Preserved from React Native reference

- 5-tab keyboard structure preserved.
- `Temel` 20-key layout preserved.
- Expanded 8 × 5 grid direction preserved.
- `MORE`, `Ans`, `↵`, and `=` product decisions preserved.
- Long-press map preserved.
- Keyboard height policy preserved.
- Compact history handle retained.
- Android `MainActivity.kt` is present.

## Repaired in Phase 9

- Selection toolbar visibility now follows active slot/selection state instead of appearing for plain expression text.
- MORE tray uses the reference premium template label set.
- Premium template labels insert structured expression strings instead of raw labels.
- User-facing stale “legacy Phase-3 evaluator” text was removed.
- Pan/pinch interaction now suppresses immediate slot taps briefly to reduce accidental slot selection.

## Still honest limitations

- Slot coordinates remain deterministic approximate layout boxes.
- Renderer-derived bounding boxes are not yet implemented.
- Real device/emulator validation is still required.
