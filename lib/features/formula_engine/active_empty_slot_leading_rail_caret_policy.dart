import 'dart:math' as math;
import 'dart:ui';

import '../editor/selection_controller.dart';
import 'role_geometry_visual_alignment_policy.dart';

/// V172-Q52 P6-locked active empty-slot leading-rail caret policy.
///
/// User-facing optical law: active empty structural slots render as `|□`.
/// The caret stays immediately before the placeholder square, never inside the
/// placeholder and never as the default exit rail `□|`. Filled slots keep the
/// existing digit/content caret stops.
class ActiveEmptySlotLeadingRailCaretPolicy {
  const ActiveEmptySlotLeadingRailCaretPolicy._();

  static const String version =
      'mathpro-v172q52-active-empty-slot-leading-rail-caret-repair-v172q53-role-geometry-p6-locked-v2';

  static const bool activeEmptySlotLeadingRailCaretAvailable = true;
  static const bool activeEmptySlotLeadingRailAvailable = true;
  static const bool emptySlotCaretRendersAsLeadingRailBox = true;
  static const bool emptyActiveSlotRendersAsLeadingRail = true;
  static const bool activeEmptySlotCaretInsidePlaceholderAllowed = false;
  static const bool emptySlotCaretInsidePlaceholderAllowed = false;
  static const bool emptySlotExitRailDefaultAllowed = false;
  static const bool filledSlotDigitStopsPreserved = true;
  static const bool p6VisualFilesLocked = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool fullNativeMathRendererClaimed = false;
  static const bool trueAstSlotToSvgNodeIdentityClaimed = false;
  static const bool realDevicePlus95PassClaimed = false;
  static const bool q53OwnsRoleGeometryPolish = true;
  static const bool q53RoleGeometryVisualAlignmentAvailable = true;

  static const double minOpticalGapPx = 1.2;
  static const double maxOpticalGapPx = 3.0;

  static bool isEmptySlotPayload(String? payload) {
    final clean = payload?.trim();
    return clean == null || clean.isEmpty || clean == '□';
  }

  static bool isEmptyStructuralPayload(String? payload) {
    return isEmptySlotPayload(payload);
  }

  static int caretIndexForEmptyActiveSlot({required int requestedCaretIndex}) {
    return 0;
  }

  static bool shouldForceLeadingRail({
    required String? payload,
    required String role,
  }) {
    return isEmptySlotPayload(payload);
  }

  static Rect leadingRailCaretRect({
    required Rect visualRect,
    required Rect placeholderRect,
    required String role,
    required Object type,
    required double baselineY,
    required Size canvasSize,
    double? caretHeight,
  }) {
    final height = caretHeight ?? _emptySlotCaretHeight(type: type, visualRect: visualRect, placeholderRect: placeholderRect);
    final top = _emptySlotCaretTop(
      visualRect: visualRect,
      placeholderRect: placeholderRect,
      type: type,
      height: height,
      baselineY: baselineY,
    );
    final gap = opticalGapForType(type);
    final candidate = Rect.fromLTWH(
      placeholderRect.left - gap - MathProCaretController.inlineCaretWidth,
      top,
      MathProCaretController.inlineCaretWidth,
      height,
    );
    final clamped = _clampLeadingRailWithoutEnteringPlaceholder(
      candidate,
      placeholderRect: placeholderRect,
      canvasSize: canvasSize,
      gap: gap,
    );
    return RoleGeometryVisualAlignmentPolicy.finalizeActiveEmptyCaret(
      candidate: clamped,
      placeholderRect: placeholderRect,
      canvasSize: canvasSize,
      role: role,
    );
  }

  static double opticalGapForType(Object type) {
    final name = type.toString();
    if (name.contains('scriptSlot') || name.contains('logBaseSlot') ||
        name.contains('rootIndexSlot') || name.contains('limitSlot')) {
      return 1.6;
    }
    if (name.contains('fractionSlot')) return 1.8;
    return 2.0;
  }

  static bool isLeadingRailCompliant({
    required Rect caretRect,
    required Rect placeholderRect,
  }) {
    return isLeadingRailAligned(caretRect: caretRect, placeholderRect: placeholderRect);
  }

  static bool isLeadingRailAligned({
    required Rect caretRect,
    required Rect placeholderRect,
  }) {
    final gap = placeholderRect.left - caretRect.right;
    final verticalCenterDelta = (caretRect.center.dy - placeholderRect.center.dy).abs();
    return gap >= minOpticalGapPx - 0.25 &&
        gap <= maxOpticalGapPx + 0.25 &&
        !caretRect.overlaps(placeholderRect) &&
        verticalCenterDelta <= math.max(3.0, placeholderRect.height * 0.22);
  }


  static Rect enforceLeadingRail({
    required Rect candidate,
    required Rect visualRect,
    required Rect placeholderRect,
    required String role,
    Object? type,
    required double baselineY,
    required Size canvasSize,
  }) {
    if (isLeadingRailAligned(caretRect: candidate, placeholderRect: placeholderRect)) {
      return candidate;
    }
    return leadingRailCaretRect(
      visualRect: visualRect,
      placeholderRect: placeholderRect,
      role: role,
      type: type ?? role,
      baselineY: baselineY,
      canvasSize: canvasSize,
    );
  }

  static double _emptySlotCaretHeight({
    required Object type,
    required Rect visualRect,
    required Rect placeholderRect,
  }) {
    final nativeHeight = _preferredHeightForType(type: type, visualRect: visualRect);
    final target = math.max(nativeHeight, placeholderRect.height * 0.78);
    final maxHeight = math.max(nativeHeight, placeholderRect.height + 8.0);
    return target.clamp(nativeHeight, maxHeight).toDouble();
  }

  static double _emptySlotCaretTop({
    required Rect visualRect,
    required Rect placeholderRect,
    required Object type,
    required double height,
    required double baselineY,
  }) {
    final centeredTop = placeholderRect.center.dy - height / 2;
    final baselineTop = baselineY - height * _baselineLiftForType(type);
    final blended = centeredTop * 0.82 + baselineTop * 0.18;
    final minTop = visualRect.top - 6.0;
    final maxTop = math.max(minTop, visualRect.bottom + 6.0 - height);
    return blended.clamp(minTop, maxTop).toDouble();
  }

  static double _baselineLiftForType(Object type) {
    final name = type.toString();
    if (name.contains('scriptSlot') || name.contains('logBaseSlot') ||
        name.contains('rootIndexSlot') || name.contains('limitSlot')) {
      return 0.52;
    }
    return 0.50;
  }

  static double _preferredHeightForType({required Object type, required Rect visualRect}) {
    final name = type.toString();
    final factor = name.contains('scriptSlot') || name.contains('logBaseSlot') || name.contains('rootIndexSlot')
        ? 0.40
        : name.contains('limitSlot')
            ? 0.44
            : name.contains('fractionSlot')
                ? 0.54
                : name.contains('functionArgumentSlot')
                    ? 0.64
                    : 0.62;
    final minHeight = name.contains('scriptSlot') || name.contains('logBaseSlot') || name.contains('rootIndexSlot')
        ? 11.0
        : name.contains('limitSlot')
            ? 12.0
            : name.contains('fractionSlot')
                ? 14.0
                : 17.0;
    final maxHeight = name.contains('scriptSlot') || name.contains('logBaseSlot') || name.contains('rootIndexSlot')
        ? 18.0
        : name.contains('limitSlot')
            ? 20.0
            : name.contains('fractionSlot')
                ? 24.0
                : 34.0;
    return (visualRect.height * factor).clamp(minHeight, maxHeight).toDouble();
  }

  static Rect _clampLeadingRailWithoutEnteringPlaceholder(
    Rect candidate, {
    required Rect placeholderRect,
    required Size canvasSize,
    required double gap,
  }) {
    if (canvasSize.isEmpty) return candidate;
    final width = candidate.width;
    final height = candidate.height;
    final maxLeft = math.max(0.0, canvasSize.width - width);
    final maxTop = math.max(0.0, canvasSize.height - height);
    var left = candidate.left.clamp(0.0, maxLeft).toDouble();
    final top = candidate.top.clamp(0.0, maxTop).toDouble();
    final maxAllowedLeft = placeholderRect.left - gap - width;
    if (left > maxAllowedLeft && maxAllowedLeft >= 0) {
      left = maxAllowedLeft;
    }
    return Rect.fromLTWH(left, top, width, height);
  }
}
