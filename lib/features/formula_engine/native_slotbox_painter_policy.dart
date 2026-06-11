import 'dart:math' as math;
import 'dart:ui';

import 'active_empty_slot_leading_rail_caret_policy.dart';
import 'native_exclusive_placeholder_caret_renderer_policy.dart';
import 'slot_geometry_bundle_authority.dart';

/// V172-Q72 Native SlotBox painter foundation.
///
/// Q72 deliberately stays in the editor/cursor surface only. It does not paint
/// keyboard keys, MORE, long-press popups, app shell, Graph, History, or
/// Solution. The purpose is narrower and stricter: when the editor paints a
/// caret/slot surface, the paint model must be derived from the same immutable
/// [SlotGeometryBundle] that hit-testing uses. That prevents the previous drift
/// where the visual placeholder, tap target, and caret rail could be produced
/// by different geometry paths.
class NativeSlotBoxPainterPolicy {
  const NativeSlotBoxPainterPolicy._();

  static const String version =
      'mathpro-v172q75-native-slotbox-painter-shared-slotgeometrybundle-source-v2';

  static const bool nativeSlotBoxPainterAvailable = true;
  static const bool cursorOnlyChange = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool fullNativeMathRendererClaimed = false;
  static const bool realDevicePlus95PassClaimed = false;

  /// Painter, caret, and hit-test must share [SlotGeometryBundle].
  static const bool painterUsesSlotGeometryBundle = true;
  static const bool painterHasIndependentRectMath = false;
  static const bool painterMayUseHitRectForCaret = false;
  static const bool emptySlotPainterMustEmitLeadingCaret = true;
  static const bool q74ExclusiveCaretRendererWired = true;
  static const String emptySlotPaintLaw = '|□';

  /// Visible focus/debug slot boxes remain opt-in. The normal app surface keeps
  /// MathJax/WebView as the visible math layer while this painter policy owns
  /// the caret/slot paint geometry contract.
  static const bool visibleSlotBoxesEnabledByDefault = false;

  static NativeSlotBoxPaintModel paintModelForBundle({
    required SlotGeometryBundle bundle,
    required bool isEmptySlot,
    required int caretIndex,
    required int childCount,
    required Size canvasSize,
  }) {
    final safeChildCount = math.max(1, childCount);
    final effectiveCaretIndex = isEmptySlot
        ? ActiveEmptySlotLeadingRailCaretPolicy.caretIndexForEmptyActiveSlot(requestedCaretIndex: caretIndex)
        : caretIndex.clamp(0, safeChildCount).toInt();
    final rawCaret = SlotGeometryBundleAuthority.caretRectForBundle(
      bundle: bundle,
      caretIndex: effectiveCaretIndex,
      childCount: safeChildCount,
      activeEmptySlotLeadingRail: isEmptySlot,
      canvasSize: canvasSize,
    );
    final caret = isEmptySlot
        ? NativeExclusivePlaceholderCaretRendererPolicy.exclusiveCaretForEmptySlot(
            bundle: bundle,
            candidate: rawCaret,
            payload: '□',
            canvasSize: canvasSize,
          )
        : rawCaret;
    return NativeSlotBoxPaintModel(
      slotId: bundle.slotId,
      nodeId: bundle.nodeId,
      role: bundle.role,
      visualRect: bundle.visualRect,
      placeholderRect: bundle.placeholderRect,
      hitRect: bundle.hitRect,
      leadingRailRect: bundle.leadingRailRect,
      trailingRailRect: bundle.trailingRailRect,
      innerTextRect: bundle.innerTextRect,
      caretRect: caret,
      activeEmptySlot: isEmptySlot,
      source: 'native-slotbox-painter-slotgeometrybundle',
    );
  }

  static bool modelUsesSameBundle({
    required NativeSlotBoxPaintModel model,
    required SlotGeometryBundle bundle,
  }) {
    return model.slotId == bundle.slotId &&
        model.nodeId == bundle.nodeId &&
        model.role == bundle.role &&
        model.visualRect == bundle.visualRect &&
        model.placeholderRect == bundle.placeholderRect &&
        model.hitRect == bundle.hitRect &&
        model.leadingRailRect == bundle.leadingRailRect &&
        model.trailingRailRect == bundle.trailingRailRect &&
        model.innerTextRect == bundle.innerTextRect;
  }

  static bool caretIsPaintSafe(NativeSlotBoxPaintModel model) {
    if (model.activeEmptySlot) {
      return ActiveEmptySlotLeadingRailCaretPolicy.isLeadingRailAligned(
            caretRect: model.caretRect,
            placeholderRect: model.placeholderRect,
          ) &&
          !model.caretRect.overlaps(model.placeholderRect) &&
          model.caretRect != model.hitRect &&
          model.caretRect != model.trailingRailRect;
    }
    return !model.caretRect.overlaps(model.placeholderRect) ||
        model.innerTextRect.contains(model.caretRect.center);
  }

  static bool slotBoxPaintingAllowed({required bool debugOverlayRequested}) {
    return visibleSlotBoxesEnabledByDefault && debugOverlayRequested;
  }

  static Map<String, Rect> rectsForPaintModel(NativeSlotBoxPaintModel model) {
    return <String, Rect>{
      'visualRect': model.visualRect,
      'placeholderRect': model.placeholderRect,
      'hitRect': model.hitRect,
      'leadingRailRect': model.leadingRailRect,
      'trailingRailRect': model.trailingRailRect,
      'innerTextRect': model.innerTextRect,
      'caretRect': model.caretRect,
    };
  }
}

class NativeSlotBoxPaintModel {
  const NativeSlotBoxPaintModel({
    required this.slotId,
    required this.nodeId,
    required this.role,
    required this.visualRect,
    required this.placeholderRect,
    required this.hitRect,
    required this.leadingRailRect,
    required this.trailingRailRect,
    required this.innerTextRect,
    required this.caretRect,
    required this.activeEmptySlot,
    required this.source,
  });

  final String slotId;
  final String nodeId;
  final String role;
  final Rect visualRect;
  final Rect placeholderRect;
  final Rect hitRect;
  final Rect leadingRailRect;
  final Rect trailingRailRect;
  final Rect innerTextRect;
  final Rect caretRect;
  final bool activeEmptySlot;
  final String source;

  bool get caretUsesHitRect => caretRect == hitRect;
  bool get placeholderPaintUsesVisualGeometry => visualRect.contains(placeholderRect.center);
  bool get caretPaintUsesLeadingRailForEmptySlot =>
      activeEmptySlot && caretRect == leadingRailRect;
}
