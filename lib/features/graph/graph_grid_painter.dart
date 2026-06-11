import 'package:flutter/material.dart';

import 'graph_style.dart';

class GraphGridPainter extends CustomPainter {
  const GraphGridPainter({this.divisions = 8});

  final int divisions;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || divisions <= 0) return;
    final minor = Paint()
      ..color = GraphStyle.gridMinor
      ..strokeWidth = 0.6;
    final major = Paint()
      ..color = GraphStyle.gridMajor
      ..strokeWidth = 0.9;
    for (var i = 0; i <= divisions; i++) {
      final dx = size.width * i / divisions;
      final dy = size.height * i / divisions;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), i == divisions ~/ 2 ? major : minor);
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), i == divisions ~/ 2 ? major : minor);
    }
  }

  @override
  bool shouldRepaint(covariant GraphGridPainter oldDelegate) => oldDelegate.divisions != divisions;
}
