import 'dart:ui';

import 'active_empty_slot_leading_rail_caret_policy.dart';
import 'active_empty_slot_leading_rail_finalizer_policy.dart';
import 'slot_geometry_bundle_authority.dart';

/// V172-Q74 — Native exclusive `|□` caret renderer.
///
/// This is deliberately editor/cursor-only.  It does not paint or mutate the
/// keyboard, MORE tray, long-press popup, app shell, MathLabel, TemplateTray,
/// Graph, History, or Solution surfaces.
///
/// Hard law: when an active structural slot is empty, the only valid rendered
/// caret is the leading pipe immediately before the placeholder box: `|□`.
/// The renderer may not use the placeholder center, trailing rail, hitRect, or
/// detached linear fallback as the painted caret source for empty slots.
class NativeExclusivePlaceholderCaretRendererPolicy {
  const NativeExclusivePlaceholderCaretRendererPolicy._();

  static const String version =
      'mathpro-v172q74-native-exclusive-pipe-box-caret-renderer-v1';

  static const bool nativeExclusiveCaretRendererAvailable = true;
  static const bool cursorOnlyChange = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool realDevicePlus95PassClaimed = false;

  static const bool emptySlotUsesLeadingRailOnly = true;
  static const bool emptySlotMayUseHitRectForCaret = false;
  static const bool emptySlotMayUseTrailingRail = false;
  static const bool emptySlotMayUseLinearFallbackCaret = false;
  static const String exclusiveEmptySlotVisualLaw = '|□';

  static Rect exclusiveCaretForEmptySlot({
    required SlotGeometryBundle bundle,
    required Rect candidate,
    required String? payload,
    required Size canvasSize,
  }) {
    final finalized = ActiveEmptySlotLeadingRailFinalizerPolicy.finalizePaintedCaret(
      candidate: candidate,
      bundle: bundle,
      payload: payload ?? '□',
      canvasSize: canvasSize,
    );
    if (isExclusivePipeBoxCaret(caretRect: finalized, bundle: bundle)) {
      return finalized;
    }
    return ActiveEmptySlotLeadingRailCaretPolicy.enforceLeadingRail(
      candidate: finalized,
      visualRect: bundle.visualRect,
      placeholderRect: bundle.placeholderRect,
      role: bundle.role,
      type: 'placeholder',
      baselineY: bundle.baselineY,
      canvasSize: canvasSize,
    );
  }

  static bool isExclusivePipeBoxCaret({
    required Rect caretRect,
    required SlotGeometryBundle bundle,
  }) {
    if (!ActiveEmptySlotLeadingRailCaretPolicy.isLeadingRailAligned(
      caretRect: caretRect,
      placeholderRect: bundle.placeholderRect,
    )) {
      return false;
    }
    if (caretRect.overlaps(bundle.placeholderRect)) return false;
    if (caretRect == bundle.hitRect) return false;
    if (caretRect == bundle.trailingRailRect) return false;
    return caretRect.right <= bundle.placeholderRect.left + 0.75;
  }

  static bool forbidsInvalidEmptySlotCaret(Rect caretRect, SlotGeometryBundle bundle) {
    return caretRect != bundle.hitRect &&
        caretRect != bundle.trailingRailRect &&
        !caretRect.overlaps(bundle.placeholderRect);
  }
}
