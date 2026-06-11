import 'dart:ui';

import '../editor/slot_registry.dart';

/// Central touch-target calibration for MathPro structural slots.
///
/// The visual renderer can change later, but this policy keeps the interaction
/// contract stable: small mathematical zones such as integral limits, root
/// indices, powers, and matrix cells must remain tappable on mobile.
class SlotInteractionCalibrationPolicy {
  const SlotInteractionCalibrationPolicy._();

  static const String version = 'mathpro-v66-v105-premium-slot-interaction-calibration-matrix-system-cells';
  static const double minimumMobileTarget = 56;
  static const double preferredStructuralTarget = 96;
  static const double premiumFingerTarget = 112;

  static double minTouchSizeForRole(String role, double proposed) {
    final roleMinimum = switch (role) {
      'integralUpperLimit' || 'integralLowerLimit' => 88.0,
      'integralBody' => 82.0,
      'integralDifferential' => 72.0,
      'sumUpperLimit' || 'sumLowerLimit' || 'productUpperLimit' || 'productLowerLimit' => 82.0,
      'sumBody' || 'productBody' => 78.0,
      'sqrtValue' || 'fractionNumerator' || 'fractionDenominator' => 88.0,
      'powerExponent' || 'rootIndex' => 76.0,
      'powerBase' => 68.0,
      'subscript' => 88.0,
      'subscriptBase' => 68.0,
      'logBase' => 92.0,
      'derivativeOrder' => 82.0,
      'derivativeBody' => 116.0,
      'derivativeVariable' => 76.0,
      'functionArgument' => 128.0,
      'matrixCell' => 84.0,
      'systemLeft' || 'systemRight' || 'piecewiseExpression' || 'piecewiseCondition' => 84.0,
      'placeholder' => 124.0,
      _ => minimumMobileTarget,
    };
    return proposed < roleMinimum ? roleMinimum : proposed;
  }

  static Rect normalizeRectForCanvas(Rect rect, Size canvasSize, SlotEntry entry) {
    final minTarget = minTouchSizeForRole(entry.role, entry.minTouchSize);
    final width = rect.width < minTarget ? minTarget : rect.width;
    final height = rect.height < minTarget ? minTarget : rect.height;
    final expanded = Rect.fromCenter(center: rect.center, width: width, height: height);
    return clampRectToCanvas(expanded, canvasSize);
  }

  /// Keeps the visible highlight/caret rect inside the editor canvas without
  /// promoting it to a large finger target. Phase C separates visual geometry
  /// from hit geometry; do not use this method to size mobile touch areas.
  static Rect clampVisualRectToCanvas(Rect rect, Size canvasSize) => clampRectToCanvas(rect, canvasSize);

  static Rect clampRectToCanvas(Rect rect, Size canvasSize) {
    if (canvasSize.isEmpty) return rect;
    final width = rect.width > canvasSize.width ? canvasSize.width : rect.width;
    final height = rect.height > canvasSize.height ? canvasSize.height : rect.height;
    final left = rect.left.clamp(0.0, canvasSize.width - width).toDouble();
    final top = rect.top.clamp(0.0, canvasSize.height - height).toDouble();
    return Rect.fromLTWH(left, top, width, height);
  }

  static SlotHitSlop slopForRole(String role) {
    switch (role) {
      case 'sqrtValue':
      case 'fractionNumerator':
      case 'fractionDenominator':
      case 'integralUpperLimit':
      case 'integralLowerLimit':
      case 'sumUpperLimit':
      case 'sumLowerLimit':
      case 'productUpperLimit':
      case 'productLowerLimit':
        return const SlotHitSlop(left: 42, right: 42, top: 40, bottom: 40);
      case 'rootIndex':
      case 'powerExponent':
      case 'derivativeOrder':
      case 'derivativeVariable':
        return const SlotHitSlop(left: 38, right: 36, top: 42, bottom: 34);
      case 'subscript':
        return const SlotHitSlop(left: 54, right: 58, top: 36, bottom: 58);
      case 'logBase':
        return const SlotHitSlop(left: 58, right: 54, top: 42, bottom: 58);
      case 'derivativeBody':
        return const SlotHitSlop(left: 108, right: 108, top: 80, bottom: 80);
      case 'functionArgument':
        return const SlotHitSlop(left: 128, right: 128, top: 92, bottom: 92);
      case 'placeholder':
        return const SlotHitSlop(left: 118, right: 118, top: 86, bottom: 86);
      case 'matrixCell':
      case 'systemLeft':
      case 'systemRight':
      case 'piecewiseExpression':
      case 'piecewiseCondition':
        return const SlotHitSlop(left: 34, right: 34, top: 34, bottom: 34);
      default:
        return const SlotHitSlop(left: 58, right: 58, top: 52, bottom: 52);
    }
  }

  static double nearestFallbackRadiusForRole(String role) {
    return switch (role) {
      'functionArgument' => 136.0,
      'derivativeBody' => 124.0,
      'derivativeVariable' => 58.0,
      'integralUpperLimit' || 'integralLowerLimit' => 64.0,
      'sqrtValue' || 'fractionNumerator' || 'fractionDenominator' => 58.0,
      'powerExponent' || 'rootIndex' || 'derivativeOrder' => 54.0,
      'subscript' || 'logBase' => 72.0,
      'matrixCell' => 72.0,
      'systemLeft' || 'systemRight' || 'piecewiseExpression' || 'piecewiseCondition' => 72.0,
      'placeholder' => 132.0,
      _ => 78.0,
    };
  }

  static int roleOrder(String role) {
    const order = <String, int>{
      'fractionNumerator': 10,
      'fractionDenominator': 11,
      'rootIndex': 20,
      'sqrtValue': 21,
      'powerBase': 30,
      'powerExponent': 31,
      'subscriptBase': 32,
      'subscript': 33,
      'logBase': 34,
      'derivativeOrder': 35,
      'derivativeBody': 36,
      'derivativeVariable': 37,
      'integralLowerLimit': 40,
      'integralUpperLimit': 41,
      'integralBody': 42,
      'integralDifferential': 43,
      'sumUpperLimit': 50,
      'sumLowerLimit': 51,
      'sumBody': 52,
      'productUpperLimit': 53,
      'productLowerLimit': 54,
      'productBody': 55,
      'limitVariable': 60,
      'limitTarget': 61,
      'limitBody': 62,
      'functionArgument': 70,
      'matrixCell': 80,
      'systemLeft': 82,
      'systemRight': 83,
      'piecewiseExpression': 84,
      'piecewiseCondition': 85,
      'placeholder': 90,
    };
    return order[role] ?? 1000;
  }

}

class SlotHitSlop {
  const SlotHitSlop({required this.left, required this.right, required this.top, required this.bottom});

  final double left;
  final double right;
  final double top;
  final double bottom;

  Rect inflate(Rect rect) => Rect.fromLTRB(rect.left - left, rect.top - top, rect.right + right, rect.bottom + bottom);
}
