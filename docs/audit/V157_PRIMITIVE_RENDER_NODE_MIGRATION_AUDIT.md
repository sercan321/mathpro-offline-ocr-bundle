# V157 Primitive Render Node Migration Audit

## Scope

V157 begins the final render-fallback closure for primitive math input. It promotes number literals, symbols and constants from metadata-tagged text tokens into explicit primitive MathNode kinds:

- `MathNodeKind.number`
- `MathNodeKind.symbol`
- `MathNodeKind.constant`

This is deliberately not the operator migration phase. Operator/delimiter keys remain typed text tokens until V158 to avoid changing replacement/caret semantics in the same phase.

## Changed Runtime Areas

- `lib/features/editor/math_node.dart`
- `lib/features/editor/node_factory.dart`
- `lib/features/editor/tex_serializer.dart`
- `lib/features/editor/editor_commands.dart`
- `lib/features/editor/slot_registry.dart`
- `lib/logic/mathpro_package_contract.dart`

## Locked Non-Goals

- No keyboard position/order changes.
- No MORE or long-press ordering changes.
- No Graph, History, Solution, EditorViewport, or EditorInteractionLayer changes.
- No fake Flutter PASS claim from the assistant environment.
- No operator/delimiter full migration in V157; that is V158.

## Primitive Render Node Coverage

- Numbers: `0-9`, decimal literals such as `12.3`, `0.5`, `.75` -> `MathNodeKind.number`.
- Symbols: variables such as `x y z a b c n m k r A B I` and differentials `dx dy dt dθ` -> `MathNodeKind.symbol`.
- Constants: `π e i θ λ μ φ ρ ∞ rad deg +∞ −∞ −i` -> `MathNodeKind.constant`.
- Operators remain typed text tokens with `pendingRenderNode: OperatorNode` for V158.

## Required User Verification

Run:

```bash
flutter clean
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

Only user-side logs can establish Flutter PASS.
