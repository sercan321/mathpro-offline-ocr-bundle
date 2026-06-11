# V160 Exhaustive Public Label Render Contract Audit

## Scope

V160 performs a stricter static closure on the post-V159 public keyboard / MORE / long-press surface. The audit found that every visible structureInsert path routed through `InsertTemplateAction`, but a small set of structure aliases were not explicitly present in `PremiumMathKeySpecs`.

## Finding

The remaining central-contract gap was alias-level, not layout-level:

- `cot`
- `acot`
- `coth`
- `sec`
- `csc`
- `real(□)`
- `imag(□)`
- `dot(□,□)`
- `cross(□,□)`

These labels were already mapped by `ActionUtils`, but were not fully represented as premium specs. That made the central registry less exhaustive than the public key behavior map.

## Repair

V160 adds explicit `PremiumMathKeySpec` entries for the alias labels above and extends the public inventory gate so every public `structureInsert`, `wrapper`, and `postfix` label must be spec-backed or contract-backed.

## Preserved Contracts

V160 does not change keyboard layout, key positions, tab order, MORE, Ans, ↵, Graph, History, Solution, EditorViewport, or EditorInteractionLayer.

## Verification Limit

Flutter/Dart were not available in the assistant environment, so `flutter pub get`, `flutter analyze`, `flutter test`, and `flutter run` were not executed by the assistant.
