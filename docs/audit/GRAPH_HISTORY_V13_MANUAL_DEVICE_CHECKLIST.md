# GRAPH_HISTORY_V13 — Manual Device Checklist

Run this on the Windows/Flutter environment with the Android device connected.

## Commands

```powershell
cd MathProFlutterPhase17
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

## Keyboard checks

- Temel tab has exactly 20 visible keys in the frozen layout.
- Expanded tabs use the 8 × 5 layout.
- `MORE` is visible as `MORE`, not `...`.
- `Ans` is directly visible.
- `↵` evaluates / enters.
- `=` inserts literal equality and does not evaluate.
- Integral long-press still exposes `∫`, `∫ₐᵇ`, `∮`; no `∬` in the integral long-press popup.

## Graph checks

- `sin(x)` opens direct Graph Card.
- `y = x² - 4` opens direct Graph Card.
- `3+5`, then `↵`, then graph button gives `y = 8` constant suggestion.
- `x² + y² = 1` gives the implicit/advanced-mode message.
- Graph Card closes correctly.
- Fullscreen graph opens and returns with state preserved.
- Pinch zoom, pan, double tap reset, trace, settings apply.

## History checks

- History is hidden on launch.
- History opens by icon.
- History opens by downward card drag if available on the surface.
- History closes without keyboard layout drift.
- Calculation item restores expression.
- Graph item reopens graph preview.
- Delete has undo.
- Clear-all has confirmation and undo.
- Pin/unpin persists.
- Close/reopen app; persisted history remains.

## Visual checks

- No debug green boxes.
- No slot technical IDs visible to user.
- No old history handle.
- No keyboard/navigation bar collision.
- No obvious overflow on short-height device.
