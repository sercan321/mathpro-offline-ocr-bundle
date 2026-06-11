import 'dart:math' as math;
import 'dart:ui';

import 'active_empty_slot_leading_rail_caret_policy.dart';
import 'slot_geometry_bundle_authority.dart';

/// V172-Q57 final painted-caret rail guard for the existing MathPro cursor motor.
///
/// Q52 defined the user-facing optical law: an active empty slot must render as
/// `|□`. Q55 made SlotGeometryBundle the single geometry authority and Q56 made
/// structural intent beat detached linear fallback. Q57 is the final rendering
/// guard: when a selected structural slot is empty, the painted caret is forced
/// to the bundle leading rail, not to hitRect, not inside the placeholder, and
/// not to a detached linear caret position.
class ActiveEmptySlotLeadingRailFinalizerPolicy {
  const ActiveEmptySlotLeadingRailFinalizerPolicy._();

  static const String version =
      'mathpro-v172q57-active-empty-slot-leading-rail-finalizer-bundle-authority-p6-locked-v1';

  static const bool activeEmptySlotLeadingRailFinalizerAvailable = true;
  static const bool paintedCaretUsesBundleLeadingRail = true;
  static const bool emptySlotCaretFinalizationOverridesCandidate = true;
  static const bool hitRectCaretDriftAllowed = false;
  static const bool detachedLinearFallbackCaretAllowedForEmptyStructuralSlot = false;
  static const bool placeholderOverlapAllowed = false;
  static const bool defaultExitRailForEmptySlotAllowed = false;
  static const bool filledSlotCaretStopsPreserved = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool realDevicePlus95PassClaimed = false;

  static bool shouldFinalizeAsLeadingRail({required String? payload}) {
    return ActiveEmptySlotLeadingRailCaretPolicy.isEmptyStructuralPayload(payload);
  }

  static Rect finalizePaintedCaret({
    required Rect candidate,
    required SlotGeometryBundle bundle,
    required String? payload,
    required Size canvasSize,
  }) {
    if (!shouldFinalizeAsLeadingRail(payload: payload)) {
      return candidate;
    }
    return leadingRailFromBundle(bundle: bundle, canvasSize: canvasSize);
  }

  static Rect leadingRailFromBundle({
    required SlotGeometryBundle bundle,
    required Size canvasSize,
  }) {
    final rail = bundle.leadingRailRect;
    if (isFinalizedLeadingRail(caretRect: rail, bundle: bundle)) {
      return _clampToCanvas(rail, canvasSize);
    }
    final repaired = ActiveEmptySlotLeadingRailCaretPolicy.leadingRailCaretRect(
      visualRect: bundle.visualRect,
      placeholderRect: bundle.placeholderRect,
      role: bundle.role,
      type: bundle.type,
      baselineY: bundle.baselineY,
      canvasSize: canvasSize,
    );
    return _clampToCanvas(repaired, canvasSize);
  }

  static bool isFinalizedLeadingRail({
    required Rect caretRect,
    required SlotGeometryBundle bundle,
  }) {
    final gap = bundle.placeholderRect.left - caretRect.right;
    final verticalCenterDelta = (caretRect.center.dy - bundle.placeholderRect.center.dy).abs();
    return caretRect.width > 0 &&
        caretRect.height > 0 &&
        !caretRect.overlaps(bundle.placeholderRect) &&
        caretRect.right <= bundle.placeholderRect.left &&
        gap >= ActiveEmptySlotLeadingRailCaretPolicy.minOpticalGapPx - 0.25 &&
        gap <= ActiveEmptySlotLeadingRailCaretPolicy.maxOpticalGapPx + 0.25 &&
        verticalCenterDelta <= math.max(3.0, bundle.placeholderRect.height * 0.24);
  }

  static bool provesPipeBoxLaw({required Rect caretRect, required SlotGeometryBundle bundle}) {
    return isFinalizedLeadingRail(caretRect: caretRect, bundle: bundle) &&
        caretRect.right <= bundle.placeholderRect.left &&
        !caretRect.overlaps(bundle.placeholderRect);
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
