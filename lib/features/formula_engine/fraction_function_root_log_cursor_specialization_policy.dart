import 'dart:math' as math;
import 'dart:ui';

/// V172-Q59 specialization for non-integral core editor families.
///
/// The MathPro cursor motor already exists. Q59 does not replace it and does not
/// touch keyboard, MORE, long-press, app shell, MathLabel, template tray,
/// Solution, Graph, or History. It specializes the Q54-Q58 structural-first
/// cursor pipeline for fraction, function, radical/root and log templates so
/// active empty slots preserve the user-facing `|□` law and taps near these
/// templates do not fall back to detached linear caret positions.
class FractionFunctionRootLogCursorSpecializationPolicy {
  const FractionFunctionRootLogCursorSpecializationPolicy._();

  static const String version =
      'mathpro-v172q59-fraction-function-root-log-cursor-specialization-p6-locked-v1';

  static const bool fractionFunctionRootLogSpecializationAvailable = true;
  static const bool nonIntegralCoreFamiliesSpecialized = true;
  static const bool fractionUsesPipeBoxLaw = true;
  static const bool functionArgumentUsesPipeBoxLaw = true;
  static const bool rootRadicandUsesPipeBoxLaw = true;
  static const bool logBaseAndArgumentUsePipeBoxLaw = true;
  static const bool activeEmptyCoreSlotsUseLeadingRail = true;
  static const bool coreTemplateLinearFallbackAllowed = false;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool realDevicePlus95PassClaimed = false;

  static const Set<String> specializedRoles = <String>{
    'fractionNumerator',
    'fractionDenominator',
    'functionArgument',
    'functionArgument2',
    'functionArgument3',
    'sqrtValue',
    'rootIndex',
    'logBase',
  };

  static bool isSpecializedRole(String role) => specializedRoles.contains(role);

  static bool isFractionRole(String role) => role == 'fractionNumerator' || role == 'fractionDenominator';

  static bool isFunctionArgumentRole(String role) =>
      role == 'functionArgument' || role == 'functionArgument2' || role == 'functionArgument3';

  static bool isRootRole(String role) => role == 'sqrtValue' || role == 'rootIndex';

  static bool isLogRole(String role) => role == 'logBase' || isFunctionArgumentRole(role);

  static double hitSlopForRole(String role, double fallback) {
    return switch (role) {
      'fractionNumerator' || 'fractionDenominator' => math.max(fallback, 48.0),
      'functionArgument' || 'functionArgument2' || 'functionArgument3' => math.max(fallback, 46.0),
      'sqrtValue' => math.max(fallback, 48.0),
      'rootIndex' => math.max(fallback, 42.0),
      'logBase' => math.max(fallback, 44.0),
      _ => fallback,
    };
  }

  static double minimumTouchSizeForRole(String role, double fallback) {
    return switch (role) {
      'fractionNumerator' || 'fractionDenominator' => math.max(fallback, 80.0),
      'functionArgument' || 'functionArgument2' || 'functionArgument3' => math.max(fallback, 78.0),
      'sqrtValue' => math.max(fallback, 82.0),
      'rootIndex' => math.max(fallback, 66.0),
      'logBase' => math.max(fallback, 70.0),
      _ => fallback,
    };
  }

  static double nearestRadiusForRole(String role, double fallback) {
    return switch (role) {
      'fractionNumerator' || 'fractionDenominator' => math.max(fallback, 214.0),
      'functionArgument' || 'functionArgument2' || 'functionArgument3' => math.max(fallback, 204.0),
      'sqrtValue' => math.max(fallback, 218.0),
      'rootIndex' => math.max(fallback, 176.0),
      'logBase' => math.max(fallback, 184.0),
      _ => fallback,
    };
  }

  static Rect refineHitRectForRole({
    required String role,
    required Rect visualRect,
    required Rect baseHitRect,
    required Size canvasSize,
  }) {
    if (!isSpecializedRole(role) || canvasSize.isEmpty) return baseHitRect;
    final extraLeft = switch (role) {
      'fractionNumerator' || 'fractionDenominator' => 26.0,
      'functionArgument' || 'functionArgument2' || 'functionArgument3' => 30.0,
      'sqrtValue' => 34.0,
      'rootIndex' => 22.0,
      'logBase' => 26.0,
      _ => 0.0,
    };
    final extraRight = switch (role) {
      'fractionNumerator' || 'fractionDenominator' => 30.0,
      'functionArgument' || 'functionArgument2' || 'functionArgument3' => 38.0,
      'sqrtValue' => 40.0,
      'rootIndex' => 24.0,
      'logBase' => 26.0,
      _ => 0.0,
    };
    final extraTop = switch (role) {
      'fractionNumerator' || 'rootIndex' => 22.0,
      'fractionDenominator' || 'logBase' => 10.0,
      _ => 18.0,
    };
    final extraBottom = switch (role) {
      'fractionNumerator' || 'rootIndex' => 10.0,
      'fractionDenominator' || 'logBase' => 22.0,
      _ => 18.0,
    };
    return _clampRect(
      Rect.fromLTRB(
        math.min(baseHitRect.left, visualRect.left - extraLeft),
        math.min(baseHitRect.top, visualRect.top - extraTop),
        math.max(baseHitRect.right, visualRect.right + extraRight),
        math.max(baseHitRect.bottom, visualRect.bottom + extraBottom),
      ),
      canvasSize,
    );
  }

  static Rect refinePlaceholderRectForRole({
    required String role,
    required Rect visualRect,
    required Rect placeholderRect,
  }) {
    if (!isSpecializedRole(role)) return placeholderRect;
    final widthFactor = switch (role) {
      'fractionNumerator' || 'fractionDenominator' => 0.68,
      'functionArgument' || 'functionArgument2' || 'functionArgument3' => 0.72,
      'sqrtValue' => 0.74,
      'rootIndex' => 0.62,
      'logBase' => 0.64,
      _ => 1.0,
    };
    final heightFactor = switch (role) {
      'fractionNumerator' || 'fractionDenominator' => 0.68,
      'functionArgument' || 'functionArgument2' || 'functionArgument3' => 0.72,
      'sqrtValue' => 0.74,
      'rootIndex' => 0.62,
      'logBase' => 0.64,
      _ => 1.0,
    };
    final minSide = switch (role) {
      'rootIndex' || 'logBase' => 13.0,
      'fractionNumerator' || 'fractionDenominator' => 15.0,
      _ => 16.0,
    };
    final dx = switch (role) {
      'sqrtValue' => math.max(0.0, visualRect.width * 0.04),
      'functionArgument' || 'functionArgument2' || 'functionArgument3' => math.max(0.0, visualRect.width * 0.03),
      _ => 0.0,
    };
    final center = visualRect.center + Offset(dx, 0);
    return Rect.fromCenter(
      center: center,
      width: math.max(minSide, math.min(placeholderRect.width, visualRect.width * widthFactor)),
      height: math.max(minSide, math.min(placeholderRect.height, visualRect.height * heightFactor)),
    );
  }

  static Rect refineLeadingRailRectForRole({
    required String role,
    required Rect candidate,
    required Rect placeholderRect,
    required Size canvasSize,
  }) {
    if (!isSpecializedRole(role)) return candidate;
    final width = candidate.width;
    final height = candidate.height;
    final gap = leadingGapForRole(role);
    final left = placeholderRect.left - gap - width;
    final top = placeholderRect.center.dy - height / 2;
    return _clampRect(Rect.fromLTWH(left, top, width, height), canvasSize);
  }

  static Rect refineInnerTextRectForRole({
    required String role,
    required Rect visualRect,
    required Rect placeholderRect,
    required Rect baseInnerTextRect,
  }) {
    if (!isSpecializedRole(role)) return baseInnerTextRect;
    if (role == 'rootIndex' || role == 'logBase') {
      return placeholderRect.inflate(1.6).intersect(visualRect.inflate(1.6));
    }
    final left = math.max(visualRect.left, placeholderRect.left - 2.0);
    final right = math.min(visualRect.right, placeholderRect.right + 4.0);
    final top = math.max(visualRect.top, placeholderRect.top - 2.0);
    final bottom = math.min(visualRect.bottom, placeholderRect.bottom + 2.0);
    final refined = Rect.fromLTRB(left, top, right, bottom);
    return refined.isEmpty ? baseInnerTextRect : refined;
  }

  static double roleBonus(String role) {
    return switch (role) {
      'fractionNumerator' || 'fractionDenominator' => -24.0,
      'functionArgument' || 'functionArgument2' || 'functionArgument3' => -21.0,
      'sqrtValue' => -23.0,
      'rootIndex' => -17.0,
      'logBase' => -19.0,
      _ => 0.0,
    };
  }

  static double lanePenalty({required Offset point, required String role, required Rect visualRect}) {
    if (!isSpecializedRole(role)) return 0.0;
    final dy = point.dy - visualRect.center.dy;
    if (role == 'fractionNumerator' && dy > visualRect.height * 0.70) return 30.0;
    if (role == 'fractionDenominator' && dy < -visualRect.height * 0.70) return 30.0;
    if (role == 'rootIndex' && (point.dx > visualRect.center.dx + visualRect.width * 0.62 || dy > visualRect.height * 0.60)) {
      return 28.0;
    }
    if (role == 'logBase' && dy < -visualRect.height * 0.56) return 24.0;
    return 0.0;
  }

  static bool shouldSuppressLinearFallbackForCoreRegion({
    required Offset point,
    required Iterable<Rect> coreHitRects,
  }) {
    for (final rect in coreHitRects) {
      if (rect.inflate(20.0).contains(point)) return true;
    }
    return false;
  }

  static double leadingGapForRole(String role) {
    return switch (role) {
      'rootIndex' || 'logBase' => 1.25,
      'fractionNumerator' || 'fractionDenominator' => 1.35,
      'functionArgument' || 'functionArgument2' || 'functionArgument3' => 1.45,
      'sqrtValue' => 1.55,
      _ => 1.5,
    };
  }

  static bool provesPipeBoxLaw({required Rect caretRect, required Rect placeholderRect}) {
    final gap = placeholderRect.left - caretRect.right;
    return caretRect.right <= placeholderRect.left && !caretRect.overlaps(placeholderRect) && gap >= 0.65 && gap <= 3.2;
  }

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
