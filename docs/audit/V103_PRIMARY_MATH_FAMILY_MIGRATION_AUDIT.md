# MathPro V103 — Primary Math Family Migration Audit

## Scope
V103 is a core editor/render migration phase, not a solver phase. It targets the primary visual-editable math families that were still prone to one-off string behavior:

- Fraction
- Power
- Subscript
- Root / indexed root
- Function call / inverse function display
- Log base

## Implementation Summary

### New central policy
Added `lib/features/formula_engine/math_node_family_policy.dart`.

This policy canonicalizes primary-family display forms before parsing/rendering:

- `asin(x)` -> `sin⁻¹(x)`
- `log(2)(5)` -> `log₍2₎(5)`
- `√x` -> `√(x)`
- `x²` -> `x^(2)`
- numeric/placeholder `3/4` -> `3⁄4`

Derivative forms such as `d/dx` are intentionally not normalized into fractions. Series/Product templates containing `Σ` or `Π` are also protected from primary-family canonicalization so their existing linked-placeholder contracts do not silently drift.

### New render bridge
Added `lib/features/formula_engine/math_expression_render_bridge.dart`.

The bridge centralizes:

- canonical display expression
- MathNode parsing
- SlotRegistry snapshot
- TeX generation
- safe fallback label

### Render surface integration
`MathRenderSurface` now uses `MathExpressionRenderBridge.snapshotForSurface(...)` instead of manually mixing structural and fallback paths. This reduces UI drift between canonical display and TeX rendering.

### Structural bridge integration
`StructuralRendererBridge` now canonicalizes through `MathExpressionRenderBridge.canonicalDisplayExpression(...)` before building the node tree.

### Serializer hardening
`MathTexSerializer` gained direct support for filled primary-family forms:

- `log₂(5)`
- `log₁₀(5)`
- `log₍10₎(5)`
- grouped fractions such as `(1+2)⁄(5-1)`
- `√(x)`, `³√(x)`, `ⁿ√(x)`
- `x^(2)` and generic subscript text

### Edit serialization hardening
`EditorCommands._plainSerialize(...)` now groups compound fraction/power/subscript operands to reduce structural collapse after slot replacement.

Example:

- `(1+2)⁄4`, denominator replacement `5-1` -> `(1+2)⁄(5-1)`

Limit serialization was also moved to compact display form:

- `lim₍y→8₎(8)` instead of `lim_y → 8(8)`

## Explicit Non-Goals

- No solver added.
- No Graph/History/Solution panel redesign.
- No keyboard layout change.
- No tab order change.
- No long-press list/order change.
- No claim of Photomath/WolframAlpha equivalence.

## Test Status
Flutter/Dart SDK was not available in the assistant environment, so `flutter analyze`, `flutter test`, and `flutter run` were not executed locally.

## User-Side Required Commands

```bash
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

## Manual QA Focus

1. `log(2)(5)` and log-base templates render as `log₂(5)`-style display, not programmer call chains.
2. `√x`, `x²`, `3/4` canonicalize into structural primary-family forms.
3. Filled fractions with grouped numerator/denominator remain editable after slot replacement.
4. Fallback rendering does not expose raw TeX where a canonical display label is available.
5. Keyboard/Graph/History/Solution panels show no visual contract drift.
