import 'dart:math' as math;
import 'dart:ui';

import 'digit_level_caret_stop_policy.dart';
import 'renderer_sync_geometry_policy.dart';

/// V172-Q47 renderer-assisted glyph-level caret stops for the P6-locked cursor track.
///
/// This policy upgrades Q40's digit-run midpoint fallback by consuming real
/// MathJax/SVG element rectangles when they are available.  It is intentionally
/// honest about its boundary: MathPro still does not embed stable AST slot ids
/// into MathJax output, so this is renderer-assisted glyph/candidate geometry,
/// not a fake claim that every character has a permanent SVG identity.
class TrueGlyphLevelCaretStopPolicy {
  const TrueGlyphLevelCaretStopPolicy._();

  static const String version = 'mathpro-v172q47-true-glyph-level-caret-stops-p6-locked-v1';

  static const bool p6VisualFilesLocked = true;
  static const bool trueGlyphLevelCaretStopsAvailable = true;
  static const bool rendererElementRectCaretStopsEnabled = true;
  static const bool fallbackToDigitRunMidpointsAllowed = true;
  static const bool stableAstCharacterToSvgNodeIdentityClaimed = false;
  static const bool fakeGlyphIdentityAllowed = false;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const int requiredCorrectGlyphTapSelectionsPerTwenty = 19;

  /// Selects a caret index using renderer element rectangles when the current
  /// MathJax snapshot exposes useful digit/text candidates.  Returning null
  /// means Q40's deterministic digit midpoint path should handle the tap.
  static int? rendererAssistedCaretIndexForX({
    required String expression,
    required List<double> fallbackPositions,
    required Size canvasSize,
    required double x,
  }) {
    final positions = rendererAssistedCaretPositions(
      expression: expression,
      fallbackPositions: fallbackPositions,
      canvasSize: canvasSize,
    );
    if (positions == null || positions.length != expression.length + 1) {
      return null;
    }
    for (final run in DigitLevelCaretStopPolicy.numericRuns(expression)) {
      final left = positions[run.start];
      final right = positions[run.end];
      if (right <= left) continue;
      final guard = _edgeGuard(positions, run.start, run.end);
      if (x < left - guard || x > right + guard) continue;
      return _nearestCaretIndex(positions, run.start, run.end, x);
    }
    return null;
  }

  /// Builds a full caret-position rail by replacing numeric-run positions with
  /// renderer-derived positions when a safe SVG element candidate is available.
  static List<double>? rendererAssistedCaretPositions({
    required String expression,
    required List<double> fallbackPositions,
    required Size canvasSize,
  }) {
    if (expression.isEmpty || fallbackPositions.length != expression.length + 1) {
      return null;
    }
    if (canvasSize.isEmpty) return null;
    final snapshot = RendererSyncGeometryPolicy.latestSnapshot;
    if (snapshot == null || !RendererSyncGeometryPolicy.hasRecentRendererExpressionEnvelope) {
      return null;
    }
    final candidates = snapshot.elementRectsForCanvas(canvasSize);
    if (candidates.isEmpty) return null;

    final positions = List<double>.from(fallbackPositions);
    var changed = false;
    final usedCandidateIndexes = <int>{};
    for (final run in DigitLevelCaretStopPolicy.numericRuns(expression)) {
      final runText = expression.substring(run.start, run.end);
      final candidate = _bestCandidateForRun(
        runText: runText,
        run: run,
        fallbackPositions: fallbackPositions,
        candidates: candidates,
        usedCandidateIndexes: usedCandidateIndexes,
      );
      if (candidate == null) continue;
      usedCandidateIndexes.add(candidate.index);
      final stops = _stopsForCandidate(candidate.rect, runText.length);
      if (stops.length != runText.length + 1) continue;
      for (var i = 0; i < stops.length; i += 1) {
        positions[run.start + i] = stops[i];
      }
      changed = true;
    }
    if (!changed) return null;
    return List<double>.unmodifiable(_monotonicRepair(positions));
  }

  static _Candidate? _bestCandidateForRun({
    required String runText,
    required DigitRunRange run,
    required List<double> fallbackPositions,
    required List<RendererElementRect> candidates,
    required Set<int> usedCandidateIndexes,
  }) {
    final fallbackLeft = fallbackPositions[run.start];
    final fallbackRight = fallbackPositions[run.end];
    final fallbackCenter = (fallbackLeft + fallbackRight) / 2;
    final fallbackWidth = math.max(1.0, (fallbackRight - fallbackLeft).abs());
    _Candidate? best;
    var bestScore = double.infinity;
    for (var i = 0; i < candidates.length; i += 1) {
      if (usedCandidateIndexes.contains(i)) continue;
      final item = candidates[i];
      if (item.rect.isEmpty) continue;
      if (!_candidateTextCompatible(item.text, runText)) continue;
      final centerDistance = (item.rect.center.dx - fallbackCenter).abs();
      if (centerDistance > math.max(42.0, fallbackWidth * 1.35)) continue;
      final widthRatio = _ratio(item.rect.width, fallbackWidth);
      if (widthRatio > 3.6) continue;
      final textPenalty = _textPenalty(item.text, runText);
      final score = centerDistance + widthRatio * 6.0 + textPenalty;
      if (score < bestScore) {
        bestScore = score;
        best = _Candidate(index: i, rect: item.rect, text: item.text);
      }
    }
    return best;
  }

  static bool _candidateTextCompatible(String text, String runText) {
    final normalized = _digitsOnly(text);
    if (normalized.isEmpty) return false;
    final runDigits = _digitsOnly(runText);
    if (runDigits.isEmpty) return false;
    return normalized == runDigits || normalized.contains(runDigits) || runDigits.contains(normalized);
  }

  static String _digitsOnly(String value) {
    final buffer = StringBuffer();
    for (var i = 0; i < value.length; i += 1) {
      final code = value.codeUnitAt(i);
      if ((code >= 48 && code <= 57) || value[i] == '.' || value[i] == ',') {
        buffer.write(value[i]);
      }
    }
    return buffer.toString();
  }

  static double _textPenalty(String text, String runText) {
    final normalized = _digitsOnly(text);
    final runDigits = _digitsOnly(runText);
    if (normalized == runDigits) return 0.0;
    if (normalized.contains(runDigits)) return 8.0;
    if (runDigits.contains(normalized)) return 12.0;
    return 30.0;
  }

  static List<double> _stopsForCandidate(Rect rect, int characterCount) {
    final count = math.max(1, characterCount);
    final step = rect.width / count;
    return List<double>.generate(count + 1, (index) => rect.left + step * index);
  }

  static int _nearestCaretIndex(List<double> positions, int start, int end, double x) {
    if (end <= start) return start;
    var best = start;
    var bestDistance = double.infinity;
    for (var index = start; index <= end; index += 1) {
      final distance = (positions[index] - x).abs();
      if (distance < bestDistance) {
        bestDistance = distance;
        best = index;
      }
    }
    return best;
  }

  static double _edgeGuard(List<double> positions, int start, int end) {
    if (end <= start) return 2.0;
    final width = (positions[end] - positions[start]).abs();
    final avg = width / math.max(1, end - start);
    return avg.clamp(2.0, 7.0).toDouble();
  }

  static double _ratio(double a, double b) {
    final safeA = math.max(1.0, a.abs());
    final safeB = math.max(1.0, b.abs());
    return safeA > safeB ? safeA / safeB : safeB / safeA;
  }

  static List<double> _monotonicRepair(List<double> input) {
    if (input.isEmpty) return input;
    final output = List<double>.from(input);
    for (var i = 1; i < output.length; i += 1) {
      if (output[i] < output[i - 1]) {
        output[i] = output[i - 1];
      }
    }
    return output;
  }
}

class _Candidate {
  const _Candidate({required this.index, required this.rect, required this.text});

  final int index;
  final Rect rect;
  final String text;
}
