/// Q40 digit-level caret stop policy for the P6-locked cursor track.
///
/// This policy does not change MathPro keyboard, MORE, long-press, MathLabel,
/// app shell, Graph, History or Solution surfaces. It only strengthens the
/// existing linear caret engine so filled numeric/function arguments choose
/// real digit gaps instead of snapping to a nearby structural boundary.
class DigitLevelCaretStopPolicy {
  const DigitLevelCaretStopPolicy._();

  static const String version =
      'mathpro-v172q40-digit-level-caret-stops-p6-locked-v1';

  static const bool p6VisualFilesLocked = true;
  static const bool digitLevelCaretStopsAvailable = true;
  static const bool digitRunMidpointSelectionEnabled = true;
  static const bool structuralBoundarySnapSuppressedInsideDigitRuns = true;
  static const bool rendererGlyphIdentityClaimed = false;
  static const int requiredCorrectDigitTapSelectionsPerTwenty = 19;

  /// Returns a caret index inside a numeric run when [x] lands inside the
  /// visual band of that run. Returning null means the normal structural / text
  /// fallback may continue.  The policy deliberately uses existing linear
  /// caret rails supplied by MathProCaretController, so it remains compatible
  /// with P6 UI rendering and does not make fake renderer-glyph claims.
  static int? digitCaretIndexForX({
    required String expression,
    required List<double> positions,
    required double x,
  }) {
    if (expression.isEmpty || positions.length != expression.length + 1) {
      return null;
    }
    for (final run in numericRuns(expression)) {
      final left = positions[run.start];
      final right = positions[run.end];
      final guard = _runEdgeGuard(positions, run.start, run.end);
      if (x < left - guard || x > right + guard) continue;
      return _caretIndexInsideRun(
        positions: positions,
        start: run.start,
        end: run.end,
        x: x,
      );
    }
    return null;
  }

  /// Returns true when [x] is clearly inside a numeric run and therefore should
  /// not be stolen by coarse structural anchors such as function boundaries.
  static bool isInsideDigitRunBand({
    required String expression,
    required List<double> positions,
    required double x,
  }) {
    if (expression.isEmpty || positions.length != expression.length + 1) {
      return false;
    }
    for (final run in numericRuns(expression)) {
      final left = positions[run.start];
      final right = positions[run.end];
      final guard = _runEdgeGuard(positions, run.start, run.end) * 0.62;
      if (x >= left + guard && x <= right - guard) return true;
    }
    return false;
  }

  static List<DigitRunRange> numericRuns(String expression) {
    final runs = <DigitRunRange>[];
    var index = 0;
    while (index < expression.length) {
      if (!_isDigitOrDecimal(expression[index])) {
        index += 1;
        continue;
      }
      final start = index;
      var sawDigit = _isDigit(expression[index]);
      index += 1;
      while (index < expression.length && _isDigitOrDecimal(expression[index])) {
        sawDigit = sawDigit || _isDigit(expression[index]);
        index += 1;
      }
      if (sawDigit) runs.add(DigitRunRange(start: start, end: index));
    }
    return List<DigitRunRange>.unmodifiable(runs);
  }

  static int _caretIndexInsideRun({
    required List<double> positions,
    required int start,
    required int end,
    required double x,
  }) {
    if (end <= start) return start;
    if (x <= positions[start]) return start;
    for (var index = start; index < end; index += 1) {
      final midpoint = (positions[index] + positions[index + 1]) / 2;
      if (x <= midpoint) return index;
    }
    return end;
  }

  static double _runEdgeGuard(List<double> positions, int start, int end) {
    if (end <= start || start < 0 || end >= positions.length) return 2.0;
    final width = (positions[end] - positions[start]).abs();
    final count = (end - start).clamp(1, 64).toDouble();
    final avg = width / count;
    return avg.clamp(2.0, 9.0).toDouble();
  }

  static bool _isDigitOrDecimal(String char) => _isDigit(char) || char == '.' || char == ',';

  static bool _isDigit(String char) {
    if (char.isEmpty) return false;
    final code = char.codeUnitAt(0);
    return code >= 48 && code <= 57;
  }
}

class DigitRunRange {
  const DigitRunRange({required this.start, required this.end});

  final int start;
  final int end;

  int get length => end - start;
}
