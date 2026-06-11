# V159 Final Render Fallback Closure Audit

## Scope

V159 closes the render-path gap left after V157/V158. Primitive math input already parsed into `NumberNode`, `SymbolNode`, `ConstantNode`, `OperatorNode`, and `DelimiterNode`, but the surface render bridge still considered only higher structural templates as structural. Pure primitive expressions could therefore still choose the legacy string-to-TeX fallback path.

## Repair

`TreeUtils.containsStructuralNode` now delegates to `TreeUtils.isRenderableAstNode`, and primitive render-node families are included as first-class renderable AST nodes:

- `MathNodeKind.number`
- `MathNodeKind.symbol`
- `MathNodeKind.constant`
- `MathNodeKind.operatorToken`
- `MathNodeKind.delimiter`

This makes expressions such as `x+1`, `π`, `12.3`, `(a,b)` and `θ≤∞` render through `EditorTexSerializer` rather than `MathTexSerializer.toTex`.

## Protected Contracts

V159 does not change keyboard layout, tab order, MORE, Ans, ↵, Graph, History, Solution, EditorViewport or EditorInteractionLayer.

## Verification Limit

Flutter/Dart were not available in the assistant environment, so `flutter pub get`, `flutter analyze`, `flutter test`, and `flutter run` were not executed by the assistant. The package must be verified on the user's machine.
