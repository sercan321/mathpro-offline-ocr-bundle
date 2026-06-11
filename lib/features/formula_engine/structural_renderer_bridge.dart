import '../editor/math_node.dart';
import '../editor/node_factory.dart';
import '../editor/slot_registry.dart';
import '../editor/tex_serializer.dart';
import 'math_expression_render_bridge.dart';

class StructuralRendererBridge {
  const StructuralRendererBridge._();

  static StructuralRendererSnapshot snapshotForExpression(String expression) {
    final canonical = MathExpressionRenderBridge.canonicalDisplayExpression(expression);
    final tree = NodeFactory.rootFromExpression(canonical);
    return StructuralRendererSnapshot(
      expression: canonical,
      root: tree,
      tex: EditorTexSerializer.serialize(tree),
      registry: SlotRegistry.build(tree),
    );
  }
}

class StructuralRendererSnapshot {
  const StructuralRendererSnapshot({
    required this.expression,
    required this.root,
    required this.tex,
    required this.registry,
  });

  final String expression;
  final MathNode root;
  final String tex;
  final SlotRegistry registry;
}
