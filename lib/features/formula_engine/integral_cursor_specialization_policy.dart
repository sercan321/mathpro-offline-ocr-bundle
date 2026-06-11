import 'dart:math' as math;
import 'dart:ui';

/// V172-Q58 integral cursor specialization for the existing MathPro cursor motor.
///
/// The MathPro cursor motor already exists. Q58 does not replace it and does not
/// touch keyboard, MORE, long-press, app shell, MathLabel, template tray,
/// Solution, Graph, or History. It specializes the existing Q54-Q57 pipeline for
/// the real-device integral failure family: upper/lower/body/differential taps
/// must remain structural-first and empty integral slots must paint as `|□`,
/// especially the differential target as `d|□`, without drifting to the left
/// edge of the expression or into detached linear fallback.
class IntegralCursorSpecializationPolicy {
  const IntegralCursorSpecializationPolicy._();

  static const String version =
      'mathpro-v172q58-integral-cursor-specialization-differential-leading-rail-p6-locked-v1';

  static const bool integralCursorSpecializationAvailable = true;
  static const bool upperLowerBodyDifferentialRolesSpecialized = true;
  static const bool differentialUsesDPipeBoxLaw = true;
  static const bool integralTemplateLinearFallbackAllowed = false;
  static const bool integralCaretLeftVoidDriftAllowed = false;
  static const bool activeEmptyIntegralSlotsUseLeadingRail = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool realDevicePlus95PassClaimed = false;

  static const Set<String> integralRoles = <String>{
    'integralUpperLimit',
    'integralLowerLimit',
    'integralBody',
    'integralDifferential',
  };

  static bool isIntegralRole(String role) => integralRoles.contains(role);

  static bool isDifferentialRole(String role) => role == 'integralDifferential';

  static double hitSlopForRole(String role, double fallback) {
    return switch (role) {
      'integralUpperLimit' || 'integralLowerLimit' => math.max(fallback, 54.0),
      'integralBody' => math.max(fallback, 50.0),
      'integralDifferential' => math.max(fallback, 58.0),
      _ => fallback,
    };
  }

  static double minimumTouchSizeForRole(String role, double fallback) {
    return switch (role) {
      'integralUpperLimit' || 'integralLowerLimit' => math.max(fallback, 88.0),
      'integralBody' => math.max(fallback, 84.0),
      'integralDifferential' => math.max(fallback, 92.0),
      _ => fallback,
    };
  }

  static double nearestRadiusForRole(String role, double fallback) {
    return switch (role) {
      'integralUpperLimit' || 'integralLowerLimit' => math.max(fallback, 248.0),
      'integralBody' => math.max(fallback, 232.0),
      'integralDifferential' => math.max(fallback, 260.0),
      _ => fallback,
    };
  }

  static Rect refineHitRectForRole({
    required String role,
    required Rect visualRect,
    required Rect baseHitRect,
    required Size canvasSize,
  }) {
    if (!isIntegralRole(role) || canvasSize.isEmpty) return baseHitRect;
    final extraLeft = switch (role) {
      'integralUpperLimit' || 'integralLowerLimit' => 18.0,
      'integralBody' => 16.0,
      'integralDifferential' => 34.0,
      _ => 0.0,
    };
    final extraRight = switch (role) {
      'integralUpperLimit' || 'integralLowerLimit' => 20.0,
      'integralBody' => 28.0,
      'integralDifferential' => 44.0,
      _ => 0.0,
    };
    final extraTop = switch (role) {
      'integralUpperLimit' => 22.0,
      'integralLowerLimit' => 8.0,
      'integralBody' => 18.0,
      'integralDifferential' => 18.0,
      _ => 0.0,
    };
    final extraBottom = switch (role) {
      'integralUpperLimit' => 8.0,
      'integralLowerLimit' => 22.0,
      'integralBody' => 18.0,
      'integralDifferential' => 18.0,
      _ => 0.0,
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
    if (!isIntegralRole(role)) return placeholderRect;
    final widthFactor = switch (role) {
      'integralUpperLimit' || 'integralLowerLimit' => 0.64,
      'integralBody' => 0.70,
      'integralDifferential' => 0.66,
      _ => 1.0,
    };
    final heightFactor = switch (role) {
      'integralUpperLimit' || 'integralLowerLimit' => 0.66,
      'integralBody' => 0.72,
      'integralDifferential' => 0.70,
      _ => 1.0,
    };
    final dx = switch (role) {
      // The differential placeholder sits visually after the `d` glyph. Keeping
      // the placeholder slightly right-biased makes the leading rail read as
      // d|□ instead of |d□ on real devices.
      'integralDifferential' => math.max(1.0, visualRect.width * 0.08),
      _ => 0.0,
    };
    final center = visualRect.center + Offset(dx, 0);
    return Rect.fromCenter(
      center: center,
      width: math.max(13.0, math.min(placeholderRect.width, visualRect.width * widthFactor)),
      height: math.max(13.0, math.min(placeholderRect.height, visualRect.height * heightFactor)),
    );
  }

  static double baselineForRole(String role, Rect visualRect, double fallback) {
    return switch (role) {
      'integralUpperLimit' || 'integralLowerLimit' => visualRect.top + visualRect.height * 0.56,
      'integralBody' => visualRect.top + visualRect.height * 0.61,
      'integralDifferential' => visualRect.top + visualRect.height * 0.58,
      _ => fallback,
    };
  }

  static Rect refineLeadingRailRectForRole({
    required String role,
    required Rect candidate,
    required Rect placeholderRect,
    required Size canvasSize,
  }) {
    if (!isIntegralRole(role)) return candidate;
    final width = candidate.width;
    final height = candidate.height;
    final gap = switch (role) {
      'integralDifferential' => 1.15,
      'integralUpperLimit' || 'integralLowerLimit' => 1.35,
      'integralBody' => 1.55,
      _ => 1.5,
    };
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
    if (!isIntegralRole(role)) return baseInnerTextRect;
    if (role == 'integralDifferential') {
      final left = math.max(visualRect.left, placeholderRect.left - 2.0);
      return Rect.fromLTRB(left, visualRect.top + 2.0, visualRect.right, visualRect.bottom - 2.0);
    }
    return baseInnerTextRect;
  }

  static double roleBonus(String role) {
    return switch (role) {
      'integralDifferential' => -28.0,
      'integralUpperLimit' || 'integralLowerLimit' => -24.0,
      'integralBody' => -20.0,
      _ => 0.0,
    };
  }

  static double lanePenalty({required Offset point, required String role, required Rect visualRect}) {
    if (!isIntegralRole(role)) return 0.0;
    final dy = point.dy - visualRect.center.dy;
    if (role == 'integralUpperLimit' && dy > visualRect.height * 0.74) return 34.0;
    if (role == 'integralLowerLimit' && dy < -visualRect.height * 0.74) return 34.0;
    if (role == 'integralDifferential' && point.dx < visualRect.left - 68.0) return 36.0;
    return 0.0;
  }

  static bool shouldSuppressLinearFallbackForIntegralRegion({
    required Offset point,
    required Iterable<Rect> integralHitRects,
  }) {
    // Q65R3: integral hit rects are already deliberately widened by
    // SlotGeometryBundleAuthority and Q58 role specialization. Re-inflating
    // them here caused far bottom/right canvas points to be treated as inside
    // the integral envelope, which made detached linear fallback suppression too
    // aggressive. The suppression gate now trusts the authoritative bundle
    // hitRect exactly: inside the expanded structural hit target is suppressed;
    // outside remains available for normal linear caret behavior.
    for (final rect in integralHitRects) {
      if (rect.contains(point)) return true;
    }
    return false;
  }

  static bool provesDifferentialPipeBoxLaw({required Rect caretRect, required Rect placeholderRect}) {
    final gap = placeholderRect.left - caretRect.right;
    return caretRect.right <= placeholderRect.left && !caretRect.overlaps(placeholderRect) && gap >= 0.65 && gap <= 2.8;
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
