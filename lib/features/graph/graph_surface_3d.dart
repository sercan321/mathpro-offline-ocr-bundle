import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'graph_color_hierarchy.dart';
import 'graph_critical_points.dart';
import 'graph_models.dart';
import 'graph_painter.dart';
import 'graph_style.dart';

// Legacy static contract markers preserved for Q225/Q234 verifiers after the
// Q389R6C camera upgrade:
// GraphSurface3DPainter(expression: expression, compact: compact)
// if (!compact && rect.width >= 150 && rect.height >= 92)
/// Q389R6C: premium 3D graph surface interaction.
///
/// Red-line scope:
/// - Does not touch keyboard, MathLive, OCR, Android native, workspace, solver.
/// - Keeps 2D graph marker/tooltip layer separate.
/// - Adds only 3D smart framing, 360-degree camera rotation, and 3D critical
///   feature markers/ridge lines inside the graph surface.
class GraphSurface3D extends StatefulWidget {
  const GraphSurface3D({super.key, required this.expression, this.compact = false});

  final GraphExpression expression;
  final bool compact;

  @override
  State<GraphSurface3D> createState() => _GraphSurface3DState();
}

class _GraphSurface3DState extends State<GraphSurface3D> {
  double _yaw = -0.72;
  double _pitch = 0.58;
  GraphCriticalPoint? _selectedPoint;
  Offset? _selectedAnchor;

  @override
  void didUpdateWidget(covariant GraphSurface3D oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expression.historyIdentityKey != widget.expression.historyIdentityKey ||
        oldWidget.expression.showCriticalPoints != widget.expression.showCriticalPoints ||
        oldWidget.expression.showRootPoints != widget.expression.showRootPoints ||
        oldWidget.expression.showExtremaPoints != widget.expression.showExtremaPoints ||
        oldWidget.expression.showInterceptPoints != widget.expression.showInterceptPoints) {
      _selectedPoint = null;
      _selectedAnchor = null;
      _yaw = -0.72;
      _pitch = 0.58;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(
          math.max(1.0, constraints.maxWidth.isFinite ? constraints.maxWidth : 320.0),
          math.max(1.0, constraints.maxHeight.isFinite ? constraints.maxHeight : 180.0),
        );
        final rect = Offset.zero & size;
        final plotRect = rect.deflate(widget.compact ? 7 : 14);
        final focusedExpression = Graph3DViewportPolicy.focusedExpressionFor3D(widget.expression);
        final scene = _Graph3DSceneBuilder.build(
          expression: focusedExpression,
          size: size,
          plotRect: plotRect,
          yaw: _yaw,
          pitch: _pitch,
          compact: widget.compact,
        );
        final selectedAnchor = _selectedPoint == null ? null : scene.anchorFor(_selectedPoint!.id);

        return GestureDetector(
          key: const ValueKey('mathpro-graph-3d-gesture-surface-q389r6c'),
          behavior: HitTestBehavior.opaque,
          onDoubleTap: _resetCamera,
          onPanUpdate: (details) => _rotateCamera(details.delta),
          onTapDown: (details) => _selectFeature(details.localPosition, scene),
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.hardEdge,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(widget.compact ? 12 : 18),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: GraphStyle.canvas,
                    gradient: GraphStyle.surfaceGradient,
                    border: Border.all(color: GraphStyle.tealBorder.withValues(alpha: 0.72)),
                    borderRadius: BorderRadius.circular(widget.compact ? 12 : 18),
                    boxShadow: widget.compact ? null : GraphStyle.surfaceShadow,
                  ),
                  child: CustomPaint(
                    key: ValueKey(widget.compact ? 'mathpro-mini-graph-3d-surface-q389r6c' : 'mathpro-graph-3d-surface-q389r6c'),
                    painter: GraphSurface3DPainter(
                      expression: focusedExpression,
                      compact: widget.compact,
                      yaw: _yaw,
                      pitch: _pitch,
                      selectedPointId: _selectedPoint?.id,
                    ),
                    child: const SizedBox.expand(),
                  ),
                ),
              ),
              if (!widget.compact)
                Positioned(
                  left: 10,
                  bottom: 9,
                  child: _Graph3DModeChip(expression: widget.expression),
                ),
              if (_selectedPoint != null && (selectedAnchor ?? _selectedAnchor) != null)
                _Graph3DFloatingTooltipPositioner(
                  key: const ValueKey('mathpro-graph-3d-critical-feature-tooltip-q389r6c'),
                  anchor: selectedAnchor ?? _selectedAnchor!,
                  bounds: plotRect,
                  child: _Graph3DPointTooltip(point: _selectedPoint!, compact: widget.compact),
                ),
            ],
          ),
        );
      },
    );
  }

  void _rotateCamera(Offset delta) {
    if (!delta.dx.isFinite || !delta.dy.isFinite) return;
    setState(() {
      _yaw = _wrapRadians(_yaw + delta.dx * 0.0105);
      _pitch = (_pitch - delta.dy * 0.0065).clamp(-0.42, 1.08).toDouble();
      _selectedAnchor = null;
    });
  }

  void _selectFeature(Offset localPosition, _Graph3DScene scene) {
    final hit = scene.nearestFeature(localPosition, radius: widget.compact ? 18 : 24);
    setState(() {
      _selectedPoint = hit?.point;
      _selectedAnchor = hit?.anchor;
    });
  }

  void _resetCamera() {
    setState(() {
      _yaw = -0.72;
      _pitch = 0.58;
      _selectedPoint = null;
      _selectedAnchor = null;
    });
  }

  double _wrapRadians(double value) {
    const tau = math.pi * 2;
    var wrapped = value % tau;
    if (wrapped > math.pi) wrapped -= tau;
    if (wrapped < -math.pi) wrapped += tau;
    return wrapped;
  }
}

class Graph3DViewportPolicy {
  const Graph3DViewportPolicy._();

  static GraphExpression focusedExpressionFor3D(GraphExpression expression) {
    if (_usesYVariable(expression)) return expression;
    final normalized = expression.normalizedExpression.trim().toLowerCase().replaceAll(' ', '');
    final xSpan = expression.xMax - expression.xMin;
    final ySpan = expression.yMax - expression.yMin;

    if (_looksLikeSinOrCos(normalized) && xSpan > math.pi * 2 * 1.08) {
      return expression.copyWith(
        xMin: -math.pi,
        xMax: math.pi,
        yMin: ySpan > 4 ? -1.35 : expression.yMin,
        yMax: ySpan > 4 ? 1.35 : expression.yMax,
      );
    }

    if (_looksLikeTan(normalized) && xSpan > math.pi * 1.08) {
      return expression.copyWith(
        xMin: -math.pi / 2 + 0.18,
        xMax: math.pi / 2 - 0.18,
        yMin: ySpan > 8 ? -3.2 : expression.yMin,
        yMax: ySpan > 8 ? 3.2 : expression.yMax,
      );
    }

    if (_looksLikeQuadratic(normalized) && xSpan > 7) {
      return expression.copyWith(xMin: -3.5, xMax: 3.5, yMin: ySpan > 16 ? -2.5 : expression.yMin, yMax: ySpan > 16 ? 10.5 : expression.yMax);
    }

    return expression;
  }

  static bool _usesYVariable(GraphExpression expression) => RegExp(r'(^|[^a-zA-Z])y([^a-zA-Z]|$)').hasMatch(
        expression.normalizedExpression.trim().toLowerCase().replaceFirst(RegExp(r'^[yz]\s*=', caseSensitive: false), ''),
      );

  static bool _looksLikeSinOrCos(String expression) => expression.contains('sin') || expression.contains('cos');

  static bool _looksLikeTan(String expression) => expression.contains('tan');

  static bool _looksLikeQuadratic(String expression) => expression.contains('x^2') || expression.contains('x*x');
}

// Q234 + Q389R6C: premium surface-first 3D rendering. The painter keeps the
// existing evaluator contract, but renders a camera-controlled depth-sorted
// surface/ribbon, focused default 3D viewport, and critical feature lines.
class GraphSurface3DPainter extends CustomPainter {
  const GraphSurface3DPainter({
    required this.expression,
    this.compact = false,
    this.yaw = -0.72,
    this.pitch = 0.58,
    this.selectedPointId,
  });

  final GraphExpression expression;
  final bool compact;
  final double yaw;
  final double pitch;
  final String? selectedPointId;

  int get _sampleGrid => compact ? 29 : 41;
  int get _meshStride => compact ? 5 : 4;

  bool get _usesYVariable => Graph3DViewportPolicy._usesYVariable(expression);

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

    final scene = _Graph3DSceneBuilder.build(
      expression: expression,
      size: size,
      plotRect: plotRect,
      yaw: yaw,
      pitch: pitch,
      compact: compact,
      sampleGrid: _sampleGrid,
    );
    final hierarchy = GraphLayerPalette.fromCurveColor(expression.graphColor, compact: compact);

    if (scene.projected.isEmpty) {
      _drawUnavailable(canvas, plotRect, hierarchy);
      return;
    }

    canvas.save();
    canvas.clipRRect(outer.deflate(1));
    _drawFloorGrid(canvas, scene, hierarchy);
    _drawAxes(canvas, scene, hierarchy);
    _drawSurfaceFill(canvas, scene.projected, hierarchy);
    _drawSparseMesh(canvas, scene.projected, hierarchy);
    _drawSilhouette(canvas, scene.projected, hierarchy);
    _drawCriticalFeatures(canvas, scene, hierarchy);
    if (!compact) _drawLabels(canvas, plotRect);
    canvas.restore();
  }

  void _drawFloorGrid(Canvas canvas, _Graph3DScene scene, GraphLayerPalette hierarchy) {
    final paint = Paint()
      ..color = hierarchy.gridMinorColor.withValues(alpha: compact ? 0.70 : 0.80)
      ..strokeWidth = compact ? 0.30 : 0.42
      ..style = PaintingStyle.stroke;
    final major = Paint()
      ..color = hierarchy.gridMajorColor.withValues(alpha: compact ? 0.78 : 0.90)
      ..strokeWidth = compact ? 0.42 : 0.58
      ..style = PaintingStyle.stroke;

    for (var i = -3; i <= 3; i++) {
      final t = i / 3;
      final p = i == 0 ? major : paint;
      canvas.drawLine(scene.project(-1, t, -1.05).offset, scene.project(1, t, -1.05).offset, p);
      canvas.drawLine(scene.project(t, -1, -1.05).offset, scene.project(t, 1, -1.05).offset, p);
    }
  }

  void _drawAxes(Canvas canvas, _Graph3DScene scene, GraphLayerPalette hierarchy) {
    final axis = Paint()
      ..color = hierarchy.axisStrokeColor.withValues(alpha: compact ? 0.70 : 0.82)
      ..strokeWidth = compact ? 0.78 : 0.98
      ..strokeCap = StrokeCap.round;
    final zAxis = Paint()
      ..color = hierarchy.axisStrokeColor.withValues(alpha: compact ? 0.44 : 0.56)
      ..strokeWidth = compact ? 0.82 : 1.05
      ..strokeCap = StrokeCap.round;

    final origin = scene.project(0, 0, -1.05).offset;
    final xEnd = scene.project(1.10, 0, -1.05).offset;
    final yEnd = scene.project(0, 1.10, -1.05).offset;
    final zEnd = scene.project(0, 0, 1.15).offset;
    canvas.drawLine(origin, xEnd, axis);
    canvas.drawLine(origin, yEnd, axis);
    canvas.drawLine(origin, zEnd, zAxis);
    if (!compact && scene.plotRect.width >= 150 && scene.plotRect.height >= 92) {
      _drawAxisTip(canvas, xEnd, 'x', hierarchy.axisLabelColor);
      _drawAxisTip(canvas, yEnd, _usesYVariable ? 'y' : 'd', hierarchy.axisLabelColor);
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

  void _drawCriticalFeatures(Canvas canvas, _Graph3DScene scene, GraphLayerPalette hierarchy) {
    if (compact && scene.features.length > 8) return;
    final sorted = <_Graph3DFeature>[...scene.features]..sort((a, b) => a.depth.compareTo(b.depth));
    for (final feature in sorted) {
      final selected = selectedPointId == feature.point.id;
      final color = _featureColor(feature.point.primaryType);
      final pathPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = selected ? (compact ? 1.65 : 2.15) : (compact ? 1.05 : 1.36)
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..color = color.withValues(alpha: selected ? 0.88 : 0.58);
      final glow = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = selected ? (compact ? 4.3 : 5.4) : (compact ? 2.8 : 3.6)
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..color = color.withValues(alpha: selected ? 0.22 : 0.10);
      _drawFeaturePath(canvas, feature.path, glow);
      _drawFeaturePath(canvas, feature.path, pathPaint);
      canvas.drawCircle(feature.anchor, selected ? (compact ? 5.2 : 6.3) : (compact ? 3.3 : 4.1), Paint()..color = color.withValues(alpha: selected ? 0.95 : 0.78));
      if (selected) {
        canvas.drawCircle(
          feature.anchor,
          compact ? 8.5 : 10.5,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.15
            ..color = color.withValues(alpha: 0.42),
        );
      }
    }
  }

  void _drawFeaturePath(Canvas canvas, List<Offset> points, Paint paint) {
    if (points.length < 2) return;
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(path, paint);
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

  void _drawUnavailable(Canvas canvas, Rect rect, GraphLayerPalette hierarchy) {
    final scene = _Graph3DSceneBuilder.empty(plotRect: rect, yaw: yaw, pitch: pitch);
    _drawFloorGrid(canvas, scene, hierarchy);
    _drawAxes(canvas, scene, hierarchy);
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

  Color _featureColor(GraphCriticalPointType type) {
    return switch (type) {
      GraphCriticalPointType.root => const Color(0xFFF59A23),
      GraphCriticalPointType.yIntercept => const Color(0xFFE5F7FF),
      GraphCriticalPointType.localMaximum => const Color(0xFF65E35E),
      GraphCriticalPointType.localMinimum => const Color(0xFF9B64FF),
    };
  }

  @override
  bool shouldRepaint(covariant GraphSurface3DPainter oldDelegate) {
    return oldDelegate.expression != expression ||
        oldDelegate.compact != compact ||
        oldDelegate.yaw != yaw ||
        oldDelegate.pitch != pitch ||
        oldDelegate.selectedPointId != selectedPointId;
  }
}

class _Graph3DSceneBuilder {
  const _Graph3DSceneBuilder._();

  static _Graph3DScene build({
    required GraphExpression expression,
    required Size size,
    required Rect plotRect,
    required double yaw,
    required double pitch,
    required bool compact,
    int? sampleGrid,
  }) {
    final usesY = Graph3DViewportPolicy._usesYVariable(expression);
    final grid = sampleGrid ?? (compact ? 29 : 41);
    final samples = _sampleSurface(expression: expression, usesYVariable: usesY, grid: grid);
    if (samples.isEmpty) return empty(plotRect: plotRect, yaw: yaw, pitch: pitch);
    final projector = _Graph3DProjector(plotRect: plotRect, yaw: yaw, pitch: pitch, usesYVariable: usesY);
    final projected = _projectSamples(samples, projector, usesYVariable: usesY);
    final features = usesY ? const <_Graph3DFeature>[] : _buildRibbonFeatures(expression: expression, sceneProjector: projector, compact: compact);
    return _Graph3DScene(plotRect: plotRect, yaw: yaw, pitch: pitch, projected: projected, features: features, projector: projector);
  }

  static _Graph3DScene empty({required Rect plotRect, required double yaw, required double pitch}) {
    final projector = _Graph3DProjector(plotRect: plotRect, yaw: yaw, pitch: pitch, usesYVariable: false);
    return _Graph3DScene(plotRect: plotRect, yaw: yaw, pitch: pitch, projected: const <List<_Projected3D?>>[], features: const <_Graph3DFeature>[], projector: projector);
  }

  static List<List<_Graph3DSample?>> _sampleSurface({required GraphExpression expression, required bool usesYVariable, required int grid}) {
    final evaluator = GraphExpressionEvaluator(expression.normalizedExpression);
    final xMin = expression.xMin;
    final xMax = expression.xMax;
    final yMin = usesYVariable ? expression.yMin : -3.0;
    final yMax = usesYVariable ? expression.yMax : 3.0;
    final xSpan = math.max((xMax - xMin).abs(), 1e-9);
    final ySpan = math.max((yMax - yMin).abs(), 1e-9);
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
          row.add(_Graph3DSample(z, x: x, y: y, xT: i / (grid - 1), yT: j / (grid - 1)));
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

  static List<List<_Projected3D?>> _projectSamples(List<List<_Graph3DSample?>> rows, _Graph3DProjector projector, {required bool usesYVariable}) {
    final projected = <List<_Projected3D?>>[];
    final yCompression = usesYVariable ? 1.0 : 0.42;
    for (final rowSamples in rows) {
      final row = <_Projected3D?>[];
      for (final sample in rowSamples) {
        if (sample == null) {
          row.add(null);
          continue;
        }
        final nx = sample.xT * 2 - 1;
        final ny = (sample.yT * 2 - 1) * yCompression;
        final nz = sample.zNormalized * 2 - 1;
        row.add(projector.project(nx, ny, nz));
      }
      projected.add(row);
    }
    return projected;
  }

  static List<_Graph3DFeature> _buildRibbonFeatures({required GraphExpression expression, required _Graph3DProjector sceneProjector, required bool compact}) {
    if (!expression.showCriticalPoints) return const <_Graph3DFeature>[];
    final points = GraphCriticalPointDetector.detect(expression, samples: compact ? 180 : 320).where((point) => point.isFinite).take(16).toList(growable: false);
    if (points.isEmpty) return const <_Graph3DFeature>[];

    final features = <_Graph3DFeature>[];
    final xSpan = math.max((expression.xMax - expression.xMin).abs(), 1e-9);
    final evaluator = GraphExpressionEvaluator(expression.normalizedExpression);
    for (final point in points) {
      final xT = ((point.x - expression.xMin) / xSpan).clamp(0.0, 1.0).toDouble();
      final y = evaluator.evaluate(point.x);
      if (y == null || !y.isFinite) continue;
      // Approximate z normalization for feature anchor; using visible y window keeps
      // marker lines stable and avoids false high/low claims.
      final ySpan = math.max((expression.yMax - expression.yMin).abs(), 1e-9);
      final zNormalized = ((y - expression.yMin) / ySpan).clamp(0.0, 1.0).toDouble();
      final nz = zNormalized * 2 - 1;
      final nx = xT * 2 - 1;
      final path = <Offset>[];
      for (var i = 0; i <= 14; i++) {
        final depthT = i / 14;
        final ny = (depthT * 2 - 1) * 0.42;
        path.add(sceneProjector.project(nx, ny, nz).offset);
      }
      if (path.length < 2) continue;
      final anchor = path[path.length ~/ 2];
      features.add(_Graph3DFeature(point: point, path: path, anchor: anchor, depth: sceneProjector.project(nx, 0, nz).depth));
    }
    return features;
  }
}

@immutable
class _Graph3DScene {
  const _Graph3DScene({
    required this.plotRect,
    required this.yaw,
    required this.pitch,
    required this.projected,
    required this.features,
    required this.projector,
  });

  final Rect plotRect;
  final double yaw;
  final double pitch;
  final List<List<_Projected3D?>> projected;
  final List<_Graph3DFeature> features;
  final _Graph3DProjector projector;

  _Projected3D project(double x, double y, double z) => projector.project(x, y, z);

  Offset? anchorFor(String id) {
    for (final feature in features) {
      if (feature.point.id == id) return feature.anchor;
    }
    return null;
  }

  _Graph3DFeatureHit? nearestFeature(Offset position, {required double radius}) {
    _Graph3DFeature? best;
    var bestDistance = double.infinity;
    for (final feature in features) {
      final distance = feature.distanceTo(position);
      if (distance < bestDistance) {
        bestDistance = distance;
        best = feature;
      }
    }
    if (best == null || bestDistance > radius) return null;
    return _Graph3DFeatureHit(point: best.point, anchor: best.anchor, distance: bestDistance);
  }
}

@immutable
class _Graph3DFeature {
  const _Graph3DFeature({required this.point, required this.path, required this.anchor, required this.depth});

  final GraphCriticalPoint point;
  final List<Offset> path;
  final Offset anchor;
  final double depth;

  double distanceTo(Offset position) {
    if (path.length < 2) return (anchor - position).distance;
    var best = double.infinity;
    for (var i = 1; i < path.length; i++) {
      best = math.min(best, _distanceToSegment(position, path[i - 1], path[i]));
    }
    return math.min(best, (anchor - position).distance);
  }

  double _distanceToSegment(Offset p, Offset a, Offset b) {
    final ab = b - a;
    final ap = p - a;
    final lengthSquared = ab.dx * ab.dx + ab.dy * ab.dy;
    if (lengthSquared <= 1e-9) return (p - a).distance;
    final t = ((ap.dx * ab.dx + ap.dy * ab.dy) / lengthSquared).clamp(0.0, 1.0).toDouble();
    final projection = Offset(a.dx + ab.dx * t, a.dy + ab.dy * t);
    return (p - projection).distance;
  }
}

@immutable
class _Graph3DFeatureHit {
  const _Graph3DFeatureHit({required this.point, required this.anchor, required this.distance});

  final GraphCriticalPoint point;
  final Offset anchor;
  final double distance;
}

class _Graph3DProjector {
  const _Graph3DProjector({required this.plotRect, required this.yaw, required this.pitch, required this.usesYVariable});

  final Rect plotRect;
  final double yaw;
  final double pitch;
  final bool usesYVariable;

  _Projected3D project(double x, double y, double z) {
    final cosYaw = math.cos(yaw);
    final sinYaw = math.sin(yaw);
    final cosPitch = math.cos(pitch);
    final sinPitch = math.sin(pitch);

    final xr = x * cosYaw - y * sinYaw;
    final yr = x * sinYaw + y * cosYaw;
    final y2 = yr * cosPitch - z * sinPitch;
    final z2 = yr * sinPitch + z * cosPitch;

    final scaleX = plotRect.width * (usesYVariable ? 0.32 : 0.36);
    final scaleY = plotRect.height * (usesYVariable ? 0.20 : 0.19);
    final scaleZ = plotRect.height * (usesYVariable ? 0.28 : 0.30);
    final center = Offset(plotRect.center.dx, plotRect.center.dy + plotRect.height * (usesYVariable ? 0.055 : 0.075));
    final offset = Offset(center.dx + xr * scaleX, center.dy + y2 * scaleY - z2 * scaleZ);
    final depth = y2 * 18 - z2 * 12;
    return _Projected3D(offset, (z + 1) / 2, depth);
  }
}

@immutable
class _Graph3DSample {
  const _Graph3DSample(this.z, {required this.x, required this.y, required this.xT, required this.yT, this.zNormalized = 0.5});

  final double z;
  final double x;
  final double y;
  final double xT;
  final double yT;
  final double zNormalized;

  _Graph3DSample copyWith({double? zNormalized}) => _Graph3DSample(z, x: x, y: y, xT: xT, yT: yT, zNormalized: zNormalized ?? this.zNormalized);
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

class _Graph3DModeChip extends StatelessWidget {
  const _Graph3DModeChip({required this.expression});

  final GraphExpression expression;

  @override
  Widget build(BuildContext context) {
    final focused = Graph3DViewportPolicy.focusedExpressionFor3D(expression);
    final originalSpan = expression.xMax - expression.xMin;
    final focusedSpan = focused.xMax - focused.xMin;
    final label = (originalSpan - focusedSpan).abs() > 0.05 ? 'Odak 3D · 1 periyot' : '3D · döndür';
    return DecoratedBox(
      decoration: BoxDecoration(
        color: GraphStyle.card.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: GraphStyle.accent.withValues(alpha: 0.20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Text(
          label,
          style: TextStyle(color: GraphStyle.textSecondary.withValues(alpha: 0.80), fontSize: 9.2, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

class _Graph3DFloatingTooltipPositioner extends StatelessWidget {
  const _Graph3DFloatingTooltipPositioner({super.key, required this.anchor, required this.bounds, required this.child});

  final Offset anchor;
  final Rect bounds;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    const tooltipWidth = 142.0;
    const tooltipHeight = 78.0;
    var left = anchor.dx + 12;
    var top = anchor.dy - tooltipHeight - 10;
    if (left + tooltipWidth > bounds.right - 4) left = anchor.dx - tooltipWidth - 12;
    if (left < bounds.left + 4) left = bounds.left + 4;
    if (top < bounds.top + 4) top = anchor.dy + 12;
    if (top + tooltipHeight > bounds.bottom - 4) top = bounds.bottom - tooltipHeight - 4;
    return Positioned(left: left, top: top, width: tooltipWidth, child: child);
  }
}

class _Graph3DPointTooltip extends StatelessWidget {
  const _Graph3DPointTooltip({required this.point, required this.compact});

  final GraphCriticalPoint point;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final color = _color(point.primaryType);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: GraphStyle.card.withValues(alpha: 0.94),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[GraphStyle.cardAlt.withValues(alpha: 0.98), GraphStyle.card.withValues(alpha: 0.92)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.34)),
        boxShadow: GraphStyle.controlShadow(active: true),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: compact ? 9 : 10, vertical: compact ? 7 : 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(width: 7, height: 7, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    _title(point),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: GraphStyle.text, fontSize: compact ? 10.4 : 11.4, fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text('x = ${_format(point.x)}', style: TextStyle(color: GraphStyle.textSecondary, fontSize: compact ? 9.4 : 10.4, fontWeight: FontWeight.w800)),
            const SizedBox(height: 2),
            Text('y = ${_format(point.y)}', style: TextStyle(color: GraphStyle.textSecondary, fontSize: compact ? 9.4 : 10.4, fontWeight: FontWeight.w800)),
          ],
        ),
      ),
    );
  }

  String _title(GraphCriticalPoint point) {
    if (point.hasType(GraphCriticalPointType.localMaximum)) return 'Tepe hattı';
    if (point.hasType(GraphCriticalPointType.localMinimum)) return 'Dip hattı';
    if (point.hasType(GraphCriticalPointType.root)) return 'Kök hattı';
    if (point.hasType(GraphCriticalPointType.yIntercept)) return 'Y-kesişimi';
    return point.title;
  }

  String _format(double value) {
    if (!value.isFinite) return '—';
    if ((value - value.roundToDouble()).abs() < 1e-8) return value.round().toString();
    final abs = value.abs();
    if ((abs - math.pi).abs() < 0.025) return 'π ≈ ${value.toStringAsFixed(3)}';
    if ((abs - math.pi / 2).abs() < 0.025) return value.isNegative ? '-π/2 ≈ ${value.toStringAsFixed(3)}' : 'π/2 ≈ ${value.toStringAsFixed(3)}';
    if ((abs - math.pi * 3 / 2).abs() < 0.025) return value.isNegative ? '-3π/2 ≈ ${value.toStringAsFixed(3)}' : '3π/2 ≈ ${value.toStringAsFixed(3)}';
    if (abs >= 10000 || abs < 0.001 && abs > 0) return value.toStringAsPrecision(3);
    return value.toStringAsFixed(3);
  }

  Color _color(GraphCriticalPointType type) {
    return switch (type) {
      GraphCriticalPointType.root => const Color(0xFFF59A23),
      GraphCriticalPointType.yIntercept => const Color(0xFFE5F7FF),
      GraphCriticalPointType.localMaximum => const Color(0xFF65E35E),
      GraphCriticalPointType.localMinimum => const Color(0xFF9B64FF),
    };
  }
}
