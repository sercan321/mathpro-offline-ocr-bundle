# V172-Q77 Integral Native SlotBox Specialization Audit Report

Active version: `0.172.108+172`

## Scope

Q77 is cursor/editor-only. It specializes integral cursor behavior inside the native SlotBox input surface introduced by Q71-Q76. It does not modify keyboard layout, key order, MORE, Ans, ↵, =, long-press popup, app shell, MathLabel, template tray, Solution, Graph, or History.

## Runtime changes

- Added `NativeIntegralSlotBoxSpecializationPolicy`.
- Integrated deterministic integral lane resolution into `NativeSlotBoxHitTestPolicy.hitTest(...)`.
- Routed integral hitRect, placeholder and leading-rail refinements through the native integral policy while preserving Q58 lineage.
- Added `NativeSlotBoxInputSurfaceIntegrationPolicy.hasCompleteNativeIntegralSlotSet(...)` so the shared input surface frame can prove all four integral slots are present.

## Cursor law

Integral taps are now resolved as follows:

1. The tap must be inside an authoritative `SlotGeometryBundle.hitRect`.
2. Upper/lower/body/differential candidates are not inferred by nearest-distance fallback.
3. Overlapping integral hitRects are resolved by native integral lane rules.
4. Differential `d□` taps beat integral body only when the point is in the differential lane.
5. Empty differential caret must remain `d|□` via the leading rail and must not detach to linear fallback.

## Honest limits

Q77 does not claim Flutter analyze/test/run PASS from this assistant environment. Flutter and Dart are unavailable here. Q77 also does not claim full native math renderer completion, true AST-slot-to-SVG identity, real-device +95 PASS, or Photomath/Wolfram parity. Those remain evidence-gated by user-side Flutter logs and device testing.
