import 'dart:math' as math;
import 'dart:ui';

import '../editor/selection_controller.dart';

/// V172-Q115 — Structural caret anchor geometry repair.
///
/// Q115 is intentionally a narrow cursor/editor geometry repair. It does not
/// switch MathLive into the main workspace, does not delete the legacy cursor
/// stack, and does not mutate keyboard, MORE, long-press, AppShell, MathLabel,
/// TemplateTray, Graph, History, or Solution surfaces.
///
/// User-facing law for an empty structural slot remains strict: the caret must
/// render as `|□` from the same slot/placeholder geometry that hit-testing
/// selected. It may not sit inside the placeholder, on top of the placeholder,
/// or detached from it in a stale linear fallback lane.
class MathLiveStructuralCaretAnchorGeometryRepairPolicy {
  const MathLiveStructuralCaretAnchorGeometryRepairPolicy._();

  static const String version =
      'mathpro-v172q115-structural-caret-anchor-geometry-repair-guard-v1';

  static const bool structuralCaretAnchorGeometryRepairAvailable = true;
  static const bool cursorOnlyChange = true;
  static const bool emptyPlaceholderLeadingRailLocked = true;
  static const bool caretMayOverlapPlaceholder = false;
  static const bool detachedLinearFallbackCaretAllowed = false;
  static const bool hitRectMayPaintCaret = false;
  static const bool mathLiveMainEditorSwitchAllowedInThisPackage = false;
  static const bool mathLiveDefaultEditorEnabled = false;
  static const bool legacyCursorDeletionAllowed = false;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool realDeviceCursorPassClaimed = false;
  static const bool photomathWolframLevelClaimed = false;

  static const Set<String> q108StructuralRoles = <String>{
    'placeholder',
    'fractionNumerator',
    'fractionDenominator',
    'sqrtValue',
    'rootIndex',
    'powerExponent',
    'subscript',
    'logBase',
    'functionArgument',
    'functionArgument2',
    'functionArgument3',
    'integralUpperLimit',
    'integralLowerLimit',
    'integralBody',
    'integralDifferential',
    'sumUpperLimit',
    'sumLowerLimit',
    'sumBody',
    'productUpperLimit',
    'productLowerLimit',
    'productBody',
    'limitVariable',
    'limitTarget',
    'limitBody',
  };

  static bool ownsRole(String role) => q108StructuralRoles.contains(role);

  static Rect anchorActiveEmptyCaret({
    required Rect candidate,
    required Rect visualRect,
    required Rect placeholderRect,
    required String role,
    required Size canvasSize,
  }) {
    if (!ownsRole(role) || canvasSize.isEmpty) return _clampToCanvas(candidate, canvasSize);
    final height = _activeEmptyCaretHeight(
      role: role,
      candidate: candidate,
      visualRect: visualRect,
      placeholderRect: placeholderRect,
    );
    final gap = leadingGapForRole(role);
    final left = placeholderRect.left - gap - MathProCaretController.inlineCaretWidth;
    final top = placeholderRect.center.dy - height / 2;
    final anchored = Rect.fromLTWH(left, top, MathProCaretController.inlineCaretWidth, height);
    return _clampLeadingRail(
      anchored,
      placeholderRect: placeholderRect,
      visualRect: visualRect,
      canvasSize: canvasSize,
      gap: gap,
    );
  }

  static Rect anchorFilledStructuralCaret({
    required Rect candidate,
    required Rect visualRect,
    required Rect placeholderRect,
    required String role,
    required Size canvasSize,
  }) {
    if (!ownsRole(role) || canvasSize.isEmpty) return _clampToCanvas(candidate, canvasSize);
    final verticalGuard = math.max(4.0, visualRect.height * 0.18);
    final minTop = math.max(0.0, visualRect.top - verticalGuard);
    final maxTop = math.max(minTop, math.min(canvasSize.height - candidate.height, visualRect.bottom + verticalGuard - candidate.height));
    var left = candidate.left;
    var top = candidate.top.clamp(minTop, maxTop).toDouble();

    // Filled structural slots may expose character-level stops, but the caret
    // must not sit on the empty placeholder outline. If the candidate still
    // collides with the placeholder, move it to the nearest local rail rather
    // than the detached global linear lane.
    final guardedPlaceholder = placeholderRect.inflate(0.75);
    final adjustedCandidate = Rect.fromLTWH(left, top, candidate.width, candidate.height);
    if (adjustedCandidate.overlaps(guardedPlaceholder)) {
      final leftRail = placeholderRect.left - leadingGapForRole(role) - candidate.width;
      final rightRail = placeholderRect.right + leadingGapForRole(role);
      final chooseLeft = (candidate.center.dx - leftRail).abs() <= (candidate.center.dx - rightRail).abs();
      left = chooseLeft ? leftRail : rightRail;
      top = placeholderRect.center.dy - candidate.height / 2;
    }

    final local = Rect.fromLTWH(left, top, candidate.width, candidate.height);
    return _clampToVisualEnvelope(local, visualRect: visualRect, canvasSize: canvasSize);
  }

  static Rect anchorPaintedCaret({
    required Rect candidate,
    required Rect visualRect,
    required Rect placeholderRect,
    required String role,
    required Size canvasSize,
    required bool activeEmptySlotLeadingRail,
  }) {
    return activeEmptySlotLeadingRail
        ? anchorActiveEmptyCaret(
            candidate: candidate,
            visualRect: visualRect,
            placeholderRect: placeholderRect,
            role: role,
            canvasSize: canvasSize,
          )
        : anchorFilledStructuralCaret(
            candidate: candidate,
            visualRect: visualRect,
            placeholderRect: placeholderRect,
            role: role,
            canvasSize: canvasSize,
          );
  }

  static bool isAnchoredPipeBoxCaret({
    required Rect caretRect,
    required Rect placeholderRect,
    required String role,
  }) {
    final gap = placeholderRect.left - caretRect.right;
    final verticalDelta = (caretRect.center.dy - placeholderRect.center.dy).abs();
    return gap >= 0.75 &&
        gap <= math.max(3.4, leadingGapForRole(role) + 1.0) &&
        !caretRect.overlaps(placeholderRect) &&
        caretRect.right <= placeholderRect.left &&
        verticalDelta <= math.max(2.6, placeholderRect.height * 0.18);
  }

  static bool isDetachedFromPlaceholder({
    required Rect caretRect,
    required Rect placeholderRect,
    required String role,
  }) {
    final gap = (placeholderRect.left - caretRect.right).abs();
    final verticalDelta = (caretRect.center.dy - placeholderRect.center.dy).abs();
    return gap > math.max(6.0, leadingGapForRole(role) + 3.0) ||
        verticalDelta > math.max(5.0, placeholderRect.height * 0.30);
  }

  static double leadingGapForRole(String role) {
    return switch (role) {
      'integralUpperLimit' ||
      'integralLowerLimit' ||
      'rootIndex' ||
      'logBase' ||
      'powerExponent' ||
      'subscript' ||
      'limitVariable' ||
      'limitTarget' => 1.35,
      'integralDifferential' => 1.45,
      'fractionNumerator' || 'fractionDenominator' => 1.55,
      'sqrtValue' ||
      'functionArgument' ||
      'functionArgument2' ||
      'functionArgument3' ||
      'integralBody' ||
      'sumBody' ||
      'productBody' ||
      'limitBody' => 1.75,
      _ => 1.8,
    };
  }

  static double _activeEmptyCaretHeight({
    required String role,
    required Rect candidate,
    required Rect visualRect,
    required Rect placeholderRect,
  }) {
    final target = switch (role) {
      'integralUpperLimit' ||
      'integralLowerLimit' ||
      'rootIndex' ||
      'logBase' ||
      'powerExponent' ||
      'subscript' ||
      'limitVariable' ||
      'limitTarget' => math.max(11.0, placeholderRect.height * 0.90),
      'fractionNumerator' || 'fractionDenominator' => math.max(13.0, placeholderRect.height * 0.94),
      'integralDifferential' => math.max(14.0, placeholderRect.height * 1.00),
      'sqrtValue' ||
      'functionArgument' ||
      'functionArgument2' ||
      'functionArgument3' ||
      'integralBody' => math.max(16.0, placeholderRect.height * 1.02),
      _ => math.max(14.0, placeholderRect.height * 0.96),
    };
    final maxHeight = math.min(visualRect.height + 6.0, switch (role) {
      'integralUpperLimit' ||
      'integralLowerLimit' ||
      'rootIndex' ||
      'logBase' ||
      'powerExponent' ||
      'subscript' => 20.0,
      'fractionNumerator' || 'fractionDenominator' => 24.0,
      _ => 34.0,
    });
    final fallback = candidate.height.isFinite && candidate.height > 0 ? candidate.height : target;
    return math.max(target, fallback * 0.88).clamp(10.0, math.max(10.0, maxHeight)).toDouble();
  }

  static Rect _clampLeadingRail(
    Rect rect, {
    required Rect placeholderRect,
    required Rect visualRect,
    required Size canvasSize,
    required double gap,
  }) {
    final width = math.min(rect.width, canvasSize.width);
    final height = math.min(rect.height, canvasSize.height);
    final maxTop = math.max(0.0, canvasSize.height - height);
    final top = rect.top.clamp(0.0, maxTop).toDouble();
    final maxAllowedLeft = placeholderRect.left - gap - width;
    var left = rect.left;
    if (maxAllowedLeft.isFinite) left = math.min(left, maxAllowedLeft);
    final minVisualLeft = math.max(0.0, visualRect.left - math.max(8.0, visualRect.width * 0.24));
    if (maxAllowedLeft >= minVisualLeft) {
      left = left.clamp(minVisualLeft, maxAllowedLeft).toDouble();
    } else {
      // Extreme left-edge safety: keep the caret as far left of the placeholder
      // as the canvas permits and never intentionally fall back to □|.
      left = math.max(0.0, math.min(left, maxAllowedLeft));
    }
    final maxLeft = math.max(0.0, canvasSize.width - width);
    return Rect.fromLTWH(left.clamp(0.0, maxLeft).toDouble(), top, width, height);
  }

  static Rect _clampToVisualEnvelope(
    Rect rect, {
    required Rect visualRect,
    required Size canvasSize,
  }) {
    final width = math.min(rect.width, canvasSize.width);
    final height = math.min(rect.height, canvasSize.height);
    final horizontalGuard = math.max(4.0, visualRect.width * 0.12);
    final verticalGuard = math.max(4.0, visualRect.height * 0.16);
    final minLeft = math.max(0.0, visualRect.left - horizontalGuard);
    final maxLeft = math.min(math.max(0.0, canvasSize.width - width), math.max(minLeft, visualRect.right + horizontalGuard - width));
    final minTop = math.max(0.0, visualRect.top - verticalGuard);
    final maxTop = math.min(math.max(0.0, canvasSize.height - height), math.max(minTop, visualRect.bottom + verticalGuard - height));
    return Rect.fromLTWH(
      rect.left.clamp(minLeft, maxLeft).toDouble(),
      rect.top.clamp(minTop, maxTop).toDouble(),
      width,
      height,
    );
  }

  static Rect _clampToCanvas(Rect rect, Size canvasSize) {
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
