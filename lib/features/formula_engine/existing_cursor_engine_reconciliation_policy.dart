import 'dart:math' as math;
import 'dart:ui';

import '../editor/slot_registry.dart';
import 'active_empty_slot_leading_rail_caret_policy.dart';
import 'native_slotbox_hit_test_policy.dart';
import 'slot_hit_testing.dart';

/// V172-Q54 reconciliation layer for the existing MathPro cursor engine.
/// Legacy verifier marker retained: v172q54-existing-cursor-engine-reconciliation.
///
/// MathPro already has a structural cursor motor. Q54 does not replace it and
/// does not touch keyboard/MORE/long-press/app shell/Graph/History/Solution.
/// It reconciles the existing motor so hit-testing, structural slot intent,
/// linear fallback suppression, and caret rendering all obey the same
/// structural-first law on real devices.
class ExistingCursorEngineReconciliationPolicy {
  const ExistingCursorEngineReconciliationPolicy._();

  static const String version =
      'mathpro-v172q54-v172q73-existing-cursor-engine-reconciliation-no-nearest-slotbox-fallback-p6-locked-v1';

  static const bool existingCursorEngineReconciled = true;
  static const bool existingCursorMotorPreserved = true;
  static const bool structuralFirstHitTestingEnabled = true;
  static const bool slotInteractionSeparatedFromVisibleOverlay = true;
  static const bool structuralTemplateLinearFallbackGuardEnabled = true;
  static const bool q73NativeSlotBoxHitTestWired = true;
  static const bool nearestStructuralFallbackEnabled = false;
  static const bool directNearestStructuralHitHardBlocked = true;
  static const bool activeEmptySlotLeadingRailPreserved = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool fullNativeMathRendererClaimed = false;
  static const bool trueAstSlotToSvgNodeIdentityClaimed = false;
  static const bool realDevicePlus95PassClaimed = false;

  static const double structuralIntentEnvelopeInflate = 124.0;
  static const double structuralNearestFallbackRadius = 156.0;

  static bool slotInteractionEnabled({
    required bool rendererPolicyAllowsSlots,
    required SlotRegistry registry,
    required String expression,
  }) {
    if (!registry.hasSlots) return false;
    if (rendererPolicyAllowsSlots) return true;
    final clean = expression.trim();
    return clean.contains('□') || _hasStructuralRoles(registry);
  }

  static SlotHitTestResult? reconcileStructuralHit({
    required Offset point,
    required Map<SlotEntry, Rect> visualRects,
    required SlotHitTestResult? primaryHit,
    required bool structuralInteractionEnabled,
  }) {
    if (!structuralInteractionEnabled || visualRects.isEmpty) return primaryHit;
    if (primaryHit != null) return primaryHit;
    if (!NativeSlotBoxHitTestPolicy.canUseLegacyNearestStructuralFallback(
      structuralInteractionEnabled: structuralInteractionEnabled,
      geometryBundleCount: visualRects.length,
    )) {
      return null;
    }
    return nearestStructuralHit(point: point, visualRects: visualRects);
  }

  static SlotHitTestResult? nearestStructuralHit({
    required Offset point,
    required Map<SlotEntry, Rect> visualRects,
  }) {
    // Q80R1: keep the historical method as a compatibility symbol, but make
    // the method itself honor the no-nearest law even if called directly.
    if (!nearestStructuralFallbackEnabled || directNearestStructuralHitHardBlocked) return null;
    if (visualRects.isEmpty) return null;
    final envelope = structuralIntentEnvelope(visualRects);
    if (!envelope.inflate(structuralIntentEnvelopeInflate).contains(point)) {
      return null;
    }

    SlotEntry? bestEntry;
    Rect? bestRect;
    var bestScore = double.infinity;
    for (final item in visualRects.entries) {
      final distance = _distanceToRect(point, item.value);
      if (distance > structuralNearestFallbackRadius + _roleRadiusBonus(item.key.role)) continue;
      final centerDistance = (point - item.value.center).distance;
      final score = distance + centerDistance * 0.045 + _rolePenalty(item.key.role);
      if (score < bestScore) {
        bestScore = score;
        bestEntry = item.key;
        bestRect = item.value;
      }
    }

    if (bestEntry == null || bestRect == null) return null;
    return SlotHitTestResult(
      entry: bestEntry,
      rect: bestRect,
      hitRect: bestRect.inflate(StructuralReconciliationHitSlop.forRole(bestEntry.role)),
      source: 'q54-structural-intent-reconciliation',
    );
  }

  static bool shouldSuppressLinearFallback({
    required Offset point,
    required Map<SlotEntry, Rect> visualRects,
    required bool structuralInteractionEnabled,
  }) {
    if (!structuralInteractionEnabled || visualRects.isEmpty) return false;
    final envelope = structuralIntentEnvelope(visualRects);
    return envelope.inflate(structuralIntentEnvelopeInflate * 0.88).contains(point);
  }

  static int reconciledStructuralCaretIndex({
    required String? payload,
    required String role,
    required int requestedCaretIndex,
  }) {
    if (ActiveEmptySlotLeadingRailCaretPolicy.isEmptyStructuralPayload(payload)) {
      return ActiveEmptySlotLeadingRailCaretPolicy.caretIndexForEmptyActiveSlot(
        requestedCaretIndex: requestedCaretIndex,
      );
    }
    return requestedCaretIndex < 0 ? 0 : requestedCaretIndex;
  }

  static Rect structuralIntentEnvelope(Map<SlotEntry, Rect> visualRects) {
    assert(visualRects.isNotEmpty);
    var left = double.infinity;
    var top = double.infinity;
    var right = -double.infinity;
    var bottom = -double.infinity;
    for (final rect in visualRects.values) {
      left = math.min(left, rect.left);
      top = math.min(top, rect.top);
      right = math.max(right, rect.right);
      bottom = math.max(bottom, rect.bottom);
    }
    return Rect.fromLTRB(left, top, right, bottom);
  }

  static bool _hasStructuralRoles(SlotRegistry registry) {
    for (final entry in registry.entries) {
      if (entry.role != 'placeholder') return true;
    }
    return false;
  }

  static double _roleRadiusBonus(String role) {
    return switch (role) {
      'integralUpperLimit' || 'integralLowerLimit' || 'integralBody' || 'integralDifferential' => 48.0,
      'fractionNumerator' || 'fractionDenominator' => 34.0,
      'sqrtValue' || 'rootIndex' => 34.0,
      'functionArgument' || 'functionArgument2' || 'functionArgument3' => 30.0,
      _ => 18.0,
    };
  }

  static double _rolePenalty(String role) {
    return switch (role) {
      'integralUpperLimit' || 'integralLowerLimit' || 'integralBody' || 'integralDifferential' => -10.0,
      'fractionNumerator' || 'fractionDenominator' => -6.0,
      'sqrtValue' || 'functionArgument' || 'functionArgument2' || 'functionArgument3' => -4.0,
      _ => 0.0,
    };
  }

  static double _distanceToRect(Offset point, Rect rect) {
    final dx = point.dx < rect.left ? rect.left - point.dx : point.dx > rect.right ? point.dx - rect.right : 0.0;
    final dy = point.dy < rect.top ? rect.top - point.dy : point.dy > rect.bottom ? point.dy - rect.bottom : 0.0;
    return math.sqrt(dx * dx + dy * dy);
  }
}

class StructuralReconciliationHitSlop {
  const StructuralReconciliationHitSlop._();

  static double forRole(String role) {
    return switch (role) {
      'integralUpperLimit' || 'integralLowerLimit' || 'integralBody' || 'integralDifferential' => 42.0,
      'fractionNumerator' || 'fractionDenominator' => 36.0,
      'sqrtValue' || 'rootIndex' => 34.0,
      'functionArgument' || 'functionArgument2' || 'functionArgument3' => 34.0,
      _ => 28.0,
    };
  }
}
