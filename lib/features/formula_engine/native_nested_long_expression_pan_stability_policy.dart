import 'dart:math' as math;
import 'dart:ui';

import 'drag_to_move_cursor_stability_policy.dart';
import 'long_expression_pan_nested_cursor_stability_policy.dart';
import 'slot_geometry_bundle_authority.dart';

/// V172-Q79 — Nested / long expression / pan stability for the native SlotBox
/// input surface.
///
/// Q79 is still cursor/editor-only. It does not mutate keyboard layout, MORE,
/// long-press popup, app shell, MathLabel, template tray, Solution, Graph, or
/// History. Its job is to make the Q71-Q78 SlotBox pipeline safe on real phone
/// interaction patterns: nested structures, long expressions, and viewport pan
/// gestures must not emit detached linear carets or stale-geometry slot jumps.
class NativeNestedLongExpressionPanStabilityPolicy {
  const NativeNestedLongExpressionPanStabilityPolicy._();

  static const String version =
      'mathpro-v172q79-native-nested-long-expression-pan-stability-v1';

  static const bool nativeNestedLongExpressionPanStabilityAvailable = true;
  static const bool cursorOnlyChange = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool fullNativeMathRendererClaimed = false;
  static const bool trueAstSlotToSvgNodeIdentityClaimed = false;
  static const bool realDevicePlus95PassClaimed = false;

  static const bool nestedSelectionUsesDeepestMeasuredSlotBox = true;
  static const bool panSourceMayNotEmitDetachedLinearCaret = true;
  static const bool panSourceMayNotSwitchStructuralSlotInLongExpression = true;
  static const bool activeVisibilityTargetUsesNativeCaretRail = true;
  static const bool transformStaleGeometryRejected = true;
  static const bool longExpressionKeepsSingleInputSurfaceFrame = true;

  static const double nestedCaretVisibilityInflation = 46.0;
  static const double longExpressionCaretVisibilityInflation = 56.0;
  static const double compactRoleVisibilityInflation = 40.0;

  static bool isNativeLongSurfaceCandidate({
    required String expression,
    required Iterable<SlotGeometryBundle> bundles,
  }) {
    final list = bundles.toList(growable: false);
    if (LongExpressionPanNestedCursorStabilityPolicy.isLongExpressionStressCandidate(expression)) {
      return true;
    }
    if (list.length >= 4) return true;
    return maxBundleDepth(list) >= 2 || list.any((bundle) => _isCompactNestedRole(bundle.role));
  }

  /// Pan gestures are viewport navigation in long/nested expressions. They must
  /// not also emit structural-slot changes or detached linear carets while the
  /// canvas transform is moving underneath the finger.
  static bool shouldSuppressPointerSourceForPan({
    required String source,
    required String expression,
    required Iterable<SlotGeometryBundle> bundles,
  }) {
    if (!DragToMoveCursorStabilityPolicy.isDragSource(source)) return false;
    return isNativeLongSurfaceCandidate(expression: expression, bundles: bundles);
  }

  /// Resolves only among measured candidates whose authoritative hitRect
  /// already contains [point]. No nearest/visual fallback is introduced here.
  /// The only tie-break is deterministic: deepest structural owner, smallest
  /// distance to native caret/placeholder geometry, then priority/role/id.
  static SlotGeometryBundle? resolveNestedCandidate({
    required Offset point,
    required Iterable<SlotGeometryBundle> candidates,
  }) {
    final measured = candidates
        .where((bundle) => bundle.hitRect.contains(point))
        .map((bundle) => _NestedCandidate(bundle: bundle, score: _score(point: point, bundle: bundle)))
        .toList(growable: false);
    if (measured.isEmpty) return null;
    if (measured.length == 1) return measured.first.bundle;
    measured.sort(_compareNestedCandidates);
    return measured.first.bundle;
  }

  static Rect activeVisibilityTargetForBundle({
    required SlotGeometryBundle bundle,
    required bool activeEmptySlot,
    required int caretIndex,
    required int childCount,
    required Size canvasSize,
    required String expression,
  }) {
    final caret = SlotGeometryBundleAuthority.caretRectForBundle(
      bundle: bundle,
      caretIndex: caretIndex,
      childCount: childCount,
      activeEmptySlotLeadingRail: activeEmptySlot,
      canvasSize: canvasSize,
    );
    final inflation = _visibilityInflationForRole(
      expression: expression,
      role: bundle.role,
      activeEmptySlot: activeEmptySlot,
    );
    final guard = activeEmptySlot ? bundle.placeholderRect : bundle.innerTextRect;
    return _union(caret.inflate(inflation), guard.inflate(math.max(10.0, inflation * 0.42)));
  }

  static bool activeTargetUsesNativeCaretRail({
    required SlotGeometryBundle bundle,
    required Rect target,
    required bool activeEmptySlot,
  }) {
    final source = activeEmptySlot ? bundle.leadingRailRect : bundle.innerTextRect;
    return target.inflate(0.5).contains(source.center) && target.overlaps(bundle.visualRect.inflate(72.0));
  }

  static bool frameGeometryLooksStable({
    required Size canvasSize,
    required Iterable<SlotGeometryBundle> bundles,
  }) {
    if (canvasSize.isEmpty) return false;
    for (final bundle in bundles) {
      if (!_rectWithinCanvas(bundle.hitRect, canvasSize)) return false;
      if (!_rectWithinCanvas(bundle.visualRect, canvasSize)) return false;
      if (!_rectWithinCanvas(bundle.leadingRailRect, canvasSize)) return false;
      if (bundle.leadingRailRect == bundle.hitRect) return false;
    }
    return true;
  }

  static int maxBundleDepth(Iterable<SlotGeometryBundle> bundles) {
    var maxDepth = 0;
    for (final bundle in bundles) {
      maxDepth = math.max(maxDepth, bundle.entry.depth);
    }
    return maxDepth;
  }

  static int roleOrder(String role) {
    return switch (role) {
      'integralDifferential' => 5,
      'integralUpperLimit' || 'integralLowerLimit' => 6,
      'rootIndex' || 'logBase' || 'powerExponent' || 'subscript' => 7,
      'fractionNumerator' || 'fractionDenominator' => 8,
      'sqrtValue' || 'functionArgument' || 'functionArgument2' || 'functionArgument3' => 9,
      'integralBody' => 10,
      _ => 100,
    };
  }

  static double _score({required Offset point, required SlotGeometryBundle bundle}) {
    final caretDistance = math.min(
      _distanceToRect(point, bundle.leadingRailRect),
      _distanceToRect(point, bundle.trailingRailRect),
    );
    final placeholderDistance = _distanceToRect(point, bundle.placeholderRect);
    final innerDistance = _distanceToRect(point, bundle.innerTextRect);
    final visualDistance = _distanceToRect(point, bundle.visualRect);
    final depthBonus = -bundle.entry.depth * 100.0;
    final priorityBonus = -bundle.entry.priority * 0.015;
    final roleBonus = roleOrder(bundle.role) * 0.01;
    final compactBonus = _isCompactNestedRole(bundle.role) ? -8.0 : 0.0;
    return depthBonus +
        priorityBonus +
        roleBonus +
        compactBonus +
        placeholderDistance * 0.48 +
        innerDistance * 0.24 +
        caretDistance * 0.18 +
        visualDistance * 0.10;
  }

  static int _compareNestedCandidates(_NestedCandidate a, _NestedCandidate b) {
    final score = a.score.compareTo(b.score);
    if (score != 0) return score;
    final depth = b.bundle.entry.depth.compareTo(a.bundle.entry.depth);
    if (depth != 0) return depth;
    final priority = b.bundle.entry.priority.compareTo(a.bundle.entry.priority);
    if (priority != 0) return priority;
    final role = roleOrder(a.bundle.role).compareTo(roleOrder(b.bundle.role));
    if (role != 0) return role;
    return a.bundle.slotId.compareTo(b.bundle.slotId);
  }

  static double _visibilityInflationForRole({
    required String expression,
    required String role,
    required bool activeEmptySlot,
  }) {
    if (_isCompactNestedRole(role)) return compactRoleVisibilityInflation;
    if (LongExpressionPanNestedCursorStabilityPolicy.isLongExpressionStressCandidate(expression)) {
      return longExpressionCaretVisibilityInflation;
    }
    return activeEmptySlot ? nestedCaretVisibilityInflation : nestedCaretVisibilityInflation - 6.0;
  }

  static bool _isCompactNestedRole(String role) {
    return switch (role) {
      'integralUpperLimit' || 'integralLowerLimit' || 'integralDifferential' ||
      'rootIndex' || 'logBase' || 'powerExponent' || 'subscript' => true,
      _ => false,
    };
  }

  static Rect _union(Rect a, Rect b) {
    return Rect.fromLTRB(
      math.min(a.left, b.left),
      math.min(a.top, b.top),
      math.max(a.right, b.right),
      math.max(a.bottom, b.bottom),
    );
  }

  static bool _rectWithinCanvas(Rect rect, Size canvasSize) {
    final canvas = Offset.zero & canvasSize;
    return canvas.contains(rect.topLeft) && canvas.contains(rect.bottomRight);
  }

  static double _distanceToRect(Offset point, Rect rect) {
    final dx = point.dx < rect.left ? rect.left - point.dx : point.dx > rect.right ? point.dx - rect.right : 0.0;
    final dy = point.dy < rect.top ? rect.top - point.dy : point.dy > rect.bottom ? point.dy - rect.bottom : 0.0;
    return math.sqrt(dx * dx + dy * dy);
  }
}

class _NestedCandidate {
  const _NestedCandidate({required this.bundle, required this.score});

  final SlotGeometryBundle bundle;
  final double score;
}
