import 'dart:math' as math;
import 'dart:ui';

import '../editor/selection_controller.dart';
import '../editor/slot_registry.dart';
import 'active_empty_slot_leading_rail_caret_policy.dart';
import 'native_layout_box_cursor_layer.dart';
import 'mathlive_structural_caret_anchor_geometry_repair_policy.dart';
import 'role_geometry_visual_alignment_policy.dart';

/// V172-Q49 release-hardening gate for the P6-locked structural cursor pipeline.
///
/// Q34-Q48 added separate precision layers: deterministic geometry,
/// placeholder-safe rails, compact role-aware cursor sizes, fraction/script/log
/// lanes, digit/glyph stops, nested-depth selection, drag stability,
/// structural insert/delete guards, renderer-envelope telemetry, renderer slot
/// candidates, and the native LayoutBox cursor layer. Q49 does not add a new
/// keyboard, MORE surface, long-press UI, app shell, Graph, History, Solution,
/// solver, loupe, or visible slot overlay. It freezes the release pipeline
/// order and exposes small final guards so those layers cannot silently drift
/// apart before a real-device Pixel QA pass.
class StructuralCursorReleaseHardeningPolicy {
  const StructuralCursorReleaseHardeningPolicy._();

  static const String version =
      'mathpro-v172q49-structural-cursor-release-hardening-v172q52-leading-rail-v172q53-role-geometry-p6-locked-v3';

  static const bool structuralCursorReleaseHardeningAvailable = true;
  static const bool p6VisualFilesLocked = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool loupeOrMenuIntroduced = false;
  static const bool visibleGreenOverlayAllowed = false;
  static const bool fullNativeMathRendererClaimed = false;
  static const bool trueAstSlotToSvgNodeIdentityClaimed = false;
  static const bool realDevicePlus95PassClaimed = false;
  static const bool q52ActiveEmptySlotLeadingRailFinalizerAvailable = true;
  static const bool q53RoleGeometryFinalizerAvailable = true;

  static const int requiredCorrectSelectionsPerTwenty = 19;

  static const List<String> frozenPipelineStageOrder = <String>[
    'renderer-expression-envelope',
    'renderer-slot-candidate-refinement',
    'deterministic-slot-geometry',
    'native-layout-box-cursor-geometry',
    'premium-tap-visual-intent-filter',
    'script-lane-filter',
    'fraction-lane-filter',
    'log-root-lane-filter',
    'nested-depth-filter',
    'release-hardening-final-sort',
    'digit-or-renderer-assisted-caret-stop',
    'structural-insert-delete-safety',
    'drag-to-move-stability',
  ];

  static const Set<String> compactRoleFamilies = <String>{
    'powerExponent',
    'subscript',
    'logBase',
    'rootIndex',
    'derivativeOrder',
    'integralUpperLimit',
    'integralLowerLimit',
    'sumUpperLimit',
    'sumLowerLimit',
    'productUpperLimit',
    'productLowerLimit',
    'limitVariable',
    'limitTarget',
    'derivativeVariable',
    'integralDifferential',
  };

  static bool get hasFrozenPipelineWithoutDuplicates {
    return frozenPipelineStageOrder.toSet().length == frozenPipelineStageOrder.length &&
        frozenPipelineStageOrder.first == 'renderer-expression-envelope' &&
        frozenPipelineStageOrder.contains('native-layout-box-cursor-geometry') &&
        frozenPipelineStageOrder.contains('release-hardening-final-sort') &&
        frozenPipelineStageOrder.last == 'drag-to-move-stability';
  }

  static List<T> preservePipelineStage<T>({
    required String stage,
    required Iterable<T> candidates,
  }) {
    assert(frozenPipelineStageOrder.contains(stage));
    return List<T>.of(candidates, growable: false);
  }

  /// Keeps slot-local caret movement deterministic before the real-device QA
  /// court. Empty placeholders expose only entry/exit rails; filled slots expose
  /// bounded rune-level stops so Android taps cannot create runaway indices.
  static int guardedChildCount({required String role, required int rawChildCount}) {
    final safe = math.max(1, rawChildCount);
    final maxStops = compactRoleFamilies.contains(role) ? 24 : 32;
    return safe.clamp(1, maxStops).toInt();
  }

  static int chooseStructuralCaretIndex({
    required Rect visualRect,
    required Offset point,
    required String role,
    required int rawChildCount,
  }) {
    final childCount = guardedChildCount(role: role, rawChildCount: rawChildCount);
    final width = math.max(1.0, visualRect.width);
    final localX = (point.dx - visualRect.left).clamp(0.0, width).toDouble();
    final edgeGuard = edgeGuardForRole(role: role, visualRect: visualRect);
    if (localX <= edgeGuard) return 0;
    if (localX >= width - edgeGuard) return childCount;
    if (childCount == 1) return localX <= width / 2 ? 0 : 1;
    return ((localX / width) * childCount).round().clamp(0, childCount).toInt();
  }

  static double edgeGuardForRole({required String role, required Rect visualRect}) {
    final base = compactRoleFamilies.contains(role) ? 4.0 : 5.0;
    return math.min(math.max(base, visualRect.width * 0.045), visualRect.width * 0.22).toDouble();
  }

  static Rect hardenedNativeCaretRect({
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
    final guardedCount = guardedChildCount(role: role, rawChildCount: childCount);
    final nativeRect = NativeLayoutBoxCursorLayer.caretRectForBox(
      visualRect: visualRect,
      placeholderRect: placeholderRect,
      role: role,
      type: type,
      baselineY: baselineY,
      caretIndex: caretIndex,
      childCount: guardedCount,
      canvasSize: canvasSize,
      activeEmptySlotLeadingRail: activeEmptySlotLeadingRail,
    );
    return finalizeCaretRect(
      nativeCaretRect: nativeRect,
      visualRect: visualRect,
      placeholderRect: placeholderRect,
      role: role,
      canvasSize: canvasSize,
      activeEmptySlotLeadingRail: activeEmptySlotLeadingRail,
      baselineY: baselineY,
    );
  }

  static Rect finalizeCaretRect({
    required Rect nativeCaretRect,
    required Rect visualRect,
    required Rect placeholderRect,
    required String role,
    required Size canvasSize,
    bool activeEmptySlotLeadingRail = false,
    double? baselineY,
  }) {
    final finite = _finiteOrFallback(nativeCaretRect, visualRect: visualRect, role: role);
    if (activeEmptySlotLeadingRail) {
      final q52 = ActiveEmptySlotLeadingRailCaretPolicy.enforceLeadingRail(
        candidate: finite,
        visualRect: visualRect,
        placeholderRect: placeholderRect,
        baselineY: baselineY ?? visualRect.center.dy,
        canvasSize: canvasSize,
        role: role,
      );
      final roleFinalized = RoleGeometryVisualAlignmentPolicy.finalizeActiveEmptyCaret(
        candidate: q52,
        placeholderRect: placeholderRect,
        canvasSize: canvasSize,
        role: role,
      );
      return MathLiveStructuralCaretAnchorGeometryRepairPolicy.anchorPaintedCaret(
        candidate: roleFinalized,
        visualRect: visualRect,
        placeholderRect: placeholderRect,
        role: role,
        canvasSize: canvasSize,
        activeEmptySlotLeadingRail: true,
      );
    }
    final guardedPlaceholder = placeholderRect.inflate(compactRoleFamilies.contains(role) ? 1.6 : 1.8);
    if (!finite.overlaps(guardedPlaceholder)) {
      return _clampToCanvas(finite, canvasSize);
    }

    final gap = compactRoleFamilies.contains(role) ? 5.0 : 6.0;
    final leftRoom = guardedPlaceholder.left;
    final rightRoom = math.max(0.0, canvasSize.width - guardedPlaceholder.right);
    final pushRight = rightRoom >= leftRoom;
    final rail = pushRight ? guardedPlaceholder.right + gap : guardedPlaceholder.left - gap;
    final shifted = Rect.fromLTWH(
      rail - MathProCaretController.inlineCaretWidth / 2,
      finite.top,
      finite.width,
      finite.height,
    );
    return MathLiveStructuralCaretAnchorGeometryRepairPolicy.anchorPaintedCaret(
      candidate: _clampToCanvas(shifted, canvasSize),
      visualRect: visualRect,
      placeholderRect: placeholderRect,
      role: role,
      canvasSize: canvasSize,
      activeEmptySlotLeadingRail: false,
    );
  }

  /// Final deterministic tie-breaker after the specialist lane filters have run.
  /// It only acts when both candidates still overlap the tap point; otherwise the
  /// older priority policy remains authoritative.
  static int compareFinalCandidates({
    required Offset point,
    required SlotEntry aEntry,
    required Rect aVisualRect,
    required SlotEntry bEntry,
    required Rect bVisualRect,
  }) {
    if (aEntry.id == bEntry.id) return 0;
    final aContains = aVisualRect.inflate(1.0).contains(point);
    final bContains = bVisualRect.inflate(1.0).contains(point);
    if (aContains && bContains && aEntry.depth != bEntry.depth) {
      return bEntry.depth.compareTo(aEntry.depth);
    }
    return 0;
  }

  static Rect _finiteOrFallback(Rect rect, {required Rect visualRect, required String role}) {
    final values = <double>[rect.left, rect.top, rect.width, rect.height];
    if (values.every((value) => value.isFinite) && rect.width > 0 && rect.height > 0) {
      return rect;
    }
    final height = compactRoleFamilies.contains(role)
        ? math.min(18.0, math.max(11.0, visualRect.height * 0.42))
        : math.min(32.0, math.max(17.0, visualRect.height * 0.62));
    return Rect.fromLTWH(
      visualRect.center.dx - MathProCaretController.inlineCaretWidth / 2,
      visualRect.center.dy - height / 2,
      MathProCaretController.inlineCaretWidth,
      height,
    );
  }

  static Rect _clampToCanvas(Rect rect, Size canvasSize) {
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
