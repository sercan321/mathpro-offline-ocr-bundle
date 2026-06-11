import 'dart:math' as math;
import 'dart:ui';

import '../editor/slot_registry.dart';
import 'premium_tap_precision_policy.dart';

/// Q41 nested-expression depth resolver for the P6-locked cursor track.
///
/// MathPro already had a structural slot registry and depth information before
/// Q41.  The real-device weakness was that broad parent hitboxes could still
/// steal a tap from the inner `ln`, `cos`, `logBase`, root body, or function
/// argument in nested expressions.  This policy does not change the keyboard,
/// MORE tray, long-press popup, app shell, MathLabel, Graph, History, or
/// Solution UI.  It only filters an already-built hit-test candidate set so the
/// deepest visually-plausible slot wins when the tap point is inside nested
/// structural territory.
class NestedExpressionDepthCursorPolicy {
  const NestedExpressionDepthCursorPolicy._();

  static const String version =
      'mathpro-v172q41-nested-expression-depth-engine-p6-locked-v1';

  static const bool nestedExpressionDepthEngineAvailable = true;
  static const bool deepestValidSlotPreferred = true;
  static const bool parentSlotStealSuppressed = true;
  static const bool p6VisualFilesLocked = true;
  static const bool rendererGlyphIdentityClaimed = false;
  static const int requiredCorrectNestedTapSelectionsPerTwenty = 19;

  static NestedDepthDecision? decideDepthForPoint({
    required Offset point,
    required Iterable<NestedSlotCandidate> candidates,
  }) {
    final plausible = candidates
        .where((candidate) => _isDepthCandidate(point, candidate))
        .toList(growable: false);
    if (plausible.length < 2) return null;

    final maxDepth = plausible.map((candidate) => candidate.entry.depth).reduce(math.max);
    if (maxDepth <= 0) return null;

    final deepest = plausible
        .where((candidate) => candidate.entry.depth == maxDepth)
        .toList(growable: false);
    if (deepest.isEmpty) return null;

    deepest.sort((a, b) {
      final visual = _visualDistance(point, a.visualRect).compareTo(_visualDistance(point, b.visualRect));
      if (visual != 0) return visual;
      final priority = b.entry.priority.compareTo(a.entry.priority);
      if (priority != 0) return priority;
      return a.entry.id.compareTo(b.entry.id);
    });

    final selected = deepest.first;
    return NestedDepthDecision(
      slotId: selected.entry.id,
      nodeId: selected.entry.nodeId,
      role: selected.entry.role,
      depth: selected.entry.depth,
    );
  }

  static bool suppressesParentSlotSteal({
    required SlotEntry child,
    required SlotEntry parent,
  }) {
    return child.depth > parent.depth && parentSlotStealSuppressed;
  }

  static bool _isDepthCandidate(Offset point, NestedSlotCandidate candidate) {
    if (candidate.entry.depth <= 0) return false;
    if (candidate.visualRect.contains(point)) return true;
    if (PremiumTapPrecisionPolicy.visualIntentRect(candidate.entry.role, candidate.visualRect).contains(point)) return true;
    if (PremiumTapPrecisionPolicy.precisionLaneRect(candidate.entry.role, candidate.visualRect).contains(point)) {
      return _visualDistance(point, candidate.visualRect) <= _nestedDepthRadiusForRole(candidate.entry.role);
    }
    return false;
  }

  static double _nestedDepthRadiusForRole(String role) {
    return switch (role) {
      'functionArgument' || 'functionArgument2' || 'functionArgument3' => 82.0,
      'logBase' || 'rootIndex' || 'powerExponent' || 'subscript' => 58.0,
      'sqrtValue' || 'fractionNumerator' || 'fractionDenominator' => 64.0,
      'integralBody' || 'limitBody' || 'sumBody' || 'productBody' => 68.0,
      'matrixCell' || 'systemLeft' || 'systemRight' => 42.0,
      _ => 54.0,
    };
  }

  static double _visualDistance(Offset point, Rect rect) {
    final dx = point.dx < rect.left ? rect.left - point.dx : point.dx > rect.right ? point.dx - rect.right : 0.0;
    final dy = point.dy < rect.top ? rect.top - point.dy : point.dy > rect.bottom ? point.dy - rect.bottom : 0.0;
    return math.sqrt(dx * dx + dy * dy);
  }
}

class NestedSlotCandidate {
  const NestedSlotCandidate({required this.entry, required this.visualRect});

  final SlotEntry entry;
  final Rect visualRect;
}

class NestedDepthDecision {
  const NestedDepthDecision({
    required this.slotId,
    required this.nodeId,
    required this.role,
    required this.depth,
  });

  final String slotId;
  final String nodeId;
  final String role;
  final int depth;
}
