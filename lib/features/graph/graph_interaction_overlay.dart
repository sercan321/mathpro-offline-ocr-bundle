import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'graph_critical_points.dart';
import 'graph_models.dart';
import 'graph_style.dart';

class GraphInteractiveSurface extends StatefulWidget {
  const GraphInteractiveSurface({
    super.key,
    required this.expression,
    required this.child,
    this.compact = false,
    this.pixelTight = false,
    this.enabled = true,
  });

  final GraphExpression expression;
  final Widget child;
  final bool compact;
  final bool pixelTight;
  final bool enabled;

  @override
  State<GraphInteractiveSurface> createState() => _GraphInteractiveSurfaceState();
}

class _GraphInteractiveSurfaceState extends State<GraphInteractiveSurface> {
  GraphCriticalPoint? _selectedPoint;
  GraphFreeCoordinate? _selectedCoordinate;

  @override
  void didUpdateWidget(covariant GraphInteractiveSurface oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expression.historyIdentityKey != widget.expression.historyIdentityKey ||
        oldWidget.expression.xMin != widget.expression.xMin ||
        oldWidget.expression.xMax != widget.expression.xMax ||
        oldWidget.expression.yMin != widget.expression.yMin ||
        oldWidget.expression.yMax != widget.expression.yMax ||
        oldWidget.expression.showCriticalPoints != widget.expression.showCriticalPoints ||
        oldWidget.expression.showRootPoints != widget.expression.showRootPoints ||
        oldWidget.expression.showExtremaPoints != widget.expression.showExtremaPoints ||
        oldWidget.expression.showInterceptPoints != widget.expression.showInterceptPoints) {
      _selectedPoint = null;
      _selectedCoordinate = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(
          math.max(1.0, constraints.maxWidth.isFinite ? constraints.maxWidth : 320.0),
          math.max(1.0, constraints.maxHeight.isFinite ? constraints.maxHeight : 160.0),
        );
        final metrics = GraphViewportMetrics.fromSize(size, compact: widget.compact, pixelTight: widget.pixelTight);
        final points = GraphCriticalPointDetector.detect(widget.expression, samples: widget.pixelTight ? 150 : widget.compact ? 240 : 420);
        final selectedOffset = _selectedPoint == null ? null : metrics.toCanvas(widget.expression, _selectedPoint!.x, _selectedPoint!.y);
        final coordinateOffset = _selectedCoordinate == null ? null : metrics.toCanvas(widget.expression, _selectedCoordinate!.x, _selectedCoordinate!.y);

        return Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.hardEdge,
          children: <Widget>[
            widget.child,
            Positioned.fill(
              child: GestureDetector(
                key: const ValueKey('mathpro-graph-interaction-hit-layer-q389r6b'),
                behavior: HitTestBehavior.translucent,
                onTapDown: (details) => _handleTap(details.localPosition, metrics, points),
              ),
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  key: const ValueKey('mathpro-graph-critical-point-marker-layer-q389r6b'),
                  painter: GraphCriticalPointOverlayPainter(
                    expression: widget.expression,
                    metrics: metrics,
                    points: points,
                    selectedPoint: _selectedPoint,
                    selectedCoordinate: _selectedCoordinate,
                    compact: widget.compact,
                    pixelTight: widget.pixelTight,
                  ),
                ),
              ),
            ),
            if (_selectedPoint != null && selectedOffset != null)
              _GraphFloatingTooltipPositioner(
                key: const ValueKey('mathpro-graph-critical-point-tooltip-q389r6b'),
                anchor: selectedOffset,
                bounds: metrics.plotRect,
                child: _GraphPointTooltip(point: _selectedPoint!, compact: widget.compact || widget.pixelTight),
              )
            else if (_selectedCoordinate != null && coordinateOffset != null)
              _GraphFloatingTooltipPositioner(
                key: const ValueKey('mathpro-graph-coordinate-tooltip-q389r6b'),
                anchor: coordinateOffset,
                bounds: metrics.plotRect,
                child: _GraphCoordinateTooltip(coordinate: _selectedCoordinate!, compact: widget.compact || widget.pixelTight),
              ),
          ],
        );
      },
    );
  }

  void _handleTap(Offset localPosition, GraphViewportMetrics metrics, List<GraphCriticalPoint> points) {
    if (!metrics.plotRect.contains(localPosition)) {
      setState(() {
        _selectedPoint = null;
        _selectedCoordinate = null;
      });
      return;
    }

    final nearest = _nearestPoint(localPosition, metrics, points);
    if (nearest != null) {
      setState(() {
        _selectedPoint = nearest;
        _selectedCoordinate = null;
      });
      return;
    }

    final coordinate = metrics.toGraph(widget.expression, localPosition);
    setState(() {
      _selectedPoint = null;
      _selectedCoordinate = GraphFreeCoordinate(x: coordinate.dx, y: coordinate.dy);
    });
  }

  GraphCriticalPoint? _nearestPoint(Offset localPosition, GraphViewportMetrics metrics, List<GraphCriticalPoint> points) {
    GraphCriticalPoint? best;
    var bestDistance = double.infinity;
    final hitRadius = widget.pixelTight ? 15.0 : widget.compact ? 18.0 : 22.0;
    for (final point in points) {
      if (!_isPointVisible(point)) continue;
      final offset = metrics.toCanvas(widget.expression, point.x, point.y);
      if (offset == null) continue;
      final distance = (offset - localPosition).distance;
      if (distance < bestDistance) {
        bestDistance = distance;
        best = point;
      }
    }
    return bestDistance <= hitRadius ? best : null;
  }

  bool _isPointVisible(GraphCriticalPoint point) {
    return point.x >= widget.expression.xMin &&
        point.x <= widget.expression.xMax &&
        point.y >= widget.expression.yMin &&
        point.y <= widget.expression.yMax;
  }
}

@immutable
class GraphViewportMetrics {
  const GraphViewportMetrics({required this.size, required this.plotRect});

  final Size size;
  final Rect plotRect;

  static GraphViewportMetrics fromSize(Size size, {required bool compact, required bool pixelTight}) {
    final tightCanvas = pixelTight || size.height < 92 || size.width < 220;
    final horizontalInset = tightCanvas ? 6.0 : compact ? 8.0 : 13.0;
    final verticalInset = tightCanvas ? 6.0 : compact ? 7.0 : 12.0;
    final rect = Offset.zero & size;
    return GraphViewportMetrics(
      size: size,
      plotRect: Rect.fromLTRB(
        rect.left + horizontalInset,
        rect.top + verticalInset,
        rect.right - horizontalInset,
        rect.bottom - verticalInset,
      ),
    );
  }

  Offset? toCanvas(GraphExpression expression, double x, double y) {
    if (!x.isFinite || !y.isFinite) return null;
    final xSpan = math.max((expression.xMax - expression.xMin).abs(), 1e-9);
    final ySpan = math.max((expression.yMax - expression.yMin).abs(), 1e-9);
    final dx = plotRect.left + plotRect.width * ((x - expression.xMin) / xSpan);
    final dy = plotRect.bottom - plotRect.height * ((y - expression.yMin) / ySpan);
    if (dx < plotRect.left - 0.5 || dx > plotRect.right + 0.5 || dy < plotRect.top - 0.5 || dy > plotRect.bottom + 0.5) return null;
    return Offset(dx, dy);
  }

  Offset toGraph(GraphExpression expression, Offset localPosition) {
    final xRatio = ((localPosition.dx - plotRect.left) / math.max(plotRect.width, 1e-9)).clamp(0.0, 1.0).toDouble();
    final yRatio = ((localPosition.dy - plotRect.top) / math.max(plotRect.height, 1e-9)).clamp(0.0, 1.0).toDouble();
    final x = expression.xMin + (expression.xMax - expression.xMin) * xRatio;
    final y = expression.yMax - (expression.yMax - expression.yMin) * yRatio;
    return Offset(x, y);
  }
}

class GraphCriticalPointOverlayPainter extends CustomPainter {
  const GraphCriticalPointOverlayPainter({
    required this.expression,
    required this.metrics,
    required this.points,
    this.selectedPoint,
    this.selectedCoordinate,
    this.compact = false,
    this.pixelTight = false,
  });

  final GraphExpression expression;
  final GraphViewportMetrics metrics;
  final List<GraphCriticalPoint> points;
  final GraphCriticalPoint? selectedPoint;
  final GraphFreeCoordinate? selectedCoordinate;
  final bool compact;
  final bool pixelTight;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.clipRect(metrics.plotRect.inflate(0.5));
    _drawFreeCoordinate(canvas);
    if (!pixelTight) _drawMarkers(canvas);
    canvas.restore();
  }

  void _drawFreeCoordinate(Canvas canvas) {
    final coordinate = selectedCoordinate;
    if (coordinate == null) return;
    final center = metrics.toCanvas(expression, coordinate.x, coordinate.y);
    if (center == null) return;
    final crosshair = Paint()
      ..color = GraphStyle.accent.withValues(alpha: compact ? 0.105 : 0.14)
      ..strokeWidth = compact ? 0.55 : 0.72;
    canvas.drawLine(Offset(center.dx, metrics.plotRect.top), Offset(center.dx, metrics.plotRect.bottom), crosshair);
    canvas.drawLine(Offset(metrics.plotRect.left, center.dy), Offset(metrics.plotRect.right, center.dy), crosshair);
    canvas.drawCircle(center, compact ? 4.2 : 5.2, Paint()..color = GraphStyle.accent.withValues(alpha: 0.13));
    canvas.drawCircle(center, compact ? 1.7 : 2.1, Paint()..color = GraphStyle.accent.withValues(alpha: 0.80));
  }

  void _drawMarkers(Canvas canvas) {
    final radius = compact ? 3.2 : 4.2;
    for (final point in points) {
      final center = metrics.toCanvas(expression, point.x, point.y);
      if (center == null) continue;
      final selected = selectedPoint?.id == point.id;
      final color = _markerColor(point.primaryType);
      if (selected) {
        canvas.drawCircle(center, radius + 6.2, Paint()..color = color.withValues(alpha: 0.16));
        canvas.drawCircle(
          center,
          radius + 3.2,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.1
            ..color = GraphStyle.text.withValues(alpha: 0.44),
        );
      }
      canvas.drawCircle(center, radius + 2.1, Paint()..color = color.withValues(alpha: 0.18));
      canvas.drawCircle(center, radius, Paint()..color = color.withValues(alpha: selected ? 0.96 : 0.82));
      canvas.drawCircle(
        center,
        radius + 0.65,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.8
          ..color = GraphStyle.text.withValues(alpha: selected ? 0.70 : 0.44),
      );
    }
  }

  Color _markerColor(GraphCriticalPointType type) {
    return switch (type) {
      GraphCriticalPointType.root => const Color(0xFFFFC857),
      GraphCriticalPointType.yIntercept => const Color(0xFFE8EEF2),
      GraphCriticalPointType.localMaximum => const Color(0xFF8DFFB3),
      GraphCriticalPointType.localMinimum => const Color(0xFFB88CFF),
    };
  }

  @override
  bool shouldRepaint(covariant GraphCriticalPointOverlayPainter oldDelegate) {
    return oldDelegate.expression != expression ||
        oldDelegate.metrics != metrics ||
        oldDelegate.points != points ||
        oldDelegate.selectedPoint != selectedPoint ||
        oldDelegate.selectedCoordinate != selectedCoordinate ||
        oldDelegate.compact != compact ||
        oldDelegate.pixelTight != pixelTight;
  }
}

class _GraphFloatingTooltipPositioner extends StatelessWidget {
  const _GraphFloatingTooltipPositioner({super.key, required this.anchor, required this.bounds, required this.child});

  final Offset anchor;
  final Rect bounds;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    const width = 148.0;
    const height = 74.0;
    var left = anchor.dx + 10;
    var top = anchor.dy - height - 10;
    if (left + width > bounds.right - 4) left = anchor.dx - width - 10;
    if (top < bounds.top + 4) top = anchor.dy + 12;
    final minLeft = bounds.left + 4;
    final maxLeft = math.max(minLeft, bounds.right - width - 4);
    final minTop = bounds.top + 4;
    final maxTop = math.max(minTop, bounds.bottom - height - 4);
    left = left.clamp(minLeft, maxLeft).toDouble();
    top = top.clamp(minTop, maxTop).toDouble();
    return Positioned(
      left: left,
      top: top,
      width: width,
      child: IgnorePointer(child: child),
    );
  }
}

class _GraphPointTooltip extends StatelessWidget {
  const _GraphPointTooltip({required this.point, required this.compact});

  final GraphCriticalPoint point;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return _TooltipShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(point.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: GraphStyle.text, fontSize: compact ? 10.5 : 11.5, fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          _TooltipLine(label: 'x', value: GraphValueFormat.premium(point.x), compact: compact),
          _TooltipLine(label: 'y', value: GraphValueFormat.premium(point.y), compact: compact),
        ],
      ),
    );
  }
}

class _GraphCoordinateTooltip extends StatelessWidget {
  const _GraphCoordinateTooltip({required this.coordinate, required this.compact});

  final GraphFreeCoordinate coordinate;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return _TooltipShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Koordinat', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: GraphStyle.text, fontSize: compact ? 10.5 : 11.5, fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          _TooltipLine(label: 'x', value: GraphValueFormat.premium(coordinate.x), compact: compact),
          _TooltipLine(label: 'y', value: GraphValueFormat.premium(coordinate.y), compact: compact),
        ],
      ),
    );
  }
}

class _TooltipShell extends StatelessWidget {
  const _TooltipShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: GraphStyle.cardAlt.withValues(alpha: 0.90),
        gradient: GraphStyle.controlGradient,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: GraphStyle.accent.withValues(alpha: 0.30)),
        boxShadow: GraphStyle.controlShadow(active: true),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: child,
      ),
    );
  }
}

class _TooltipLine extends StatelessWidget {
  const _TooltipLine({required this.label, required this.value, required this.compact});

  final String label;
  final String value;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$label = $value',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: label == 'y' ? GraphStyle.accent : GraphStyle.axisLabel,
        fontSize: compact ? 10.0 : 10.8,
        fontWeight: FontWeight.w800,
        height: 1.15,
      ),
    );
  }
}

class GraphValueFormat {
  const GraphValueFormat._();

  static String premium(double value) {
    if (!value.isFinite) return '—';
    if (value.abs() < 1e-10) return '0';
    final piRatio = value / math.pi;
    final piLabel = _piLabel(piRatio);
    if (piLabel != null) return '$piLabel ≈ ${_decimal(value)}';
    return _decimal(value);
  }

  static String _decimal(double value) {
    if ((value - value.roundToDouble()).abs() < 1e-8) return value.round().toString();
    final abs = value.abs();
    if (abs >= 10000 || abs < 0.001 && abs > 0) return value.toStringAsPrecision(4);
    return value.toStringAsFixed(abs < 1 ? 3 : 2).replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '');
  }

  static String? _piLabel(double ratio) {
    const maxDenominator = 12;
    for (var denominator = 1; denominator <= maxDenominator; denominator++) {
      final numerator = (ratio * denominator).round();
      if (numerator == 0) continue;
      final candidate = numerator / denominator;
      if ((ratio - candidate).abs() > 0.006) continue;
      final gcd = _gcd(numerator.abs(), denominator);
      final n = numerator ~/ gcd;
      final d = denominator ~/ gcd;
      final sign = n < 0 ? '-' : '';
      final absN = n.abs();
      if (d == 1) return absN == 1 ? '$signπ' : '$sign$absNπ';
      final prefix = absN == 1 ? 'π' : '$absNπ';
      return '$sign$prefix/$d';
    }
    return null;
  }

  static int _gcd(int a, int b) {
    while (b != 0) {
      final t = b;
      b = a % b;
      a = t;
    }
    return a == 0 ? 1 : a;
  }
}

@immutable
class GraphFreeCoordinate {
  const GraphFreeCoordinate({required this.x, required this.y});

  final double x;
  final double y;
}
