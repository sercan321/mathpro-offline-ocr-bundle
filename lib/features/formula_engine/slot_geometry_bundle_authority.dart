import 'dart:math' as math;
import 'dart:ui';

import '../editor/selection_controller.dart';
import '../editor/slot_registry.dart';
import 'active_empty_slot_leading_rail_caret_policy.dart';
import 'fraction_function_root_log_cursor_specialization_policy.dart';
import 'integral_cursor_specialization_policy.dart';
import 'native_layout_box_cursor_layer.dart';
import 'native_integral_slotbox_specialization_policy.dart';
import 'mathlive_structural_caret_anchor_geometry_repair_policy.dart';
import 'native_fraction_function_root_log_slotbox_specialization_policy.dart';
import 'role_geometry_visual_alignment_policy.dart';

/// V172-Q55 single geometry authority for the existing MathPro cursor engine.
/// Q77 wraps the older Q58 integral helpers through NativeIntegralSlotBoxSpecializationPolicy.
/// Lineage markers: IntegralCursorSpecializationPolicy.refineHitRectForRole,
/// IntegralCursorSpecializationPolicy.refinePlaceholderRectForRole,
/// IntegralCursorSpecializationPolicy.refineLeadingRailRectForRole.
///
/// The cursor motor already existed before Q55. This layer does not replace it
/// and does not touch keyboard, MORE, long-press, app shell, Graph, History or
/// Solution. Its job is to make hit-test, placeholder geometry, visible slot
/// geometry, leading/trailing rails and filled-slot inner text rails come from
/// one immutable bundle so real-device taps and painted carets cannot drift into
/// separate coordinate systems.
class SlotGeometryBundleAuthority {
  const SlotGeometryBundleAuthority._();

  static const String version =
      'mathpro-v172q55-v172q59-v172q78-single-slot-geometry-bundle-authority-native-integral-ffrl-specialized-p6-locked-v1';

  static const bool singleSlotGeometryBundleAuthorityAvailable = true;
  static const bool hitRectOnlyForSelection = true;
  static const bool caretNeverUsesHitRect = true;
  static const bool activeEmptySlotUsesLeadingRail = true;
  static const bool filledSlotUsesInnerTextRect = true;
  static const bool structuralIntentSharesBundleGeometry = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool fullNativeMathRendererClaimed = false;
  static const bool trueAstSlotToSvgNodeIdentityClaimed = false;
  static const bool realDevicePlus95PassClaimed = false;
  static const bool q59FractionFunctionRootLogSpecializationWired = true;
  static const bool q77NativeIntegralSlotBoxSpecializationWired = true;
  static const bool q78NativeFractionFunctionRootLogSlotBoxSpecializationWired = true;

  static Map<SlotEntry, SlotGeometryBundle> buildFromVisualRects({
    required Map<SlotEntry, Rect> visualRects,
    required Size canvasSize,
  }) {
    if (visualRects.isEmpty || canvasSize.isEmpty) {
      return const <SlotEntry, SlotGeometryBundle>{};
    }
    final output = <SlotEntry, SlotGeometryBundle>{};
    for (final item in visualRects.entries) {
      final type = NativeLayoutBoxCursorLayer.boxTypeForRole(item.key.role);
      final placeholder = _placeholderRectForVisualRect(
        role: item.key.role,
        type: type,
        visualRect: item.value,
      );
      output[item.key] = bundleFor(
        entry: item.key,
        visualRect: item.value,
        placeholderRect: placeholder,
        baselineY: _baselineForVisualRect(role: item.key.role, visualRect: item.value),
        canvasSize: canvasSize,
      );
    }
    return Map<SlotEntry, SlotGeometryBundle>.unmodifiable(output);
  }

  static Map<SlotEntry, Rect> visualRectsFromBundles(Map<SlotEntry, SlotGeometryBundle> bundles) {
    if (bundles.isEmpty) return const <SlotEntry, Rect>{};
    return Map<SlotEntry, Rect>.unmodifiable(
      bundles.map((entry, bundle) => MapEntry(entry, bundle.visualRect)),
    );
  }

  static SlotGeometryBundle bundleFor({
    required SlotEntry entry,
    required Rect visualRect,
    required Rect placeholderRect,
    required double baselineY,
    required Size canvasSize,
  }) {
    final type = NativeLayoutBoxCursorLayer.boxTypeForRole(entry.role);
    final hitRect = hitRectForRole(entry: entry, visualRect: visualRect, canvasSize: canvasSize);
    final leading = leadingRailRectFor(
      role: entry.role,
      type: type,
      visualRect: visualRect,
      placeholderRect: placeholderRect,
      baselineY: baselineY,
      canvasSize: canvasSize,
    );
    final trailing = trailingRailRectFor(
      role: entry.role,
      type: type,
      visualRect: visualRect,
      placeholderRect: placeholderRect,
      baselineY: baselineY,
      canvasSize: canvasSize,
    );
    return SlotGeometryBundle(
      slotId: entry.id,
      nodeId: entry.nodeId,
      role: entry.role,
      entry: entry,
      type: type,
      hitRect: hitRect,
      visualRect: visualRect,
      placeholderRect: placeholderRect,
      leadingRailRect: leading,
      trailingRailRect: trailing,
      innerTextRect: innerTextRectFor(
        role: entry.role,
        visualRect: visualRect,
        placeholderRect: placeholderRect,
      ),
      baselineY: baselineY,
      priorityZone: priorityZoneForRole(entry.role),
    );
  }

  static Rect hitRectForRole({
    required SlotEntry entry,
    required Rect visualRect,
    required Size canvasSize,
  }) {
    final inflation = hitSlopForRole(entry.role);
    final inflated = visualRect.inflate(inflation);
    final minSize = math.max(entry.minTouchSize, minimumTouchSizeForRole(entry.role));
    final width = math.max(inflated.width, minSize);
    final height = math.max(inflated.height, minSize);
    final baseHitRect = _clampRect(Rect.fromCenter(center: visualRect.center, width: width, height: height), canvasSize);
    final nativeIntegralHitRect = NativeIntegralSlotBoxSpecializationPolicy.refineHitRectForRole(
      role: entry.role,
      visualRect: visualRect,
      baseHitRect: baseHitRect,
      canvasSize: canvasSize,
    );
    final legacyFfrlHitRect = FractionFunctionRootLogCursorSpecializationPolicy.refineHitRectForRole(
      role: entry.role,
      visualRect: visualRect,
      baseHitRect: nativeIntegralHitRect,
      canvasSize: canvasSize,
    );
    return NativeFractionFunctionRootLogSlotBoxSpecializationPolicy.refineHitRectForRole(
      role: entry.role,
      visualRect: visualRect,
      baseHitRect: legacyFfrlHitRect,
      canvasSize: canvasSize,
    );
  }

  static Rect leadingRailRectFor({
    required String role,
    required NativeCursorBoxType type,
    required Rect visualRect,
    required Rect placeholderRect,
    required double baselineY,
    required Size canvasSize,
  }) {
    final nativeHeight = NativeLayoutBoxCursorLayer.caretHeightForBox(type: type, visualRect: visualRect);
    final height = RoleGeometryVisualAlignmentPolicy.caretHeightForRole(
      role: role,
      type: type,
      visualRect: visualRect,
      placeholderRect: placeholderRect,
      nativeHeight: nativeHeight,
    );
    final candidate = ActiveEmptySlotLeadingRailCaretPolicy.leadingRailCaretRect(
      visualRect: visualRect,
      placeholderRect: placeholderRect,
      role: role,
      type: type,
      baselineY: baselineY,
      canvasSize: canvasSize,
      caretHeight: height,
    );
    final finalRect = RoleGeometryVisualAlignmentPolicy.finalizeActiveEmptyCaret(
      candidate: candidate,
      placeholderRect: placeholderRect,
      canvasSize: canvasSize,
      role: role,
    );
    final nativeIntegralRail = NativeIntegralSlotBoxSpecializationPolicy.refineLeadingRailRectForRole(
      role: role,
      candidate: finalRect,
      placeholderRect: placeholderRect,
      canvasSize: canvasSize,
    );
    final legacyFfrlRail = FractionFunctionRootLogCursorSpecializationPolicy.refineLeadingRailRectForRole(
      role: role,
      candidate: nativeIntegralRail,
      placeholderRect: placeholderRect,
      canvasSize: canvasSize,
    );
    final nativeFfrlRail = NativeFractionFunctionRootLogSlotBoxSpecializationPolicy.refineLeadingRailRectForRole(
      role: role,
      candidate: legacyFfrlRail,
      placeholderRect: placeholderRect,
      canvasSize: canvasSize,
    );
    // V172-Q115 final anchor guard: after every specialist has refined the
    // geometry, force the painted empty-slot caret back to the visible
    // placeholder's immediate leading rail. This blocks the real-device failure
    // class where the caret looked detached from or painted over a structural box.
    return MathLiveStructuralCaretAnchorGeometryRepairPolicy.anchorActiveEmptyCaret(
      candidate: _clampRect(nativeFfrlRail, canvasSize),
      visualRect: visualRect,
      placeholderRect: placeholderRect,
      role: role,
      canvasSize: canvasSize,
    );
  }

  static Rect trailingRailRectFor({
    required String role,
    required NativeCursorBoxType type,
    required Rect visualRect,
    required Rect placeholderRect,
    required double baselineY,
    required Size canvasSize,
  }) {
    final nativeHeight = NativeLayoutBoxCursorLayer.caretHeightForBox(type: type, visualRect: visualRect);
    final height = RoleGeometryVisualAlignmentPolicy.caretHeightForRole(
      role: role,
      type: type,
      visualRect: visualRect,
      placeholderRect: placeholderRect,
      nativeHeight: nativeHeight,
    );
    final gap = RoleGeometryVisualAlignmentPolicy.leadingGapForRole(role);
    final left = placeholderRect.right + gap;
    final top = (placeholderRect.center.dy - height / 2)
        .clamp(0.0, math.max(0.0, canvasSize.height - height))
        .toDouble();
    return _clampRect(Rect.fromLTWH(left, top, MathProCaretController.inlineCaretWidth, height), canvasSize);
  }

  static Rect caretRectForBundle({
    required SlotGeometryBundle bundle,
    required int caretIndex,
    required int childCount,
    required bool activeEmptySlotLeadingRail,
    required Size canvasSize,
  }) {
    if (activeEmptySlotLeadingRail) return bundle.leadingRailRect;
    final safeChildren = math.max(1, childCount);
    final safeIndex = caretIndex.clamp(0, safeChildren).toInt();
    if (safeChildren <= 1) {
      return safeIndex <= 0 ? bundle.leadingRailRect : bundle.trailingRailRect;
    }
    final x = bundle.innerTextRect.left + bundle.innerTextRect.width * (safeIndex / safeChildren);
    final height = math.max(bundle.leadingRailRect.height, bundle.innerTextRect.height * 0.82);
    final top = bundle.innerTextRect.center.dy - height / 2;
    return _clampRect(
      Rect.fromLTWH(x - MathProCaretController.inlineCaretWidth / 2, top, MathProCaretController.inlineCaretWidth, height),
      canvasSize,
    );
  }

  static Rect innerTextRectFor({
    required String role,
    required Rect visualRect,
    required Rect placeholderRect,
  }) {
    final baseInner = () {
      if (_compactRole(role)) {
        return placeholderRect.inflate(2.0).intersect(visualRect.inflate(2.0));
      }
      final horizontal = math.max(2.0, visualRect.width * 0.08);
      final vertical = math.max(1.0, visualRect.height * 0.12);
      final candidate = Rect.fromLTRB(
        visualRect.left + horizontal,
        visualRect.top + vertical,
        visualRect.right - horizontal,
        visualRect.bottom - vertical,
      );
      return candidate.isEmpty ? placeholderRect : candidate;
    }();
    final integralInner = IntegralCursorSpecializationPolicy.refineInnerTextRectForRole(
      role: role,
      visualRect: visualRect,
      placeholderRect: placeholderRect,
      baseInnerTextRect: baseInner,
    );
    return FractionFunctionRootLogCursorSpecializationPolicy.refineInnerTextRectForRole(
      role: role,
      visualRect: visualRect,
      placeholderRect: placeholderRect,
      baseInnerTextRect: integralInner,
    );
  }

  static String priorityZoneForRole(String role) {
    return switch (role) {
      'integralUpperLimit' || 'sumUpperLimit' || 'productUpperLimit' => 'upper-limit-zone',
      'integralLowerLimit' || 'sumLowerLimit' || 'productLowerLimit' => 'lower-limit-zone',
      'integralBody' || 'sqrtValue' || 'functionArgument' || 'functionArgument2' || 'functionArgument3' => 'body-zone',
      'integralDifferential' || 'derivativeVariable' => 'differential-zone',
      'fractionNumerator' => 'fraction-upper-zone',
      'fractionDenominator' => 'fraction-lower-zone',
      'logBase' || 'subscript' => 'lower-script-zone',
      'powerExponent' || 'rootIndex' || 'derivativeOrder' => 'upper-script-zone',
      _ => 'main-zone',
    };
  }

  static double hitSlopForRole(String role) {
    final fallback = switch (role) {
      'integralUpperLimit' || 'integralLowerLimit' || 'integralBody' || 'integralDifferential' => 44.0,
      'fractionNumerator' || 'fractionDenominator' => 38.0,
      'sqrtValue' || 'rootIndex' => 36.0,
      'functionArgument' || 'functionArgument2' || 'functionArgument3' => 36.0,
      'logBase' || 'powerExponent' || 'subscript' => 32.0,
      _ => 30.0,
    };
    final integralFallback = IntegralCursorSpecializationPolicy.hitSlopForRole(role, fallback);
    return FractionFunctionRootLogCursorSpecializationPolicy.hitSlopForRole(role, integralFallback);
  }

  static double minimumTouchSizeForRole(String role) {
    final fallback = switch (role) {
      'integralUpperLimit' || 'integralLowerLimit' || 'integralBody' || 'integralDifferential' => 76.0,
      'fractionNumerator' || 'fractionDenominator' => 70.0,
      'sqrtValue' || 'rootIndex' => 68.0,
      'functionArgument' || 'functionArgument2' || 'functionArgument3' => 68.0,
      _ => 64.0,
    };
    final integralFallback = IntegralCursorSpecializationPolicy.minimumTouchSizeForRole(role, fallback);
    return FractionFunctionRootLogCursorSpecializationPolicy.minimumTouchSizeForRole(role, integralFallback);
  }

  static Rect _placeholderRectForVisualRect({
    required String role,
    required NativeCursorBoxType type,
    required Rect visualRect,
  }) {
    final scale = switch (type) {
      NativeCursorBoxType.scriptSlot || NativeCursorBoxType.logBaseSlot || NativeCursorBoxType.rootIndexSlot => 0.62,
      NativeCursorBoxType.limitSlot => 0.64,
      NativeCursorBoxType.fractionSlot => 0.66,
      NativeCursorBoxType.gridSlot => 0.68,
      _ => 0.70,
    };
    final rect = Rect.fromCenter(
      center: visualRect.center,
      width: math.max(8.0, visualRect.width * scale),
      height: math.max(8.0, visualRect.height * scale),
    );
    final roleRefined = RoleGeometryVisualAlignmentPolicy.refinePlaceholderRect(
      role: role,
      type: type,
      visualRect: visualRect,
      placeholderRect: rect,
    );
    final integralPlaceholder = NativeIntegralSlotBoxSpecializationPolicy.refinePlaceholderRectForRole(
      role: role,
      visualRect: visualRect,
      placeholderRect: roleRefined,
    );
    final legacyFfrlPlaceholder = FractionFunctionRootLogCursorSpecializationPolicy.refinePlaceholderRectForRole(
      role: role,
      visualRect: visualRect,
      placeholderRect: integralPlaceholder,
    );
    return NativeFractionFunctionRootLogSlotBoxSpecializationPolicy.refinePlaceholderRectForRole(
      role: role,
      visualRect: visualRect,
      placeholderRect: legacyFfrlPlaceholder,
    );
  }

  static double _baselineForVisualRect({required String role, required Rect visualRect}) {
    final factor = _compactRole(role) ? 0.58 : 0.62;
    final fallback = visualRect.top + visualRect.height * factor;
    return IntegralCursorSpecializationPolicy.baselineForRole(role, visualRect, fallback);
  }

  static bool _compactRole(String role) {
    return switch (role) {
      'integralUpperLimit' || 'integralLowerLimit' || 'rootIndex' || 'logBase' ||
      'powerExponent' || 'subscript' || 'derivativeOrder' => true,
      _ => false,
    };
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

class SlotGeometryBundle {
  const SlotGeometryBundle({
    required this.slotId,
    required this.nodeId,
    required this.role,
    required this.entry,
    required this.type,
    required this.hitRect,
    required this.visualRect,
    required this.placeholderRect,
    required this.leadingRailRect,
    required this.trailingRailRect,
    required this.innerTextRect,
    required this.baselineY,
    required this.priorityZone,
  });

  final String slotId;
  final String nodeId;
  final String role;
  final SlotEntry entry;
  final NativeCursorBoxType type;
  final Rect hitRect;
  final Rect visualRect;
  final Rect placeholderRect;
  final Rect leadingRailRect;
  final Rect trailingRailRect;
  final Rect innerTextRect;
  final double baselineY;
  final String priorityZone;

  bool get leadingRailBeforePlaceholder => leadingRailRect.right <= placeholderRect.left;
  bool get caretSourceIsIndependentFromHitRect => leadingRailRect != hitRect && trailingRailRect != hitRect;
}
