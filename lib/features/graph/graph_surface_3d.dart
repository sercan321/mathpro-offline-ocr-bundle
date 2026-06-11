import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'graph_color_hierarchy.dart';
import 'graph_models.dart';
import 'graph_painter.dart';
import 'graph_style.dart';

class GraphSurface3D extends StatelessWidget {
  const GraphSurface3D({super.key, required this.expression, this.compact = false});

  final GraphExpression expression;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(compact ? 12 : 18),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: GraphStyle.canvas,
          gradient: GraphStyle.surfaceGradient,
          border: Border.all(color: GraphStyle.tealBorder.withValues(alpha: 0.72)),
          borderRadius: BorderRadius.circular(compact ? 12 : 18),
          boxShadow: compact ? null : GraphStyle.surfaceShadow,
        ),
        child: CustomPaint(
          key: ValueKey(compact ? 'mathpro-mini-graph-3d-surface' : 'mathpro-graph-3d-surface'),
          painter: GraphSurface3DPainter(expression: expression, compact: compact),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

// Q234: premium surface-first 3D rendering.  The painter keeps the existing
// evaluator/viewport contract, but replaces the dense debug-like wireframe with
// depth-sorted filled quads, a z-height color ramp, sparse mesh, muted grid,
// and neutral axes so the data surface is the dominant visual layer.
class GraphSurface3DPainter extends CustomPainter {
  const GraphSurface3DPainter({required this.expression, this.compact = false});

  final GraphExpression expression;
  final bool compact;

  int get _sampleGrid => compact ? 29 : 41;
  int get _meshStride => compact ? 5 : 4;

  bool get _usesYVariable => RegExp(r'(^|[^a-zA-Z])y([^a-zA-Z]|$)').hasMatch(
        expression.normalizedExpression.trim().toLowerCase().replaceFirst(RegExp(r'^[yz]\s*=', caseSensitive: false), ''),
      );

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final background = Paint()..shader = GraphStyle.surfaceGradient.createShader(rect);
    final outer = RRect.fromRectAndRadius(rect, Radius.circular(compact ? 12 : 18));
    canvas.drawRRect(outer, background);
    canvas.drawRRect(
      outer.deflate(0.5),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = compact ? 0.6 : 0.8
        ..color = GraphStyle.tealBorder.withValues(alpha: compact ? 0.34 : 0.48),
    );

    final plotRect = rect.deflate(compact ? 7 : 14);
    if (plotRect.width <= 20 || plotRect.height <= 20) return;

    final samples = _sampleSurface();
    if (samples.isEmpty) {
      _drawUnavailable(canvas, plotRect);
      return;
    }

    final projected = _projectSamples(samples, plotRect);
    final hierarchy = GraphLayerPalette.fromCurveColor(expression.graphColor, compact: compact);
    _drawFloorGrid(canvas, plotRect, hierarchy);
    _drawAxes(canvas, plotRect, hierarchy);
    _drawSurfaceFill(canvas, projected, hierarchy);
    _drawSparseMesh(canvas, projected, hierarchy);
    _drawSilhouette(canvas, projected, hierarchy);
    if (!compact) _drawLabels(canvas, plotRect);
  }

  List<List<_Graph3DSample?>> _sampleSurface() {
    final evaluator = GraphExpressionEvaluator(expression.normalizedExpression);
    final xMin = expression.xMin;
    final xMax = expression.xMax;
    final yMin = _usesYVariable ? expression.yMin : -3.0;
    final yMax = _usesYVariable ? expression.yMax : 3.0;
    final xSpan = math.max((xMax - xMin).abs(), 1e-9);
    final ySpan = math.max((yMax - yMin).abs(), 1e-9);
    final grid = _sampleGrid;
    final rows = <List<_Graph3DSample?>>[];
    final values = <double>[];

    for (var j = 0; j < grid; j++) {
      final row = <_Graph3DSample?>[];
      final y = yMin + ySpan * j / (grid - 1);
      for (var i = 0; i < grid; i++) {
        final x = xMin + xSpan * i / (grid - 1);
        final z = evaluator.evaluate2D(x, y);
        if (z == null || z.isNaN || z.isInfinite || z.abs() > GraphViewportPolicy.maxAbsValue) {
          row.add(null);
        } else {
          row.add(_Graph3DSample(z, xT: i / (grid - 1), yT: j / (grid - 1)));
          values.add(z);
        }
      }
      rows.add(row);
    }

    if (values.length < 6) return const <List<_Graph3DSample?>>[];
    values.sort();
    final low = values[(values.length * 0.06).floor().clamp(0, values.length - 1)];
    final high = values[(values.length * 0.94).floor().clamp(0, values.length - 1)];
    final span = math.max((high - low).abs(), 1e-6);
    return rows
        .map((row) => row
            .map((sample) => sample?.copyWith(zNormalized: ((sample.z - low) / span).clamp(-0.22, 1.22).toDouble()))
            .toList(growable: false))
        .toList(growable: false);
  }

  List<List<_Projected3D?>> _projectSamples(List<List<_Graph3DSample?>> rows, Rect rect) {
    final projected = <List<_Projected3D?>>[];
    final yCompression = _usesYVariable ? 1.0 : 0.42;
    for (var j = 0; j < rows.length; j++) {
      final row = <_Projected3D?>[];
      for (var i = 0; i < rows[j].length; i++) {
        final sample = rows[j][i];
        if (sample == null) {
          row.add(null);
          continue;
        }
        final nx = sample.xT * 2 - 1;
        final ny = (sample.yT * 2 - 1) * yCompression;
        final nz = sample.zNormalized * 2 - 1;
        final dx = (nx - ny) * rect.width * (_usesYVariable ? 0.275 : 0.325);
        final dy = (nx + ny) * rect.height * (_usesYVariable ? 0.108 : 0.090) - nz * rect.height * 0.235;
        final center = Offset(rect.center.dx, rect.center.dy + rect.height * (_usesYVariable ? 0.055 : 0.090));
        final offset = Offset(center.dx + dx, center.dy + dy);
        final depth = offset.dy + sample.yT * 14 - sample.zNormalized * 10;
        row.add(_Projected3D(offset, sample.zNormalized, depth));
      }
      projected.add(row);
    }
    return projected;
  }

  void _drawFloorGrid(Canvas canvas, Rect rect, GraphLayerPalette hierarchy) {
    final paint = Paint()
      ..color = hierarchy.gridMinorColor.withValues(alpha: compact ? 0.82 : 0.92)
      ..strokeWidth = compact ? 0.30 : 0.42
      ..style = PaintingStyle.stroke;
    final major = Paint()
      ..color = hierarchy.gridMajorColor.withValues(alpha: compact ? 0.82 : 0.92)
      ..strokeWidth = compact ? 0.42 : 0.58
      ..style = PaintingStyle.stroke;
    final center = Offset(rect.center.dx, rect.center.dy + rect.height * 0.25);
    final w = rect.width * 0.64;
    final h = rect.height * 0.25;
    for (var i = -3; i <= 3; i++) {
      final t = i / 3;
      final p = i == 0 ? major : paint;
      canvas.drawLine(
        Offset(center.dx - w * 0.5 + w * (t + 1) / 2, center.dy - h * 0.5),
        Offset(center.dx + w * t / 2, center.dy + h * 0.5),
        p,
      );
      canvas.drawLine(
        Offset(center.dx + w * 0.5 - w * (t + 1) / 2, center.dy - h * 0.5),
        Offset(center.dx - w * t / 2, center.dy + h * 0.5),
        p,
      );
    }
  }

  void _drawAxes(Canvas canvas, Rect rect, GraphLayerPalette hierarchy) {
    final axis = Paint()
      ..color = hierarchy.axisStrokeColor
      ..strokeWidth = compact ? 0.78 : 0.98
      ..strokeCap = StrokeCap.round;
    final origin = Offset(rect.center.dx, rect.center.dy + rect.height * 0.25);
    final xEnd = Offset(origin.dx + rect.width * 0.34, origin.dy + rect.height * 0.15);
    final yEnd = Offset(origin.dx - rect.width * 0.34, origin.dy + rect.height * 0.15);
    final zEnd = Offset(origin.dx, origin.dy - rect.height * 0.47);
    canvas.drawLine(origin, xEnd, axis);
    canvas.drawLine(origin, yEnd, axis);
    final zAxis = Paint()
      ..color = hierarchy.axisStrokeColor.withValues(alpha: compact ? 0.44 : 0.54)
      ..strokeWidth = compact ? 0.82 : 1.05
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(origin, zEnd, zAxis);
    if (!compact && rect.width >= 150 && rect.height >= 92) {
      _drawAxisTip(canvas, xEnd, 'x', hierarchy.axisLabelColor);
      _drawAxisTip(canvas, yEnd, 'y', hierarchy.axisLabelColor);
      _drawAxisTip(canvas, zEnd, 'z', hierarchy.axisLabelColor);
    }
  }

  void _drawAxisTip(Canvas canvas, Offset offset, String label, Color color) {
    final painter = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(color: color, fontSize: compact ? 9 : 10, fontWeight: FontWeight.w900),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(maxWidth: 20);
    painter.paint(canvas, offset + const Offset(3, -9));
  }

  void _drawSurfaceFill(Canvas canvas, List<List<_Projected3D?>> projected, GraphLayerPalette hierarchy) {
    final quads = <_SurfaceQuad>[];
    for (var j = 0; j < projected.length - 1; j++) {
      for (var i = 0; i < projected[j].length - 1; i++) {
        final a = projected[j][i];
        final b = projected[j][i + 1];
        final c = projected[j + 1][i + 1];
        final d = projected[j + 1][i];
        if (a == null || b == null || c == null || d == null) continue;
        quads.add(_SurfaceQuad(<_Projected3D>[a, b, c, d]));
      }
    }
    quads.sort((a, b) => a.depth.compareTo(b.depth));
    final fill = Paint()..style = PaintingStyle.fill;
    for (final quad in quads) {
      final path = Path()
        ..moveTo(quad.points[0].offset.dx, quad.points[0].offset.dy)
        ..lineTo(quad.points[1].offset.dx, quad.points[1].offset.dy)
        ..lineTo(quad.points[2].offset.dx, quad.points[2].offset.dy)
        ..lineTo(quad.points[3].offset.dx, quad.points[3].offset.dy)
        ..close();
      fill.color = GraphSurfaceColorRamp.colorAt(
        quad.meanZ,
        hierarchy.curveStrokeColor,
        alpha: compact ? 0.62 : 0.73,
      );
      canvas.drawPath(path, fill);
    }
  }

  void _drawSparseMesh(Canvas canvas, List<List<_Projected3D?>> projected, GraphLayerPalette hierarchy) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = compact ? 0.42 : 0.58
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = hierarchy.surfaceMeshColor;
    final grid = projected.length;
    for (var j = 0; j < grid; j += _meshStride) {
      _drawProjectedPath(canvas, projected[j], paint);
    }
    if ((grid - 1) % _meshStride != 0) _drawProjectedPath(canvas, projected.last, paint);
    for (var i = 0; i < grid; i += _meshStride) {
      final column = <_Projected3D?>[];
      for (var j = 0; j < grid; j++) {
        column.add(projected[j][i]);
      }
      _drawProjectedPath(canvas, column, paint);
    }
  }

  void _drawSilhouette(Canvas canvas, List<List<_Projected3D?>> projected, GraphLayerPalette hierarchy) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = compact ? 0.72 : 1.04
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = hierarchy.surfaceEdgeColor;
    _drawProjectedPath(canvas, projected.first, paint);
    _drawProjectedPath(canvas, projected.last, paint);
    final left = <_Projected3D?>[];
    final right = <_Projected3D?>[];
    for (final row in projected) {
      left.add(row.first);
      right.add(row.last);
    }
    _drawProjectedPath(canvas, left, paint);
    _drawProjectedPath(canvas, right, paint);
  }

  void _drawProjectedPath(Canvas canvas, List<_Projected3D?> points, Paint paint) {
    var path = Path();
    var started = false;
    for (final point in points) {
      if (point == null) {
        if (started) {
          canvas.drawPath(path, paint);
          path = Path();
          started = false;
        }
        continue;
      }
      if (!started) {
        path.moveTo(point.offset.dx, point.offset.dy);
        started = true;
      } else {
        path.lineTo(point.offset.dx, point.offset.dy);
      }
    }
    if (started) canvas.drawPath(path, paint);
  }

  void _drawLabels(Canvas canvas, Rect rect) {
    _drawText(canvas, _usesYVariable ? '3D Surface' : '3D Ribbon', rect.topLeft + const Offset(10, 9), GraphStyle.text.withValues(alpha: 0.88), 10.8);
    _drawText(canvas, expression.displayExpressionFor(GraphRenderMode.threeD), rect.bottomRight - const Offset(126, 21), GraphStyle.textSecondary.withValues(alpha: 0.70), 10.0);
  }

  void _drawUnavailable(Canvas canvas, Rect rect) {
    final hierarchy = GraphLayerPalette.fromCurveColor(expression.graphColor, compact: compact);
    _drawFloorGrid(canvas, rect, hierarchy);
    _drawAxes(canvas, rect, hierarchy);
    if (!compact) {
      _drawText(canvas, '3D örnek üretilemedi', rect.center - const Offset(62, 8), GraphStyle.textSecondary, 11.0);
    }
  }

  void _drawText(Canvas canvas, String text, Offset offset, Color color, double size) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: TextStyle(color: color, fontSize: size, fontWeight: FontWeight.w800)),
      textDirection: TextDirection.ltr,
      maxLines: 1,
      ellipsis: '…',
    )..layout(maxWidth: 160);
    painter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant GraphSurface3DPainter oldDelegate) {
    return oldDelegate.expression != expression || oldDelegate.compact != compact;
  }
}

@immutable
class _Graph3DSample {
  const _Graph3DSample(this.z, {required this.xT, required this.yT, this.zNormalized = 0.5});

  final double z;
  final double xT;
  final double yT;
  final double zNormalized;

  _Graph3DSample copyWith({double? zNormalized}) => _Graph3DSample(z, xT: xT, yT: yT, zNormalized: zNormalized ?? this.zNormalized);
}

@immutable
class _Projected3D {
  const _Projected3D(this.offset, this.zNormalized, this.depth);

  final Offset offset;
  final double zNormalized;
  final double depth;
}

@immutable
class _SurfaceQuad {
  const _SurfaceQuad(this.points);

  final List<_Projected3D> points;

  double get meanZ => points.fold<double>(0, (sum, point) => sum + point.zNormalized) / points.length;

  double get depth => points.fold<double>(0, (sum, point) => sum + point.depth) / points.length;
}
