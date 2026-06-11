import 'math_node.dart';

class TreeUtils {
  const TreeUtils._();

  static Iterable<MathNode> walk(MathNode root) sync* {
    yield root;
    for (final child in root.children) {
      yield* walk(child);
    }
    for (final slot in root.slots.values) {
      yield* walk(slot);
    }
  }

  static MathNode? findById(MathNode root, String id) {
    for (final node in walk(root)) {
      if (node.id == id) return node;
    }
    return null;
  }

  static int countSlots(MathNode root) {
    return walk(root).where((node) => node.isPlaceholder).length;
  }

  static bool containsStructuralNode(MathNode root) {
    return walk(root).any((node) => isRenderableAstNode(node));
  }

  /// True for every node family that must render through MathPro's owned
  /// node serializer rather than the legacy string-to-TeX fallback. V159 adds
  /// primitive render nodes here so pure expressions like `x+1`, `π`, or
  /// `(a,b)` still use the AST render path.
  static bool isRenderableAstNode(MathNode node) {
    return node.kind == MathNodeKind.number ||
        node.kind == MathNodeKind.symbol ||
        node.kind == MathNodeKind.constant ||
        node.kind == MathNodeKind.operatorToken ||
        node.kind == MathNodeKind.delimiter ||
        node.kind == MathNodeKind.placeholder ||
        node.kind == MathNodeKind.postfix ||
        node.kind == MathNodeKind.fraction ||
        node.kind == MathNodeKind.sqrt ||
        node.kind == MathNodeKind.indexedRoot ||
        node.kind == MathNodeKind.power ||
        node.kind == MathNodeKind.subscript ||
        node.kind == MathNodeKind.logBase ||
        node.kind == MathNodeKind.integral ||
        node.kind == MathNodeKind.derivative ||
        node.kind == MathNodeKind.bigOperator ||
        node.kind == MathNodeKind.limit ||
        node.kind == MathNodeKind.functionCall ||
        node.kind == MathNodeKind.matrix ||
        node.kind == MathNodeKind.vector ||
        node.kind == MathNodeKind.piecewise ||
        node.kind == MathNodeKind.series;
  }
}
