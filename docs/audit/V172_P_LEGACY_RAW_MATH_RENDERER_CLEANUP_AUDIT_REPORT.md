# V172-P Legacy Raw Math Renderer Cleanup Audit Report

## Scope
V172-P targets visible UI/render leakage of legacy programmer math strings such as `asin(x)`, `log(2)(5)`, and the known `x8n` corruption marker. This phase does not remove parser, evaluator, graph, or regression-test compatibility for internal aliases.

## Runtime Changes
- Added `lib/features/formula_engine/legacy_raw_math_renderer_cleanup_policy.dart`.
- Routed `MathExpressionRenderBridge` visible canonicalization through `LegacyRawMathRendererCleanupPolicy`.
- Routed `UnifiedMathPreviewPolicy` compact preview labels through the same cleanup gate.
- Removed unreachable raw inverse function case labels from `MathLabel`; raw labels should enter through canonical preview first and render as mathematical inverse notation.

## Protected Contracts
- Keyboard layout unchanged.
- MORE unchanged.
- Ans unchanged.
- `=` / `↵` behavior unchanged.
- Long-press maps and order unchanged.
- Graph, History, and Solution panel unchanged.
- No editor loupe/büyüteç added.
- No green debug overlay enabled.

## Acceptance
Visible surfaces must canonicalize:
- `asin(x)` → `sin⁻¹(x)`
- `acos(□)` → `cos⁻¹(□)`
- `log(2)(5)` → `log₍2₎(5)`
- `x8n` → `x₈`

Internal aliases remain allowed only as non-visible parser/evaluator compatibility.

## Test Status
Flutter/Dart were not available in the assistant container, so `flutter analyze` and `flutter test` were not run locally. Static contract verification was run.
