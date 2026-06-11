import 'package:flutter/material.dart';

import 'graph_style.dart';

class GraphTraceOverlay extends StatelessWidget {
  const GraphTraceOverlay({super.key, required this.xLabel, required this.yLabel});

  final String xLabel;
  final String yLabel;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: GraphStyle.cardAlt.withValues(alpha: 0.78),
        gradient: GraphStyle.controlGradient,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: GraphStyle.accent.withValues(alpha: 0.32)),
        boxShadow: GraphStyle.controlShadow(active: true),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('x = $xLabel', style: const TextStyle(color: GraphStyle.axisLabel, fontSize: 11, fontWeight: FontWeight.w700)),
            const SizedBox(width: 10),
            Text('y = $yLabel', style: const TextStyle(color: GraphStyle.accent, fontSize: 13, fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }
}
