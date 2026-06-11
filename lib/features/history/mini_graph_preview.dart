import 'package:flutter/material.dart';

import '../graph/graph_models.dart';
import '../graph/graph_surface.dart';
import 'history_style.dart';

class MiniGraphPreview extends StatelessWidget {
  const MiniGraphPreview({super.key, required this.expression});

  final GraphExpression expression;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: HistoryStyle.innerSurface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: HistoryStyle.accent.withValues(alpha: 0.18)),
        boxShadow: const <BoxShadow>[BoxShadow(color: Color(0x33000000), blurRadius: 14, offset: Offset(0, 8))],
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(1.2),
        child: GraphSurface(expression: expression, compact: true),
      ),
    );
  }
}
