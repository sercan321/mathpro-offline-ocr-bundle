import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import 'graph_models.dart';
import 'graph_painter.dart';

/// Q389R6B: lightweight, viewport-scoped critical-point detector for the 2D
/// graph interaction layer.  This deliberately favors safe/approximate markers
/// over aggressive symbolic claims; wrong points are worse than missing points.
enum GraphCriticalPointType {
  root,
  yIntercept,
  localMaximum,
  localMinimum,
}

@immutable
class GraphCriticalPoint {
  const GraphCriticalPoint({
    required this.id,
    required this.types,
    required this.x,
    required this.y,
    this.confidence = 1,
  });

  final String id;
  final List<GraphCriticalPointType> types;
  final double x;
  final double y;
  final double confidence;

  GraphCriticalPointType get primaryType => types.first;

  String get title => types.map(GraphCriticalPointLabels.titleFor).join(' / ');

  bool get isFinite => x.isFinite && y.isFinite;

  bool hasType(GraphCriticalPointType type) => types.contains(type);

  GraphCriticalPoint mergeWith(GraphCriticalPoint other) {
    final mergedTypes = <GraphCriticalPointType>[...types];
    for (final type in other.types) {
      if (!mergedTypes.contains(type)) mergedTypes.add(type);
    }
    return GraphCriticalPoint(
      id: id,
      types: mergedTypes,
      x: (x + other.x) / 2,
      y: (y + other.y) / 2,
      confidence: math.min(confidence, other.confidence),
    );
  }
}

class GraphCriticalPointLabels {
  const GraphCriticalPointLabels._();

  static String titleFor(GraphCriticalPointType type) {
    return switch (type) {
      GraphCriticalPointType.root => 'Kök',
      GraphCriticalPointType.yIntercept => 'Y-kesişimi',
      GraphCriticalPointType.localMaximum => 'Maksimum',
      GraphCriticalPointType.localMinimum => 'Minimum',
    };
  }
}

class GraphCriticalPointDetector {
  const GraphCriticalPointDetector._();

  static List<GraphCriticalPoint> detect(GraphExpression expression, {int samples = 420}) {
    if (!expression.showCriticalPoints || expression.type == GraphType.implicitPending) return const <GraphCriticalPoint>[];
    if (expression.xMin >= expression.xMax || expression.yMin >= expression.yMax) return const <GraphCriticalPoint>[];

    final evaluator = GraphExpressionEvaluator(expression.normalizedExpression);
    if (expression.type == GraphType.constant) {
      final intercept = expression.showInterceptPoints ? _detectYIntercept(expression, evaluator) : null;
      return intercept == null ? const <GraphCriticalPoint>[] : <GraphCriticalPoint>[intercept];
    }
    final xSpan = expression.xMax - expression.xMin;
    final ySpan = expression.yMax - expression.yMin;
    if (!xSpan.isFinite || !ySpan.isFinite || xSpan <= 0 || ySpan <= 0) return const <GraphCriticalPoint>[];

    final sampleCount = samples.clamp(96, 720).toInt();
    final sampled = <_SampledGraphPoint>[];
    for (var i = 0; i <= sampleCount; i++) {
      final x = expression.xMin + xSpan * i / sampleCount;
      final y = evaluator.evaluate(x);
      sampled.add(_SampledGraphPoint(x, y));
    }

    final points = <GraphCriticalPoint>[];
    if (expression.showRootPoints) {
      points.addAll(_detectRoots(expression, evaluator, sampled, ySpan));
    }
    if (expression.showInterceptPoints) {
      final intercept = _detectYIntercept(expression, evaluator);
      if (intercept != null) points.add(intercept);
    }
    if (expression.showExtremaPoints) {
      points.addAll(_detectExtrema(expression, evaluator, sampled, ySpan));
    }

    final merged = _mergeClosePoints(points, expression);
    merged.sort((a, b) => a.x.compareTo(b.x));
    return merged.take(24).toList(growable: false);
  }

  static List<GraphCriticalPoint> _detectRoots(
    GraphExpression expression,
    GraphExpressionEvaluator evaluator,
    List<_SampledGraphPoint> sampled,
    double ySpan,
  ) {
    final points = <GraphCriticalPoint>[];
    final nearZeroTolerance = math.max(ySpan * 0.0025, 1e-6);

    for (var i = 1; i < sampled.length; i++) {
      final previous = sampled[i - 1];
      final next = sampled[i];
      final y0 = previous.y;
      final y1 = next.y;
      if (!_finite(y0) || !_finite(y1)) continue;
      final leftY = y0!;
      final rightY = y1!;

      double? rootX;
      if (leftY.abs() <= nearZeroTolerance) {
        rootX = previous.x;
      } else if (rightY.abs() <= nearZeroTolerance) {
        rootX = next.x;
      } else if ((leftY < 0 && rightY > 0) || (leftY > 0 && rightY < 0)) {
        rootX = _bisectRoot(evaluator, previous.x, next.x, leftY, rightY);
      }

      if (rootX == null || !_within(rootX, expression.xMin, expression.xMax)) continue;
      final rootY = evaluator.evaluate(rootX);
      if (!_finite(rootY) || rootY!.abs() > math.max(ySpan * 0.015, 0.02)) continue;
      points.add(
        GraphCriticalPoint(
          id: 'root-${_id(rootX)}',
          types: const <GraphCriticalPointType>[GraphCriticalPointType.root],
          x: rootX,
          y: 0,
          confidence: 0.88,
        ),
      );
    }
    return points;
  }

  static GraphCriticalPoint? _detectYIntercept(GraphExpression expression, GraphExpressionEvaluator evaluator) {
    if (!_within(0, expression.xMin, expression.xMax)) return null;
    final y = evaluator.evaluate(0);
    if (!_finite(y) || !_within(y!, expression.yMin, expression.yMax)) return null;
    return GraphCriticalPoint(
      id: 'y-intercept',
      types: const <GraphCriticalPointType>[GraphCriticalPointType.yIntercept],
      x: 0,
      y: y,
      confidence: 1,
    );
  }

  static List<GraphCriticalPoint> _detectExtrema(
    GraphExpression expression,
    GraphExpressionEvaluator evaluator,
    List<_SampledGraphPoint> sampled,
    double ySpan,
  ) {
    final points = <GraphCriticalPoint>[];
    final flatTolerance = math.max(ySpan * 0.000001, 1e-9);

    for (var i = 1; i < sampled.length - 1; i++) {
      final left = sampled[i - 1];
      final center = sampled[i];
      final right = sampled[i + 1];
      if (!_finite(left.y) || !_finite(center.y) || !_finite(right.y)) continue;

      final leftDelta = center.y! - left.y!;
      final rightDelta = right.y! - center.y!;
      final isMax = leftDelta > flatTolerance && rightDelta < -flatTolerance;
      final isMin = leftDelta < -flatTolerance && rightDelta > flatTolerance;
      if (!isMax && !isMin) continue;

      final refined = isMax
          ? _refineExtremum(evaluator, left.x, right.x, maximize: true)
          : _refineExtremum(evaluator, left.x, right.x, maximize: false);
      if (refined == null) continue;
      final x = refined.$1;
      final y = refined.$2;
      if (!_within(x, expression.xMin, expression.xMax) || !_within(y, expression.yMin, expression.yMax)) continue;
      points.add(
        GraphCriticalPoint(
          id: '${isMax ? 'max' : 'min'}-${_id(x)}',
          types: <GraphCriticalPointType>[isMax ? GraphCriticalPointType.localMaximum : GraphCriticalPointType.localMinimum],
          x: x,
          y: y,
          confidence: 0.74,
        ),
      );
    }
    return points;
  }

  static double? _bisectRoot(GraphExpressionEvaluator evaluator, double left, double right, double leftY, double rightY) {
    var a = left;
    var b = right;
    var fa = leftY;
    var fb = rightY;
    for (var i = 0; i < 28; i++) {
      final mid = (a + b) / 2;
      final fm = evaluator.evaluate(mid);
      if (!_finite(fm)) return null;
      if (fm!.abs() < 1e-10) return mid;
      if ((fa < 0 && fm > 0) || (fa > 0 && fm < 0)) {
        b = mid;
        fb = fm;
      } else {
        a = mid;
        fa = fm;
      }
      if ((b - a).abs() < 1e-9 || (fb - fa).abs() < 1e-12) break;
    }
    return (a + b) / 2;
  }

  static (double, double)? _refineExtremum(GraphExpressionEvaluator evaluator, double left, double right, {required bool maximize}) {
    var a = math.min(left, right);
    var b = math.max(left, right);
    for (var i = 0; i < 34; i++) {
      final m1 = a + (b - a) / 3;
      final m2 = b - (b - a) / 3;
      final y1 = evaluator.evaluate(m1);
      final y2 = evaluator.evaluate(m2);
      if (!_finite(y1) || !_finite(y2)) return null;
      if (maximize ? y1! < y2! : y1! > y2!) {
        a = m1;
      } else {
        b = m2;
      }
    }
    final x = (a + b) / 2;
    final y = evaluator.evaluate(x);
    if (!_finite(y)) return null;
    return (x, y!);
  }

  static List<GraphCriticalPoint> _mergeClosePoints(List<GraphCriticalPoint> points, GraphExpression expression) {
    final merged = <GraphCriticalPoint>[];
    final xTolerance = math.max((expression.xMax - expression.xMin).abs() * 0.004, 1e-5);
    final yTolerance = math.max((expression.yMax - expression.yMin).abs() * 0.006, 1e-5);

    for (final point in points) {
      if (!point.isFinite) continue;
      var mergedIndex = -1;
      for (var i = 0; i < merged.length; i++) {
        final candidate = merged[i];
        if ((candidate.x - point.x).abs() <= xTolerance && (candidate.y - point.y).abs() <= yTolerance) {
          mergedIndex = i;
          break;
        }
      }
      if (mergedIndex == -1) {
        merged.add(point);
      } else {
        merged[mergedIndex] = merged[mergedIndex].mergeWith(point);
      }
    }
    return merged;
  }

  static bool _finite(double? value) => value != null && value.isFinite;

  static bool _within(double value, double min, double max) {
    final low = math.min(min, max);
    final high = math.max(min, max);
    return value >= low && value <= high;
  }

  static String _id(double value) => value.toStringAsFixed(4).replaceAll('-', 'm').replaceAll('.', '_');
}

@immutable
class _SampledGraphPoint {
  const _SampledGraphPoint(this.x, this.y);

  final double x;
  final double? y;
}
