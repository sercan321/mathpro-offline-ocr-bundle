# V166 Integral Differential Slot Precision Repair Audit

## Scope

V166 repairs the final user-side regression where `StructuralRendererBridge.snapshotForExpression('∫_{0}^{1}(x)d□')` exposed more than one slot entry, causing `registry.entries.single` to throw `Bad state: Too many elements` in `core_editor_regression_test.dart`.

## Root Cause

V165 kept a filled `integralBody` selectable whenever any integral slot was still open. That was too broad: for `∫_{0}^{1}(x)d□`, only `integralDifferential` should be open/addressable. The filled body should remain selectable only when the expression is still the editable template variant with open lower/upper limits, such as `∫_{□}^{□}(x)d□`.

## Repair

`SlotRegistry._isFilledEditableSlot` now exposes a filled `integralBody` only when at least one limit slot is still an open placeholder. This preserves V143 role-aware clearing for editable template integrals while preserving fixed/partially-fixed definite integral precision.

## Non-Goals

- No keyboard layout change.
- No key order change.
- No Graph, History, Solution, EditorViewport, or EditorInteractionLayer redesign.
- No fake Flutter PASS claim.

## Required User-Side Verification

```bash
flutter clean
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```
