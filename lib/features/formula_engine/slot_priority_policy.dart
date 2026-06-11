import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';

import '../editor/calculus_cursor_navigation_policy.dart';
import '../editor/slot_registry.dart';

@immutable
class SlotPriorityScore {
  const SlotPriorityScore({
    required this.total,
    required this.visualCenterDistance,
    required this.hitEdgeDistance,
    required this.containsVisualRect,
    required this.containsHitRect,
  });

  final double total;
  final double visualCenterDistance;
  final double hitEdgeDistance;
  final bool containsVisualRect;
  final bool containsHitRect;
}

class SlotPriorityPolicy {
  const SlotPriorityPolicy._();

  static const String version = 'mathpro-core-editor-v172i-priority-hit-test-calculus-matrix-system-v1';

  static SlotPriorityScore score({
    required Offset point,
    required SlotEntry entry,
    required Rect visualRect,
    required Rect hitRect,
  }) {
    final centerDistance = _distanceToRectCenter(point, visualRect);
    final edgeDistance = _distanceToRect(point, visualRect);
    final containsVisual = visualRect.contains(point);
    final containsHit = hitRect.contains(point);

    final structuralPriority = entry.priority * 1.15;
    final depthBonus = entry.depth * 8.0;
    final visualIntentBonus = containsVisual ? 72.0 : 0.0;
    final hitContainmentBonus = containsHit ? _hitContainmentBonus(entry.role) : 0.0;
    final criticalSmallSlotBonus = _criticalSmallSlotBonus(entry.role);
    final roleTieBreaker = -_roleOrder(entry.role) * 0.015;
    final distancePenalty = centerDistance * _centerDistanceWeight(entry.role) + edgeDistance * 0.55;
    final oversizedVisualPenalty = math.sqrt(visualRect.width * visualRect.height) * 0.04;

    return SlotPriorityScore(
      total: structuralPriority +
          depthBonus +
          visualIntentBonus +
          hitContainmentBonus +
          criticalSmallSlotBonus +
          roleTieBreaker -
          distancePenalty -
          oversizedVisualPenalty,
      visualCenterDistance: centerDistance,
      hitEdgeDistance: _distanceToRect(point, hitRect),
      containsVisualRect: containsVisual,
      containsHitRect: containsHit,
    );
  }

  static int compare(SlotPriorityScore aScore, SlotEntry aEntry, SlotPriorityScore bScore, SlotEntry bEntry) {
    final score = bScore.total.compareTo(aScore.total);
    if (score != 0) return score;

    final visualContainment = _boolRank(bScore.containsVisualRect).compareTo(_boolRank(aScore.containsVisualRect));
    if (visualContainment != 0) return visualContainment;

    final distance = aScore.visualCenterDistance.compareTo(bScore.visualCenterDistance);
    if (distance != 0) return distance;

    final priority = bEntry.priority.compareTo(aEntry.priority);
    if (priority != 0) return priority;

    final depth = bEntry.depth.compareTo(aEntry.depth);
    if (depth != 0) return depth;

    final roleOrder = _roleOrder(aEntry.role).compareTo(_roleOrder(bEntry.role));
    if (roleOrder != 0) return roleOrder;

    return aEntry.id.compareTo(bEntry.id);
  }

  static double _criticalSmallSlotBonus(String role) {
    return switch (role) {
      'integralUpperLimit' || 'integralLowerLimit' => 40.0,
      'integralDifferential' => 28.0,
      'limitVariable' || 'limitTarget' || 'sumUpperLimit' || 'sumLowerLimit' || 'productUpperLimit' || 'productLowerLimit' => 30.0,
      'derivativeVariable' => 26.0,
      'fractionNumerator' || 'fractionDenominator' => 30.0,
      'powerExponent' || 'rootIndex' => 28.0,
      'subscript' || 'logBase' || 'derivativeOrder' => 30.0,
      'sqrtValue' => 32.0,
      'functionArgument' => 46.0,
      'matrixCell' || 'systemLeft' || 'systemRight' => 14.0,
      _ => 0.0,
    };
  }

  static double _hitContainmentBonus(String role) {
    return switch (role) {
      'functionArgument' => 30.0,
      'integralUpperLimit' || 'integralLowerLimit' => 28.0,
      'limitVariable' || 'limitTarget' || 'sumUpperLimit' || 'sumLowerLimit' || 'productUpperLimit' || 'productLowerLimit' => 24.0,
      'integralDifferential' || 'derivativeVariable' => 22.0,
      'sqrtValue' || 'fractionNumerator' || 'fractionDenominator' => 24.0,
      'powerExponent' || 'rootIndex' || 'subscript' || 'logBase' || 'derivativeOrder' => 22.0,
      'matrixCell' || 'systemLeft' || 'systemRight' => 16.0,
      _ => 12.0,
    };
  }

  static double _centerDistanceWeight(String role) {
    return switch (role) {
      'functionArgument' => 1.45,
      'limitBody' || 'derivativeBody' || 'sumBody' || 'productBody' => 1.45,
      'integralUpperLimit' || 'integralLowerLimit' || 'limitVariable' || 'limitTarget' => 1.55,
      'sumUpperLimit' || 'sumLowerLimit' || 'productUpperLimit' || 'productLowerLimit' => 1.55,
      'sqrtValue' || 'fractionNumerator' || 'fractionDenominator' => 1.65,
      'powerExponent' || 'rootIndex' || 'subscript' || 'logBase' || 'derivativeOrder' => 1.70,
      _ => 2.00,
    };
  }


  static int _roleOrder(String role) {
    const order = <String, int>{
      'integralUpperLimit': 10,
      'integralLowerLimit': 11,
      'fractionNumerator': 20,
      'fractionDenominator': 21,
      'powerExponent': 30,
      'rootIndex': 31,
      'subscript': 32,
      'logBase': 33,
      'derivativeOrder': 34,
      'sqrtValue': 40,
      'integralBody': 50,
      'integralDifferential': 51,
      'powerBase': 60,
      'sumUpperLimit': 70,
      'sumLowerLimit': 71,
      'sumBody': 72,
      'productUpperLimit': 73,
      'productLowerLimit': 74,
      'productBody': 75,
      'limitVariable': 80,
      'limitTarget': 81,
      'limitBody': 82,
      'derivativeVariable': 83,
      'derivativeBody': 84,
      'functionArgument': 25,
      'matrixCell': 100,
      'systemLeft': 101,
      'systemRight': 102,
      'placeholder': 110,
    };
    return order[role] ?? CalculusCursorNavigationPolicy.roleOrder(role);
  }

  static int _boolRank(bool value) => value ? 1 : 0;

  static double _distanceToRectCenter(Offset point, Rect rect) {
    final dx = point.dx - rect.center.dx;
    final dy = point.dy - rect.center.dy;
    return math.sqrt(dx * dx + dy * dy);
  }

  static double _distanceToRect(Offset point, Rect rect) {
    final dx = point.dx < rect.left ? rect.left - point.dx : point.dx > rect.right ? point.dx - rect.right : 0.0;
    final dy = point.dy < rect.top ? rect.top - point.dy : point.dy > rect.bottom ? point.dy - rect.bottom : 0.0;
    return math.sqrt(dx * dx + dy * dy);
  }
}
