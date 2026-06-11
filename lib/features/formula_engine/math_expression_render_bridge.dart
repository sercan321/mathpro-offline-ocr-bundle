import '../editor/math_node.dart';
import '../editor/node_factory.dart';
import '../editor/render/math_tex_serializer.dart';
import '../editor/slot_registry.dart';
import '../editor/tex_serializer.dart';
import '../editor/tree_utils.dart';
import 'math_node_family_policy.dart';
import 'calculus_operator_policy.dart';
import 'legacy_raw_math_renderer_cleanup_policy.dart';
import '../../logic/mathpro_regression_gate.dart';

/// Single visible-render authority for MathPro expression surfaces.
///
/// The editor owns MathNode/Slot semantics; renderers only draw. This bridge
/// canonicalizes the primary families before parsing so editor, inline result,
/// popup previews and fallbacks do not leak programmer tokens or diverging
/// display forms.
class MathExpressionRenderBridge {
  const MathExpressionRenderBridge._();

  static const String version = 'mathpro-v107-renderer-bridge-regression-gated';

  static MathExpressionRenderSnapshot snapshotForSurface(String expression) {
    final canonical = canonicalDisplayExpression(expression);
    final root = NodeFactory.rootFromExpression(canonical);
    final structural = TreeUtils.containsStructuralNode(root);
    final tex = structural ? EditorTexSerializer.serialize(root) : MathTexSerializer.toTex(canonical);
    return MathExpressionRenderSnapshot(
      originalExpression: expression,
      displayExpression: canonical,
      root: root,
      registry: SlotRegistry.build(root),
      tex: tex,
      usedStructuralSerializer: structural,
    );
  }

  static String texForSurface(String expression) => snapshotForSurface(expression).tex;

  static String canonicalDisplayExpression(String expression) {
    var value = MathProRegressionGate.guardVisibleLabel(expression.trim());
    value = LegacyRawMathRendererCleanupPolicy.canonicalVisibleMath(value);
    if (value.isEmpty) return value;

    value = MathNodeFamilyPolicy.canonicalDisplayForPrimaryFamilies(value);
    value = LegacyRawMathRendererCleanupPolicy.canonicalVisibleMath(value);
    value = CalculusOperatorPolicy.canonicalDisplayForCalculusFamilies(value);
    value = _canonicalizeLimitForms(value);
    return MathProRegressionGate.guardVisibleLabel(
      LegacyRawMathRendererCleanupPolicy.canonicalVisibleMath(value),
    );
  }

  static String safeFallbackLabel({required String expression, required String tex}) {
    final canonical = LegacyRawMathRendererCleanupPolicy.canonicalVisibleMath(canonicalDisplayExpression(expression));
    if (canonical.isNotEmpty && !_looksLikeRawTex(canonical) && !LegacyRawMathRendererCleanupPolicy.exposesVisibleRawMath(canonical)) return canonical;
    final readableTex = LegacyRawMathRendererCleanupPolicy.canonicalVisibleMath(_readableFromTex(tex));
    if (readableTex.isNotEmpty && !_looksLikeRawTex(readableTex) && !LegacyRawMathRendererCleanupPolicy.exposesVisibleRawMath(readableTex)) return readableTex;
    final fallback = LegacyRawMathRendererCleanupPolicy.canonicalVisibleMath(expression.trim());
    return fallback.isEmpty ? '□' : fallback;
  }

  static bool exposesProgrammerToken(String expression) {
    final value = expression.trim();
    return MathProRegressionGate.hasForbiddenVisibleToken(value) ||
        LegacyRawMathRendererCleanupPolicy.exposesVisibleRawMath(value) ||
        RegExp(r'^log\([^)]*\)\([^)]*\)$').hasMatch(value) ||
        RegExp(r'^lim_?[A-Za-zπθλ]\s*→').hasMatch(value) ||
        RegExp(r'\b(?:log_10|log_2|x_n|y_n)\b').hasMatch(value);
  }

  static String _canonicalizeLimitForms(String value) {
    var output = value;
    output = output.replaceAllMapped(
      RegExp(r'lim_?([A-Za-zπθλ])\s*→\s*([^()]+)\(([^()]*)\)'),
      (match) => 'lim₍${match.group(1)!}→${match.group(2)!.trim()}₎(${match.group(3)!.trim()})',
    );
    output = output.replaceAll('lim x→□', 'lim₍x→□₎(□)');
    output = output.replaceAll('lim x→∞', 'lim₍x→∞₎(□)');
    output = output.replaceAll('lim x→0⁺', 'lim₍x→0⁺₎(□)');
    output = output.replaceAll('lim x→0⁻', 'lim₍x→0⁻₎(□)');
    return output;
  }

  static bool _looksLikeRawTex(String value) {
    return value.contains('\\') || value.contains(r'\left') || value.contains(r'\frac') || value.contains(r'\Box');
  }

  static String _readableFromTex(String tex) {
    var value = tex.trim();
    if (value.isEmpty) return '';
    value = value
        .replaceAll(r'\Box', '□')
        .replaceAll(r'\pi', 'π')
        .replaceAll(r'\theta', 'θ')
        .replaceAll(r'\lambda', 'λ')
        .replaceAll(r'\infty', '∞')
        .replaceAll(r'\left', '')
        .replaceAll(r'\right', '')
        .replaceAll(r'\,', '')
        .replaceAll('{', '')
        .replaceAll('}', '');
    value = value.replaceAllMapped(RegExp(r'\\log_([^\\s]+)\(([^()]*)\)'), (match) {
      return 'log₍${match.group(1)!}₎(${match.group(2)!})';
    });
    value = value.replaceAll(r'\sum', 'Σ').replaceAll(r'\prod', 'Π').replaceAll(r'\int', '∫').replaceAll(r'\sqrt', '√');
    value = value.replaceAll(r'\sin', 'sin').replaceAll(r'\cos', 'cos').replaceAll(r'\tan', 'tan').replaceAll(r'\ln', 'ln');
    return value.trim();
  }
}

class MathExpressionRenderSnapshot {
  const MathExpressionRenderSnapshot({
    required this.originalExpression,
    required this.displayExpression,
    required this.root,
    required this.registry,
    required this.tex,
    required this.usedStructuralSerializer,
  });

  final String originalExpression;
  final String displayExpression;
  final MathNode root;
  final SlotRegistry registry;
  final String tex;
  final bool usedStructuralSerializer;
}
