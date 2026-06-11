import 'dart:math' as math;

/// Central performance budget for the premium editor surface.
///
/// This is intentionally editor/UI only. It does not add solver/CAS behavior.
/// Its job is to keep repeated measurement, popup animation, long-expression
/// panning and slot-follow logic inside a single 60 fps-oriented policy instead
/// of scattering magic numbers across widgets.
class PremiumEditorPerformancePolicy {
  const PremiumEditorPerformancePolicy._();

  static const String version = 'mathpro-v92-premium-editor-performance-policy-v1';

  /// 60 fps frame budget. Used by tests/audits as an explicit product target.
  static const int targetFrameBudgetMicros = 16667;

  /// Small enough to avoid unbounded memory growth, large enough for normal
  /// mobile editing sessions where users repeatedly adjust one expression.
  static const int maxExpressionMeasurementCacheEntries = 32;

  static const double minMeasuredExpressionWidth = 80.0;
  static const double maxMeasuredExpressionWidth = 5200.0;
  static const double maxStructuralWidthBonus = 520.0;

  static const int longPressPressAnimationMs = 72;
  static const int moreChipPressAnimationMs = 72;
  static const int categorySelectionAnimationMs = 120;

  static const double longPressPanelHorizontalPadding = 24.0;
  static const double longPressChipGap = 10.0;
  static const double longPressChipHeight = 88.0;
  static const double longPressMinimumPanelWidth = 184.0;
  static const double longPressMinimumWidePanelWidth = 216.0;

  static const int maxImmediateLayoutExpressionLength = 420;
  static const int maxImmediateLayoutSlotCount = 28;

  static String measurementCacheKey({
    required String expression,
    required double viewportWidth,
  }) {
    return '${expression.trim()}|${viewportWidth.toStringAsFixed(1)}';
  }

  static bool shouldCacheExpressionMeasurement(String expression) {
    final clean = expression.trim();
    if (clean.isEmpty) return false;
    return clean.length <= 1200;
  }

  static double clampMeasuredExpressionWidth(double width) {
    if (!width.isFinite || width.isNaN) return minMeasuredExpressionWidth;
    return width.clamp(minMeasuredExpressionWidth, maxMeasuredExpressionWidth).toDouble();
  }

  static double structuralComplexityWidthBonus(String expression) {
    final clean = expression.trim();
    if (clean.isEmpty) return 0;
    final slotBonus = '□'.allMatches(clean).length * 18.0;
    final matrixBonus = RegExp(r'\[[^\]]*[;…][^\]]*\]').allMatches(clean).length * 58.0;
    final seriesBonus = (clean.contains('Σ') || clean.contains('Π')) ? 72.0 : 0.0;
    final calculusBonus = clean.contains('∫') ? 52.0 : 0.0;
    final functionBonus = RegExp(r'(sin|cos|tan|log|ln|sqrt|√)').allMatches(clean).length * 12.0;
    final nestingBonus = maxParenthesisDepth(clean) * 28.0;
    return math.min(
      maxStructuralWidthBonus,
      slotBonus + matrixBonus + seriesBonus + calculusBonus + functionBonus + nestingBonus,
    );
  }

  static int maxParenthesisDepth(String expression) {
    var depth = 0;
    var maxDepth = 0;
    for (final codeUnit in expression.codeUnits) {
      if (codeUnit == 40) {
        depth += 1;
        maxDepth = math.max(maxDepth, depth);
      } else if (codeUnit == 41) {
        depth = math.max(0, depth - 1);
      }
    }
    return maxDepth;
  }

  static bool canUseImmediateLayoutPath({
    required String expression,
    required int slotCount,
  }) {
    return expression.length <= maxImmediateLayoutExpressionLength && slotCount <= maxImmediateLayoutSlotCount;
  }

  static bool shouldApplyRepaintBoundary({
    required bool mathSurface,
    required bool animatedSurface,
  }) {
    return mathSurface || animatedSurface;
  }

  static double desiredLongPressPanelWidth(Iterable<String> labels, double Function(String label) chipWidthFor) {
    final list = labels.toList(growable: false);
    final chipTotal = list.fold<double>(0, (sum, label) => sum + chipWidthFor(label));
    final gapTotal = list.length <= 1 ? 0.0 : longPressChipGap * (list.length - 1);
    final minimum = list.length <= 3 ? longPressMinimumPanelWidth : longPressMinimumWidePanelWidth;
    return math.max(minimum, chipTotal + gapTotal + longPressPanelHorizontalPadding);
  }

  static void evictOldestMeasurementIfNeeded(Map<String, double> cache) {
    while (cache.length > maxExpressionMeasurementCacheEntries) {
      cache.remove(cache.keys.first);
    }
  }
}
