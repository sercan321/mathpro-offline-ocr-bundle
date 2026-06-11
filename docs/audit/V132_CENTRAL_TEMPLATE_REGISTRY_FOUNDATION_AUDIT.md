# V132 — Central Template Registry Foundation Audit

## Scope

V132 begins the structural cleanup phase for keyboard, MORE and long-press math templates. It does not move keys, tabs, MORE, Ans, =, ↵, long-press ordering, Graph, History, Solution, EditorViewport layout, or EditorInteractionLayer behavior.

## Implemented

- Added `lib/logic/math_template_contract_registry.dart` as a registry-backed contract layer for high-risk visible math templates.
- Wired `ActionUtils.templateSpecForStructure`, `ActionUtils.templateForStructure`, and `_defaultFocusRole` through the registry before falling back to legacy maps.
- Wired `UnifiedMathPreviewPolicy.canonicalPreviewLabel` through registry canonical expressions so keycap/MORE/long-press previews share the same template identity.
- Updated `MathKeyInventory` so registry-backed entries count as spec-backed and old missing-spec audits do not report stale gaps for registry-owned templates.
- Added structural parser support for `(f∘g)(□)` as a functionCall with `functionArgument`.
- Added structural parser support for `□C□` and `□P□` as two-argument semantic function calls.
- Updated `TexSerializer` to serialize function composition as `\left(f\circ g\right)(...)`, and combination/permutation as mathematical discrete notation.
- Updated `MathTexSerializer` string path for `(f∘g)(□)` so the MathJax direct-string renderer also produces `\circ` notation.
- Added `test/v132_template_registry_foundation_test.dart`.

## Guarded contracts

- `□!`, `□ᵀ`, `□⁻¹`, `□ᴴ` keep `postfixTarget`.
- `□C□` / `□P□` expose two argument slots.
- `f(□,□)` exposes two function arguments.
- `f∘g` routes to `(f∘g)(□)` and serializes with `\circ`.
- `lim`, `∫□dx`, `∫ₐᵇ`, `Σ`, `Π`, and `Taylor` are registry-backed.

## Not claimed

Flutter/Dart execution was not available in the assistant container. No `flutter analyze`, `flutter test`, or real-device PASS is claimed.
