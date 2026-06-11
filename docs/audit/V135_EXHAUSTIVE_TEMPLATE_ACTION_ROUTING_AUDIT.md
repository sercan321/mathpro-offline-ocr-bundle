# V135 — Exhaustive Template Action Routing and Stale Audit Repair

## Scope

V135 continues the MathPro keyboard / MORE / long-press template unification work from the real V133 package. The phase focuses on stale metadata cleanup and on closing template routing gaps that could keep long-press-only labels in loose text insertion instead of structural template insertion.

## Non-negotiable preserved contracts

- Keyboard key positions unchanged.
- Tab order unchanged.
- MORE label unchanged.
- Ans unchanged.
- `=` remains literal equality.
- `↵` remains evaluate/enter.
- Long-press ordering unchanged.
- Graph, History, Solution panel unchanged.
- EditorViewport layout unchanged.
- EditorInteractionLayer behavior unchanged.

## Repairs

1. Package metadata updated to `0.135.0+135` with V135 description.
2. `KeyHandlers` now routes all `MathTemplateContractRegistry.labels` and `PremiumMathKeySpecs.labels` through `InsertTemplateAction` before falling back to text insertion.
3. Long-press-only matrix postfix labels are now premium specs:
   - `A⁻¹`
   - `Aᵀ`
   - `B⁻¹`
   - `Bᵀ`
4. MathJax fallback serializer now includes `Aᵀ`, `B⁻¹`, and `Bᵀ` replacements alongside the existing `A⁻¹` replacement.
5. Stale V131/V133 package metadata tests were updated so old V133 metadata cannot remain authoritative.
6. Added `test/v135_exhaustive_template_action_routing_test.dart` to lock routing, postfix parsing, slot exposure, serializer safety, and MathJax SVG-only commit.

## Static verification focus

- `□!`, `□ᵀ`, `□⁻¹`, `sin⁻¹(□)`, `f∘g`, `f(□,□)`, `□C□`, `□P□`, Taylor/Maclaurin remain structural nodes.
- `A⁻¹`, `Aᵀ`, `B⁻¹`, `Bᵀ` no longer rely on text fallback.
- MathJax `visualSvg` commit remains locked.
- Assistive MathML remains disabled.

## Test note

Flutter/Dart were unavailable in the packaging environment, so no `flutter analyze` or `flutter test` PASS is claimed here. The user must run the Flutter command sequence on a real development machine.
