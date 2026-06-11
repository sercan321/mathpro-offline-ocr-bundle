import 'dart:ui';

import '../editor/slot_registry.dart';
import 'fraction_precision_cursor_policy.dart';
import 'log_root_precision_cursor_policy.dart';
import 'nested_expression_depth_cursor_policy.dart';
import 'premium_tap_precision_policy.dart';
import 'script_precision_cursor_policy.dart';
import 'slot_geometry_bundle_authority.dart';
import 'slot_interaction_calibration_policy.dart';
import 'slot_priority_policy.dart';
import 'structural_cursor_release_hardening_policy.dart';

class SlotHitTarget {
  const SlotHitTarget({required this.entry, required this.visualRect, required this.hitRect});

  final SlotEntry entry;
  final Rect visualRect;
  final Rect hitRect;

  bool get hasInvisibleExpansion => hitRect.width > visualRect.width || hitRect.height > visualRect.height;
}

class SlotHitTestResult {
  const SlotHitTestResult({required this.entry, required Rect rect, required this.hitRect, required this.source}) : visualRect = rect;

  final SlotEntry entry;
  final Rect visualRect;
  final Rect hitRect;
  final String source;

  Rect get rect => visualRect;
}

class SlotHitTesting {
  const SlotHitTesting._();

  static const version = 'mathpro-v66-v172j-v172q37-v172q38-v172q39-v172q41-v172q49-v172q55-v172q71-v172q73-native-slotbox-exact-hit-only';
  static const double minimumFingerTarget = 64;
  // Q71: retained as a legacy constant for older audits, but no longer used
  // to select a structural slot. Native SlotBox cursor selection is exact-hit
  // only: the user must hit a slot's authoritative touch rect, not an inferred
  // nearest target outside it.
  static const double nearestFallbackRadius = 152;
  static const bool nativeSlotBoxExactHitOnly = true;
  static const bool nearestFallbackSelectionEnabled = false;
  static const bool q73AuthoritativeBundleHitTestPreferred = true;

  static SlotHitSlop slopFor(String role) {
    return SlotInteractionCalibrationPolicy.slopForRole(role);
  }

  static SlotHitTarget targetFor(SlotEntry entry, Rect visualRect) {
    return SlotHitTarget(entry: entry, visualRect: visualRect, hitRect: _hitRectFor(entry, visualRect));
  }

  static Map<SlotEntry, SlotHitTarget> targetsFor(Map<SlotEntry, Rect> visualRects) {
    return visualRects.map((entry, rect) => MapEntry(entry, targetFor(entry, rect)));
  }

  static SlotHitTestResult? hitTest(Offset point, Map<SlotEntry, Rect> visualRects) {
    final targets = targetsFor(visualRects).values;
    final candidates = <_Candidate>[];

    for (final target in targets) {
      if (target.hitRect.contains(point)) {
        candidates.add(_Candidate(
          target: target,
          score: SlotPriorityPolicy.score(
            point: point,
            entry: target.entry,
            visualRect: target.visualRect,
            hitRect: target.hitRect,
          ),
          source: 'slot-hit-invisible-target',
        ));
      }
    }

    // Q71 Native SlotBox rule: do not infer a slot from nearest-distance
    // fallback. Comfort still comes from the authoritative hitRect generated
    // by SlotGeometryBundleAuthority, but points outside that rect are not
    // silently mapped to a structural target. This removes the random-feeling
    // jumps users saw when tapping long/nested expressions.

    if (candidates.isEmpty) return null;
    final precisionFiltered = _precisionFilteredCandidates(point, candidates);
    final scriptFiltered = _scriptLaneFilteredCandidates(point, precisionFiltered);
    final fractionFiltered = _fractionLaneFilteredCandidates(point, scriptFiltered);
    final logRootFiltered = _logRootLaneFilteredCandidates(point, fractionFiltered);
    final nestedDepthFiltered = _nestedDepthFilteredCandidates(point, logRootFiltered);
    final releaseHardened = StructuralCursorReleaseHardeningPolicy.preservePipelineStage<_Candidate>(
      stage: 'release-hardening-final-sort',
      candidates: nestedDepthFiltered,
    );
    releaseHardened.sort((a, b) => _compareCandidatesForPoint(point, a, b));
    final best = releaseHardened.first;
    return SlotHitTestResult(
      entry: best.target.entry,
      rect: best.target.visualRect,
      hitRect: best.target.hitRect,
      source: best.source,
    );
  }

  static Rect _hitRectFor(SlotEntry entry, Rect visualRect) {
    final baseHitRect = SlotGeometryBundleAuthority.hitRectForRole(
      entry: entry,
      visualRect: visualRect,
      canvasSize: Size(visualRect.right + minimumFingerTarget, visualRect.bottom + minimumFingerTarget),
    );
    final scriptAwareHitRect = ScriptPrecisionCursorPolicy.laneAwareHitRect(
      entry: entry,
      visualRect: visualRect,
      baseHitRect: baseHitRect,
    );
    final fractionAwareHitRect = FractionPrecisionCursorPolicy.laneAwareHitRect(
      entry: entry,
      visualRect: visualRect,
      baseHitRect: scriptAwareHitRect,
    );
    return LogRootPrecisionCursorPolicy.laneAwareHitRect(
      entry: entry,
      visualRect: visualRect,
      baseHitRect: fractionAwareHitRect,
    );
  }

  static List<_Candidate> _precisionFilteredCandidates(Offset point, List<_Candidate> candidates) {
    final visual = candidates
        .where((candidate) => PremiumTapPrecisionPolicy.isVisualIntentTap(
              point: point,
              entry: candidate.target.entry,
              visualRect: candidate.target.visualRect,
            ))
        .toList(growable: false);
    if (visual.isNotEmpty) return visual;

    final lane = candidates
        .where((candidate) => PremiumTapPrecisionPolicy.isPrecisionLaneTap(
              point: point,
              entry: candidate.target.entry,
              visualRect: candidate.target.visualRect,
            ))
        .toList(growable: false);
    return lane.isEmpty ? candidates : lane;
  }



  static List<_Candidate> _scriptLaneFilteredCandidates(Offset point, List<_Candidate> candidates) {
    final decision = ScriptPrecisionCursorPolicy.decideLaneForPoint(
      point: point,
      candidates: candidates.map(
        (candidate) => ScriptSlotCandidate(
          entry: candidate.target.entry,
          visualRect: candidate.target.visualRect,
        ),
      ),
    );
    if (decision == null) return candidates;
    final laneCandidates = candidates
        .where((candidate) =>
            candidate.target.entry.nodeId == decision.nodeId &&
            candidate.target.entry.role == decision.role)
        .toList(growable: false);
    return laneCandidates.isEmpty ? candidates : laneCandidates;
  }

  static List<_Candidate> _fractionLaneFilteredCandidates(Offset point, List<_Candidate> candidates) {
    final decision = FractionPrecisionCursorPolicy.decideLaneForPoint(
      point: point,
      candidates: candidates.map(
        (candidate) => FractionSlotCandidate(
          entry: candidate.target.entry,
          visualRect: candidate.target.visualRect,
        ),
      ),
    );
    if (decision == null) return candidates;
    final laneCandidates = candidates
        .where((candidate) =>
            candidate.target.entry.nodeId == decision.nodeId &&
            candidate.target.entry.role == decision.role)
        .toList(growable: false);
    return laneCandidates.isEmpty ? candidates : laneCandidates;
  }


  static List<_Candidate> _logRootLaneFilteredCandidates(Offset point, List<_Candidate> candidates) {
    final decision = LogRootPrecisionCursorPolicy.decideLaneForPoint(
      point: point,
      candidates: candidates.map(
        (candidate) => LogRootSlotCandidate(
          entry: candidate.target.entry,
          visualRect: candidate.target.visualRect,
        ),
      ),
    );
    if (decision == null) return candidates;
    final laneCandidates = candidates
        .where((candidate) =>
            candidate.target.entry.nodeId == decision.nodeId &&
            candidate.target.entry.role == decision.role)
        .toList(growable: false);
    return laneCandidates.isEmpty ? candidates : laneCandidates;
  }


  static List<_Candidate> _nestedDepthFilteredCandidates(Offset point, List<_Candidate> candidates) {
    final decision = NestedExpressionDepthCursorPolicy.decideDepthForPoint(
      point: point,
      candidates: candidates.map(
        (candidate) => NestedSlotCandidate(
          entry: candidate.target.entry,
          visualRect: candidate.target.visualRect,
        ),
      ),
    );
    if (decision == null) return candidates;
    final depthCandidates = candidates
        .where((candidate) =>
            candidate.target.entry.id == decision.slotId &&
            candidate.target.entry.nodeId == decision.nodeId &&
            candidate.target.entry.role == decision.role &&
            candidate.target.entry.depth == decision.depth)
        .toList(growable: false);
    return depthCandidates.isEmpty ? candidates : depthCandidates;
  }

  static int _compareCandidatesForPoint(Offset point, _Candidate a, _Candidate b) {
    final intent = PremiumTapPrecisionPolicy.compareTapIntent(
      TapCandidateView(entry: a.target.entry, visualRect: a.target.visualRect),
      TapCandidateView(entry: b.target.entry, visualRect: b.target.visualRect),
      point,
    );
    if (intent != 0) return intent;
    final releaseHardening = StructuralCursorReleaseHardeningPolicy.compareFinalCandidates(
      point: point,
      aEntry: a.target.entry,
      aVisualRect: a.target.visualRect,
      bEntry: b.target.entry,
      bVisualRect: b.target.visualRect,
    );
    if (releaseHardening != 0) return releaseHardening;
    return _compareCandidates(a, b);
  }

  static int _compareCandidates(_Candidate a, _Candidate b) {
    final policy = SlotPriorityPolicy.compare(a.score, a.target.entry, b.score, b.target.entry);
    if (policy != 0) return policy;

    final roleOrder = SlotInteractionCalibrationPolicy.roleOrder(a.target.entry.role).compareTo(
      SlotInteractionCalibrationPolicy.roleOrder(b.target.entry.role),
    );
    if (roleOrder != 0) return roleOrder;
    return a.target.entry.id.compareTo(b.target.entry.id);
  }

}

class _Candidate {
  const _Candidate({required this.target, required this.score, required this.source});

  final SlotHitTarget target;
  final SlotPriorityScore score;
  final String source;
}
