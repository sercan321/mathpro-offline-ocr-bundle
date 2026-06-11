# V150 Structural Atom Tree Binding Migration Audit

## Scope
V150 begins the long-term MathPro direction that mathematical key input should be routed through the central math-tree contract instead of remaining invisible loose text. This phase is intentionally bounded: it migrates fixed mathematical atoms that carry structure, while keeping frozen keyboard layout, Graph, History, Solution, EditorViewport, and EditorInteractionLayer unchanged.

## Migrated public labels
The following public keyboard/MORE/long-press labels are now spec-backed structural atoms:

- Fixed subscripts: `x₁`, `x₂`, `y₁`, `y₂`, `z₁`, `z₂`, `A₁`, `A₂`, `B₁`, `B₂`, `I₂`, `I₃`
- Prime atoms: `y′`, `y″`, `y‴`
- Overline atom: `z̄`
- Fixed power atom: `i²`
- Signed atoms: `−i`, `+∞`, `−∞`
- Differential atoms: `dx`, `dy`, `dt`, `dθ`

## Implementation evidence
- `lib/logic/premium_math_key_specs.dart` now declares these labels as `PremiumMathKeySpec` entries.
- `lib/logic/math_key_inventory.dart` removes these labels from the primitive text set so they no longer pass the V136 primitive-text route.
- `lib/features/editor/node_factory.dart` parses fixed subscripts, `i²`, prime atoms, and overline atoms into structural AST families.
- `lib/features/editor/tex_serializer.dart` serializes prime and overline postfix nodes to premium TeX.
- `test/v150_structural_atom_tree_binding_migration_test.dart` locks the new routing, parser and serializer contract.

## Preserved boundaries
The following product-critical surfaces were intentionally not edited:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/graph/graph_card.dart`
- `lib/features/history/history_panel.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/features/workspace/editor_viewport.dart`
- `lib/features/editor/render/editor_interaction_layer.dart`

## Important limitation
This is not a full editor-core rewrite. MathPro still stores the visible expression as linear source text and builds/parses the AST for rendering, slot registry and tests. V150 moves high-risk mathematical atoms onto the central spec/parser/serializer path; it does not claim that every number/operator token is now a persistent independent AST object in a fully node-owned document model.

## Test honesty
Flutter/Dart were not available in the assistant container. Therefore no local `flutter pub get`, `flutter analyze`, `flutter test`, or `flutter run` PASS is claimed here.
