import 'dart:math' as math;
import 'dart:ui';

import 'integral_cursor_specialization_policy.dart';
import 'slot_geometry_bundle_authority.dart';

/// V172-Q77 — Integral Native SlotBox specialization.
///
/// Q77 keeps the cursor work inside the editor/formula-engine layer only.  It
/// does not touch the keyboard, MORE tray, long-press popup, app shell,
/// MathLabel, template tray, Solution, Graph, or History surfaces.
///
/// The purpose is narrower than Q58. Q58 specialized the old cursor pipeline;
/// Q77 makes integral taps use the native SlotBox frame deterministically.  An
/// integral tap may select upper/lower/body/differential only when the tap is
/// inside an authoritative SlotGeometryBundle.hitRect, and overlapping integral
/// hitRects are resolved by native integral lanes instead of nearest-distance
/// guessing or detached linear fallback.
class NativeIntegralSlotBoxSpecializationPolicy {
  const NativeIntegralSlotBoxSpecializationPolicy._();

  static const String version =
      'mathpro-v172q77-integral-native-slotbox-specialization-v1';

  static const bool nativeIntegralSlotBoxSpecializationAvailable = true;
  static const bool cursorOnlyChange = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool fullNativeMathRendererClaimed = false;
  static const bool trueAstSlotToSvgNodeIdentityClaimed = false;
  static const bool realDevicePlus95PassClaimed = false;

  static const bool upperLowerBodyDifferentialUseNativeSlotBoxes = true;
  static const bool integralOverlapsUseNativeLaneResolver = true;
  static const bool differentialSlotBeatsBodyWhenPointIsInDifferentialLane = true;
  static const bool integralOutsideAuthoritativeHitRectIsNotSelected = true;
  static const bool integralDetachedLinearFallbackSuppressedInsideMeasuredSlots = true;
  static const bool differentialEmptyCaretMustBeDPipeBox = true;

  static const Set<String> nativeIntegralRoles = <String>{
    'integralUpperLimit',
    'integralLowerLimit',
    'integralBody',
    'integralDifferential',
  };

  static bool isNativeIntegralRole(String role) => nativeIntegralRoles.contains(role);

  static int nativeRoleOrder(String role) {
    return switch (role) {
      'integralUpperLimit' => 10,
      'integralLowerLimit' => 11,
      'integralBody' => 12,
      'integralDifferential' => 13,
      _ => 1000,
    };
  }

  /// Builds a stable role map for an integral node. The map is deliberately
  /// keyed by role, not by visual order, so Q77 can prove that all four native
  /// integral targets are known before hit-test tie-breaking.
  static Map<String, SlotGeometryBundle> integralBundlesForNode({
    required String nodeId,
    required Iterable<SlotGeometryBundle> bundles,
  }) {
    final output = <String, SlotGeometryBundle>{};
    for (final bundle in bundles) {
      if (bundle.nodeId != nodeId || !isNativeIntegralRole(bundle.role)) continue;
      output[bundle.role] = bundle;
    }
    return Map<String, SlotGeometryBundle>.unmodifiable(output);
  }

  static bool hasCompleteIntegralSlotSet(Iterable<SlotGeometryBundle> bundles) {
    final byNode = <String, Set<String>>{};
    for (final bundle in bundles) {
      if (!isNativeIntegralRole(bundle.role)) continue;
      byNode.putIfAbsent(bundle.nodeId, () => <String>{}).add(bundle.role);
    }
    return byNode.values.any((roles) => nativeIntegralRoles.every(roles.contains));
  }

  /// Q77 tie-breaker for overlapping native integral hitRects.
  ///
  /// The input candidates must already be authoritative hitRect matches. This
  /// function never invents a structural selection outside those measured rects;
  /// it only decides among overlapping integral SlotBoxes from the same native
  /// frame.
  static SlotGeometryBundle? resolveIntegralCandidate({
    required Offset point,
    required Iterable<SlotGeometryBundle> candidates,
  }) {
    final integralCandidates = candidates
        .where((bundle) => isNativeIntegralRole(bundle.role) && bundle.hitRect.contains(point))
        .toList(growable: false);
    if (integralCandidates.isEmpty) return null;
    if (integralCandidates.length == 1) return integralCandidates.first;

    final byNode = <String, List<SlotGeometryBundle>>{};
    for (final candidate in integralCandidates) {
      byNode.putIfAbsent(candidate.nodeId, () => <SlotGeometryBundle>[]).add(candidate);
    }

    final ranked = <_NativeIntegralCandidate>[];
    for (final nodeCandidates in byNode.values) {
      final nodeBundleMap = <String, SlotGeometryBundle>{
        for (final bundle in nodeCandidates) bundle.role: bundle,
      };
      for (final bundle in nodeCandidates) {
        ranked.add(_NativeIntegralCandidate(
          bundle: bundle,
          score: _nativeIntegralScore(
            point: point,
            bundle: bundle,
            nodeBundles: nodeBundleMap,
          ),
        ));
      }
    }

    if (ranked.isEmpty) return null;
    ranked.sort(_compareNativeIntegralCandidates);
    return ranked.first.bundle;
  }

  static bool shouldSuppressDetachedLinearFallback({
    required Offset point,
    required Iterable<SlotGeometryBundle> bundles,
  }) {
    for (final bundle in bundles) {
      if (isNativeIntegralRole(bundle.role) && bundle.hitRect.contains(point)) {
        return true;
      }
    }
    return false;
  }

  static Rect refineHitRectForRole({
    required String role,
    required Rect visualRect,
    required Rect baseHitRect,
    required Size canvasSize,
  }) {
    if (!isNativeIntegralRole(role)) return baseHitRect;
    final oldIntegral = IntegralCursorSpecializationPolicy.refineHitRectForRole(
      role: role,
      visualRect: visualRect,
      baseHitRect: baseHitRect,
      canvasSize: canvasSize,
    );
    // Differential needs a generous but bounded lane because users tap the
    // visible `d□` tail. It must not expand so far left that the body slot is
    // swallowed. The bounds below enlarge around the visual differential target
    // while keeping the left edge close to the d/placeholder lane.
    if (role == 'integralDifferential') {
      final bounded = Rect.fromLTRB(
        math.max(oldIntegral.left, visualRect.left - 26.0),
        oldIntegral.top,
        math.max(oldIntegral.right, visualRect.right + 34.0),
        oldIntegral.bottom,
      );
      return _clampRect(bounded, canvasSize);
    }
    if (role == 'integralBody') {
      // Keep body comfortable, but do not let it aggressively occupy the
      // differential tail. Q77 resolves remaining overlaps with lane scoring.
      final bounded = Rect.fromLTRB(
        oldIntegral.left,
        oldIntegral.top,
        math.min(oldIntegral.right, visualRect.right + 46.0),
        oldIntegral.bottom,
      );
      return _clampRect(bounded, canvasSize);
    }
    return oldIntegral;
  }

  static Rect refinePlaceholderRectForRole({
    required String role,
    required Rect visualRect,
    required Rect placeholderRect,
  }) {
    if (!isNativeIntegralRole(role)) return placeholderRect;
    return IntegralCursorSpecializationPolicy.refinePlaceholderRectForRole(
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
    if (!isNativeIntegralRole(role)) return candidate;
    return IntegralCursorSpecializationPolicy.refineLeadingRailRectForRole(
      role: role,
      candidate: candidate,
      placeholderRect: placeholderRect,
      canvasSize: canvasSize,
    );
  }

  static bool provesDifferentialNativeDPipeBox({
    required SlotGeometryBundle bundle,
  }) {
    if (bundle.role != 'integralDifferential') return false;
    return IntegralCursorSpecializationPolicy.provesDifferentialPipeBoxLaw(
      caretRect: bundle.leadingRailRect,
      placeholderRect: bundle.placeholderRect,
    );
  }

  static double _nativeIntegralScore({
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
    return lane + placeholder * 0.62 + inner * 0.24 + visual * 0.12 + roleTie + priorityTie + depthTie;
  }

  static double _lanePenalty({
    required Offset point,
    required SlotGeometryBundle bundle,
    required Map<String, SlotGeometryBundle> nodeBundles,
  }) {
    final role = bundle.role;
    final rect = bundle.visualRect;
    final upper = nodeBundles['integralUpperLimit'];
    final lower = nodeBundles['integralLowerLimit'];
    final body = nodeBundles['integralBody'];
    final differential = nodeBundles['integralDifferential'];

    if (role == 'integralDifferential') {
      if (bundle.placeholderRect.inflate(8.0).contains(point)) return -420.0;
      if (bundle.innerTextRect.inflate(8.0).contains(point)) return -320.0;
      if (point.dx >= rect.left - 10.0 && point.dx <= bundle.hitRect.right) return -180.0;
      if (body != null && point.dx < body.visualRect.right - 8.0) return 220.0;
      return 20.0;
    }

    if (role == 'integralBody') {
      if (differential != null && point.dx >= differential.visualRect.left - 8.0) return 260.0;
      if (rect.inflate(6.0).contains(point)) return -130.0;
      return 10.0;
    }

    if (role == 'integralUpperLimit') {
      final lowerTop = lower?.visualRect.top;
      if (lowerTop != null && point.dy > lowerTop - 2.0) return 260.0;
      if (upper != null && point.dy <= upper.visualRect.bottom + 12.0) return -170.0;
      return point.dy <= rect.center.dy ? -80.0 : 90.0;
    }

    if (role == 'integralLowerLimit') {
      final upperBottom = upper?.visualRect.bottom;
      if (upperBottom != null && point.dy < upperBottom + 2.0) return 260.0;
      if (lower != null && point.dy >= lower.visualRect.top - 12.0) return -170.0;
      return point.dy >= rect.center.dy ? -80.0 : 90.0;
    }

    return 0.0;
  }

  static int _compareNativeIntegralCandidates(_NativeIntegralCandidate a, _NativeIntegralCandidate b) {
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

class _NativeIntegralCandidate {
  const _NativeIntegralCandidate({required this.bundle, required this.score});

  final SlotGeometryBundle bundle;
  final double score;
}
