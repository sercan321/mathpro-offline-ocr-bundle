import 'dart:math' as math;
import 'dart:ui';

import '../editor/slot_registry.dart';
import 'fraction_function_root_log_cursor_specialization_policy.dart';
import 'integral_cursor_specialization_policy.dart';
import 'native_integral_slotbox_specialization_policy.dart';
import 'native_fraction_function_root_log_slotbox_specialization_policy.dart';
import 'native_nested_long_expression_pan_stability_policy.dart';
import 'slot_geometry_bundle_authority.dart';
import 'slot_hit_testing.dart';
import 'slot_interaction_calibration_policy.dart';

/// V172-Q73 Native SlotBox hit-test engine.
///
/// Q73 is cursor/editor-only. It deliberately does not touch the keyboard,
/// MORE tray, long-press popup, app shell, MathLabel, template tray, Solution,
/// Graph, or History. The purpose is to make structural selection deterministic:
/// a tap can select a structural slot only when it is inside that slot's
/// authoritative [SlotGeometryBundle.hitRect]. Overlapping measured hitRects are
/// resolved by stable geometry/role/depth rules; points outside every measured
/// hitRect are not guessed through nearest-distance fallback.
class NativeSlotBoxHitTestPolicy {
  const NativeSlotBoxHitTestPolicy._();

  static const String version =
      'mathpro-v172q73-v172q79-native-slotbox-hit-test-engine-authoritative-hitrect-integral-ffrl-nested-long-pan-lanes-v1';

  static const bool nativeSlotBoxHitTestAvailable = true;
  static const bool cursorOnlyChange = true;
  static const bool authoritativeHitRectOnly = true;
  static const bool nearestDistanceFallbackAllowed = false;
  static const bool legacyNearestStructuralFallbackAllowed = false;
  static const bool visualRectOnlyFallbackAllowedWithBundles = false;
  static const bool overlappingHitRectsUseDeterministicTieBreak = true;
  static const bool emptySlotExclusiveLeadingCaretPreserved = true;
  static const bool q77IntegralNativeLaneResolverWired = true;
  static const bool q79NestedLongExpressionPanStabilityWired = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool fullNativeMathRendererClaimed = false;
  static const bool realDevicePlus95PassClaimed = false;

  static SlotHitTestResult? hitTest({
    required Offset point,
    required Map<SlotEntry, SlotGeometryBundle> bundles,
  }) {
    if (bundles.isEmpty) return null;
    final candidates = <_NativeSlotBoxCandidate>[];
    for (final item in bundles.entries) {
      final bundle = item.value;
      if (!bundle.hitRect.contains(point)) continue;
      candidates.add(_NativeSlotBoxCandidate(bundle: bundle, score: _score(point: point, bundle: bundle)));
    }
    if (candidates.isEmpty) return null;
    final candidateBundles = candidates.map((candidate) => candidate.bundle).toList(growable: false);
    // Q79 is a tie-breaker for genuinely nested/overlapping measured SlotBoxes.
    // It must not steal ordinary single-slot Q77/Q78 lane hits, but when a tap
    // is inside multiple measured boxes at nested depth, the deepest measured
    // SlotBox wins before family-specific lane ranking.
    if (candidateBundles.length > 1 && NativeNestedLongExpressionPanStabilityPolicy.maxBundleDepth(candidateBundles) >= 2) {
      final nativeNestedLong = NativeNestedLongExpressionPanStabilityPolicy.resolveNestedCandidate(
        point: point,
        candidates: candidateBundles,
      );
      if (nativeNestedLong != null) {
        return SlotHitTestResult(
          entry: nativeNestedLong.entry,
          rect: nativeNestedLong.visualRect,
          hitRect: nativeNestedLong.hitRect,
          source: 'q79-native-nested-long-expression-pan-stable-hit',
        );
      }
    }
    final nativeIntegral = NativeIntegralSlotBoxSpecializationPolicy.resolveIntegralCandidate(
      point: point,
      candidates: candidateBundles,
    );
    if (nativeIntegral != null) {
      return SlotHitTestResult(
        entry: nativeIntegral.entry,
        rect: nativeIntegral.visualRect,
        hitRect: nativeIntegral.hitRect,
        source: 'q77-native-integral-slotbox-lane-hit',
      );
    }
    final nativeFfrl = NativeFractionFunctionRootLogSlotBoxSpecializationPolicy.resolveNativeCandidate(
      point: point,
      candidates: candidateBundles,
    );
    if (nativeFfrl != null) {
      return SlotHitTestResult(
        entry: nativeFfrl.entry,
        rect: nativeFfrl.visualRect,
        hitRect: nativeFfrl.hitRect,
        source: 'q78-native-fraction-function-root-log-slotbox-lane-hit',
      );
    }
    candidates.sort(_compareCandidates);
    final best = candidates.first.bundle;
    return SlotHitTestResult(
      entry: best.entry,
      rect: best.visualRect,
      hitRect: best.hitRect,
      source: 'q73-native-slotbox-authoritative-hitrect',
    );
  }

  static bool pointHitsAnyAuthoritativeSlot({
    required Offset point,
    required Map<SlotEntry, SlotGeometryBundle> bundles,
  }) {
    for (final bundle in bundles.values) {
      if (bundle.hitRect.contains(point)) return true;
    }
    return false;
  }

  static bool canUseLegacyVisualHitTest({
    required bool structuralInteractionEnabled,
    required int geometryBundleCount,
  }) {
    if (!structuralInteractionEnabled) return false;
    // Only legacy/no-geometry surfaces may fall back to old visual-rect hit-test.
    return geometryBundleCount <= 0;
  }

  static bool canUseLegacyNearestStructuralFallback({
    required bool structuralInteractionEnabled,
    required int geometryBundleCount,
  }) {
    if (!structuralInteractionEnabled) return false;
    if (geometryBundleCount > 0) return false;
    return legacyNearestStructuralFallbackAllowed;
  }

  static bool shouldBlockLinearFallbackInsideMeasuredStructuralHit({
    required Offset point,
    required Map<SlotEntry, SlotGeometryBundle> bundles,
    required bool structuralInteractionEnabled,
  }) {
    if (!structuralInteractionEnabled || bundles.isEmpty) return false;
    if (NativeIntegralSlotBoxSpecializationPolicy.shouldSuppressDetachedLinearFallback(
      point: point,
      bundles: bundles.values,
    )) {
      return true;
    }
    if (NativeFractionFunctionRootLogSlotBoxSpecializationPolicy.shouldSuppressDetachedLinearFallback(
      point: point,
      bundles: bundles.values,
    )) {
      return true;
    }
    return pointHitsAnyAuthoritativeSlot(point: point, bundles: bundles);
  }

  static int _compareCandidates(_NativeSlotBoxCandidate a, _NativeSlotBoxCandidate b) {
    final score = a.score.compareTo(b.score);
    if (score != 0) return score;
    final priority = b.bundle.entry.priority.compareTo(a.bundle.entry.priority);
    if (priority != 0) return priority;
    final depth = b.bundle.entry.depth.compareTo(a.bundle.entry.depth);
    if (depth != 0) return depth;
    final role = SlotInteractionCalibrationPolicy.roleOrder(a.bundle.role).compareTo(
      SlotInteractionCalibrationPolicy.roleOrder(b.bundle.role),
    );
    if (role != 0) return role;
    return a.bundle.slotId.compareTo(b.bundle.slotId);
  }

  static double _score({required Offset point, required SlotGeometryBundle bundle}) {
    // This score never admits points outside hitRect. It only breaks ties when
    // multiple measured hitRects overlap, which is unavoidable for phone-sized
    // structural slots. Prefer the most semantically precise region first.
    final band = _precisionBand(point: point, bundle: bundle);
    final depthBonus = -bundle.entry.depth * 32.0;
    final priorityBonus = -bundle.entry.priority * 0.015;
    final roleBonus = _roleBonus(bundle.role) +
        IntegralCursorSpecializationPolicy.roleBonus(bundle.role) +
        FractionFunctionRootLogCursorSpecializationPolicy.roleBonus(bundle.role);
    final lanePenalty = IntegralCursorSpecializationPolicy.lanePenalty(
          point: point,
          role: bundle.role,
          visualRect: bundle.visualRect,
        ) +
        FractionFunctionRootLogCursorSpecializationPolicy.lanePenalty(
          point: point,
          role: bundle.role,
          visualRect: bundle.visualRect,
        );
    final placeholderDistance = _distanceToRect(point, bundle.placeholderRect);
    final innerDistance = _distanceToRect(point, bundle.innerTextRect);
    final visualDistance = _distanceToRect(point, bundle.visualRect);
    final railDistance = math.min(
      (point - bundle.leadingRailRect.center).distance,
      (point - bundle.trailingRailRect.center).distance,
    );
    final areaPenalty = math.sqrt(math.max(1.0, bundle.hitRect.width * bundle.hitRect.height)) * 0.012;
    return band * 10000.0 +
        placeholderDistance * 0.55 +
        innerDistance * 0.22 +
        visualDistance * 0.18 +
        railDistance * 0.07 +
        areaPenalty +
        lanePenalty +
        roleBonus +
        depthBonus +
        priorityBonus;
  }

  static int _precisionBand({required Offset point, required SlotGeometryBundle bundle}) {
    if (bundle.placeholderRect.contains(point)) return 0;
    if (bundle.innerTextRect.contains(point)) return 1;
    if (bundle.visualRect.contains(point)) return 2;
    return 3;
  }

  static double _roleBonus(String role) {
    return switch (role) {
      'integralDifferential' => -18.0,
      'integralUpperLimit' || 'integralLowerLimit' || 'integralBody' => -13.0,
      'fractionNumerator' || 'fractionDenominator' => -11.0,
      'sqrtValue' || 'rootIndex' => -10.0,
      'logBase' => -9.0,
      'functionArgument' || 'functionArgument2' || 'functionArgument3' => -8.0,
      'powerExponent' || 'subscript' => -6.0,
      _ => 0.0,
    };
  }

  static double _distanceToRect(Offset point, Rect rect) {
    final dx = point.dx < rect.left ? rect.left - point.dx : point.dx > rect.right ? point.dx - rect.right : 0.0;
    final dy = point.dy < rect.top ? rect.top - point.dy : point.dy > rect.bottom ? point.dy - rect.bottom : 0.0;
    return math.sqrt(dx * dx + dy * dy);
  }
}

class _NativeSlotBoxCandidate {
  const _NativeSlotBoxCandidate({required this.bundle, required this.score});

  final SlotGeometryBundle bundle;
  final double score;
}
