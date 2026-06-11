import 'dart:math' as math;
import 'dart:ui';

import '../editor/selection_controller.dart';
import '../editor/slot_registry.dart';
import 'native_layout_box_cursor_layer.dart';
import 'renderer_sync_geometry_policy.dart';
import 'renderer_slot_identity_policy.dart';
import 'role_geometry_visual_alignment_policy.dart';
import 'slot_geometry_bundle_authority.dart';
import 'slot_interaction_calibration_policy.dart';

/// Q34 deterministic geometry authority for the P6-locked cursor track.
///
/// This file does not introduce a new keyboard, MORE surface, long-press UI,
/// layout shell, Graph, History, or Solution behavior.  Its only purpose is to
/// make the existing cursor engine consume one role-aware geometry record per
/// structural slot instead of letting hit-test, visual focus and caret overlay
/// each infer slightly different rectangles.
///
/// The registry is deliberately honest: it is deterministic role geometry, not
/// renderer/SVG identity mapping.  Renderer-extracted per-slot bounds must stay
/// a separate future capability until real renderer data is available.
class DeterministicSlotGeometryRegistry {
  const DeterministicSlotGeometryRegistry._();

  static const String version =
      'mathpro-v172q34-v172q35-v172q36-v172q37-v172q38-v172q39-v172q40-v172q41-v172q44-v172q46-v172q48-deterministic-slot-geometry-registry-native-layout-box-cursor-layer-p6-locked-v11';

  static const bool p6VisualFilesLocked = true;
  static const bool rendererSlotIdentityClaimed = false;
  static const bool deterministicGeometryRegistryAvailable = true;
  static const bool placeholderSafeCaretEngineAvailable = true;
  static const bool placeholderCaretOverlapAllowed = false;
  static const bool roleBasedCaretSizeEngineAvailable = true;
  static const bool mainLineCaretUsedInScriptRoles = false;
  static const bool fractionPrecisionEngineAvailable = true;
  static const bool fractionNumeratorDenominatorLaneSplitEnabled = true;
  static const bool fractionBarCrossLaneSelectionAllowed = false;
  static const bool scriptPrecisionEngineAvailable = true;
  static const bool exponentSubscriptLaneSplitEnabled = true;
  static const bool scriptBaseCrossLaneSelectionAllowed = false;
  static const bool logRootPrecisionEngineAvailable = true;
  static const bool logBaseArgumentLaneSplitEnabled = true;
  static const bool rootIndexRadicandLaneSplitEnabled = true;
  static const bool logBaseArgumentCrossLaneSelectionAllowed = false;
  static const bool rootIndexRadicandCrossLaneSelectionAllowed = false;
  static const bool digitLevelCaretStopsAvailable = true;
  static const bool digitRunMidpointSelectionEnabled = true;
  static const bool structuralBoundarySnapSuppressedInsideDigitRuns = true;
  static const bool nestedExpressionDepthEngineAvailable = true;
  static const bool deepestValidSlotPreferred = true;
  static const bool parentSlotStealSuppressed = true;
  static const bool q44RendererSyncUpgradeAvailable = true;
  static const bool rendererExpressionEnvelopeTelemetryCanRefineGeometry = true;
  static const bool rendererPerSlotSvgIdentityClaimed = false;
  static const bool q46RendererSlotIdentityPrototypeAvailable = true;
  static const bool rendererSlotIdentityCandidateRefinementEnabled = true;
  static const bool trueAstSlotToSvgNodeIdentityClaimed = false;

  static const bool q48NativeLayoutBoxCursorLayerAvailable = true;
  static const bool nativeLayoutBoxCursorGeometryEnabled = true;
  static const bool q53RoleGeometryVisualAlignmentAvailable = true;
  static const bool q55SingleSlotGeometryBundleAuthorityAvailable = true;
  static const bool fullNativeMathRendererClaimed = false;

  static Map<SlotEntry, DeterministicSlotGeometry> build({
    required Map<SlotEntry, Rect> slotRects,
    required Size canvasSize,
  }) {
    if (slotRects.isEmpty || canvasSize.isEmpty) {
      return const <SlotEntry, DeterministicSlotGeometry>{};
    }
    final output = <SlotEntry, DeterministicSlotGeometry>{};
    for (final item in slotRects.entries) {
      output[item.key] = geometryFor(
        entry: item.key,
        rawRect: item.value,
        canvasSize: canvasSize,
      );
    }
    return Map<SlotEntry, DeterministicSlotGeometry>.unmodifiable(output);
  }

  static DeterministicSlotGeometry geometryFor({
    required SlotEntry entry,
    required Rect rawRect,
    required Size canvasSize,
  }) {
    final rect = visualRectFor(entry: entry, rawRect: rawRect, canvasSize: canvasSize);
    final baselineY = baselineForRole(role: entry.role, rect: rect, canvasSize: canvasSize);
    final nativeBox = NativeLayoutBoxCursorLayer.boxForSlot(
      entry: entry,
      visualRect: rect,
      placeholderRect: placeholderRectFor(role: entry.role, rect: rect),
      baselineY: baselineY,
      canvasSize: canvasSize,
    );
    final bundle = SlotGeometryBundleAuthority.bundleFor(
      entry: entry,
      visualRect: nativeBox.visualRect,
      placeholderRect: nativeBox.placeholderRect,
      baselineY: nativeBox.baselineY,
      canvasSize: canvasSize,
    );
    return DeterministicSlotGeometry(
      entry: entry,
      rect: bundle.visualRect,
      placeholderRect: bundle.placeholderRect,
      baselineY: bundle.baselineY,
      entryCaretRect: bundle.leadingRailRect,
      exitCaretRect: bundle.trailingRailRect,
      bundle: bundle,
    );
  }

  static Rect visualRectFor({
    required SlotEntry entry,
    required Rect rawRect,
    required Size canvasSize,
  }) {
    if (canvasSize.isEmpty) return rawRect;
    final role = entry.role;
    final calibrated = RendererSyncGeometryPolicy.calibrateVisualRect(
      entry: entry,
      rawRect: rawRect,
      canvasSize: canvasSize,
    );
    final profile = _profileForRole(role);
    final targetCenter = Offset(
      calibrated.center.dx.clamp(profile.edgePadding, math.max(profile.edgePadding, canvasSize.width - profile.edgePadding)).toDouble(),
      _stableRoleCenterY(role: role, rect: calibrated, canvasSize: canvasSize),
    );
    final width = calibrated.width.clamp(profile.minWidth, math.min(profile.maxWidth, math.max(profile.minWidth, canvasSize.width * profile.maxWidthFactor))).toDouble();
    final height = calibrated.height.clamp(profile.minHeight, math.min(profile.maxHeight, math.max(profile.minHeight, canvasSize.height * profile.maxHeightFactor))).toDouble();
    final deterministic = SlotInteractionCalibrationPolicy.clampVisualRectToCanvas(
      Rect.fromCenter(center: targetCenter, width: width, height: height),
      canvasSize,
    );
    final roleAligned = RoleGeometryVisualAlignmentPolicy.refineVisualRect(
      entry: entry,
      calibratedRect: calibrated,
      deterministicRect: deterministic,
      canvasSize: canvasSize,
    );
    return RendererSlotIdentityPolicy.refineVisualRect(
      entry: entry,
      deterministicRect: roleAligned,
      canvasSize: canvasSize,
    );
  }

  static Rect caretRectFor({
    required Rect slotRect,
    required String role,
    required int caretIndex,
    required int childCount,
  }) {
    final canvasSize = Size(slotRect.right + 1, slotRect.bottom + 1);
    final placeholderRect = placeholderRectFor(role: role, rect: slotRect);
    final baselineY = baselineForRole(role: role, rect: slotRect, canvasSize: canvasSize);
    final boxType = NativeLayoutBoxCursorLayer.boxTypeForRole(role);
    return NativeLayoutBoxCursorLayer.caretRectForBox(
      visualRect: slotRect,
      placeholderRect: placeholderRect,
      role: role,
      type: boxType,
      baselineY: baselineY,
      caretIndex: caretIndex,
      childCount: childCount,
      canvasSize: canvasSize,
    );
  }

  /// Q35: place empty-slot carets on a safe optical rail outside the visible
  /// placeholder box.  The caret must never be centered inside □, exponent
  /// placeholder, log-base placeholder, radical body placeholder, numerator or
  /// denominator placeholder.  Filled slots still use the local caret index.
  static Rect placeholderSafeCaretRectFor({
    required Rect slotRect,
    required Rect placeholderRect,
    required String role,
    required int caretIndex,
    required int childCount,
    required Size canvasSize,
  }) {
    final safeChildren = math.max(1, childCount);
    final safeCaret = caretIndex.clamp(0, safeChildren).toInt();
    final profile = _profileForRole(role);
    final height = roleBasedCaretHeightFor(role: role, slotRect: slotRect);
    final desiredTop = baselineForRole(
          role: role,
          rect: slotRect,
          canvasSize: canvasSize,
        ) -
        height * profile.baselineCaretLift;
    final minTop = slotRect.top - profile.verticalOverflowGuard;
    final maxTop = math.max(minTop, slotRect.bottom + profile.verticalOverflowGuard - height);
    final top = desiredTop.clamp(minTop, maxTop).toDouble();

    if (safeChildren > 1) {
      final x = slotRect.left + slotRect.width * (safeCaret / safeChildren);
      final candidate = Rect.fromLTWH(x - MathProCaretController.inlineCaretWidth / 2, top, MathProCaretController.inlineCaretWidth, height);
      return _clampCaretToCanvas(candidate, canvasSize);
    }

    final guard = math.max(1.8, profile.edgeCaretGap * 0.36);
    final leftRail = placeholderRect.left - profile.edgeCaretGap;
    final rightRail = placeholderRect.right + profile.edgeCaretGap;
    final preferLeft = safeCaret <= 0;
    final first = _caretFromRail(preferLeft ? leftRail : rightRail, top, height);
    final second = _caretFromRail(preferLeft ? rightRail : leftRail, top, height);
    final firstClamped = _clampCaretToCanvas(first, canvasSize);
    if (!caretOverlapsPlaceholder(firstClamped, placeholderRect.inflate(guard))) {
      return firstClamped;
    }
    final secondClamped = _clampCaretToCanvas(second, canvasSize);
    if (!caretOverlapsPlaceholder(secondClamped, placeholderRect.inflate(guard))) {
      return secondClamped;
    }

    // If the slot sits near a canvas edge and both rails would be clamped into
    // the placeholder, choose the side with more free room and push the caret
    // just outside the guarded placeholder. This is intentionally deterministic
    // and does not modify keyboard, MORE, layout, or visible slot styling.
    final roomLeft = placeholderRect.left;
    final roomRight = math.max(0.0, canvasSize.width - placeholderRect.right);
    final rail = roomRight >= roomLeft
        ? placeholderRect.right + guard + MathProCaretController.inlineCaretWidth
        : placeholderRect.left - guard - MathProCaretController.inlineCaretWidth;
    return _clampCaretToCanvas(_caretFromRail(rail, top, height), canvasSize);
  }

  static bool caretOverlapsPlaceholder(Rect caretRect, Rect placeholderRect) {
    return caretRect.overlaps(placeholderRect);
  }

  /// Q36: a script/log/root-limit cursor must not reuse the full main-line
  /// caret height.  The value is derived from the selected structural role and
  /// the visible slot rect so P6 key faces, MORE, long-press and layout remain
  /// untouched while the caret becomes optically proportional to its slot.
  static double roleBasedCaretHeightFor({
    required String role,
    required Rect slotRect,
  }) {
    final profile = _profileForRole(role);
    final scaled = slotRect.height * profile.caretHeightFactor;
    return scaled.clamp(profile.minCaretHeight, profile.maxCaretHeight).toDouble();
  }

  static bool usesCompactCaretForRole(String role) {
    return switch (role) {
      'powerExponent' || 'subscript' || 'logBase' || 'rootIndex' ||
      'derivativeOrder' || 'integralUpperLimit' || 'integralLowerLimit' ||
      'sumUpperLimit' || 'sumLowerLimit' || 'productUpperLimit' ||
      'productLowerLimit' || 'limitVariable' || 'limitTarget' ||
      'derivativeVariable' || 'integralDifferential' => true,
      _ => false,
    };
  }

  static Rect _caretFromRail(double railX, double top, double height) {
    return Rect.fromLTWH(
      railX - MathProCaretController.inlineCaretWidth / 2,
      top,
      MathProCaretController.inlineCaretWidth,
      height,
    );
  }

  static Rect _clampCaretToCanvas(Rect rect, Size canvasSize) {
    final maxLeft = math.max(0.0, canvasSize.width - rect.width);
    final maxTop = math.max(0.0, canvasSize.height - rect.height);
    return Rect.fromLTWH(
      rect.left.clamp(0.0, maxLeft).toDouble(),
      rect.top.clamp(0.0, maxTop).toDouble(),
      rect.width,
      rect.height,
    );
  }

  static Rect placeholderRectFor({required String role, required Rect rect}) {
    final profile = _profileForRole(role);
    return Rect.fromCenter(
      center: rect.center,
      width: math.min(rect.width * profile.placeholderWidthFactor, rect.width),
      height: math.min(rect.height * profile.placeholderHeightFactor, rect.height),
    );
  }

  static double baselineForRole({
    required String role,
    required Rect rect,
    required Size canvasSize,
  }) {
    final profile = _profileForRole(role);
    return (rect.top + rect.height * profile.baselineFactor)
        .clamp(0.0, math.max(0.0, canvasSize.height))
        .toDouble();
  }

  static double _stableRoleCenterY({
    required String role,
    required Rect rect,
    required Size canvasSize,
  }) {
    final center = MathProCaretController.inlineExpressionCenterY(canvasSize);
    final band = math.max(42.0, canvasSize.height * 0.58);
    final farUp = center - band * 0.34;
    final mildUp = center - band * 0.20;
    final mildDown = center + band * 0.20;
    final farDown = center + band * 0.34;
    final target = switch (role) {
      'fractionNumerator' || 'integralUpperLimit' || 'sumUpperLimit' ||
      'productUpperLimit' => farUp,
      'powerExponent' || 'rootIndex' || 'derivativeOrder' => mildUp,
      'fractionDenominator' || 'integralLowerLimit' || 'sumLowerLimit' ||
      'productLowerLimit' => farDown,
      'subscript' || 'logBase' => mildDown,
      'limitVariable' || 'limitTarget' || 'derivativeVariable' ||
      'integralDifferential' => mildDown,
      'matrixCell' || 'systemLeft' || 'systemRight' ||
      'piecewiseExpression' || 'piecewiseCondition' => rect.center.dy,
      _ => center,
    };
    return target.clamp(18.0, math.max(18.0, canvasSize.height - 18.0)).toDouble();
  }

  static _SlotGeometryProfile _profileForRole(String role) {
    return switch (role) {
      'powerExponent' || 'rootIndex' || 'derivativeOrder' => const _SlotGeometryProfile.script(),
      'subscript' || 'logBase' => const _SlotGeometryProfile.subscript(),
      'integralUpperLimit' || 'integralLowerLimit' || 'sumUpperLimit' ||
      'sumLowerLimit' || 'productUpperLimit' || 'productLowerLimit' => const _SlotGeometryProfile.limit(),
      'fractionNumerator' || 'fractionDenominator' => const _SlotGeometryProfile.fraction(),
      'matrixCell' || 'systemLeft' || 'systemRight' ||
      'piecewiseExpression' || 'piecewiseCondition' => const _SlotGeometryProfile.grid(),
      'sqrtValue' || 'functionArgument' || 'functionArgument2' ||
      'functionArgument3' || 'integralBody' || 'derivativeBody' ||
      'limitBody' || 'sumBody' || 'productBody' => const _SlotGeometryProfile.body(),
      _ => const _SlotGeometryProfile.main(),
    };
  }
}

class DeterministicSlotGeometry {
  const DeterministicSlotGeometry({
    required this.entry,
    required this.rect,
    required this.placeholderRect,
    required this.baselineY,
    required this.entryCaretRect,
    required this.exitCaretRect,
    required this.bundle,
  });

  final SlotEntry entry;
  final Rect rect;
  final Rect placeholderRect;
  final double baselineY;
  final Rect entryCaretRect;
  final Rect exitCaretRect;
  final SlotGeometryBundle bundle;

  String get role => entry.role;
  String get slotId => entry.id;
}

class _SlotGeometryProfile {
  const _SlotGeometryProfile({
    required this.minWidth,
    required this.maxWidth,
    required this.minHeight,
    required this.maxHeight,
    required this.maxWidthFactor,
    required this.maxHeightFactor,
    required this.caretHeightFactor,
    required this.minCaretHeight,
    required this.maxCaretHeight,
    required this.baselineFactor,
    required this.baselineCaretLift,
    required this.edgeCaretGap,
    required this.edgePadding,
    required this.placeholderWidthFactor,
    required this.placeholderHeightFactor,
    required this.verticalOverflowGuard,
  });

  const _SlotGeometryProfile.main()
      : this(
          minWidth: 46,
          maxWidth: 64,
          minHeight: 42,
          maxHeight: 58,
          maxWidthFactor: 0.32,
          maxHeightFactor: 0.50,
          caretHeightFactor: 0.68,
          minCaretHeight: 18,
          maxCaretHeight: 34,
          baselineFactor: 0.62,
          baselineCaretLift: 0.50,
          edgeCaretGap: 5.8,
          edgePadding: 12,
          placeholderWidthFactor: 0.70,
          placeholderHeightFactor: 0.72,
          verticalOverflowGuard: 12,
        );

  const _SlotGeometryProfile.body()
      : this(
          minWidth: 52,
          maxWidth: 70,
          minHeight: 46,
          maxHeight: 62,
          maxWidthFactor: 0.34,
          maxHeightFactor: 0.52,
          caretHeightFactor: 0.62,
          minCaretHeight: 17,
          maxCaretHeight: 32,
          baselineFactor: 0.62,
          baselineCaretLift: 0.50,
          edgeCaretGap: 6.2,
          edgePadding: 12,
          placeholderWidthFactor: 0.68,
          placeholderHeightFactor: 0.70,
          verticalOverflowGuard: 12,
        );

  const _SlotGeometryProfile.fraction()
      : this(
          minWidth: 52,
          maxWidth: 64,
          minHeight: 38,
          maxHeight: 52,
          maxWidthFactor: 0.30,
          maxHeightFactor: 0.42,
          caretHeightFactor: 0.54,
          minCaretHeight: 14,
          maxCaretHeight: 24,
          baselineFactor: 0.58,
          baselineCaretLift: 0.50,
          edgeCaretGap: 5.4,
          edgePadding: 12,
          placeholderWidthFactor: 0.70,
          placeholderHeightFactor: 0.70,
          verticalOverflowGuard: 10,
        );

  const _SlotGeometryProfile.script()
      : this(
          minWidth: 40,
          maxWidth: 54,
          minHeight: 28,
          maxHeight: 42,
          maxWidthFactor: 0.24,
          maxHeightFactor: 0.34,
          caretHeightFactor: 0.40,
          minCaretHeight: 11,
          maxCaretHeight: 18,
          baselineFactor: 0.60,
          baselineCaretLift: 0.52,
          edgeCaretGap: 5.0,
          edgePadding: 18,
          placeholderWidthFactor: 0.66,
          placeholderHeightFactor: 0.66,
          verticalOverflowGuard: 9,
        );

  const _SlotGeometryProfile.subscript()
      : this(
          minWidth: 42,
          maxWidth: 56,
          minHeight: 30,
          maxHeight: 44,
          maxWidthFactor: 0.24,
          maxHeightFactor: 0.36,
          caretHeightFactor: 0.42,
          minCaretHeight: 11,
          maxCaretHeight: 18,
          baselineFactor: 0.58,
          baselineCaretLift: 0.50,
          edgeCaretGap: 4.8,
          edgePadding: 18,
          placeholderWidthFactor: 0.66,
          placeholderHeightFactor: 0.66,
          verticalOverflowGuard: 9,
        );

  const _SlotGeometryProfile.limit()
      : this(
          minWidth: 42,
          maxWidth: 58,
          minHeight: 30,
          maxHeight: 46,
          maxWidthFactor: 0.26,
          maxHeightFactor: 0.38,
          caretHeightFactor: 0.44,
          minCaretHeight: 12,
          maxCaretHeight: 20,
          baselineFactor: 0.58,
          baselineCaretLift: 0.50,
          edgeCaretGap: 5.0,
          edgePadding: 16,
          placeholderWidthFactor: 0.66,
          placeholderHeightFactor: 0.66,
          verticalOverflowGuard: 9,
        );

  const _SlotGeometryProfile.grid()
      : this(
          minWidth: 46,
          maxWidth: 70,
          minHeight: 40,
          maxHeight: 58,
          maxWidthFactor: 0.30,
          maxHeightFactor: 0.50,
          caretHeightFactor: 0.58,
          minCaretHeight: 15,
          maxCaretHeight: 28,
          baselineFactor: 0.58,
          baselineCaretLift: 0.50,
          edgeCaretGap: 5.2,
          edgePadding: 10,
          placeholderWidthFactor: 0.70,
          placeholderHeightFactor: 0.70,
          verticalOverflowGuard: 10,
        );

  final double minWidth;
  final double maxWidth;
  final double minHeight;
  final double maxHeight;
  final double maxWidthFactor;
  final double maxHeightFactor;
  final double caretHeightFactor;
  final double minCaretHeight;
  final double maxCaretHeight;
  final double baselineFactor;
  final double baselineCaretLift;
  final double edgeCaretGap;
  final double edgePadding;
  final double placeholderWidthFactor;
  final double placeholderHeightFactor;
  final double verticalOverflowGuard;
}
