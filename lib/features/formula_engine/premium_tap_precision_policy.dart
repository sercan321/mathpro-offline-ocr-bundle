import 'dart:math' as math;
import 'dart:ui';

import '../editor/slot_registry.dart';

/// V172-J no-loupe tap precision contract.
///
/// MathPro does not use an editor loupe or textual Pay/Payda/Üs menu for cursor
/// placement.  A normal tap must resolve directly to the most plausible
/// mathematical cursor anchor.  This policy keeps that selection premium by
/// privileging visual intent first, then a narrow role-aware lane, and only then
/// the broader invisible mobile touch target.
class PremiumTapPrecisionPolicy {
  const PremiumTapPrecisionPolicy._();

  static const String version = 'mathpro-v172j-no-loupe-premium-tap-precision-v1';
  static const bool editorLoupeEnabled = false;
  static const bool editorLongPressMenuEnabled = false;

  static bool isVisualIntentTap({
    required Offset point,
    required SlotEntry entry,
    required Rect visualRect,
  }) {
    return visualIntentRect(entry.role, visualRect).contains(point);
  }

  static bool isPrecisionLaneTap({
    required Offset point,
    required SlotEntry entry,
    required Rect visualRect,
  }) {
    return precisionLaneRect(entry.role, visualRect).contains(point);
  }

  static Rect visualIntentRect(String role, Rect visualRect) {
    final inflateX = switch (role) {
      'powerExponent' || 'rootIndex' || 'subscript' || 'logBase' => 12.0,
      'fractionNumerator' || 'fractionDenominator' => 10.0,
      'integralUpperLimit' || 'integralLowerLimit' || 'sumUpperLimit' || 'sumLowerLimit' || 'productUpperLimit' || 'productLowerLimit' => 10.0,
      'matrixCell' || 'systemLeft' || 'systemRight' => 8.0,
      _ => 8.0,
    };
    final inflateY = switch (role) {
      'powerExponent' || 'rootIndex' || 'subscript' || 'logBase' => 10.0,
      'fractionNumerator' || 'fractionDenominator' => 8.0,
      'integralUpperLimit' || 'integralLowerLimit' || 'sumUpperLimit' || 'sumLowerLimit' || 'productUpperLimit' || 'productLowerLimit' => 8.0,
      _ => 6.0,
    };
    return Rect.fromLTRB(
      visualRect.left - inflateX,
      visualRect.top - inflateY,
      visualRect.right + inflateX,
      visualRect.bottom + inflateY,
    );
  }

  static Rect precisionLaneRect(String role, Rect visualRect) {
    final horizontal = switch (role) {
      'functionArgument' || 'derivativeBody' || 'integralBody' || 'limitBody' || 'sumBody' || 'productBody' => 82.0,
      'fractionNumerator' || 'fractionDenominator' || 'sqrtValue' => 58.0,
      'powerExponent' || 'rootIndex' || 'subscript' || 'logBase' || 'derivativeOrder' || 'derivativeVariable' => 52.0,
      'matrixCell' || 'systemLeft' || 'systemRight' => 34.0,
      _ => 48.0,
    };
    final vertical = switch (role) {
      'functionArgument' || 'derivativeBody' => 58.0,
      'fractionNumerator' || 'fractionDenominator' || 'sqrtValue' => 42.0,
      'powerExponent' || 'rootIndex' || 'subscript' || 'logBase' || 'derivativeOrder' || 'derivativeVariable' => 38.0,
      'integralUpperLimit' || 'integralLowerLimit' || 'sumUpperLimit' || 'sumLowerLimit' || 'productUpperLimit' || 'productLowerLimit' => 36.0,
      'matrixCell' || 'systemLeft' || 'systemRight' => 30.0,
      _ => 44.0,
    };
    return Rect.fromLTRB(
      visualRect.left - horizontal,
      visualRect.top - vertical,
      visualRect.right + horizontal,
      visualRect.bottom + vertical,
    );
  }

  static bool acceptsNearestFallback({
    required Offset point,
    required SlotEntry entry,
    required Rect visualRect,
    required double distanceToHitRect,
  }) {
    final cap = nearestFallbackCapForRole(entry.role);
    if (distanceToHitRect > cap) return false;
    final visualDistance = distanceToRect(point, visualRect);
    return visualDistance <= cap + 12.0;
  }

  static double nearestFallbackCapForRole(String role) {
    return switch (role) {
      'functionArgument' || 'derivativeBody' => 96.0,
      'placeholder' => 92.0,
      'logBase' || 'subscript' => 76.0,
      'fractionNumerator' || 'fractionDenominator' || 'sqrtValue' => 72.0,
      'powerExponent' || 'rootIndex' || 'derivativeOrder' || 'derivativeVariable' => 68.0,
      'integralUpperLimit' || 'integralLowerLimit' || 'sumUpperLimit' || 'sumLowerLimit' || 'productUpperLimit' || 'productLowerLimit' => 70.0,
      'matrixCell' || 'systemLeft' || 'systemRight' => 64.0,
      _ => 78.0,
    };
  }

  static int compareTapIntent(TapCandidateView a, TapCandidateView b, Offset point) {
    final aVisual = isVisualIntentTap(point: point, entry: a.entry, visualRect: a.visualRect);
    final bVisual = isVisualIntentTap(point: point, entry: b.entry, visualRect: b.visualRect);
    if (aVisual != bVisual) return bVisual ? 1 : -1;

    final aLane = isPrecisionLaneTap(point: point, entry: a.entry, visualRect: a.visualRect);
    final bLane = isPrecisionLaneTap(point: point, entry: b.entry, visualRect: b.visualRect);
    if (aLane != bLane) return bLane ? 1 : -1;

    final visualDistance = distanceToRect(point, a.visualRect).compareTo(distanceToRect(point, b.visualRect));
    if (visualDistance != 0) return visualDistance;

    final centerDistance = _centerDistance(point, a.visualRect).compareTo(_centerDistance(point, b.visualRect));
    if (centerDistance != 0) return centerDistance;
    return 0;
  }

  static double distanceToRect(Offset point, Rect rect) {
    final dx = point.dx < rect.left ? rect.left - point.dx : point.dx > rect.right ? point.dx - rect.right : 0.0;
    final dy = point.dy < rect.top ? rect.top - point.dy : point.dy > rect.bottom ? point.dy - rect.bottom : 0.0;
    return math.sqrt(dx * dx + dy * dy);
  }

  static double _centerDistance(Offset point, Rect rect) {
    final dx = point.dx - rect.center.dx;
    final dy = point.dy - rect.center.dy;
    return math.sqrt(dx * dx + dy * dy);
  }
}

class TapCandidateView {
  const TapCandidateView({required this.entry, required this.visualRect});

  final SlotEntry entry;
  final Rect visualRect;
}
