# V172-J — No-Loupe Premium Tap-to-Cursor Precision Audit

## Scope

V172-J improves normal tap-to-cursor precision without adding an editor loupe/büyüteç. The phase introduces a role-aware precision policy for structural slot hit testing and keeps all previous cursor-engine phases intact.

## Implemented

- Added `lib/features/formula_engine/premium_tap_precision_policy.dart`.
- Updated `SlotHitTesting` to filter candidates in this order: visual intent, precision lane, broad invisible target.
- Added per-role nearest fallback caps to reduce incorrect blank-area overreach.
- Added regression tests proving log base visual intent and fraction denominator lane behavior.
- Kept editor `onLongPress`, loupe UI, Pay/Payda/Üs menu labels, and green debug overlay out of the editor interaction layer.

## Protected Contracts

- Keyboard layout unchanged.
- MORE unchanged.
- Ans unchanged.
- `=` remains equality symbol.
- `↵` remains evaluation/enter.
- Long-press map/order unchanged.
- Graph, History, Solution panel unchanged.

## Honest Limit

This is not full renderer-synchronized +95 cursor completion. It is a no-loupe tap precision hardening phase before later renderer-sync / pixel-QA / premium visual polish work.
