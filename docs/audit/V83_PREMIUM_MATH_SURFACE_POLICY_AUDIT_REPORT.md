# MathPro V83 Premium Math Surface Policy Audit

## Scope
This phase does not add a solver. It tightens the visual/editor surface layer so keyboard keys, long-press popup options, and MORE chips use one shared policy for premium mathematical display decisions.

## Changes
- Added `lib/logic/premium_math_surface_policy.dart`.
- Routed `PremiumKey`, `TemplateTray`, `LongPressPopup`, and `MathLabel` through the shared display policy.
- Centralized canonical display labels for legacy/internal programmer tokens such as `asin(□)` → `sin⁻¹(□)` and `acot(□)` → `cot⁻¹(□)`.
- Removed duplicate private math-label lists from `LongPressPopup` and the stale `_mathishLabels` list from `PremiumKey` so future surfaces do not drift independently.
- Added `test/v83_premium_math_surface_policy_test.dart` to lock display canonicalization, no public programmer-token leaks, policy-backed math surfaces, chip width rules, and frozen keyboard contracts.

## Preserved Contracts
- Keyboard tab order is unchanged.
- Core keyboard shell is unchanged.
- `MORE`, `Ans`, `↵`, and `=` semantics are unchanged.
- Root long-press contract remains `√□`, `∛□`, `□√□`.
- Integral long-press contract remains `∫□dx`, `∫ₐᵇ`, `∬`, `∭`, `∮`.
- Graph, History, and Solution panel UI were not edited.

## Honest Limit
This is a visual/editor surface unification phase. It is not yet a full Photomath/WolframAlpha-level editor engine completion and it does not prove device UX. Flutter SDK was not available in the packaging environment, so `flutter analyze`, `flutter test`, and `flutter run` must be executed on the user's machine.
