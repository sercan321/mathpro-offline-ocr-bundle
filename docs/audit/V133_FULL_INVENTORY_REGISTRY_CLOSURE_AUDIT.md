# V133 — Full Inventory Registry Closure Foundation Audit

## Scope

V133 continues the MathPro keyboard / MORE / long-press cleanup work after V132. It does not change keyboard positions, tab order, MORE, Ans, =, ↵, long-press ordering, Graph, History, Solution, EditorViewport layout, or EditorInteractionLayer behavior.

The phase hardens the template contract layer so public labels no longer depend only on loose ActionUtils string switches. Explicit high-risk V132 contracts still win, while PremiumMathKeySpecs are now exposed as registry-compatible fallback contracts.

## Repairs

- `MathTemplateContractRegistry.contractFor()` now falls back to `PremiumMathKeySpecs.specFor()` when no explicit contract exists.
- `MathTemplateContractRegistry.labels` now includes explicit registry labels plus premium spec labels.
- Added explicit series contracts for:
  - `Maclaurin`
  - `Geometrik`
  - `Binom`
  - `eˣ serisi`
  - `sin serisi`
  - `cos serisi`
  - `ln serisi`
  - `arctan serisi`
- Repaired the exact series-template parser fast path so series templates produce semantic `MathNodeKind.series` nodes instead of legacy text/placeholder rows.
- Updated stale package metadata tests so old V131/V132 metadata does not remain authoritative.
- Added `test/v133_full_inventory_registry_closure_test.dart` to lock the new contract.

## Risk Closed

Before V133, some series templates could look mathematical at first but degrade into flat text after slot editing because the parser returned text rows for exact series strings. V133 routes these exact forms to semantic series nodes, which keeps SlotRegistry and TexSerializer in the structural path.

## Static Verification Performed

- `pubspec.yaml` is `0.133.0+133`.
- `MathJaxRenderSurface` still uses SVG-only DOM commit: `math.replaceChildren(visualSvg);`.
- `math.replaceChildren(node);` remains absent.
- `enableAssistiveMml: false` remains present.
- No keyboard layout file was edited.

## Not Claimed

Flutter/Dart SDK is not available in this container. No local `flutter analyze`, `flutter test`, or `flutter run` PASS is claimed.
