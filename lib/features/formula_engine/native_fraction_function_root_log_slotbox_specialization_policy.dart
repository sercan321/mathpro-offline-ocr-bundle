import 'dart:math' as math;
import 'dart:ui';

import 'fraction_function_root_log_cursor_specialization_policy.dart';
import 'slot_geometry_bundle_authority.dart';

/// V172-Q78 — Fraction / Function / Root / Log native SlotBox specialization.
///
/// Q78 keeps the work inside the cursor/editor input surface only. It does not
/// mutate keyboard layout, MORE, long-press popup, app shell, MathLabel,
/// template tray, Solution, Graph, or History.
///
/// The policy makes the high-frequency structural families resolve through
/// deterministic native lanes after Q76/Q77 established one SlotGeometryBundle
/// input-surface frame. It never selects a structural slot outside that slot's
/// authoritative hitRect; it only decides among already-measured overlapping
/// SlotBoxes such as numerator/denominator, log base/argument, root index/body,
/// and function argument slots.
class NativeFractionFunctionRootLogSlotBoxSpecializationPolicy {
  const NativeFractionFunctionRootLogSlotBoxSpecializationPolicy._();

  static const String version =
      'mathpro-v172q78-fraction-function-root-log-native-slotbox-specialization-v1';

  static const bool nativeFractionFunctionRootLogSlotBoxSpecializationAvailable = true;
  static const bool cursorOnlyChange = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool fullNativeMathRendererClaimed = false;
  static const bool trueAstSlotToSvgNodeIdentityClaimed = false;
  static const bool realDevicePlus95PassClaimed = false;

  static const bool fractionNumeratorDenominatorUseNativeSlotBoxes = true;
  static const bool functionArgumentsUseNativeSlotBoxes = true;
  static const bool rootIndexAndBodyUseNativeSlotBoxes = true;
  static const bool logBaseAndArgumentUseNativeSlotBoxes = true;
  static const bool outsideAuthoritativeHitRectIsNotSelected = true;
  static const bool detachedLinearFallbackSuppressedInsideMeasuredSlots = true;
  static const bool emptySlotsKeepExclusivePipeBoxCaret = true;

  static const Set<String> nativeRoles = <String>{
    'fractionNumerator',
    'fractionDenominator',
    'functionArgument',
    'functionArgument2',
    'functionArgument3',
    'sqrtValue',
    'rootIndex',
    'logBase',
    'powerExponent',
    'subscript',
  };

  static bool isNativeRole(String role) => nativeRoles.contains(role);

  static bool isFractionRole(String role) =>
      role == 'fractionNumerator' || role == 'fractionDenominator';

  static bool isFunctionArgumentRole(String role) =>
      role == 'functionArgument' || role == 'functionArgument2' || role == 'functionArgument3';

  static bool isRootRole(String role) => role == 'sqrtValue' || role == 'rootIndex';

  static bool isLogRole(String role) => role == 'logBase' || isFunctionArgumentRole(role);

  static int nativeRoleOrder(String role) {
    return switch (role) {
      'fractionNumerator' => 20,
      'fractionDenominator' => 21,
      'functionArgument' => 30,
      'functionArgument2' => 31,
      'functionArgument3' => 32,
      'sqrtValue' => 40,
      'rootIndex' => 41,
      'logBase' => 50,
      'powerExponent' => 60,
      'subscript' => 61,
      _ => 1000,
    };
  }

  /// Resolves only among candidates that already contain [point] in their
  /// authoritative hitRect. No nearest/visual guessing is performed here.
  static SlotGeometryBundle? resolveNativeCandidate({
    required Offset point,
    required Iterable<SlotGeometryBundle> candidates,
  }) {
    final nativeCandidates = candidates
        .where((bundle) => isNativeRole(bundle.role) && bundle.hitRect.contains(point))
        .toList(growable: false);
    if (nativeCandidates.isEmpty) return null;
    if (nativeCandidates.length == 1) return nativeCandidates.first;

    final byNode = <String, List<SlotGeometryBundle>>{};
    for (final candidate in nativeCandidates) {
      byNode.putIfAbsent(candidate.nodeId, () => <SlotGeometryBundle>[]).add(candidate);
    }

    final ranked = <_NativeFfrlCandidate>[];
    for (final nodeCandidates in byNode.values) {
      final nodeBundleMap = <String, SlotGeometryBundle>{
        for (final bundle in nodeCandidates) bundle.role: bundle,
      };
      for (final bundle in nodeCandidates) {
        ranked.add(_NativeFfrlCandidate(
          bundle: bundle,
          score: _score(point: point, bundle: bundle, nodeBundles: nodeBundleMap),
        ));
      }
    }

    if (ranked.isEmpty) return null;
    ranked.sort(_compare);
    return ranked.first.bundle;
  }

  static bool shouldSuppressDetachedLinearFallback({
    required Offset point,
    required Iterable<SlotGeometryBundle> bundles,
  }) {
    for (final bundle in bundles) {
      if (isNativeRole(bundle.role) && bundle.hitRect.contains(point)) return true;
    }
    return false;
  }

  static Rect refineHitRectForRole({
    required String role,
    required Rect visualRect,
    required Rect baseHitRect,
    required Size canvasSize,
  }) {
    if (!isNativeRole(role)) return baseHitRect;
    final legacy = FractionFunctionRootLogCursorSpecializationPolicy.refineHitRectForRole(
      role: role,
      visualRect: visualRect,
      baseHitRect: baseHitRect,
      canvasSize: canvasSize,
    );
    final bounded = switch (role) {
      'fractionNumerator' => Rect.fromLTRB(
          legacy.left,
          math.max(legacy.top, visualRect.top - 30.0),
          legacy.right,
          math.min(legacy.bottom, visualRect.bottom + 32.0),
        ),
      'fractionDenominator' => Rect.fromLTRB(
          legacy.left,
          math.max(legacy.top, visualRect.top - 32.0),
          legacy.right,
          math.min(legacy.bottom, visualRect.bottom + 30.0),
        ),
      'logBase' || 'rootIndex' || 'powerExponent' || 'subscript' => Rect.fromLTRB(
          math.max(legacy.left, visualRect.left - 28.0),
          math.max(legacy.top, visualRect.top - 28.0),
          math.min(legacy.right, visualRect.right + 34.0),
          math.min(legacy.bottom, visualRect.bottom + 34.0),
        ),
      'sqrtValue' || 'functionArgument' || 'functionArgument2' || 'functionArgument3' => Rect.fromLTRB(
          math.max(legacy.left, visualRect.left - 36.0),
          math.max(legacy.top, visualRect.top - 34.0),
          math.min(legacy.right, visualRect.right + 42.0),
          math.min(legacy.bottom, visualRect.bottom + 38.0),
        ),
      _ => legacy,
    };
    return _clampRect(bounded, canvasSize);
  }

  static Rect refinePlaceholderRectForRole({
    required String role,
    required Rect visualRect,
    required Rect placeholderRect,
  }) {
    if (!isNativeRole(role)) return placeholderRect;
    return FractionFunctionRootLogCursorSpecializationPolicy.refinePlaceholderRectForRole(
      role: role,
      visualRect: visualRect,
      placeholderRect: placeholderRect,
    );
  }

  static Rect refineLeadingRailRectForRole({
    required String role,
    required Rect candidate,
    required Rect placeholderRect,
    required Size canvasSize,
  }) {
    if (!isNativeRole(role)) return candidate;
    return FractionFunctionRootLogCursorSpecializationPolicy.refineLeadingRailRectForRole(
      role: role,
      candidate: candidate,
      placeholderRect: placeholderRect,
      canvasSize: canvasSize,
    );
  }

  static bool provesPipeBoxLaw({required SlotGeometryBundle bundle}) {
    if (!isNativeRole(bundle.role)) return false;
    return bundle.leadingRailRect.right <= bundle.placeholderRect.left &&
        !bundle.leadingRailRect.overlaps(bundle.placeholderRect) &&
        bundle.leadingRailRect != bundle.hitRect;
  }

  static double _score({
    required Offset point,
    required SlotGeometryBundle bundle,
    required Map<String, SlotGeometryBundle> nodeBundles,
  }) {
    final placeholder = _distanceToRect(point, bundle.placeholderRect);
    final inner = _distanceToRect(point, bundle.innerTextRect);
    final visual = _distanceToRect(point, bundle.visualRect);
    final lane = _lanePenalty(point: point, bundle: bundle, nodeBundles: nodeBundles);
    final roleTie = nativeRoleOrder(bundle.role) * 0.001;
    final priorityTie = -bundle.entry.priority * 0.0001;
    final depthTie = -bundle.entry.depth * 0.01;
    return lane + placeholder * 0.64 + inner * 0.23 + visual * 0.13 + roleTie + priorityTie + depthTie;
  }

  static double _lanePenalty({
    required Offset point,
    required SlotGeometryBundle bundle,
    required Map<String, SlotGeometryBundle> nodeBundles,
  }) {
    final role = bundle.role;
    final rect = bundle.visualRect;
    final numerator = nodeBundles['fractionNumerator'];
    final denominator = nodeBundles['fractionDenominator'];
    final logBase = nodeBundles['logBase'];
    final rootIndex = nodeBundles['rootIndex'];
    final sqrtValue = nodeBundles['sqrtValue'];

    if (role == 'fractionNumerator') {
      if (denominator != null && point.dy >= denominator.visualRect.top - 4.0) return 260.0;
      if (point.dy <= rect.bottom + 10.0) return -170.0;
    }
    if (role == 'fractionDenominator') {
      if (numerator != null && point.dy <= numerator.visualRect.bottom + 4.0) return 260.0;
      if (point.dy >= rect.top - 10.0) return -170.0;
    }
    if (role == 'logBase') {
      final argument = nodeBundles['functionArgument'] ?? nodeBundles['functionArgument2'] ?? nodeBundles['functionArgument3'];
      if (bundle.placeholderRect.inflate(8.0).contains(point)) return -360.0;
      if (argument != null && point.dx >= argument.visualRect.left - 8.0) return 240.0;
      if (point.dy >= rect.top - 12.0) return -150.0;
    }
    if (isFunctionArgumentRole(role)) {
      if (logBase != null && point.dx <= logBase.visualRect.right + 4.0 && point.dy >= logBase.visualRect.top - 10.0) {
        return 220.0;
      }
      if (bundle.placeholderRect.inflate(6.0).contains(point) || bundle.innerTextRect.inflate(4.0).contains(point)) {
        return -140.0;
      }
    }
    if (role == 'rootIndex') {
      if (sqrtValue != null && point.dx >= sqrtValue.visualRect.left - 6.0 && point.dy >= sqrtValue.visualRect.top - 8.0) {
        return 230.0;
      }
      return -135.0;
    }
    if (role == 'sqrtValue') {
      if (rootIndex != null && point.dx <= rootIndex.visualRect.right + 6.0 && point.dy <= rootIndex.visualRect.bottom + 10.0) {
        return 210.0;
      }
      return -120.0;
    }
    if (role == 'powerExponent') return point.dy <= rect.center.dy + 10.0 ? -110.0 : 60.0;
    if (role == 'subscript') return point.dy >= rect.center.dy - 10.0 ? -110.0 : 60.0;
    return 0.0;
  }

  static int _compare(_NativeFfrlCandidate a, _NativeFfrlCandidate b) {
    final score = a.score.compareTo(b.score);
    if (score != 0) return score;
    final depth = b.bundle.entry.depth.compareTo(a.bundle.entry.depth);
    if (depth != 0) return depth;
    final priority = b.bundle.entry.priority.compareTo(a.bundle.entry.priority);
    if (priority != 0) return priority;
    final role = nativeRoleOrder(a.bundle.role).compareTo(nativeRoleOrder(b.bundle.role));
    if (role != 0) return role;
    return a.bundle.slotId.compareTo(b.bundle.slotId);
  }

  static double _distanceToRect(Offset point, Rect rect) {
    final dx = point.dx < rect.left ? rect.left - point.dx : point.dx > rect.right ? point.dx - rect.right : 0.0;
    final dy = point.dy < rect.top ? rect.top - point.dy : point.dy > rect.bottom ? point.dy - rect.bottom : 0.0;
    return math.sqrt(dx * dx + dy * dy);
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

class _NativeFfrlCandidate {
  const _NativeFfrlCandidate({required this.bundle, required this.score});

  final SlotGeometryBundle bundle;
  final double score;
}
