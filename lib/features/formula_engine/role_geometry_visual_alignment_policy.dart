import 'dart:math' as math;
import 'dart:ui';

import '../editor/slot_registry.dart';

/// V172-Q53 P6-locked role-geometry polish for structural cursor boxes.
///
/// Q52 established the active empty-slot optical law (`|□`).  Q53 keeps that
/// law and tightens the role-specific geometry for the real-device problem
/// families reported by the user: fraction, function argument, radical/radicand,
/// integral limits/body/differential, log base/argument, powers and subscripts.
///
/// This is still cursor/editor geometry only. It does not mutate keyboard key
/// order, key faces, MORE, long-press popup, app shell, MathLabel, template tray,
/// Solution, Graph, History, solver logic, or visible slot styling.
class RoleGeometryVisualAlignmentPolicy {
  const RoleGeometryVisualAlignmentPolicy._();

  static const String version =
      'mathpro-v172q53-integral-root-fraction-function-role-geometry-repair-p6-locked-v1';

  static const bool q53RoleGeometryRepairAvailable = true;
  static const bool fractionFunctionRootIntegralGeometryPolishAvailable = true;
  static const bool activeEmptySlotLeadingRailPreserved = true;
  static const bool caretInsidePlaceholderAllowed = false;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool fullNativeMathRendererClaimed = false;
  static const bool trueAstSlotToSvgNodeIdentityClaimed = false;
  static const bool realDevicePlus95PassClaimed = false;

  static const Set<String> repairedRoles = <String>{
    'fractionNumerator',
    'fractionDenominator',
    'functionArgument',
    'functionArgument2',
    'functionArgument3',
    'sqrtValue',
    'rootIndex',
    'integralUpperLimit',
    'integralLowerLimit',
    'integralBody',
    'integralDifferential',
    'logBase',
    'powerExponent',
    'subscript',
  };

  static bool ownsRole(String role) => repairedRoles.contains(role);

  static Rect refineVisualRect({
    required SlotEntry entry,
    required Rect calibratedRect,
    required Rect deterministicRect,
    required Size canvasSize,
  }) {
    if (!ownsRole(entry.role) || canvasSize.isEmpty) return deterministicRect;
    final size = preferredVisualSizeForRole(
      role: entry.role,
      calibratedRect: calibratedRect,
      deterministicRect: deterministicRect,
      canvasSize: canvasSize,
    );
    final center = preferredCenterForRole(
      role: entry.role,
      calibratedRect: calibratedRect,
      deterministicRect: deterministicRect,
      canvasSize: canvasSize,
    );
    return _clampRect(Rect.fromCenter(center: center, width: size.width, height: size.height), canvasSize);
  }

  static Size preferredVisualSizeForRole({
    required String role,
    required Rect calibratedRect,
    required Rect deterministicRect,
    required Size canvasSize,
  }) {
    final base = switch (role) {
      'fractionNumerator' || 'fractionDenominator' => const Size(58, 40),
      'functionArgument' || 'functionArgument2' || 'functionArgument3' => const Size(64, 52),
      'sqrtValue' => const Size(62, 52),
      'rootIndex' => const Size(42, 30),
      'integralUpperLimit' || 'integralLowerLimit' => const Size(42, 30),
      'integralBody' => const Size(58, 48),
      'integralDifferential' => const Size(38, 32),
      'logBase' || 'powerExponent' || 'subscript' => const Size(42, 30),
      _ => Size(deterministicRect.width, deterministicRect.height),
    };
    final minWidth = math.max(base.width * 0.72, calibratedRect.width * 0.82);
    final minHeight = math.max(base.height * 0.72, calibratedRect.height * 0.82);
    final width = math.max(minWidth, math.min(base.width, canvasSize.width * 0.34));
    final height = math.max(minHeight, math.min(base.height, canvasSize.height * 0.42));
    return Size(width.clamp(24.0, canvasSize.width).toDouble(), height.clamp(20.0, canvasSize.height).toDouble());
  }

  static Offset preferredCenterForRole({
    required String role,
    required Rect calibratedRect,
    required Rect deterministicRect,
    required Size canvasSize,
  }) {
    final rawCenter = calibratedRect.center;
    final deterministicCenter = deterministicRect.center;
    final x = _blend(rawCenter.dx, deterministicCenter.dx, 0.22)
        .clamp(8.0, math.max(8.0, canvasSize.width - 8.0))
        .toDouble();
    final yBlend = switch (role) {
      'integralUpperLimit' || 'integralLowerLimit' || 'integralDifferential' ||
      'integralBody' || 'sqrtValue' || 'functionArgument' ||
      'functionArgument2' || 'functionArgument3' => 0.10,
      'fractionNumerator' || 'fractionDenominator' => 0.18,
      'rootIndex' || 'logBase' || 'powerExponent' || 'subscript' => 0.24,
      _ => 0.28,
    };
    final y = _blend(rawCenter.dy, deterministicCenter.dy, yBlend)
        .clamp(8.0, math.max(8.0, canvasSize.height - 8.0))
        .toDouble();
    return Offset(x, y);
  }

  static Rect refinePlaceholderRect({
    required String role,
    required Object type,
    required Rect visualRect,
    required Rect placeholderRect,
  }) {
    if (!ownsRole(role)) return placeholderRect;
    final factor = switch (role) {
      'integralUpperLimit' || 'integralLowerLimit' || 'rootIndex' || 'logBase' ||
      'powerExponent' || 'subscript' => 0.70,
      'integralDifferential' => 0.72,
      'fractionNumerator' || 'fractionDenominator' => 0.72,
      'sqrtValue' || 'functionArgument' || 'functionArgument2' ||
      'functionArgument3' || 'integralBody' => 0.74,
      _ => 0.70,
    };
    final minSide = switch (role) {
      'integralUpperLimit' || 'integralLowerLimit' || 'rootIndex' || 'logBase' ||
      'powerExponent' || 'subscript' => 13.0,
      'integralDifferential' => 14.0,
      _ => 16.0,
    };
    final width = math.max(minSide, math.min(visualRect.width * factor, placeholderRect.width));
    final height = math.max(minSide, math.min(visualRect.height * factor, placeholderRect.height));
    return Rect.fromCenter(center: visualRect.center, width: width, height: height);
  }

  static double caretHeightForRole({
    required String role,
    required Object type,
    required Rect visualRect,
    required Rect placeholderRect,
    required double nativeHeight,
  }) {
    final target = switch (role) {
      'integralUpperLimit' || 'integralLowerLimit' => math.max(12.0, placeholderRect.height * 0.92),
      'integralDifferential' => math.max(15.0, placeholderRect.height * 1.02),
      'integralBody' => math.max(17.0, placeholderRect.height * 1.04),
      'fractionNumerator' || 'fractionDenominator' => math.max(14.0, placeholderRect.height * 0.94),
      'sqrtValue' || 'functionArgument' || 'functionArgument2' || 'functionArgument3' => math.max(17.0, placeholderRect.height * 1.04),
      'rootIndex' || 'logBase' || 'powerExponent' || 'subscript' => math.max(11.0, placeholderRect.height * 0.88),
      _ => nativeHeight,
    };
    final maxHeight = switch (role) {
      'integralUpperLimit' || 'integralLowerLimit' || 'rootIndex' ||
      'logBase' || 'powerExponent' || 'subscript' => 20.0,
      'fractionNumerator' || 'fractionDenominator' => 24.0,
      _ => 34.0,
    };
    return target.clamp(math.min(nativeHeight, target), maxHeight).toDouble();
  }

  static Rect finalizeActiveEmptyCaret({
    required Rect candidate,
    required Rect placeholderRect,
    required Size canvasSize,
    required String role,
  }) {
    if (!ownsRole(role)) return candidate;
    final gap = leadingGapForRole(role);
    final width = candidate.width;
    final left = placeholderRect.left - gap - width;
    final top = (placeholderRect.center.dy - candidate.height / 2)
        .clamp(0.0, math.max(0.0, canvasSize.height - candidate.height))
        .toDouble();
    final unclamped = Rect.fromLTWH(left, top, width, candidate.height);
    return _clampRect(unclamped, canvasSize);
  }

  static double leadingGapForRole(String role) {
    return switch (role) {
      'integralUpperLimit' || 'integralLowerLimit' || 'rootIndex' ||
      'logBase' || 'powerExponent' || 'subscript' => 1.5,
      'integralDifferential' => 1.6,
      'fractionNumerator' || 'fractionDenominator' => 1.7,
      'sqrtValue' || 'functionArgument' || 'functionArgument2' ||
      'functionArgument3' || 'integralBody' => 1.9,
      _ => 2.0,
    };
  }

  static bool isCaretImmediatelyBeforePlaceholder({
    required Rect caretRect,
    required Rect placeholderRect,
    required String role,
  }) {
    final gap = placeholderRect.left - caretRect.right;
    final maxGap = math.max(3.2, leadingGapForRole(role) + 0.8);
    final verticalDelta = (caretRect.center.dy - placeholderRect.center.dy).abs();
    return gap >= 0.8 && gap <= maxGap && !caretRect.overlaps(placeholderRect) && verticalDelta <= math.max(2.5, placeholderRect.height * 0.20);
  }

  static double _blend(double a, double b, double amount) => a + (b - a) * amount;

  static Rect _clampRect(Rect rect, Size canvasSize) {
    if (canvasSize.isEmpty) return rect;
    final width = math.min(rect.width, canvasSize.width);
    final height = math.min(rect.height, canvasSize.height);
    final maxLeft = math.max(0.0, canvasSize.width - width);
    final maxTop = math.max(0.0, canvasSize.height - height);
    return Rect.fromLTWH(
      rect.left.clamp(0.0, maxLeft).toDouble(),
      rect.top.clamp(0.0, maxTop).toDouble(),
      width,
      height,
    );
  }
}
