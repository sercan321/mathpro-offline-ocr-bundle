import 'dart:math' as math;
import 'dart:ui';

/// V172-Q42 P6-locked drag-to-move cursor stability policy.
///
/// This is intentionally a cursor-only policy. It does not change keyboard,
/// MORE, long-press, MathLabel, app shell, Graph, History, or Solution UI.
/// It only guards the existing editor interaction layer against repeated drag
/// emissions and jittery slot switching while the user's finger is moving.
class DragToMoveCursorStabilityPolicy {
  const DragToMoveCursorStabilityPolicy._();

  static const String version =
      'mathpro-v172q42-drag-to-move-cursor-stability-p6-locked-v1';

  static const bool p6VisualFilesLocked = true;
  static const bool dragStabilityEngineAvailable = true;
  static const bool randomSlotJumpSuppressed = true;
  static const bool duplicateDragEmitSuppressed = true;
  static const bool horizontalPanConflictGuarded = true;
  static const bool editorLoupeEnabled = false;
  static const bool editorLongPressMenuEnabled = false;

  /// Tiny movement should not repeatedly re-emit the same slot/caret.
  static const double duplicateEmitDistancePx = 2.25;

  /// A drag may stay in its current slot while the finger is still near that
  /// visual slot. This prevents oscillation between adjacent compact slots.
  static const double sameSlotHysteresisPx = 8.0;

  /// Large jumps are usually viewport/pan intent or stale transform events, not
  /// precise cursor movement. They should be ignored during drag updates.
  static const double maximumStableDragJumpPx = 118.0;

  static bool isDragSource(String source) {
    return source == 'pan-down' || source == 'pan-update' || source == 'drag-update';
  }

  static bool shouldResetForSource(String source) {
    return source == 'tap-down' || source == 'tap-up' || source == 'pointer';
  }

  static bool shouldSuppressSlotDrag({
    required String source,
    required Offset currentPoint,
    required String currentSlotId,
    required String currentRole,
    required int currentCaretIndex,
    required Rect currentVisualRect,
    required String? previousSlotId,
    required String? previousRole,
    required int? previousCaretIndex,
    required Offset? previousPoint,
    required Rect? previousVisualRect,
  }) {
    if (!isDragSource(source)) return false;
    if (previousPoint == null || previousSlotId == null || previousCaretIndex == null || previousVisualRect == null) {
      return false;
    }

    final distance = (currentPoint - previousPoint).distance;
    if (distance > maximumStableDragJumpPx) {
      return true;
    }

    final sameTarget = previousSlotId == currentSlotId &&
        previousRole == currentRole &&
        previousCaretIndex == currentCaretIndex;
    if (sameTarget && distance <= duplicateEmitDistancePx) {
      return true;
    }

    // If the finger is still visually near the previous slot, avoid flickering
    // to a neighboring slot unless the user has clearly crossed out of the old
    // slot's hysteresis zone.
    if (previousSlotId != currentSlotId && previousVisualRect.inflate(sameSlotHysteresisPx).contains(currentPoint)) {
      return true;
    }

    // Compact roles are adjacent by nature. A tiny move from exponent to base,
    // log base to argument, root index to radicand, etc. should not oscillate.
    if (_isCompactRole(previousRole) && previousRole != currentRole && distance <= sameSlotHysteresisPx) {
      return true;
    }

    return false;
  }

  static bool shouldSuppressLinearDrag({
    required String source,
    required Offset currentPoint,
    required int currentCaretIndex,
    required int? previousCaretIndex,
    required Offset? previousPoint,
  }) {
    if (!isDragSource(source)) return false;
    if (previousPoint == null || previousCaretIndex == null) return false;
    final distance = (currentPoint - previousPoint).distance;
    if (distance > maximumStableDragJumpPx) return true;
    return previousCaretIndex == currentCaretIndex && distance <= duplicateEmitDistancePx;
  }

  static bool _isCompactRole(String? role) {
    return switch (role) {
      'powerExponent' || 'subscript' || 'logBase' || 'rootIndex' ||
      'integralUpperLimit' || 'integralLowerLimit' || 'sumUpperLimit' ||
      'sumLowerLimit' || 'productUpperLimit' || 'productLowerLimit' ||
      'limitTarget' || 'limitVariable' || 'derivativeOrder' ||
      'integralDifferential' => true,
      _ => false,
    };
  }

  static double stableDistance(Offset a, Offset b) {
    final dx = a.dx - b.dx;
    final dy = a.dy - b.dy;
    return math.sqrt(dx * dx + dy * dy);
  }
}
