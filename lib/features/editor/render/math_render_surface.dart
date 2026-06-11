import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import '../../../theme/mathpro_typography.dart';
import '../../formula_engine/math_expression_render_bridge.dart';
import 'math_render_surface_role.dart';
import 'visible_renderer_policy.dart';

export 'math_render_surface_role.dart';

class MathRenderSurface extends StatelessWidget {
  const MathRenderSurface({
    super.key,
    required this.expression,
    this.role = MathRenderSurfaceRole.editor,
    this.textAlign = TextAlign.center,
  });

  final String expression;
  final MathRenderSurfaceRole role;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final cleanExpression = expression.trim();

    // V172-Q205: the production expression editor no longer uses this legacy
    // Flutter/MathJax render surface. MathLiveProductionEditorSurface owns the
    // editable expression route; this widget remains only for non-editor result,
    // graph, history, and solution math labels. If historical tests instantiate
    // it with editor role, use the same local flutter_math_fork renderer rather
    // than reviving the retired MathJax/WebView editor surface.
    if (cleanExpression.isEmpty) {
      return const SizedBox.shrink();
    }

    if (!VisibleRendererPolicy.shouldUseMathRenderer(cleanExpression)) {
      return const SizedBox.shrink();
    }

    final snapshot = MathExpressionRenderBridge.snapshotForSurface(cleanExpression);
    final displayExpression = snapshot.displayExpression;
    final tex = snapshot.tex;
    final style = _styleForRole(role);
    final mathStyle = role == MathRenderSurfaceRole.inline ? MathStyle.text : MathStyle.display;

    return Semantics(
      label: displayExpression,
      value: tex,
      child: Math.tex(
        tex,
        mathStyle: mathStyle,
        textStyle: style,
        onErrorFallback: (error) => _PremiumMathFallback(
          expression: displayExpression,
          tex: tex,
          role: role,
          textAlign: textAlign,
        ),
      ),
    );
  }

  TextStyle _styleForRole(MathRenderSurfaceRole role) {
    switch (role) {
      case MathRenderSurfaceRole.editor:
        return MathProTypography.editorExpression.copyWith(
          fontSize: 32,
          height: 1.02,
          color: const Color(0xFFF4F6F6),
        );
      case MathRenderSurfaceRole.result:
        return MathProTypography.resultText.copyWith(
          fontSize: 24,
          height: 1.02,
          color: const Color(0xFF5D9CFF),
        );
      case MathRenderSurfaceRole.inline:
        return MathProTypography.editorExpression.copyWith(
          fontSize: 18,
          height: 1.06,
          color: const Color(0xFFF4F6F6),
        );
    }
  }
}

class _PremiumMathFallback extends StatelessWidget {
  const _PremiumMathFallback({
    required this.expression,
    required this.tex,
    required this.role,
    required this.textAlign,
  });

  final String expression;
  final String tex;
  final MathRenderSurfaceRole role;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final baseStyle = switch (role) {
      MathRenderSurfaceRole.editor => MathProTypography.editorExpression.copyWith(fontSize: 26),
      MathRenderSurfaceRole.result => MathProTypography.resultText.copyWith(fontSize: 22),
      MathRenderSurfaceRole.inline => MathProTypography.editorExpression.copyWith(fontSize: 17),
    };
    final display = MathExpressionRenderBridge.safeFallbackLabel(expression: expression, tex: tex);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(8, 10, 12, 0.66),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color.fromRGBO(127, 199, 184, 0.24), width: 0.8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          display,
          maxLines: 1,
          overflow: TextOverflow.fade,
          softWrap: false,
          textAlign: textAlign,
          style: baseStyle.copyWith(
            letterSpacing: -0.2,
            color: role == MathRenderSurfaceRole.result ? const Color(0xFF6FAAFF) : const Color(0xFFEFF6F4),
          ),
        ),
      ),
    );
  }
}
