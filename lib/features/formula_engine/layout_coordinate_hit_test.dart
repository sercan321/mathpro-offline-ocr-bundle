import 'dart:ui';

class LayoutCoordinateHitTest {
  const LayoutCoordinateHitTest._();

  static const version = 'flutter-phase7-layout-coordinate-hit-test-v1';
  static const double edgeGuardPx = 5;

  static int chooseCaretIndexFromSlotRect({
    required Rect rect,
    required Offset point,
    required int childCount,
  }) {
    if (childCount <= 0) return 0;
    final localX = (point.dx - rect.left).clamp(0.0, rect.width).toDouble();
    if (localX <= edgeGuardPx) return 0;
    if (localX >= rect.width - edgeGuardPx) return childCount;
    return ((localX / rect.width) * childCount).round().clamp(0, childCount);
  }
}
