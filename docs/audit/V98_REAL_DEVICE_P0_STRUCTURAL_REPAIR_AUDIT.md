# MathPro V98 — Real Device P0 Structural Repair Audit

## Scope
Targeted repair pass after V97. This pass does not add solver capability and does not change the frozen keyboard/tab contract. It focuses on P0 editor behavior that was visible on real-device screenshots: cursor/selection jitter, filled slot edit/delete, log base display, limit slot routing, sum/product structural preservation, and long-press analyzer hygiene.

## Key Repairs
- Kept `_mathishChipLabels` alive through actual long-press math-surface routing to close the private-unused analyzer warning without deleting the existing visual consistency contract.
- Repaired filled fraction slot edit/delete by preserving active slot replacement through the existing structural command path.
- Changed log-base plain serialization from `log(base)(arg)` to compact mathematical `log₍base₎(arg)` so user-visible programmer call chains do not reappear after slot edits.
- Preserved definite/indefinite integral body and differential in plain serialization without producing `ddx`.
- Preserved sum/product lower, upper, and body slots through `Σ_{lower}^{upper}(body)` / `Π_{lower}^{upper}(body)` serialization.
- Added parser and TeX serializer support for the serialized sum/product form so subsequent edits remain structural.
- Added series filled-slot editability for the known series slot keys.
- Tightened linear placeholder fallback acceptance to reduce giant/false slot captures on phone screens.
- Removed duplicate tap-up slot resolution from the editor interaction layer; tap-down is the single deterministic tap selection path and pan handlers remain responsible for drag movement.
- Added V98 regression tests for filled fraction slots, log-base serialization, limit slots, serialized sum/product slots, bounded overlay rects, and duplicate tap-up removal.

## Preserved Contracts
- Keyboard key layout unchanged.
- Tab order unchanged: Temel, Cebir, Kalkülüs, Kompleks, Lineer Cebir.
- MORE text unchanged.
- Ans remains in the keyboard contract.
- ↵ remains evaluate/enter.
- = remains equality symbol, not calculation.
- Graph, History, and Solution panel files were not intentionally redesigned.
- No solver or fake Photomath/Wolfram-level claim added.

## Test Status
Flutter SDK was not available in this assistant container. I could not run `flutter analyze`, `flutter test`, or `flutter run`. The added tests are static/test-suite locks to be run by the user locally.

## Required User Verification
Run:

```bash
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

Then verify real-device scenarios:
1. `3⁄4` → select numerator/denominator → delete/change.
2. `log_□(□)` → enter `2`, `5` → should render as `log₂(5)` style, not `log(2)(5)`.
3. Limit template → variable/target/body remain separate editable slots.
4. Σ/Π → lower/upper/body do not become giant overlays or raw text.
5. Long nested expression → cursor/slot highlight is not a huge green block.
