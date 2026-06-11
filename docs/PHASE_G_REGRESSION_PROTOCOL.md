# MathPro Core Editor — Phase G Regression Protocol

## Scope

Phase G is a regression hardening layer. It does not change the frozen keyboard layout, tab order, key labels, long-press map, MORE/Ans/↵/= decisions, or visual keyboard geometry. It adds a dedicated regression contract around the MathPro Core Editor Engine work from Phase A through Phase F.

## Covered contracts

1. Frozen keyboard contract
   - 5 tabs remain: Temel, Cebir, Kalkülüs, Kompleks, Lineer Cebir.
   - Temel remains the 20-key core.
   - Expanded tabs remain 8 × 5.
   - MORE, Ans, ↵, and = keep their locked meanings.
   - Long-press maps for √, ∫, and ^ remain protected.

2. TeX render contract
   - √, fraction, power, editable integral, and fixed integral serialize to structural TeX.
   - Technical role names such as sqrtValue, integralBody, slotId do not leak into TeX output.

3. Template / slot ownership contract
   - Templates focus the intended role.
   - Active-slot replacement updates the intended placeholder, not the first visible box by accident.

4. Invisible hit target contract
   - Critical slots expose invisible hit targets at least 44 × 44 px.
   - visualRect remains separate from hitRect.

5. Priority hit-test contract
   - Integral limit taps are not stolen by the body slot.
   - Nested sqrt overlap favors the deeper intended slot.

6. Selection/caret safety contract
   - User-facing labels stay generic and clean.
   - Stale slot IDs are normalized away instead of leaking debug state.

7. Pan/zoom coordinate contract
   - Canvas ↔ viewport coordinate conversion remains invertible.
   - Hit-testing after transform selects the expected slot.

## Required local verification

Run these commands on a machine with Flutter installed:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

Do not claim final PASS until these commands pass and the real-device manual slot protocol has been executed.
