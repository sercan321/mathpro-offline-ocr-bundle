# MATHPRO CORE EDITOR ENGINE — PHASE B AUDIT

## Scope

Phase B continues from Phase A and focuses on MathNode / Template / Slot ownership hardening. This is not a keyboard redesign and not a visual theme pass.

## Implemented

1. **Addressable slot filtering**
   - SlotRegistry now exposes hit targets only for slots that still contain an open placeholder.
   - Fixed text parts such as `0`, `1`, `dx`, `e`, or a filled numerator no longer create false editable hit targets.
   - This prevents the UI from highlighting a limit/base/slot that cannot actually receive input.

2. **Structural slot-index authority**
   - EditorCommands now resolves replacement indexes by rebuilding the MathNode tree and traversing placeholder nodes.
   - This replaces the old role-only mapping for fraction, power, integral, and matrix templates.
   - Result: numerator, denominator, base, exponent, integral lower, upper, body, and differential no longer rely on brittle fixed string indexes.

3. **Template continuity after partial fill**
   - `x⁄□` remains a FractionNode with a denominator slot.
   - `□⁄y` remains a FractionNode with a numerator slot.
   - `x^(□)` remains a PowerNode with an exponent slot.
   - `√(x)` still serializes through the structural TeX bridge as `\sqrt{x}`.

4. **Editable definite integral contract**
   - `∫ₐᵇ` now inserts the canonical editable template `∫_{□}^{□}(□)d□`.
   - It exposes true slots:
     - `integralLowerLimit`
     - `integralUpperLimit`
     - `integralBody`
     - `integralDifferential`
   - Fixed template `∫₀¹(□)dx` no longer exposes false upper/lower placeholders; it only exposes the body slot.

5. **Structural render continuity**
   - MathRenderSurface now uses StructuralRendererBridge output whenever the expression parses into a structural MathNode tree, even after all open slots are filled.
   - This prevents filled structures such as `√(x)` from falling back to weaker Unicode/plain conversion.

6. **Regression tests added**
   - Added Phase B tests for partial fill ownership and editable definite integral slot behavior.
   - Extended SlotEngineSelfCheck catalog with canonical power, editable integral, nested root, and partially filled fraction cases.

## Files changed

- `lib/features/editor/node_factory.dart`
- `lib/features/editor/slot_registry.dart`
- `lib/features/editor/editor_commands.dart`
- `lib/features/editor/tex_serializer.dart`
- `lib/features/editor/render/math_render_surface.dart`
- `lib/features/formula_engine/math_layout_engine.dart`
- `lib/features/formula_engine/slot_engine_self_check.dart`
- `lib/logic/action_utils.dart`
- `test/widget_test.dart`
- `docs/audit/PHASE_B_CORE_EDITOR_ENGINE_AUDIT.md`
- `docs/audit/PHASE_B_CHANGED_FILES_MANIFEST.md`
- `docs/audit/PHASE_B_REGRESSION_REPORT.md`
- `docs/audit/PHASE_B_RELEASE_HYGIENE_REPORT.md`

## Frozen keyboard regression result

The following keyboard files were compared against the Phase A package and are byte-identical:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/long_press_indicator.dart`

Therefore this Phase B package does **not** change:

- tabs
- key order
- MORE label
- Ans key
- ↵ behavior
- = literal behavior
- long-press map
- keyboard dock / bottom positioning

## Verification performed in this environment

- Static source inspection: completed.
- Changed-file review: completed.
- Keyboard frozen-file diff against Phase A: completed; no diff.
- Zip hygiene scan: completed; forbidden cache/build directories absent before packaging.
- Flutter runtime verification: not available in this environment because Flutter/Dart SDK is not installed.

## Required local verification

Run on the user's machine:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

Manual smoke after launch:

1. Open Cebir.
2. Tap `frac`, type numerator, confirm denominator remains selectable.
3. Tap `^`, fill base, confirm exponent remains selectable.
4. Long press / select `∫ₐᵇ`, confirm lower/upper/body/differential slots can be selected and filled in order.
5. Confirm no technical labels such as `sqrtValue`, `integralBody`, `slotId`, or `Aktif slot:` appear on the user surface.
6. Confirm keyboard still sticks to the bottom with no black navigation gap.
