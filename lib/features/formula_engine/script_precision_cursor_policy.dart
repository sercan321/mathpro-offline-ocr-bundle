import 'dart:math' as math;
import 'dart:ui';

import '../editor/slot_registry.dart';

/// Q38 script-specific cursor lane policy for the P6-locked cursor track.
///
/// This policy does not change keyboard, key faces, MORE, long-press, app
/// shell, Graph, History, Solution, or MathLabel. It only helps the existing
/// structural cursor engine resolve base/exponent/subscript ambiguity when
/// expanded mobile hit targets overlap.
class ScriptPrecisionCursorPolicy {
  const ScriptPrecisionCursorPolicy._();

  static const String version =
      'mathpro-v172q38-script-precision-engine-p6-locked-v1';

  static const bool p6VisualFilesLocked = true;
  static const bool scriptPrecisionEngineAvailable = true;
  static const bool exponentSubscriptLaneSplitEnabled = true;
  static const bool scriptBaseCrossLaneSelectionAllowed = false;
  static const bool scriptCaretUsesSeparatedRails = true;
  static const int requiredCorrectTapSelectionsPerTwenty = 19;

  static bool isScriptRole(String role) {
    return role == 'powerBase' ||
        role == 'powerExponent' ||
        role == 'subscriptBase' ||
        role == 'subscript';
  }

  static bool isBaseRole(String role) => role == 'powerBase' || role == 'subscriptBase';
  static bool isExponentRole(String role) => role == 'powerExponent';
  static bool isSubscriptRole(String role) => role == 'subscript';
  static bool isScriptLaneRole(String role) => isExponentRole(role) || isSubscriptRole(role);

  static ScriptPrecisionDecision? decideLaneForPoint({
    required Offset point,
    required Iterable<ScriptSlotCandidate> candidates,
  }) {
    final grouped = <String, _ScriptPairBuilder>{};
    for (final candidate in candidates) {
      if (!isScriptRole(candidate.entry.role)) continue;
      final builder = grouped.putIfAbsent(candidate.entry.nodeId, () => _ScriptPairBuilder(candidate.entry.nodeId));
      switch (candidate.entry.role) {
        case 'powerBase':
        case 'subscriptBase':
          builder.base = candidate;
          break;
        case 'powerExponent':
          builder.script = candidate;
          builder.scriptRole = 'powerExponent';
          break;
        case 'subscript':
          builder.script = candidate;
          builder.scriptRole = 'subscript';
          break;
      }
    }

    ScriptPrecisionDecision? best;
    double? bestScore;
    for (final builder in grouped.values) {
      final base = builder.base;
      final script = builder.script;
      final scriptRole = builder.scriptRole;
      if (base == null || script == null || scriptRole == null) continue;

      final union = base.visualRect.expandToInclude(script.visualRect);
      if (!union.inflate(48.0).contains(point)) continue;

      final role = chooseRoleForPoint(
        point: point,
        baseRect: base.visualRect,
        scriptRect: script.visualRect,
        scriptRole: scriptRole,
      );
      final laneRect = role == scriptRole ? script.visualRect : base.visualRect;
      final score = _distanceToRect(point, laneRect) + _distanceToRect(point, union) * 0.25;
      if (bestScore == null || score < bestScore) {
        bestScore = score;
        best = ScriptPrecisionDecision(
          nodeId: builder.nodeId,
          role: role,
          baseRect: base.visualRect,
          scriptRect: script.visualRect,
          scriptRole: scriptRole,
        );
      }
    }
    return best;
  }

  static String chooseRoleForPoint({
    required Offset point,
    required Rect baseRect,
    required Rect scriptRect,
    required String scriptRole,
  }) {
    final isExponent = scriptRole == 'powerExponent';
    final scriptExpanded = scriptIntentRect(scriptRole: scriptRole, scriptRect: scriptRect, baseRect: baseRect);
    final baseExpanded = baseIntentRect(scriptRole: scriptRole, baseRect: baseRect, scriptRect: scriptRect);

    if (scriptExpanded.contains(point) && !baseExpanded.contains(point)) {
      return scriptRole;
    }
    if (baseExpanded.contains(point) && !scriptExpanded.contains(point)) {
      return baseRect.top <= scriptRect.top ? 'subscriptBase' : 'powerBase';
    }

    final boundaryY = (baseRect.center.dy + scriptRect.center.dy) / 2.0;
    final boundaryX = (baseRect.right + scriptRect.left) / 2.0;
    final scriptSideIntent = point.dx >= boundaryX - math.max(4.0, scriptRect.width * 0.18);
    final verticalScriptIntent = isExponent
        ? point.dy <= boundaryY + math.max(2.0, scriptRect.height * 0.16)
        : point.dy >= boundaryY - math.max(2.0, scriptRect.height * 0.16);
    if (scriptSideIntent && verticalScriptIntent) return scriptRole;

    final scriptDistance = _distanceToRect(point, scriptRect);
    final baseDistance = _distanceToRect(point, baseRect);
    if (scriptDistance != baseDistance) {
      return scriptDistance < baseDistance ? scriptRole : (baseRect.top <= scriptRect.top ? 'subscriptBase' : 'powerBase');
    }
    return scriptRole;
  }

  static Rect scriptIntentRect({
    required String scriptRole,
    required Rect scriptRect,
    required Rect baseRect,
  }) {
    final horizontal = math.max(28.0, scriptRect.width * 0.58);
    final vertical = math.max(22.0, scriptRect.height * 0.44);
    final dy = scriptRole == 'powerExponent' ? -vertical * 0.08 : vertical * 0.08;
    return Rect.fromCenter(
      center: Offset(scriptRect.center.dx + horizontal * 0.08, scriptRect.center.dy + dy),
      width: scriptRect.width + horizontal,
      height: scriptRect.height + vertical,
    );
  }

  static Rect baseIntentRect({
    required String scriptRole,
    required Rect baseRect,
    required Rect scriptRect,
  }) {
    final trimRight = math.max(0.0, (baseRect.right - scriptRect.left + 4.0));
    final right = math.max(baseRect.left + 8.0, baseRect.right - trimRight * 0.42);
    return Rect.fromLTRB(
      baseRect.left - 22.0,
      baseRect.top - 20.0,
      right + 18.0,
      baseRect.bottom + 20.0,
    );
  }

  static Rect laneAwareHitRect({
    required SlotEntry entry,
    required Rect visualRect,
    required Rect baseHitRect,
  }) {
    if (!isScriptRole(entry.role)) return baseHitRect;
    if (isScriptLaneRole(entry.role)) {
      final width = math.max(visualRect.width + 52.0, baseHitRect.width * 0.82);
      final height = math.max(visualRect.height + 38.0, baseHitRect.height * 0.72);
      final dy = entry.role == 'powerExponent' ? -height * 0.08 : height * 0.08;
      return Rect.fromCenter(center: Offset(visualRect.center.dx, visualRect.center.dy + dy), width: width, height: height);
    }
    final width = math.max(visualRect.width + 42.0, baseHitRect.width * 0.72);
    final height = math.max(visualRect.height + 34.0, baseHitRect.height * 0.72);
    final dx = isBaseRole(entry.role) ? -width * 0.08 : 0.0;
    return Rect.fromCenter(center: Offset(visualRect.center.dx + dx, visualRect.center.dy), width: width, height: height);
  }

  static double _distanceToRect(Offset point, Rect rect) {
    final dx = point.dx < rect.left ? rect.left - point.dx : point.dx > rect.right ? point.dx - rect.right : 0.0;
    final dy = point.dy < rect.top ? rect.top - point.dy : point.dy > rect.bottom ? point.dy - rect.bottom : 0.0;
    return math.sqrt(dx * dx + dy * dy);
  }
}

class ScriptSlotCandidate {
  const ScriptSlotCandidate({required this.entry, required this.visualRect});

  final SlotEntry entry;
  final Rect visualRect;
}

class ScriptPrecisionDecision {
  const ScriptPrecisionDecision({
    required this.nodeId,
    required this.role,
    required this.baseRect,
    required this.scriptRect,
    required this.scriptRole,
  });

  final String nodeId;
  final String role;
  final Rect baseRect;
  final Rect scriptRect;
  final String scriptRole;
}

class _ScriptPairBuilder {
  _ScriptPairBuilder(this.nodeId);

  final String nodeId;
  ScriptSlotCandidate? base;
  ScriptSlotCandidate? script;
  String? scriptRole;
}
