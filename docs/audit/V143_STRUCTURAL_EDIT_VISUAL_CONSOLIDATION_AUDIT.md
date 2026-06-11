# V143 Structural Edit and Compact Visual Contract Consolidation Audit

## Scope

V143 continues from the actual uploaded package contents. The uploaded zip was still active as V140, so this release first updates active package metadata to V143 and then consolidates structural editing and compact key glyph work without changing keyboard layout or core UI surfaces.

## Preserved contracts

- Keyboard key positions unchanged.
- Tab order unchanged.
- MORE unchanged.
- Ans unchanged.
- = and ↵ semantics unchanged.
- Long-press order unchanged.
- Graph UI unchanged.
- History UI unchanged.
- Solution panel unchanged.
- EditorViewport and EditorInteractionLayer unchanged.

## Repairs

- Added V143 active metadata through `MathProPackageContract`, `pubspec.yaml`, and README.
- Added stale marker coverage for V140, V141, and V142 active versions.
- Added owner-kind-aware slot role restoration for `clearSelectedSlot`, preventing `target` slots from falling back to the wrong role such as `limitTarget` when the owner is actually postfix.
- Added postfix atomic backspace handling for `n!`, `Aᵀ`, `B⁻¹`, and `□ᴴ` style expressions.
- Added compact atomic range coverage for `□!`, `□ᵀ`, `□⁻¹`, `□ᴴ`, `A⁻¹`, `Aᵀ`, `B⁻¹`, and `Bᵀ`.
- Added stable role-order entries for `postfixTarget`, `derivativeBody`, `derivativeVariable`, `functionArgument2`, and `functionArgument3`.
- Reduced compact math glyph weight/scale in `math_label.dart` for calculus, big-operator, postfix, and binary-slot preview surfaces.
- Added `test/v143_structural_edit_visual_contract_consolidation_test.dart`.

## Verification notes

Flutter/Dart SDK is not available in this environment. No `flutter analyze`, `flutter test`, or real device `flutter run` PASS is claimed. The package was statically inspected and zipped cleanly.
