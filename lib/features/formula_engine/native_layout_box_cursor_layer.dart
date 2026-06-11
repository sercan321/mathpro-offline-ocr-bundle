import 'dart:math' as math;
import 'dart:ui';

import '../editor/selection_controller.dart';
import '../editor/slot_registry.dart';
import 'active_empty_slot_leading_rail_caret_policy.dart';
import 'role_geometry_visual_alignment_policy.dart';

/// V172-Q48 P6-locked native LayoutBox cursor layer.
///
/// This is a cursor-geometry layer only. It does not render key faces, MORE,
/// long-press popups, app layout, Graph, History, or Solution UI. The layer
/// gives the existing P6 cursor engine a deterministic box model similar to
/// professional math editors: every supported slot role is normalized into a
/// native cursor box with visual rect, placeholder rect, baseline and entry /
/// exit caret rails.
///
/// Honest boundary: this is not a full native math renderer and it does not
/// claim stable AST slot -> SVG node identity. It is a P6-locked cursor layer
/// that sits between SlotRegistry geometry and the caret overlay.
class NativeLayoutBoxCursorLayer {
  const NativeLayoutBoxCursorLayer._();

  static const String version =
      'mathpro-v172q48-native-layout-box-cursor-layer-v172q52-leading-rail-v172q53-role-geometry-v172q55-bundle-authority-p6-locked-v4';

  static const bool nativeLayoutBoxCursorLayerAvailable = true;
  static const bool p6VisualFilesLocked = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool fullNativeMathRendererClaimed = false;
  static const bool trueAstSlotToSvgNodeIdentityClaimed = false;
  static const bool cursorGeometryOnly = true;
  static const bool q52ActiveEmptySlotLeadingRailAvailable = true;
  static const bool q53RoleGeometryVisualAlignmentAvailable = true;
  static const bool q55SingleSlotGeometryBundleAuthorityAvailable = true;

  static const int requiredCorrectTapSelectionsPerTwenty = 19;

  static NativeCursorLayoutBox boxForSlot({
    required SlotEntry entry,
    required Rect visualRect,
    required Rect placeholderRect,
    required double baselineY,
    required Size canvasSize,
  }) {
    final type = boxTypeForRole(entry.role);
    final normalized = _normalizeVisualRect(
      role: entry.role,
      type: type,
      rect: visualRect,
      canvasSize: canvasSize,
    );
    final placeholder = _normalizePlaceholderRect(
      role: entry.role,
      type: type,
      visualRect: normalized,
      placeholderRect: placeholderRect,
    );
    final baseline = _baselineForBox(
      role: entry.role,
      type: type,
      rect: normalized,
      fallbackBaseline: baselineY,
      canvasSize: canvasSize,
    );
    return NativeCursorLayoutBox(
      slotId: entry.id,
      role: entry.role,
      type: type,
      visualRect: normalized,
      placeholderRect: placeholder,
      baselineY: baseline,
      entryCaretRect: caretRectForBox(
        visualRect: normalized,
        placeholderRect: placeholder,
        role: entry.role,
        type: type,
        baselineY: baseline,
        caretIndex: 0,
        childCount: 1,
        canvasSize: canvasSize,
      ),
      exitCaretRect: caretRectForBox(
        visualRect: normalized,
        placeholderRect: placeholder,
        role: entry.role,
        type: type,
        baselineY: baseline,
        caretIndex: 1,
        childCount: 1,
        canvasSize: canvasSize,
      ),
    );
  }

  static NativeCursorBoxType boxTypeForRole(String role) {
    return switch (role) {
      'fractionNumerator' || 'fractionDenominator' => NativeCursorBoxType.fractionSlot,
      'powerExponent' || 'subscript' || 'derivativeOrder' => NativeCursorBoxType.scriptSlot,
      'logBase' => NativeCursorBoxType.logBaseSlot,
      'rootIndex' => NativeCursorBoxType.rootIndexSlot,
      'sqrtValue' => NativeCursorBoxType.radicandSlot,
      'functionArgument' || 'functionArgument2' || 'functionArgument3' => NativeCursorBoxType.functionArgumentSlot,
      'integralUpperLimit' || 'integralLowerLimit' || 'sumUpperLimit' || 'sumLowerLimit' ||
      'productUpperLimit' || 'productLowerLimit' || 'limitVariable' || 'limitTarget' ||
      'derivativeVariable' || 'integralDifferential' => NativeCursorBoxType.limitSlot,
      'matrixCell' || 'systemLeft' || 'systemRight' || 'piecewiseExpression' ||
      'piecewiseCondition' => NativeCursorBoxType.gridSlot,
      _ => NativeCursorBoxType.mainLineSlot,
    };
  }

  static Rect caretRectForBox({
    required Rect visualRect,
    required Rect placeholderRect,
    required String role,
    required NativeCursorBoxType type,
    required double baselineY,
    required int caretIndex,
    required int childCount,
    required Size canvasSize,
    bool activeEmptySlotLeadingRail = false,
  }) {
    final safeChildren = math.max(1, childCount);
    final safeIndex = activeEmptySlotLeadingRail && safeChildren <= 1
        ? ActiveEmptySlotLeadingRailCaretPolicy.caretIndexForEmptyActiveSlot(requestedCaretIndex: caretIndex)
        : caretIndex.clamp(0, safeChildren).toInt();
    final nativeHeight = caretHeightForBox(type: type, visualRect: visualRect);
    final height = RoleGeometryVisualAlignmentPolicy.caretHeightForRole(
      role: role,
      type: type,
      visualRect: visualRect,
      placeholderRect: placeholderRect,
      nativeHeight: nativeHeight,
    );
    final top = (baselineY - height * _caretBaselineLift(type))
        .clamp(visualRect.top - 8.0, math.max(visualRect.top - 8.0, visualRect.bottom + 8.0 - height))
        .toDouble();

    Rect candidate;
    if (safeChildren > 1) {
      final x = visualRect.left + visualRect.width * (safeIndex / safeChildren);
      candidate = Rect.fromLTWH(x - MathProCaretController.inlineCaretWidth / 2, top, MathProCaretController.inlineCaretWidth, height);
    } else if (activeEmptySlotLeadingRail) {
      candidate = ActiveEmptySlotLeadingRailCaretPolicy.leadingRailCaretRect(
        visualRect: visualRect,
        placeholderRect: placeholderRect,
        role: role,
        type: type,
        baselineY: baselineY,
        canvasSize: canvasSize,
        caretHeight: height,
      );
      candidate = RoleGeometryVisualAlignmentPolicy.finalizeActiveEmptyCaret(
        candidate: candidate,
        placeholderRect: placeholderRect,
        canvasSize: canvasSize,
        role: role,
      );
    } else {
      final gap = _edgeGapForBox(type);
      final rail = safeIndex <= 0 ? placeholderRect.left - gap : placeholderRect.right + gap;
      candidate = Rect.fromLTWH(rail - MathProCaretController.inlineCaretWidth / 2, top, MathProCaretController.inlineCaretWidth, height);
      if (candidate.overlaps(placeholderRect.inflate(math.max(1.6, gap * 0.28)))) {
        final alternate = safeIndex <= 0 ? placeholderRect.right + gap : placeholderRect.left - gap;
        candidate = Rect.fromLTWH(alternate - MathProCaretController.inlineCaretWidth / 2, top, MathProCaretController.inlineCaretWidth, height);
      }
    }
    return _clampRect(candidate, canvasSize);
  }

  static double caretHeightForBox({
    required NativeCursorBoxType type,
    required Rect visualRect,
  }) {
    final preferred = visualRect.height * switch (type) {
      NativeCursorBoxType.scriptSlot => 0.40,
      NativeCursorBoxType.logBaseSlot => 0.40,
      NativeCursorBoxType.rootIndexSlot => 0.38,
      NativeCursorBoxType.limitSlot => 0.44,
      NativeCursorBoxType.fractionSlot => 0.54,
      NativeCursorBoxType.gridSlot => 0.58,
      NativeCursorBoxType.radicandSlot => 0.62,
      NativeCursorBoxType.functionArgumentSlot => 0.64,
      NativeCursorBoxType.mainLineSlot => 0.68,
    };
    final minHeight = switch (type) {
      NativeCursorBoxType.scriptSlot || NativeCursorBoxType.logBaseSlot || NativeCursorBoxType.rootIndexSlot => 11.0,
      NativeCursorBoxType.limitSlot => 12.0,
      NativeCursorBoxType.fractionSlot => 14.0,
      _ => 17.0,
    };
    final maxHeight = switch (type) {
      NativeCursorBoxType.scriptSlot || NativeCursorBoxType.logBaseSlot || NativeCursorBoxType.rootIndexSlot => 18.0,
      NativeCursorBoxType.limitSlot => 20.0,
      NativeCursorBoxType.fractionSlot => 24.0,
      NativeCursorBoxType.gridSlot => 28.0,
      _ => 34.0,
    };
    return preferred.clamp(minHeight, maxHeight).toDouble();
  }

  static Rect _normalizeVisualRect({
    required String role,
    required NativeCursorBoxType type,
    required Rect rect,
    required Size canvasSize,
  }) {
    final minSize = switch (type) {
      NativeCursorBoxType.scriptSlot || NativeCursorBoxType.logBaseSlot || NativeCursorBoxType.rootIndexSlot => const Size(34, 24),
      NativeCursorBoxType.limitSlot => const Size(36, 26),
      NativeCursorBoxType.fractionSlot => const Size(44, 32),
      NativeCursorBoxType.gridSlot => const Size(42, 34),
      _ => const Size(48, 38),
    };
    final maxSize = switch (type) {
      NativeCursorBoxType.scriptSlot || NativeCursorBoxType.logBaseSlot || NativeCursorBoxType.rootIndexSlot => const Size(58, 44),
      NativeCursorBoxType.limitSlot => const Size(60, 46),
      NativeCursorBoxType.fractionSlot => const Size(70, 52),
      NativeCursorBoxType.gridSlot => const Size(78, 58),
      _ => const Size(82, 64),
    };
    final width = rect.width.clamp(minSize.width, math.min(maxSize.width, math.max(minSize.width, canvasSize.width * 0.36))).toDouble();
    final height = rect.height.clamp(minSize.height, math.min(maxSize.height, math.max(minSize.height, canvasSize.height * 0.56))).toDouble();
    return _clampRect(Rect.fromCenter(center: rect.center, width: width, height: height), canvasSize);
  }

  static Rect _normalizePlaceholderRect({
    required String role,
    required NativeCursorBoxType type,
    required Rect visualRect,
    required Rect placeholderRect,
  }) {
    final scale = switch (type) {
      NativeCursorBoxType.scriptSlot || NativeCursorBoxType.logBaseSlot || NativeCursorBoxType.rootIndexSlot => 0.62,
      NativeCursorBoxType.limitSlot => 0.64,
      NativeCursorBoxType.fractionSlot => 0.66,
      NativeCursorBoxType.gridSlot => 0.68,
      _ => 0.70,
    };
    final width = math.min(visualRect.width * scale, math.max(8.0, placeholderRect.width));
    final height = math.min(visualRect.height * scale, math.max(8.0, placeholderRect.height));
    final rect = Rect.fromCenter(center: visualRect.center, width: width, height: height);
    return RoleGeometryVisualAlignmentPolicy.refinePlaceholderRect(
      role: role,
      type: type,
      visualRect: visualRect,
      placeholderRect: rect,
    );
  }

  static double _baselineForBox({
    required String role,
    required NativeCursorBoxType type,
    required Rect rect,
    required double fallbackBaseline,
    required Size canvasSize,
  }) {
    final factor = switch (type) {
      NativeCursorBoxType.scriptSlot || NativeCursorBoxType.rootIndexSlot => 0.62,
      NativeCursorBoxType.logBaseSlot => 0.58,
      NativeCursorBoxType.limitSlot => 0.58,
      NativeCursorBoxType.fractionSlot => 0.58,
      _ => 0.62,
    };
    final value = rect.top + rect.height * factor;
    final blended = (value * 0.74) + (fallbackBaseline * 0.26);
    return blended.clamp(0.0, math.max(0.0, canvasSize.height)).toDouble();
  }

  static double _edgeGapForBox(NativeCursorBoxType type) {
    return switch (type) {
      NativeCursorBoxType.scriptSlot || NativeCursorBoxType.logBaseSlot || NativeCursorBoxType.rootIndexSlot => 4.8,
      NativeCursorBoxType.limitSlot => 5.0,
      NativeCursorBoxType.fractionSlot => 5.4,
      _ => 6.0,
    };
  }

  static double _caretBaselineLift(NativeCursorBoxType type) {
    return switch (type) {
      NativeCursorBoxType.scriptSlot || NativeCursorBoxType.logBaseSlot || NativeCursorBoxType.rootIndexSlot => 0.54,
      NativeCursorBoxType.limitSlot => 0.52,
      _ => 0.50,
    };
  }

  static Rect _clampRect(Rect rect, Size canvasSize) {
    if (canvasSize.isEmpty) return rect;
    final maxLeft = math.max(0.0, canvasSize.width - rect.width);
    final maxTop = math.max(0.0, canvasSize.height - rect.height);
    return Rect.fromLTWH(
      rect.left.clamp(0.0, maxLeft).toDouble(),
      rect.top.clamp(0.0, maxTop).toDouble(),
      rect.width,
      rect.height,
    );
  }
}

enum NativeCursorBoxType {
  mainLineSlot,
  functionArgumentSlot,
  fractionSlot,
  scriptSlot,
  logBaseSlot,
  rootIndexSlot,
  radicandSlot,
  limitSlot,
  gridSlot,
}

class NativeCursorLayoutBox {
  const NativeCursorLayoutBox({
    required this.slotId,
    required this.role,
    required this.type,
    required this.visualRect,
    required this.placeholderRect,
    required this.baselineY,
    required this.entryCaretRect,
    required this.exitCaretRect,
  });

  final String slotId;
  final String role;
  final NativeCursorBoxType type;
  final Rect visualRect;
  final Rect placeholderRect;
  final double baselineY;
  final Rect entryCaretRect;
  final Rect exitCaretRect;

  bool get usesCompactCursor {
    return switch (type) {
      NativeCursorBoxType.scriptSlot || NativeCursorBoxType.logBaseSlot ||
      NativeCursorBoxType.rootIndexSlot || NativeCursorBoxType.limitSlot => true,
      _ => false,
    };
  }
}
