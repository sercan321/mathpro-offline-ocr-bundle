import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'graph_color_hierarchy.dart';
import 'graph_models.dart';
import 'graph_style.dart';

class GraphPainter extends CustomPainter {
  const GraphPainter({required this.expression, this.compact = false, this.pixelTight = false});

  final GraphExpression expression;
  final bool compact;
  final bool pixelTight;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final background = Paint()..shader = GraphStyle.surfaceGradient.createShader(rect);
    final tightCanvas = pixelTight || size.height < 92 || size.width < 220;
    final outer = RRect.fromRectAndRadius(rect, Radius.circular(tightCanvas ? 12 : compact ? 14 : 18));
    canvas.drawRRect(outer, background);
    canvas.drawRRect(
      outer.deflate(0.5),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = tightCanvas ? 0.45 : compact ? 0.58 : 0.76
        ..color = GraphStyle.graphiteLine,
    );

    final horizontalInset = tightCanvas ? 6.0 : compact ? 8.0 : 13.0;
    final verticalInset = tightCanvas ? 6.0 : compact ? 7.0 : 12.0;
    final plotRect = Rect.fromLTRB(
      rect.left + horizontalInset,
      rect.top + verticalInset,
      rect.right - horizontalInset,
      rect.bottom - verticalInset,
    );
    if (plotRect.width <= 8 || plotRect.height <= 8) return;

    if (expression.showGrid) _drawGrid(canvas, plotRect);
    if (expression.showAxes) _drawAxes(canvas, plotRect);
    _drawCurve(canvas, plotRect);
    if (!compact && !tightCanvas && expression.traceEnabled) {
      _drawTrace(canvas, plotRect);
    }
  }

  void _drawGrid(Canvas canvas, Rect plotRect) {
    final hierarchy = GraphLayerPalette.fromCurveColor(expression.graphColor, compact: compact || pixelTight);
    final minor = Paint()
      ..color = hierarchy.gridMinorColor
      ..strokeWidth = pixelTight ? 0.30 : compact ? 0.36 : 0.42;
    final major = Paint()
      ..color = hierarchy.gridMajorColor
      ..strokeWidth = pixelTight ? 0.44 : compact ? 0.52 : 0.66;

    final xTicks = _axisTicks(expression.xMin, expression.xMax, pixelTight ? 4 : compact ? 5 : 7);
    final yTicks = _axisTicks(expression.yMin, expression.yMax, pixelTight ? 3 : compact ? 4 : 6);

    for (final tick in xTicks) {
      final dx = _mapX(tick, plotRect);
      if (dx < plotRect.left - 0.5 || dx > plotRect.right + 0.5) continue;
      canvas.drawLine(
        Offset(dx, plotRect.top),
        Offset(dx, plotRect.bottom),
        _isZero(tick) ? major : minor,
      );
    }
    for (final tick in yTicks) {
      final dy = _mapY(tick, plotRect);
      if (dy < plotRect.top - 0.5 || dy > plotRect.bottom + 0.5) continue;
      canvas.drawLine(
        Offset(plotRect.left, dy),
        Offset(plotRect.right, dy),
        _isZero(tick) ? major : minor,
      );
    }
  }

  void _drawAxes(Canvas canvas, Rect plotRect) {
    final hierarchy = GraphLayerPalette.fromCurveColor(expression.graphColor, compact: compact || pixelTight);
    final axis = Paint()
      ..color = hierarchy.axisStrokeColor
      ..strokeWidth = pixelTight ? 0.58 : compact ? 0.72 : 0.92;
    final tickPaint = Paint()
      ..color = hierarchy.axisTickColor
      ..strokeWidth = pixelTight ? 0.46 : compact ? 0.56 : 0.70;

    final zeroX = _mapX(0, plotRect);
    final zeroY = _mapY(0, plotRect);
    final yAxisVisible = zeroX >= plotRect.left && zeroX <= plotRect.right;
    final xAxisVisible = zeroY >= plotRect.top && zeroY <= plotRect.bottom;

    if (yAxisVisible) {
      canvas.drawLine(Offset(zeroX, plotRect.top), Offset(zeroX, plotRect.bottom), axis);
    }
    if (xAxisVisible) {
      canvas.drawLine(Offset(plotRect.left, zeroY), Offset(plotRect.right, zeroY), axis);
    }

    if (compact || pixelTight || plotRect.height < 52 || plotRect.width < 104) return;

    final xTicks = _axisTicks(expression.xMin, expression.xMax, 5);
    final yTicks = _axisTicks(expression.yMin, expression.yMax, 5);
    final xLabelY = xAxisVisible
        ? _clampAxisLabel(zeroY + 5, plotRect.top + 2, plotRect.bottom - 16)
        : math.max(plotRect.top + 2, plotRect.bottom - 16);
    final yLabelX = yAxisVisible
        ? _clampAxisLabel(zeroX + 5, plotRect.left + 4, plotRect.right - 42)
        : plotRect.left + 4;

    for (final tick in xTicks) {
      if (_isZero(tick)) continue;
      final dx = _mapX(tick, plotRect);
      if (dx < plotRect.left + 10 || dx > plotRect.right - 10) continue;
      if (xAxisVisible) {
        canvas.drawLine(Offset(dx, zeroY - 3), Offset(dx, zeroY + 3), tickPaint);
      }
      _drawLabel(canvas, _formatTick(tick), Offset(dx, xLabelY), centered: true);
    }

    for (final tick in yTicks) {
      if (_isZero(tick)) continue;
      final dy = _mapY(tick, plotRect);
      if (dy < plotRect.top + 8 || dy > plotRect.bottom - 8) continue;
      if (yAxisVisible) {
        canvas.drawLine(Offset(zeroX - 3, dy), Offset(zeroX + 3, dy), tickPaint);
      }
      _drawLabel(canvas, _formatTick(tick), Offset(yLabelX, dy - 6));
    }
  }

  void _drawCurve(Canvas canvas, Rect plotRect) {
    final segments = GraphCurveSampler.sample(
      expression,
      samples: pixelTight ? 96 : compact ? 150 : 360,
    );
    if (segments.isEmpty) return;

    final hierarchy = GraphLayerPalette.fromCurveColor(expression.graphColor, compact: compact || pixelTight);
    final glow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = pixelTight ? 2.35 : compact ? 3.0 : 4.25
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = hierarchy.curveGlowColor;
    final curve = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = pixelTight ? 1.42 : compact ? 1.68 : 2.12
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = hierarchy.curveStrokeColor;

    canvas.save();
    canvas.clipRect(plotRect.inflate(0.5));
    for (final segment in segments) {
      if (segment.isEmpty) continue;
      final path = Path()..moveTo(_mapX(segment.first.x, plotRect), _mapY(segment.first.y, plotRect));
      for (var i = 1; i < segment.length; i++) {
        path.lineTo(_mapX(segment[i].x, plotRect), _mapY(segment[i].y, plotRect));
      }
      canvas.drawPath(path, glow);
      canvas.drawPath(path, curve);
    }
    canvas.restore();
  }

  void _drawTrace(Canvas canvas, Rect plotRect) {
    final evaluator = GraphExpressionEvaluator(expression.normalizedExpression);
    final x = math.min(math.max(0.0, expression.xMin), expression.xMax);
    final y = evaluator.evaluate(x);
    if (y == null || y < expression.yMin || y > expression.yMax) return;
    final center = Offset(_mapX(x, plotRect), _mapY(y, plotRect));
    final crosshair = Paint()
      ..color = GraphStyle.accent.withValues(alpha: 0.13)
      ..strokeWidth = 0.8;
    canvas.drawLine(Offset(center.dx, plotRect.top), Offset(center.dx, plotRect.bottom), crosshair);
    canvas.drawLine(Offset(plotRect.left, center.dy), Offset(plotRect.right, center.dy), crosshair);
    canvas.drawCircle(center, 7.0, Paint()..color = GraphStyle.accent.withValues(alpha: 0.16));
    canvas.drawCircle(center, 3.4, Paint()..color = GraphStyle.accent);
    canvas.drawCircle(
      center,
      4.2,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8
        ..color = GraphStyle.text.withValues(alpha: 0.45),
    );
  }

  double _clampAxisLabel(double value, double lower, double upper) {
    if (upper < lower) return lower;
    return value.clamp(lower, upper).toDouble();
  }

  double _mapX(double x, Rect plotRect) {
    final span = math.max((expression.xMax - expression.xMin).abs(), 1e-9);
    final t = (x - expression.xMin) / span;
    return plotRect.left + plotRect.width * t;
  }

  double _mapY(double y, Rect plotRect) {
    final span = math.max((expression.yMax - expression.yMin).abs(), 1e-9);
    final t = (y - expression.yMin) / span;
    return plotRect.bottom - plotRect.height * t;
  }

  void _drawLabel(Canvas canvas, String text, Offset offset, {bool centered = false}) {
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: GraphLayerPalette.fromCurveColor(expression.graphColor, compact: compact || pixelTight).axisLabelColor, fontSize: 9.5, fontWeight: FontWeight.w700),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(maxWidth: 48);
    painter.paint(canvas, centered ? Offset(offset.dx - painter.width / 2, offset.dy) : offset);
  }

  List<double> _axisTicks(double min, double max, int targetCount) {
    if (!min.isFinite || !max.isFinite || min == max) return const <double>[];
    final start = math.min(min, max);
    final end = math.max(min, max);
    final span = end - start;
    final step = _niceStep(span / math.max(targetCount, 1));
    final first = (start / step).ceil() * step;
    final values = <double>[];
    for (var value = first; value <= end + step * 0.25; value += step) {
      final normalized = value.abs() < step * 1e-7 ? 0.0 : value;
      values.add(normalized);
      if (values.length > 18) break;
    }
    return values;
  }

  double _niceStep(double rawStep) {
    if (!rawStep.isFinite || rawStep <= 0) return 1;
    final exponent = math.pow(10, (math.log(rawStep) / math.ln10).floor()).toDouble();
    final fraction = rawStep / exponent;
    final niceFraction = fraction <= 1
        ? 1.0
        : fraction <= 2
            ? 2.0
            : fraction <= 5
                ? 5.0
                : 10.0;
    return niceFraction * exponent;
  }

  String _formatTick(double value) {
    if (_isZero(value)) return '0';
    final abs = value.abs();
    if (abs >= 1000 || abs < 0.01) return value.toStringAsExponential(1);
    if ((value - value.roundToDouble()).abs() < 1e-8) return value.round().toString();
    return value.toStringAsFixed(abs < 1 ? 2 : 1).replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '');
  }

  bool _isZero(double value) => value.abs() < 1e-9;

  @override
  bool shouldRepaint(covariant GraphPainter oldDelegate) {
    return oldDelegate.expression != expression || oldDelegate.compact != compact || oldDelegate.pixelTight != pixelTight;
  }
}

@immutable
class GraphCurvePoint {
  const GraphCurvePoint(this.x, this.y);

  final double x;
  final double y;
}

class GraphCurveSampler {
  const GraphCurveSampler._();

  static List<List<GraphCurvePoint>> sample(GraphExpression expression, {int samples = 420}) {
    if (samples < 12) samples = 12;
    final evaluator = GraphExpressionEvaluator(expression.normalizedExpression);
    final xSpan = math.max((expression.xMax - expression.xMin).abs(), 1e-9);
    final ySpan = math.max((expression.yMax - expression.yMin).abs(), 1e-9);
    final segments = <List<GraphCurvePoint>>[];
    var current = <GraphCurvePoint>[];
    GraphCurvePoint? previous;

    void closeSegment() {
      if (current.length >= 2) segments.add(current);
      current = <GraphCurvePoint>[];
      previous = null;
    }

    for (var i = 0; i <= samples; i++) {
      final x = expression.xMin + xSpan * i / samples;
      final y = evaluator.evaluate(x);
      if (!_isRenderableY(y, expression, ySpan)) {
        closeSegment();
        continue;
      }
      final point = GraphCurvePoint(x, y!);
      if (previous != null && _shouldBreakSegment(previous!, point, evaluator, expression, xSpan, ySpan)) {
        closeSegment();
      }
      current.add(point);
      previous = point;
    }
    closeSegment();
    return segments;
  }

  static bool _isRenderableY(double? y, GraphExpression expression, double ySpan) {
    if (y == null || y.isNaN || y.isInfinite) return false;
    final margin = ySpan * 0.08;
    return y >= expression.yMin - margin && y <= expression.yMax + margin;
  }

  static bool _shouldBreakSegment(
    GraphCurvePoint previous,
    GraphCurvePoint next,
    GraphExpressionEvaluator evaluator,
    GraphExpression expression,
    double xSpan,
    double ySpan,
  ) {
    final dy = (next.y - previous.y).abs();
    final dx = math.max((next.x - previous.x).abs(), xSpan * 1e-9);
    final localSlope = dy / dx;
    final viewportSlope = ySpan / xSpan;

    // A very steep jump is suspicious, but not enough by itself: polynomials can
    // be steep. The midpoint guard below distinguishes continuous steep curves
    // from asymptotes such as tan(x).
    if (dy <= ySpan * 0.42 && localSlope <= viewportSlope * 36) return false;

    final midX = (previous.x + next.x) / 2;
    final midY = evaluator.evaluate(midX);
    if (!_isRenderableY(midY, expression, ySpan)) return true;

    final linearMid = (previous.y + next.y) / 2;
    return (midY! - linearMid).abs() > ySpan * 0.34;
  }
}

class GraphExpressionEvaluator {
  GraphExpressionEvaluator(String source) : _source = _normalize(source);

  final String _source;
  late double _x;
  late double _y;
  int _index = 0;

  static const List<String> _functionNames = <String>[
    'log10',
    'log2',
    'sqrt',
    'asin',
    'acos',
    'atan',
    'sin',
    'cos',
    'tan',
    'abs',
    'exp',
    'ln',
    'log',
  ];

  double? evaluate(double x) {
    return evaluate2D(x, 0);
  }

  double? evaluate2D(double x, double y) {
    _x = x;
    _y = y;
    _index = 0;
    try {
      final value = _parseExpression();
      _skipSpaces();
      if (_index < _source.length || value.isNaN || value.isInfinite) return null;
      return value;
    } catch (_) {
      return null;
    }
  }

  double _parseExpression() {
    var value = _parseTerm();
    while (true) {
      _skipSpaces();
      if (_match('+')) {
        value += _parseTerm();
      } else if (_match('-')) {
        value -= _parseTerm();
      } else {
        break;
      }
    }
    return value;
  }

  double _parseTerm() {
    var value = _parsePower();
    while (true) {
      _skipSpaces();
      if (_match('*')) {
        value *= _parsePower();
      } else if (_match('/')) {
        final divisor = _parsePower();
        if (divisor.abs() < 1e-12) throw const FormatException('division by zero');
        value /= divisor;
      } else if (_startsImplicitTerm()) {
        value *= _parsePower();
      } else {
        break;
      }
    }
    return value;
  }

  double _parsePower() {
    var value = _parseUnary();
    _skipSpaces();
    if (_match('^')) {
      value = math.pow(value, _parsePower()).toDouble();
    }
    return value;
  }

  double _parseUnary() {
    _skipSpaces();
    if (_match('+')) return _parseUnary();
    if (_match('-')) return -_parseUnary();
    return _parsePrimary();
  }

  double _parsePrimary() {
    _skipSpaces();
    if (_match('(')) {
      final value = _parseExpression();
      if (!_match(')')) throw const FormatException('missing )');
      return value;
    }

    final functionName = _matchFunctionName();
    if (functionName != null) {
      final double argument;
      if (_match('(')) {
        argument = _parseExpression();
        if (!_match(')')) throw const FormatException('missing function )');
      } else {
        // Accept compact graph input such as sinx, cosx, sqrtx and log10x.
        argument = _parseUnary();
      }
      return _applyFunction(functionName, argument);
    }

    if (_peekIdentifier()) {
      final id = _readIdentifier();
      if (id == 'x') return _x;
      if (id == 'y') return _y;
      if (id == 'pi') return math.pi;
      if (id == 'tau') return math.pi * 2;
      if (id == 'e') return math.e;
      throw const FormatException('unknown identifier');
    }
    return _parseNumber();
  }

  double _applyFunction(String id, double argument) {
    return switch (id) {
      'sin' => math.sin(argument),
      'cos' => math.cos(argument),
      'tan' => math.tan(argument),
      'asin' => math.asin(argument),
      'acos' => math.acos(argument),
      'atan' => math.atan(argument),
      'log' || 'ln' => math.log(argument),
      'log10' => math.log(argument) / math.ln10,
      'log2' => math.log(argument) / math.ln2,
      'sqrt' => math.sqrt(argument),
      'abs' => argument.abs(),
      'exp' => math.exp(argument),
      _ => throw const FormatException('unknown function'),
    };
  }


  double _parseNumber() {
    _skipSpaces();
    final start = _index;
    var dotSeen = false;
    while (_index < _source.length) {
      final char = _source[_index];
      final digit = char.codeUnitAt(0) >= 48 && char.codeUnitAt(0) <= 57;
      if (char == '.') {
        if (dotSeen) break;
        dotSeen = true;
        _index++;
      } else if (digit) {
        _index++;
      } else {
        break;
      }
    }
    if (start == _index) throw const FormatException('number expected');
    return double.parse(_source.substring(start, _index));
  }

  bool _startsImplicitTerm() {
    _skipSpaces();
    if (_index >= _source.length) return false;
    final char = _source[_index];
    return char == '(' || char == 'x' || char == 'y' || char == 'π' || char == 'p' || char == 'e' || _isLetter(char);
  }

  bool _peekIdentifier() {
    _skipSpaces();
    if (_index >= _source.length) return false;
    return _isLetter(_source[_index]) || _source[_index] == 'π';
  }

  String _readIdentifier() {
    _skipSpaces();
    final start = _index;
    while (_index < _source.length && (_isLetter(_source[_index]) || _isDigit(_source[_index]) || _source[_index] == 'π')) {
      _index++;
    }
    return _source.substring(start, _index).replaceAll('π', 'pi');
  }

  String? _matchFunctionName() {
    _skipSpaces();
    for (final functionName in _functionNames) {
      if (_source.startsWith(functionName, _index)) {
        _index += functionName.length;
        return functionName;
      }
    }
    return null;
  }

  bool _isLetter(String char) {
    final code = char.codeUnitAt(0);
    return (code >= 65 && code <= 90) || (code >= 97 && code <= 122);
  }

  bool _isDigit(String char) {
    final code = char.codeUnitAt(0);
    return code >= 48 && code <= 57;
  }

  bool _match(String char) {
    _skipSpaces();
    if (_index >= _source.length || _source[_index] != char) return false;
    _index++;
    return true;
  }

  void _skipSpaces() {
    while (_index < _source.length && _source[_index].trim().isEmpty) {
      _index++;
    }
  }

  static String _normalize(String source) {
    final normalized = source
        .trim()
        .replaceFirst(RegExp(r'^[yz]\s*=', caseSensitive: false), '')
        .replaceAll(',', '.')
        .replaceAll('−', '-')
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('²', '^2')
        .replaceAll('³', '^3')
        .replaceAll('⁴', '^4')
        .replaceAll('√', 'sqrt')
        .replaceAll('log₁₀', 'log10')
        .replaceAll('log₂', 'log2')
        .replaceAll('π', 'pi')
        .replaceAll(' ', '')
        .toLowerCase();
    return normalized;
  }
}
