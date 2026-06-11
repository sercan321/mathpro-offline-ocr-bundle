import 'dart:math' as math;
import 'dart:ui';

import '../editor/slot_registry.dart';

/// Q39 log/root-specific cursor lane policy for the P6-locked cursor track.
///
/// This policy does not touch keyboard, key faces, MORE, long-press, app shell,
/// MathLabel, Graph, History, or Solution. It only helps the existing structural
/// cursor engine resolve log base vs argument and root index vs radicand
/// ambiguity when expanded mobile hit targets overlap.
class LogRootPrecisionCursorPolicy {
  const LogRootPrecisionCursorPolicy._();

  static const String version =
      'mathpro-v172q39-log-root-precision-engine-p6-locked-v1';

  static const bool p6VisualFilesLocked = true;
  static const bool logRootPrecisionEngineAvailable = true;
  static const bool logBaseArgumentLaneSplitEnabled = true;
  static const bool rootIndexRadicandLaneSplitEnabled = true;
  static const bool logBaseArgumentCrossLaneSelectionAllowed = false;
  static const bool rootIndexRadicandCrossLaneSelectionAllowed = false;
  static const bool logRootCaretUsesSeparatedRails = true;
  static const int requiredCorrectTapSelectionsPerTwenty = 19;

  static bool isLogRootRole(String role) {
    return isLogRole(role) || isRootRole(role);
  }

  static bool isLogRole(String role) => role == 'logBase' || role == 'functionArgument';
  static bool isRootRole(String role) => role == 'rootIndex' || role == 'sqrtValue';
  static bool isLogBase(String role) => role == 'logBase';
  static bool isLogArgument(String role) => role == 'functionArgument';
  static bool isRootIndex(String role) => role == 'rootIndex';
  static bool isRadicand(String role) => role == 'sqrtValue';

  static LogRootPrecisionDecision? decideLaneForPoint({
    required Offset point,
    required Iterable<LogRootSlotCandidate> candidates,
  }) {
    final logGroups = <String, _LogPairBuilder>{};
    final rootGroups = <String, _RootPairBuilder>{};

    for (final candidate in candidates) {
      final role = candidate.entry.role;
      if (isLogRole(role)) {
        final builder = logGroups.putIfAbsent(candidate.entry.nodeId, () => _LogPairBuilder(candidate.entry.nodeId));
        if (isLogBase(role)) {
          builder.base = candidate;
        } else if (isLogArgument(role)) {
          builder.argument = candidate;
        }
      } else if (isRootRole(role)) {
        final builder = rootGroups.putIfAbsent(candidate.entry.nodeId, () => _RootPairBuilder(candidate.entry.nodeId));
        if (isRootIndex(role)) {
          builder.index = candidate;
        } else if (isRadicand(role)) {
          builder.radicand = candidate;
        }
      }
    }

    LogRootPrecisionDecision? best;
    double? bestScore;

    for (final builder in logGroups.values) {
      final base = builder.base;
      final argument = builder.argument;
      if (base == null || argument == null) continue;
      final union = base.visualRect.expandToInclude(argument.visualRect);
      if (!union.inflate(54.0).contains(point)) continue;
      final role = chooseLogRoleForPoint(
        point: point,
        baseRect: base.visualRect,
        argumentRect: argument.visualRect,
      );
      final laneRect = role == 'logBase' ? base.visualRect : argument.visualRect;
      final score = _distanceToRect(point, laneRect) + _distanceToRect(point, union) * 0.20;
      if (bestScore == null || score < bestScore) {
        bestScore = score;
        best = LogRootPrecisionDecision(
          nodeId: builder.nodeId,
          role: role,
          primaryRect: base.visualRect,
          bodyRect: argument.visualRect,
          family: 'log',
        );
      }
    }

    for (final builder in rootGroups.values) {
      final index = builder.index;
      final radicand = builder.radicand;
      if (index == null || radicand == null) continue;
      final union = index.visualRect.expandToInclude(radicand.visualRect);
      if (!union.inflate(54.0).contains(point)) continue;
      final role = chooseRootRoleForPoint(
        point: point,
        indexRect: index.visualRect,
        radicandRect: radicand.visualRect,
      );
      final laneRect = role == 'rootIndex' ? index.visualRect : radicand.visualRect;
      final score = _distanceToRect(point, laneRect) + _distanceToRect(point, union) * 0.20;
      if (bestScore == null || score < bestScore) {
        bestScore = score;
        best = LogRootPrecisionDecision(
          nodeId: builder.nodeId,
          role: role,
          primaryRect: index.visualRect,
          bodyRect: radicand.visualRect,
          family: 'root',
        );
      }
    }

    return best;
  }

  static String chooseLogRoleForPoint({
    required Offset point,
    required Rect baseRect,
    required Rect argumentRect,
  }) {
    final baseIntent = logBaseIntentRect(baseRect: baseRect, argumentRect: argumentRect);
    final argumentIntent = logArgumentIntentRect(baseRect: baseRect, argumentRect: argumentRect);
    if (baseIntent.contains(point) && !argumentIntent.contains(point)) return 'logBase';
    if (argumentIntent.contains(point) && !baseIntent.contains(point)) return 'functionArgument';

    final boundaryX = (baseRect.right + argumentRect.left) / 2.0;
    final boundaryY = (baseRect.center.dy + argumentRect.center.dy) / 2.0;
    final baseSideIntent = point.dx <= boundaryX + math.max(3.0, baseRect.width * 0.18);
    final baseVerticalIntent = point.dy >= boundaryY - math.max(2.0, baseRect.height * 0.16);
    if (baseSideIntent && baseVerticalIntent) return 'logBase';

    final baseDistance = _distanceToRect(point, baseRect);
    final argumentDistance = _distanceToRect(point, argumentRect);
    if (baseDistance != argumentDistance) {
      return baseDistance < argumentDistance ? 'logBase' : 'functionArgument';
    }
    return 'functionArgument';
  }

  static String chooseRootRoleForPoint({
    required Offset point,
    required Rect indexRect,
    required Rect radicandRect,
  }) {
    final indexIntent = rootIndexIntentRect(indexRect: indexRect, radicandRect: radicandRect);
    final radicandIntent = radicandIntentRect(indexRect: indexRect, radicandRect: radicandRect);
    if (indexIntent.contains(point) && !radicandIntent.contains(point)) return 'rootIndex';
    if (radicandIntent.contains(point) && !indexIntent.contains(point)) return 'sqrtValue';

    final boundaryX = (indexRect.right + radicandRect.left) / 2.0;
    final boundaryY = (indexRect.center.dy + radicandRect.center.dy) / 2.0;
    final indexSideIntent = point.dx <= boundaryX + math.max(3.0, indexRect.width * 0.20);
    final indexVerticalIntent = point.dy <= boundaryY + math.max(2.0, indexRect.height * 0.14);
    if (indexSideIntent && indexVerticalIntent) return 'rootIndex';

    final indexDistance = _distanceToRect(point, indexRect);
    final radicandDistance = _distanceToRect(point, radicandRect);
    if (indexDistance != radicandDistance) {
      return indexDistance < radicandDistance ? 'rootIndex' : 'sqrtValue';
    }
    return 'sqrtValue';
  }

  static Rect logBaseIntentRect({required Rect baseRect, required Rect argumentRect}) {
    final width = math.max(46.0, baseRect.width + 44.0);
    final height = math.max(40.0, baseRect.height + 34.0);
    final center = Offset(
      baseRect.center.dx - width * 0.04,
      baseRect.center.dy + height * 0.08,
    );
    return Rect.fromCenter(center: center, width: width, height: height);
  }

  static Rect logArgumentIntentRect({required Rect baseRect, required Rect argumentRect}) {
    final width = math.max(58.0, argumentRect.width + 48.0);
    final height = math.max(48.0, argumentRect.height + 38.0);
    final center = Offset(argumentRect.center.dx + width * 0.04, argumentRect.center.dy);
    return Rect.fromCenter(center: center, width: width, height: height);
  }

  static Rect rootIndexIntentRect({required Rect indexRect, required Rect radicandRect}) {
    final width = math.max(44.0, indexRect.width + 42.0);
    final height = math.max(38.0, indexRect.height + 34.0);
    final center = Offset(
      indexRect.center.dx - width * 0.06,
      indexRect.center.dy - height * 0.06,
    );
    return Rect.fromCenter(center: center, width: width, height: height);
  }

  static Rect radicandIntentRect({required Rect indexRect, required Rect radicandRect}) {
    final width = math.max(62.0, radicandRect.width + 50.0);
    final height = math.max(48.0, radicandRect.height + 38.0);
    final center = Offset(radicandRect.center.dx + width * 0.04, radicandRect.center.dy);
    return Rect.fromCenter(center: center, width: width, height: height);
  }

  static Rect laneAwareHitRect({
    required SlotEntry entry,
    required Rect visualRect,
    required Rect baseHitRect,
  }) {
    if (!isLogRootRole(entry.role)) return baseHitRect;
    if (entry.role == 'logBase') {
      final width = math.max(visualRect.width + 56.0, baseHitRect.width * 0.90);
      final height = math.max(visualRect.height + 42.0, baseHitRect.height * 0.76);
      return Rect.fromCenter(
        center: Offset(visualRect.center.dx - width * 0.04, visualRect.center.dy + height * 0.08),
        width: width,
        height: height,
      );
    }
    if (entry.role == 'rootIndex') {
      final width = math.max(visualRect.width + 54.0, baseHitRect.width * 0.88);
      final height = math.max(visualRect.height + 40.0, baseHitRect.height * 0.74);
      return Rect.fromCenter(
        center: Offset(visualRect.center.dx - width * 0.06, visualRect.center.dy - height * 0.07),
        width: width,
        height: height,
      );
    }
    if (entry.role == 'sqrtValue') {
      final width = math.max(visualRect.width + 52.0, baseHitRect.width * 0.88);
      final height = math.max(visualRect.height + 40.0, baseHitRect.height * 0.78);
      return Rect.fromCenter(
        center: Offset(visualRect.center.dx + width * 0.04, visualRect.center.dy),
        width: width,
        height: height,
      );
    }
    // functionArgument may belong to any function.  It is only lane-filtered
    // as log argument when a sibling logBase candidate with the same nodeId
    // exists, so this conservative hit rect does not change normal sin/cos/ln
    // argument behavior.
    return baseHitRect;
  }

  static double _distanceToRect(Offset point, Rect rect) {
    final dx = point.dx < rect.left ? rect.left - point.dx : point.dx > rect.right ? point.dx - rect.right : 0.0;
    final dy = point.dy < rect.top ? rect.top - point.dy : point.dy > rect.bottom ? point.dy - rect.bottom : 0.0;
    return math.sqrt(dx * dx + dy * dy);
  }
}

class LogRootSlotCandidate {
  const LogRootSlotCandidate({required this.entry, required this.visualRect});

  final SlotEntry entry;
  final Rect visualRect;
}

class LogRootPrecisionDecision {
  const LogRootPrecisionDecision({
    required this.nodeId,
    required this.role,
    required this.primaryRect,
    required this.bodyRect,
    required this.family,
  });

  final String nodeId;
  final String role;
  final Rect primaryRect;
  final Rect bodyRect;
  final String family;
}

class _LogPairBuilder {
  _LogPairBuilder(this.nodeId);

  final String nodeId;
  LogRootSlotCandidate? base;
  LogRootSlotCandidate? argument;
}

class _RootPairBuilder {
  _RootPairBuilder(this.nodeId);

  final String nodeId;
  LogRootSlotCandidate? index;
  LogRootSlotCandidate? radicand;
}
