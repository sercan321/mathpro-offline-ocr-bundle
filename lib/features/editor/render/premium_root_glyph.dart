import 'package:flutter/material.dart';

import '../../../theme/mathpro_tokens.dart';

class PremiumRootGlyph extends StatelessWidget {
  const PremiumRootGlyph({super.key, this.size = 28});

  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size * 1.65, size),
      painter: _PremiumRootGlyphPainter(),
    );
  }
}

class _PremiumRootGlyphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = MathProColors.text
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.85
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path()
      ..moveTo(size.width * 0.04, size.height * 0.63)
      ..lineTo(size.width * 0.20, size.height * 0.63)
      ..lineTo(size.width * 0.34, size.height * 0.86)
      ..lineTo(size.width * 0.51, size.height * 0.20)
      ..lineTo(size.width * 0.97, size.height * 0.20);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
