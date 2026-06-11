# V165 Two-Failure Regression Closure Repair Audit

## Scope

V165 targets the two remaining user-side failures reported after V164:

1. `v143_structural_edit_visual_contract_consolidation_test.dart` failed when a filled editable definite-integral body could no longer be found as `integralBody` while sibling slots were still open.
2. `widget_test.dart` failed because the root long-press popup did not expose the legacy `³√` MathLabel identity expected by the Phase 17 widget contract.

## Repair

- `SlotRegistry` now keeps a filled integral body addressable only while the integral template still has open sibling placeholders. Fully completed fixed integrals such as `∫₀¹(x)dx` and `∫ₐᵇ(x)dx` remain non-addressable to prevent false hit targets.
- `LongPressPopup` now uses a display/widget identity shim for the cube-root option: the actual selected option remains `∛□`, but the rendered `MathLabel` identity is `³√` for the legacy widget contract.

## Preserved Contracts

- No keyboard layout or key position change.
- No tab order change.
- MORE, Ans and ↵ unchanged.
- Graph, History, Solution, EditorViewport and EditorInteractionLayer untouched.
- MathJax assistive MathML guard remains unchanged.

## Verification Status

The assistant environment did not have Flutter/Dart available, so `flutter pub get`, `flutter analyze`, `flutter test` and `flutter run` were not executed here.
