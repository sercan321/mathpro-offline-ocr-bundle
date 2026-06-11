import 'dart:math' as math;
import 'dart:ui';

import '../editor/slot_registry.dart';
import 'fraction_function_root_log_cursor_specialization_policy.dart';
import 'integral_cursor_specialization_policy.dart';
import 'native_slotbox_hit_test_policy.dart';
import 'slot_geometry_bundle_authority.dart';
import 'slot_hit_testing.dart';

/// V172-Q56 structural intent resolver for the existing MathPro cursor engine.
///
/// Q56 does not create a new keyboard, MORE surface, long-press popup, app
/// shell, Graph, History or Solution behavior. It strengthens the existing
/// cursor motor after Q54/Q55 by making tap intent structural-first across the
/// SlotGeometryBundle authority. When the user taps inside or near an active
/// math template, structural slots win over detached linear fallback so the
/// caret cannot jump to the left edge of an integral or into unrelated text.
class StructuralIntentResolverPolicy {
  const StructuralIntentResolverPolicy._();

  static const String version =
      'mathpro-v172q56-v172q59-v172q71-structural-intent-exact-slotbox-only-p6-locked-v1';

  static const bool structuralIntentResolverAvailable = true;
  static const bool structuralExactHitWins = true;
  static const bool structuralNearestHitEnabled = false;
  static const bool q73NativeSlotBoxHitTestWired = true;
  static const bool templateRegionBeatsLinearFallback = true;
  static const bool slotGeometryBundleAuthorityRequired = true;
  static const bool emptySlotLeadingRailPreserved = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool fullNativeMathRendererClaimed = false;
  static const bool trueAstSlotToSvgNodeIdentityClaimed = false;
  static const bool realDevicePlus95PassClaimed = false;

  static const double templateRegionInflate = 0.0;
  static const double nearestStructuralRadius = 150.0;
  static const double integralNearestStructuralRadius = 220.0;
  static const bool q58IntegralIntentSpecializationWired = true;
  static const bool q59CoreFamilyIntentSpecializationWired = true;
  // Q58 legacy verifier marker retained while Q71 disables nearest routing:
  // IntegralCursorSpecializationPolicy.nearestRadiusForRole
  static const double railIntentWeight = 0.22;
  static const double visualIntentWeight = 0.42;
  static const double hitIntentWeight = 0.16;

  static SlotHitTestResult? resolveIntent({
    required Offset point,
    required Map<SlotEntry, SlotGeometryBundle> bundles,
    required SlotHitTestResult? primaryHit,
    required bool structuralInteractionEnabled,
  }) {
    if (!structuralInteractionEnabled || bundles.isEmpty) return primaryHit;

    final exact = NativeSlotBoxHitTestPolicy.hitTest(point: point, bundles: bundles);
    if (exact != null) return exact;

    if (primaryHit != null) return primaryHit;

    // Q71 Native SlotBox rule: no structural nearest fallback. If the tap did
    // not hit an authoritative bundle hitRect and the reconciled primary hit is
    // absent, the resolver returns null instead of guessing a nearby slot.
    return null;
  }

  static bool shouldSuppressLinearFallbackForTemplateRegion({
    required Offset point,
    required Map<SlotEntry, SlotGeometryBundle> bundles,
    required bool structuralInteractionEnabled,
  }) {
    if (!structuralInteractionEnabled || bundles.isEmpty) return false;
    return isInsideStructuralTemplateRegion(
      point: point,
      bundles: bundles,
      structuralInteractionEnabled: structuralInteractionEnabled,
    );
  }

  static bool isInsideStructuralTemplateRegion({
    required Offset point,
    required Map<SlotEntry, SlotGeometryBundle> bundles,
    required bool structuralInteractionEnabled,
  }) {
    if (!structuralInteractionEnabled || bundles.isEmpty) return false;
    final envelope = structuralTemplateRegion(bundles);
    final structuralWeight = _hasStrongStructuralTemplate(bundles) ? 1.45 : 1.0;
    return envelope.inflate(templateRegionInflate * structuralWeight).contains(point);
  }

  static Rect structuralTemplateRegion(Map<SlotEntry, SlotGeometryBundle> bundles) {
    assert(bundles.isNotEmpty);
    var left = double.infinity;
    var top = double.infinity;
    var right = -double.infinity;
    var bottom = -double.infinity;
    for (final bundle in bundles.values) {
      final region = bundle.hitRect.expandToInclude(bundle.visualRect).expandToInclude(bundle.placeholderRect);
      left = math.min(left, region.left);
      top = math.min(top, region.top);
      right = math.max(right, region.right);
      bottom = math.max(bottom, region.bottom);
    }
    return Rect.fromLTRB(left, top, right, bottom);
  }

  // ignore: unused_element
  static SlotHitTestResult? _bestExactBundleHit({
    required Offset point,
    required Map<SlotEntry, SlotGeometryBundle> bundles,
  }) {
    final candidates = <_IntentCandidate>[];
    for (final item in bundles.entries) {
      final bundle = item.value;
      if (!bundle.hitRect.contains(point)) continue;
      candidates.add(_IntentCandidate(
        bundle: bundle,
        source: 'q56-structural-intent-exact-bundle-hit',
        score: _scoreBundle(point: point, bundle: bundle, exactHit: true),
      ));
    }
    return _bestResult(candidates);
  }


  static SlotHitTestResult? _bestResult(List<_IntentCandidate> candidates) {
    if (candidates.isEmpty) return null;
    candidates.sort((a, b) => a.score.compareTo(b.score));
    final best = candidates.first;
    return SlotHitTestResult(
      entry: best.bundle.entry,
      rect: best.bundle.visualRect,
      hitRect: best.bundle.hitRect,
      source: best.source,
    );
  }

  static double _scoreBundle({
    required Offset point,
    required SlotGeometryBundle bundle,
    required bool exactHit,
  }) {
    final railDistance = math.min(
      (point - bundle.leadingRailRect.center).distance,
      (point - bundle.trailingRailRect.center).distance,
    );
    final visualDistance = _distanceToRect(point, bundle.visualRect);
    final hitDistance = _distanceToRect(point, bundle.hitRect);
    final placeholderDistance = _distanceToRect(point, bundle.placeholderRect);
    final centerDistance = (point - bundle.visualRect.center).distance;
    final lanePenalty = _lanePenalty(point: point, bundle: bundle);
    final roleBonus = _roleBonus(bundle.role);
    final integralBonus = IntegralCursorSpecializationPolicy.roleBonus(bundle.role);
    final coreFamilyBonus = FractionFunctionRootLogCursorSpecializationPolicy.roleBonus(bundle.role);
    final exactBonus = exactHit ? -18.0 : 0.0;
    return hitDistance * hitIntentWeight +
        visualDistance * visualIntentWeight +
        railDistance * railIntentWeight +
        placeholderDistance * 0.15 +
        centerDistance * 0.035 +
        lanePenalty +
        roleBonus +
        integralBonus +
        coreFamilyBonus +
        exactBonus;
  }

  static double _lanePenalty({required Offset point, required SlotGeometryBundle bundle}) {
    final role = bundle.role;
    final centerY = bundle.visualRect.center.dy;
    final dy = point.dy - centerY;
    final integralPenalty = IntegralCursorSpecializationPolicy.lanePenalty(
      point: point,
      role: role,
      visualRect: bundle.visualRect,
    );
    if (integralPenalty > 0) return integralPenalty;
    final coreFamilyPenalty = FractionFunctionRootLogCursorSpecializationPolicy.lanePenalty(
      point: point,
      role: role,
      visualRect: bundle.visualRect,
    );
    if (coreFamilyPenalty > 0) return coreFamilyPenalty;
    if (_upperRole(role) && dy > bundle.visualRect.height * 0.55) return 22.0;
    if (_lowerRole(role) && dy < -bundle.visualRect.height * 0.55) return 22.0;
    if (role == 'integralDifferential' && point.dx < bundle.visualRect.left - 52.0) return 20.0;
    return 0.0;
  }

  static double _roleBonus(String role) {
    return switch (role) {
      'integralUpperLimit' || 'integralLowerLimit' || 'integralBody' || 'integralDifferential' => -16.0,
      'fractionNumerator' || 'fractionDenominator' => -10.0,
      'sqrtValue' || 'rootIndex' => -8.0,
      'functionArgument' || 'functionArgument2' || 'functionArgument3' => -7.0,
      'logBase' || 'powerExponent' || 'subscript' => -5.0,
      _ => 0.0,
    };
  }


  static bool _hasStrongStructuralTemplate(Map<SlotEntry, SlotGeometryBundle> bundles) {
    for (final bundle in bundles.values) {
      if (bundle.role.startsWith('integral') ||
          bundle.role.startsWith('fraction') ||
          bundle.role == 'sqrtValue' ||
          bundle.role == 'rootIndex' ||
          bundle.role == 'logBase' ||
          bundle.role == 'functionArgument' ||
          bundle.role == 'functionArgument2' ||
          bundle.role == 'functionArgument3') {
        return true;
      }
    }
    return false;
  }

  static bool _upperRole(String role) {
    return role == 'integralUpperLimit' ||
        role == 'fractionNumerator' ||
        role == 'sumUpperLimit' ||
        role == 'productUpperLimit' ||
        role == 'powerExponent' ||
        role == 'rootIndex' ||
        role == 'derivativeOrder';
  }

  static bool _lowerRole(String role) {
    return role == 'integralLowerLimit' ||
        role == 'fractionDenominator' ||
        role == 'sumLowerLimit' ||
        role == 'productLowerLimit' ||
        role == 'subscript' ||
        role == 'logBase';
  }

  static double _distanceToRect(Offset point, Rect rect) {
    final dx = point.dx < rect.left ? rect.left - point.dx : point.dx > rect.right ? point.dx - rect.right : 0.0;
    final dy = point.dy < rect.top ? rect.top - point.dy : point.dy > rect.bottom ? point.dy - rect.bottom : 0.0;
    return math.sqrt(dx * dx + dy * dy);
  }
}

class _IntentCandidate {
  const _IntentCandidate({required this.bundle, required this.source, required this.score});

  final SlotGeometryBundle bundle;
  final String source;
  final double score;
}
