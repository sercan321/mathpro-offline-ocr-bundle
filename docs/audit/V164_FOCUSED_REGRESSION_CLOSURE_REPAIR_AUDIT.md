# V164 Focused Regression Closure Repair Audit

## Scope

V164 repairs the four failures reported from the real user-side V163 log:

1. `v143_structural_edit_visual_contract_consolidation_test` could not find a filled `limitTarget` slot after target replacement.
2. `v81_premium_math_key_spec_core_test` expected `□ⁿ` to keep the `powerBase` first-focus contract, not generic `powerExponent`.
3. `widget_test` could not locate the MathLabel-backed `√□` key by public label identity.
4. `widget_test` could not locate the bounded integral long-press chip as `MathLabel(label: ∫ₐᵇ)`.

## Implementation

- `SlotRegistry` now keeps filled limit slots addressable for role-aware clearing.
- `MathTemplateContractRegistry` no longer treats `□ⁿ` as an alias of generic `□^□`; the exact `PremiumMathKeySpec` for `□ⁿ` now owns its focus role.
- `PremiumKey`, `LongPressPopup`, and `TemplateTray` pass public labels to `MathLabel`; MathLabel still canonicalizes internally for visual rendering.

## Protected Areas

No keyboard layout, Graph, History, Solution, EditorViewport, or EditorInteractionLayer file was edited.

## Verification Status

Static package verification only. Flutter/Dart are unavailable in the assistant container, so no local `flutter analyze`, `flutter test`, or `flutter run` PASS is claimed.
