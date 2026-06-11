# V172-Q72 Native SlotBox Painter Audit Report

## Scope

Q72 continues the deterministic cursor repair path after Q71. The goal is cursor/editor geometry only: the painted caret/slot paint model must use the same `SlotGeometryBundle` authority as hit-test. This prevents visual placeholder, hit target, and caret rail drift.

## Runtime changes

- Added `lib/features/formula_engine/native_slotbox_painter_policy.dart`.
- Routed `EditorCaretOverlay` through `NativeSlotBoxPainterPolicy.paintModelForBundle(...)`.
- Changed active structural caret painting to build from `SlotGeometryBundleAuthority.buildFromVisualRects(...)`, matching the interaction layer's geometry source.
- Kept visible slot boxes disabled by default; no green/debug overlay is enabled.
- Fixed a cursor-side compile-risk defect in `slot_hit_testing.dart`: duplicate `aVisualRect` named argument in the final candidate comparator call.

## Protected surface status

The following surfaces are intentionally unchanged by Q72:

- Keyboard layout / key order
- MORE
- Ans
- `↵`
- `=` equality behavior
- Long-press popup/order
- App shell
- Graph
- History
- Solution panel

## Evidence

Static verifier:

```text
python3 tool/verify_mathpro_contract.py .
MathPro contract verification completed without hard failures.
```

Package metadata:

```text
version: 0.172.103+172
description: MathPro Flutter phase 17 - V172-Q72 native SlotBox painter; painter/caret model shares SlotGeometryBundle geometry with hit-test and preserves protected UI surfaces.
```

## Honest limitations

Flutter/Dart are not available in this execution environment, so this package does not claim:

- `flutter analyze` PASS
- `flutter test` PASS
- `flutter run -d 23106RN0DA` PASS
- real-device +95 / Photomath-level cursor PASS

Those must be verified on the user's machine/device.
