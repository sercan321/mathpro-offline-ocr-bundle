# V168 Visual Label Contract Restoration Audit

## Scope

V168 repairs the product-visible keyboard/MORE/long-press visual language after the semantic AST migration leaked hidden template expressions into UI labels.

## Root Cause

`UnifiedMathPreviewPolicy.canonicalPreviewLabel()` was using `MathTemplateContractRegistry.contractFor(label)?.expression` as the visible compact label. That made UI chips display internal canonical templates such as Taylor-series source strings instead of human-readable labels like `Taylor`, `Kuadratik`, `EBOB`, `EKOK`, `2×2 Matris`, `RREF`, and `Rank`.

## Repair

Visible labels now remain visible labels. Hidden template expressions still route through `ActionUtils`, `PremiumMathKeySpecs`, `NodeFactory`, AST parsing, slot routing and serializers, but are no longer substituted into keycaps, MORE chips, or long-press cards.

## Locked Examples

- Visible `Taylor` stays `Taylor`; hidden expression remains the Taylor template.
- Visible `Kuadratik` stays `Kuadratik`; hidden expression remains the quadratic formula.
- Visible `EBOB` / `EKOK` stay readable labels.
- Visible `sin`, `cos`, `tan`, `ln`, `log` stay clean keycap labels, not `sin(□)` style leaks.
- Template glyphs such as `√□`, `□^□`, `□/□`, `|□|`, and `∫ₐᵇ` can still use premium MathLabel glyph widgets.

## Protected Surfaces

V168 does not change key positions, tab order, MORE categories, long-press ordering, Graph, History, Solution, EditorViewport, or EditorInteractionLayer.

## Local Flutter Status

Flutter was not available in the assistant container. No `flutter analyze`, `flutter test`, or `flutter run` PASS is claimed by this audit.
