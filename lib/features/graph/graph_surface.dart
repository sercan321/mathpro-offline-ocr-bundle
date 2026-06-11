import 'package:flutter/material.dart';

import 'graph_models.dart';
import 'graph_painter.dart';
import 'graph_style.dart';

class GraphSurface extends StatelessWidget {
  const GraphSurface({super.key, required this.expression, this.compact = false, this.pixelTight = false});

  final GraphExpression expression;
  final bool compact;
  final bool pixelTight;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(pixelTight ? 11 : compact ? 13 : 18),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: GraphStyle.canvas,
          gradient: GraphStyle.premiumSurfaceGradient,
          border: Border.all(color: pixelTight ? GraphStyle.graphiteLine.withValues(alpha: 0.82) : GraphStyle.tealBorder.withValues(alpha: compact ? 0.20 : 0.30)),
          borderRadius: BorderRadius.circular(pixelTight ? 11 : compact ? 13 : 18),
          boxShadow: compact || pixelTight ? null : GraphStyle.surfaceShadow,
        ),
        child: CustomPaint(
          key: ValueKey(compact ? 'mathpro-mini-graph-surface' : 'mathpro-graph-surface'),
          painter: GraphPainter(expression: expression, compact: compact, pixelTight: pixelTight),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}
