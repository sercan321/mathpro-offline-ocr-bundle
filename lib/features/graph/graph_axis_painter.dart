import 'package:flutter/material.dart';

import 'graph_style.dart';

class GraphAxisPainter extends CustomPainter {
  const GraphAxisPainter({this.xZeroFraction = 0.5, this.yZeroFraction = 0.5});

  final double xZeroFraction;
  final double yZeroFraction;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    final axis = Paint()
      ..color = GraphStyle.axis
      ..strokeWidth = 1.1;
    final x = size.width * xZeroFraction.clamp(0.0, 1.0);
    final y = size.height * (1 - yZeroFraction.clamp(0.0, 1.0));
    canvas.drawLine(Offset(x, 0), Offset(x, size.height), axis);
    canvas.drawLine(Offset(0, y), Offset(size.width, y), axis);
  }

  @override
  bool shouldRepaint(covariant GraphAxisPainter oldDelegate) {
    return oldDelegate.xZeroFraction != xZeroFraction || oldDelegate.yZeroFraction != yZeroFraction;
  }
}
