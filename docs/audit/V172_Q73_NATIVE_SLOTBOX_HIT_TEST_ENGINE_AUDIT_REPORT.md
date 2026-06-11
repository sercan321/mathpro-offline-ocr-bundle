# V172-Q73 Native SlotBox Hit-Test Engine Audit Report

## Objective

Build the next cursor-only phase after Q72 without touching the protected keyboard/UI surfaces. The goal is to eliminate the remaining active path where structural taps could be routed by nearest-distance guessing instead of authoritative SlotBox geometry.

## Q73 product law

- Structural cursor selection must run through `SlotGeometryBundle.hitRect` when geometry exists.
- A tap outside all measured hitRects must not be guessed into a structural slot.
- Legacy visual-rect hit-test is allowed only for no-geometry fallback surfaces.
- The old nearest structural reconciliation path must remain inactive in the active pipeline.
- Overlapping measured hitRects are allowed because phone-sized slots overlap; tie-breaks must be deterministic and based on geometry, role, priority, and depth.
- Empty structural slots keep the existing `|□` leading-caret law.

## Implementation summary

Q73 adds `NativeSlotBoxHitTestPolicy`, then wires the editor interaction layer to prefer that policy before legacy hit-test. The policy accepts a structural hit only when the pointer is inside a measured `SlotGeometryBundle.hitRect`. It does not perform outside-distance nearest fallback.

The previous reconciliation layer still contains the historical `nearestStructuralHit(...)` method for compatibility and tests, but `reconcileStructuralHit(...)` now refuses to call it in the active Q73 path.

The structural intent resolver now delegates exact bundle selection to `NativeSlotBoxHitTestPolicy.hitTest(...)`, so `SlotGeometryBundle` remains the single shared source for painter, hit-test, and caret routing.

## Non-goals

Q73 does not change:

- Keyboard layout, key order, MORE, Ans, `↵`, `=`.
- Long-press popup/order/content.
- App shell, MathLabel, template tray.
- Solution, Graph, History.
- Solver/math engine behavior.
- Full native renderer or real device +95 status.

## Static verification

`python3 tool/verify_mathpro_contract.py .` reports PASS for the active static contract after Q73 wiring.

## Evidence limitation

Flutter and Dart were not available in the assistant execution environment. Therefore Q73 does not claim:

- `flutter analyze` PASS.
- `flutter test` PASS.
- `flutter run -d 23106RN0DA` PASS.
- Real-device Photomath/Wolfram +95 cursor PASS.

Those remain user-side verification gates.
