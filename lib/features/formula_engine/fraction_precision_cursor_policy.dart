import 'dart:math' as math;
import 'dart:ui';

import '../editor/slot_registry.dart';

/// Q37 fraction-specific cursor lane policy for the P6-locked cursor track.
///
/// This policy does not change keyboard, key faces, MORE, long-press, app
/// shell, Graph, History, or Solution.  It only helps the existing structural
/// cursor engine resolve numerator/denominator ambiguity when the expanded
/// mobile finger targets overlap.
class FractionPrecisionCursorPolicy {
  const FractionPrecisionCursorPolicy._();

  static const String version =
      'mathpro-v172q37-fraction-precision-engine-p6-locked-v1';

  static const bool p6VisualFilesLocked = true;
  static const bool fractionPrecisionEngineAvailable = true;
  static const bool numeratorDenominatorLaneSplitEnabled = true;
  static const bool fractionBarCrossLaneSelectionAllowed = false;
  static const bool fractionCaretUsesSeparatedRails = true;
  static const int requiredCorrectTapSelectionsPerTwenty = 19;

  static bool isFractionRole(String role) {
    return role == 'fractionNumerator' || role == 'fractionDenominator';
  }

  static bool isNumerator(String role) => role == 'fractionNumerator';
  static bool isDenominator(String role) => role == 'fractionDenominator';

  static FractionPrecisionDecision? decideLaneForPoint({
    required Offset point,
    required Iterable<FractionSlotCandidate> candidates,
  }) {
    final grouped = <String, _FractionPairBuilder>{};
    for (final candidate in candidates) {
      if (!isFractionRole(candidate.entry.role)) continue;
      final builder = grouped.putIfAbsent(candidate.entry.nodeId, () => _FractionPairBuilder(candidate.entry.nodeId));
      if (isNumerator(candidate.entry.role)) {
        builder.numerator = candidate;
      } else if (isDenominator(candidate.entry.role)) {
        builder.denominator = candidate;
      }
    }

    FractionPrecisionDecision? best;
    double? bestScore;
    for (final builder in grouped.values) {
      final numerator = builder.numerator;
      final denominator = builder.denominator;
      if (numerator == null || denominator == null) continue;

      final boundaryY = laneBoundaryY(numerator.visualRect, denominator.visualRect);
      final union = numerator.visualRect.expandToInclude(denominator.visualRect);
      final expandedUnion = union.inflate(44.0);
      if (!expandedUnion.contains(point)) continue;

      final role = chooseRoleForPoint(
        point: point,
        numeratorRect: numerator.visualRect,
        denominatorRect: denominator.visualRect,
        boundaryY: boundaryY,
      );
      final laneRect = role == 'fractionNumerator' ? numerator.visualRect : denominator.visualRect;
      final score = _distanceToRect(point, laneRect) + _distanceToRect(point, union) * 0.35;
      if (bestScore == null || score < bestScore) {
        bestScore = score;
        best = FractionPrecisionDecision(
          nodeId: builder.nodeId,
          role: role,
          boundaryY: boundaryY,
          numeratorRect: numerator.visualRect,
          denominatorRect: denominator.visualRect,
        );
      }
    }
    return best;
  }

  static String chooseRoleForPoint({
    required Offset point,
    required Rect numeratorRect,
    required Rect denominatorRect,
    double? boundaryY,
  }) {
    final boundary = boundaryY ?? laneBoundaryY(numeratorRect, denominatorRect);
    final deadZone = math.max(2.0, math.min(7.0, (denominatorRect.top - numeratorRect.bottom).abs() * 0.35));
    if (point.dy < boundary - deadZone) return 'fractionNumerator';
    if (point.dy > boundary + deadZone) return 'fractionDenominator';

    final numeratorDistance = _verticalDistanceToRect(point, numeratorRect);
    final denominatorDistance = _verticalDistanceToRect(point, denominatorRect);
    if (numeratorDistance != denominatorDistance) {
      return numeratorDistance < denominatorDistance ? 'fractionNumerator' : 'fractionDenominator';
    }
    final numeratorCenterDistance = (point.dy - numeratorRect.center.dy).abs();
    final denominatorCenterDistance = (point.dy - denominatorRect.center.dy).abs();
    return numeratorCenterDistance <= denominatorCenterDistance ? 'fractionNumerator' : 'fractionDenominator';
  }

  static double laneBoundaryY(Rect numeratorRect, Rect denominatorRect) {
    if (numeratorRect.bottom <= denominatorRect.top) {
      return (numeratorRect.bottom + denominatorRect.top) / 2.0;
    }
    if (denominatorRect.bottom <= numeratorRect.top) {
      return (denominatorRect.bottom + numeratorRect.top) / 2.0;
    }
    return (numeratorRect.center.dy + denominatorRect.center.dy) / 2.0;
  }

  static Rect laneAwareHitRect({
    required SlotEntry entry,
    required Rect visualRect,
    required Rect baseHitRect,
  }) {
    if (!isFractionRole(entry.role)) return baseHitRect;
    final height = math.max(baseHitRect.height * 0.72, visualRect.height + 34.0);
    final width = math.max(baseHitRect.width, visualRect.width + 72.0);
    final verticalBias = isNumerator(entry.role) ? -height * 0.09 : height * 0.09;
    return Rect.fromCenter(
      center: Offset(visualRect.center.dx, visualRect.center.dy + verticalBias),
      width: width,
      height: height,
    );
  }

  static double _verticalDistanceToRect(Offset point, Rect rect) {
    if (point.dy < rect.top) return rect.top - point.dy;
    if (point.dy > rect.bottom) return point.dy - rect.bottom;
    return 0.0;
  }

  static double _distanceToRect(Offset point, Rect rect) {
    final dx = point.dx < rect.left ? rect.left - point.dx : point.dx > rect.right ? point.dx - rect.right : 0.0;
    final dy = point.dy < rect.top ? rect.top - point.dy : point.dy > rect.bottom ? point.dy - rect.bottom : 0.0;
    return math.sqrt(dx * dx + dy * dy);
  }
}

class FractionSlotCandidate {
  const FractionSlotCandidate({required this.entry, required this.visualRect});

  final SlotEntry entry;
  final Rect visualRect;
}

class FractionPrecisionDecision {
  const FractionPrecisionDecision({
    required this.nodeId,
    required this.role,
    required this.boundaryY,
    required this.numeratorRect,
    required this.denominatorRect,
  });

  final String nodeId;
  final String role;
  final double boundaryY;
  final Rect numeratorRect;
  final Rect denominatorRect;
}

class _FractionPairBuilder {
  _FractionPairBuilder(this.nodeId);

  final String nodeId;
  FractionSlotCandidate? numerator;
  FractionSlotCandidate? denominator;
}
