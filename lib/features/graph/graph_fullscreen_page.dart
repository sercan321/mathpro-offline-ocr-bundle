import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'graph_models.dart';
import 'graph_interaction_overlay.dart';
import 'graph_painter.dart';
import 'graph_settings_sheet.dart';
import 'graph_style.dart';
import 'graph_surface.dart';
import 'graph_surface_3d.dart';
import 'graph_trace_overlay.dart';

class GraphFullscreenResult {
  const GraphFullscreenResult({required this.expression, required this.renderMode});

  final GraphExpression expression;
  final GraphRenderMode renderMode;
}

class GraphFullscreenPage extends StatefulWidget {
  const GraphFullscreenPage({super.key, required this.expression, this.initialRenderMode});

  final GraphExpression expression;
  final GraphRenderMode? initialRenderMode;

  @override
  State<GraphFullscreenPage> createState() => _GraphFullscreenPageState();
}

class _GraphFullscreenPageState extends State<GraphFullscreenPage> {
  late GraphExpression _expression;
  late GraphRenderMode _renderMode;
  GraphExpression? _gestureStartExpression;
  Size? _gestureSurfaceSize;
  Offset? _gestureStartFocal;
  Offset? _latestLocalFocal;
  bool _allowRoutePop = false;

  @override
  void initState() {
    super.initState();
    _expression = widget.expression;
    _renderMode = widget.initialRenderMode ?? widget.expression.preferredRenderMode;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope<GraphFullscreenResult>(
      canPop: _allowRoutePop,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _closeWithState();
      },
      child: Scaffold(
        backgroundColor: GraphStyle.appBackground,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
            child: Column(
              children: <Widget>[
                _FullscreenHeader(
                  expression: _expression,
                  renderMode: _renderMode,
                  onRenderModeChanged: _setRenderMode,
                  onBack: _closeWithState,
                  onSettings: _openSettings,
                  onTraceToggle: _toggleTrace,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: TweenAnimationBuilder<double>(
                    key: const ValueKey('mathpro-fullscreen-graph-motion'),
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 320),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.scale(
                          scale: 0.985 + value * 0.015,
                          alignment: Alignment.center,
                          child: child,
                        ),
                      );
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: GraphStyle.card,
                        gradient: GraphStyle.cardGradient,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: _expression.traceEnabled ? GraphStyle.accent.withValues(alpha: 0.36) : GraphStyle.graphiteLine),
                        boxShadow: GraphStyle.cardShadowFor(_expression.traceEnabled),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final surfaceSize = Size(
                              math.max(1.0, constraints.maxWidth),
                              math.max(1.0, constraints.maxHeight),
                            );
                            final surfaceStack = Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 180),
                                    switchInCurve: Curves.easeOutCubic,
                                    switchOutCurve: Curves.easeInCubic,
                                    child: _renderMode == GraphRenderMode.twoD
                                        ? GraphInteractiveSurface(
                                            key: ValueKey('fullscreen-graph-2d-interactive-${_surfaceKey(_expression)}'),
                                            expression: _expression,
                                            child: GraphSurface(
                                              key: ValueKey('fullscreen-graph-2d-${_surfaceKey(_expression)}'),
                                              expression: _expression,
                                            ),
                                          )
                                        : GraphSurface3D(
                                            key: ValueKey('fullscreen-graph-3d-${_surfaceKey(_expression)}'),
                                            expression: _expression,
                                          ),
                                  ),
                                ),
                                Positioned.fill(child: IgnorePointer(child: _FullscreenGlassSheen(traceEnabled: _expression.traceEnabled))),
                                Positioned(
                                  left: 14,
                                  top: 14,
                                  child: _ViewportChip(expression: _expression, renderMode: _renderMode),
                                ),
                                Positioned(
                                  right: 14,
                                  top: 14,
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 160),
                                    child: _renderMode == GraphRenderMode.twoD && _expression.traceEnabled
                                        ? GraphTraceOverlay(
                                            key: const ValueKey('mathpro-fullscreen-trace-overlay'),
                                            xLabel: _format(_traceX()),
                                            yLabel: _format(_traceY()),
                                          )
                                        : const SizedBox.shrink(key: ValueKey('mathpro-fullscreen-trace-hidden')),
                                  ),
                                ),
                                Positioned(
                                  left: 14,
                                  right: 14,
                                  bottom: 14,
                                  child: _GestureHint(traceEnabled: _expression.traceEnabled, renderMode: _renderMode),
                                ),
                              ],
                            );
                            if (_renderMode == GraphRenderMode.threeD) {
                              return surfaceStack;
                            }
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onDoubleTap: _reset,
                              onScaleStart: (details) => _onScaleStart(details, surfaceSize),
                              onScaleUpdate: (details) => _onScaleUpdate(details, surfaceSize),
                              onScaleEnd: (_) => _clearGestureState(),
                              child: surfaceStack,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _FullscreenActions(
                  traceEnabled: _expression.traceEnabled,
                  renderMode: _renderMode,
                  onTraceToggle: _toggleTrace,
                  onZoomIn: () => _zoomAroundCenter(0.72),
                  onZoomOut: () => _zoomAroundCenter(1.28),
                  onPanHint: _showPanHint,
                  onReset: _reset,
                  onSettings: _openSettings,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _surfaceKey(GraphExpression expression) {
    return '${_renderMode.name}|${expression.historyIdentityKey}|${expression.xMin.toStringAsFixed(3)}|${expression.xMax.toStringAsFixed(3)}|${expression.yMin.toStringAsFixed(3)}|${expression.yMax.toStringAsFixed(3)}|${expression.traceEnabled}|${expression.showCriticalPoints}|${expression.showRootPoints}|${expression.showExtremaPoints}|${expression.showInterceptPoints}|${expression.graphColor.toARGB32()}';
  }

  void _setRenderMode(GraphRenderMode mode) {
    if (_renderMode == mode) return;
    setState(() => _renderMode = mode);
  }

  void _closeWithState() {
    if (_allowRoutePop) return;
    setState(() => _allowRoutePop = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Navigator.of(context).pop(GraphFullscreenResult(expression: _expression, renderMode: _renderMode));
    });
  }

  void _openSettings() {
    showModalBottomSheet<GraphExpression>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => GraphSettingsSheet(
        expression: _expression,
        renderMode: _renderMode,
        onRenderModeChanged: _setRenderMode,
        onApply: (updated) => setState(() => _expression = _sanitizeViewport(updated)),
      ),
    );
  }

  void _toggleTrace() {
    if (_renderMode != GraphRenderMode.twoD) return;
    setState(() => _expression = _expression.copyWith(traceEnabled: !_expression.traceEnabled));
  }

  void _reset() {
    setState(() => _expression = _expression.resetViewport());
  }

  void _showPanHint() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pan zaten aktif: grafiği parmağınla sürükleyebilirsin.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _zoomAroundCenter(double factor) {
    setState(() {
      _expression = _zoomExpression(
        source: _expression,
        factor: factor,
        focalRatio: const Offset(0.5, 0.5),
      );
    });
  }

  void _onScaleStart(ScaleStartDetails details, Size surfaceSize) {
    _gestureStartExpression = _expression;
    _gestureSurfaceSize = surfaceSize;
    _gestureStartFocal = details.localFocalPoint;
    _latestLocalFocal = details.localFocalPoint;
  }

  void _onScaleUpdate(ScaleUpdateDetails details, Size surfaceSize) {
    final startExpression = _gestureStartExpression ?? _expression;
    final startSize = _gestureSurfaceSize ?? surfaceSize;
    final startFocal = _gestureStartFocal ?? details.localFocalPoint;
    _latestLocalFocal = details.localFocalPoint;

    var next = startExpression;
    if (details.scale.isFinite && (details.scale - 1).abs() > 0.008) {
      final focalRatio = _focalRatio(startFocal, startSize);
      next = _zoomExpression(
        source: startExpression,
        factor: 1 / details.scale.clamp(0.05, 20).toDouble(),
        focalRatio: focalRatio,
      );
    }

    if (details.focalPointDelta.distance > 0.01) {
      next = _panExpression(
        source: next,
        delta: details.focalPointDelta,
        surfaceSize: surfaceSize,
      );
    }

    setState(() => _expression = _sanitizeViewport(next));
  }

  void _clearGestureState() {
    _gestureStartExpression = null;
    _gestureSurfaceSize = null;
    _gestureStartFocal = null;
  }

  GraphExpression _zoomExpression({
    required GraphExpression source,
    required double factor,
    required Offset focalRatio,
  }) {
    final currentXRange = math.max(GraphViewportPolicy.minRange, source.xMax - source.xMin);
    final currentYRange = math.max(GraphViewportPolicy.minRange, source.yMax - source.yMin);
    final nextXRange = (currentXRange * factor).clamp(GraphViewportPolicy.minRange, GraphViewportPolicy.maxRange).toDouble();
    final nextYRange = (currentYRange * factor).clamp(GraphViewportPolicy.minRange, GraphViewportPolicy.maxRange).toDouble();

    final fx = focalRatio.dx.clamp(0.02, 0.98).toDouble();
    final fy = focalRatio.dy.clamp(0.02, 0.98).toDouble();
    final graphFocalX = source.xMin + currentXRange * fx;
    final graphFocalY = source.yMax - currentYRange * fy;

    return source.copyWith(
      xMin: graphFocalX - nextXRange * fx,
      xMax: graphFocalX + nextXRange * (1 - fx),
      yMin: graphFocalY - nextYRange * (1 - fy),
      yMax: graphFocalY + nextYRange * fy,
    );
  }

  GraphExpression _panExpression({
    required GraphExpression source,
    required Offset delta,
    required Size surfaceSize,
  }) {
    if (surfaceSize.width <= 0 || surfaceSize.height <= 0) return source;
    final dxRange = source.xMax - source.xMin;
    final dyRange = source.yMax - source.yMin;
    final dx = -delta.dx / surfaceSize.width * dxRange;
    final dy = delta.dy / surfaceSize.height * dyRange;
    return source.copyWith(
      xMin: source.xMin + dx,
      xMax: source.xMax + dx,
      yMin: source.yMin + dy,
      yMax: source.yMax + dy,
    );
  }

  GraphExpression _sanitizeViewport(GraphExpression source) {
    return GraphViewportPolicy.sanitize(source);
  }

  Offset _focalRatio(Offset focal, Size size) {
    return Offset(
      (focal.dx / math.max(1.0, size.width)).clamp(0.0, 1.0).toDouble(),
      (focal.dy / math.max(1.0, size.height)).clamp(0.0, 1.0).toDouble(),
    );
  }

  double _traceX() {
    final focal = _latestLocalFocal;
    final size = _gestureSurfaceSize;
    if (focal == null || size == null || size.width <= 0) {
      return math.min(math.max(0.0, _expression.xMin), _expression.xMax);
    }
    final ratio = (focal.dx / size.width).clamp(0.0, 1.0).toDouble();
    return _expression.xMin + (_expression.xMax - _expression.xMin) * ratio;
  }

  double _traceY() {
    final evaluator = GraphExpressionEvaluator(_expression.normalizedExpression);
    final y = evaluator.evaluate(_traceX());
    if (y == null || !y.isFinite) return double.nan;
    return y;
  }

  static String _format(double value) {
    if (!value.isFinite) return '—';
    if ((value - value.roundToDouble()).abs() < 1e-8) return value.round().toString();
    final abs = value.abs();
    if (abs >= 10000 || abs < 0.001 && abs > 0) return value.toStringAsPrecision(3);
    return value.toStringAsFixed(2);
  }
}

class _FullscreenGlassSheen extends StatelessWidget {
  const _FullscreenGlassSheen({required this.traceEnabled});

  final bool traceEnabled;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(-0.55, -0.70),
          radius: 1.15,
          colors: <Color>[
            Colors.white.withValues(alpha: traceEnabled ? 0.046 : 0.026),
            Colors.transparent,
            GraphStyle.accent.withValues(alpha: traceEnabled ? 0.034 : 0.012),
          ],
          stops: const <double>[0.0, 0.58, 1.0],
        ),
      ),
    );
  }
}

class _FullscreenHeader extends StatelessWidget {
  const _FullscreenHeader({
    required this.expression,
    required this.renderMode,
    required this.onRenderModeChanged,
    required this.onBack,
    required this.onSettings,
    required this.onTraceToggle,
  });

  final GraphExpression expression;
  final GraphRenderMode renderMode;
  final ValueChanged<GraphRenderMode> onRenderModeChanged;
  final VoidCallback onBack;
  final VoidCallback onSettings;
  final VoidCallback onTraceToggle;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: GraphStyle.card.withValues(alpha: 0.86),
        gradient: GraphStyle.cardGradient,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: GraphStyle.graphiteLine),
        boxShadow: GraphStyle.controlShadow(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          children: <Widget>[
            IconButton(
              tooltip: 'Geri',
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back_rounded, color: GraphStyle.text),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Tam Ekran Grafik',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: GraphStyle.textSecondary, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 0.2),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    expression.displayExpressionFor(renderMode),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: GraphStyle.text, fontSize: 16, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
            _FullscreenRenderModeToggle(mode: renderMode, onChanged: onRenderModeChanged),
            const SizedBox(width: 4),
            IconButton(
              tooltip: renderMode == GraphRenderMode.twoD ? (expression.traceEnabled ? 'Trace kapat' : 'Trace aç') : 'Trace sadece 2D modda',
              onPressed: renderMode == GraphRenderMode.twoD ? onTraceToggle : null,
              icon: Icon(
                expression.traceEnabled && renderMode == GraphRenderMode.twoD ? Icons.my_location_rounded : Icons.location_disabled_rounded,
                color: expression.traceEnabled && renderMode == GraphRenderMode.twoD ? GraphStyle.accent : GraphStyle.textSecondary,
              ),
            ),
            IconButton(
              tooltip: 'Ayarlar',
              onPressed: onSettings,
              icon: const Icon(Icons.tune_rounded, color: GraphStyle.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}


class _FullscreenRenderModeToggle extends StatelessWidget {
  const _FullscreenRenderModeToggle({required this.mode, required this.onChanged});

  final GraphRenderMode mode;
  final ValueChanged<GraphRenderMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Fullscreen graph render mode 2D 3D selector',
      button: true,
      child: DecoratedBox(
        key: const ValueKey('mathpro-fullscreen-graph-2d-3d-toggle'),
        decoration: BoxDecoration(
          color: GraphStyle.cardAlt.withValues(alpha: 0.70),
          gradient: GraphStyle.controlGradient,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: GraphStyle.accent.withValues(alpha: 0.24)),
          boxShadow: GraphStyle.controlShadow(active: mode == GraphRenderMode.threeD),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _FullscreenModeSegment(label: '2D', active: mode == GraphRenderMode.twoD, onTap: () => onChanged(GraphRenderMode.twoD)),
              const SizedBox(width: 3),
              _FullscreenModeSegment(label: '3D', active: mode == GraphRenderMode.threeD, onTap: () => onChanged(GraphRenderMode.threeD)),
            ],
          ),
        ),
      ),
    );
  }
}

class _FullscreenModeSegment extends StatelessWidget {
  const _FullscreenModeSegment({required this.label, required this.active, required this.onTap});

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutCubic,
        width: 34,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? GraphStyle.accent.withValues(alpha: 0.16) : Colors.transparent,
          borderRadius: BorderRadius.circular(11),
          border: Border.all(color: active ? GraphStyle.accent.withValues(alpha: 0.42) : Colors.transparent),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? GraphStyle.text : GraphStyle.textSecondary,
            fontSize: 10.5,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class _ViewportChip extends StatelessWidget {
  const _ViewportChip({required this.expression, required this.renderMode});

  final GraphExpression expression;
  final GraphRenderMode renderMode;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: GraphStyle.cardAlt.withValues(alpha: 0.78),
        gradient: GraphStyle.controlGradient,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: GraphStyle.graphiteLine),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: Text(
          renderMode == GraphRenderMode.twoD
              ? 'x: ${_short(expression.xMin)} … ${_short(expression.xMax)}   y: ${_short(expression.yMin)} … ${_short(expression.yMax)}'
              : _threeDLabel(expression),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: GraphStyle.axisLabel, fontSize: 11, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  static String _threeDLabel(GraphExpression expression) {
    final focused = Graph3DViewportPolicy.focusedExpressionFor3D(expression);
    final focusedSpan = focused.xMax - focused.xMin;
    final originalSpan = expression.xMax - expression.xMin;
    final prefix = (focusedSpan - originalSpan).abs() > 0.05 ? '3D odak' : '3D pencere';
    return '$prefix  x: ${_short(focused.xMin)} … ${_short(focused.xMax)}   y: ${_short(focused.yMin)} … ${_short(focused.yMax)}';
  }

  static String _short(double value) {
    if ((value - value.roundToDouble()).abs() < 1e-8) return value.round().toString();
    return value.toStringAsFixed(1);
  }
}

class _GestureHint extends StatelessWidget {
  const _GestureHint({required this.traceEnabled, required this.renderMode});

  final bool traceEnabled;
  final GraphRenderMode renderMode;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: GraphStyle.cardAlt.withValues(alpha: 0.70),
            gradient: GraphStyle.controlGradient,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: GraphStyle.graphiteLine),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            child: Text(
              renderMode == GraphRenderMode.threeD
                  ? '3D yüzey • Sürükle: 360° döndür • Noktaya dokun: bilgi • Çift dokun: reset'
                  : (traceEnabled ? 'Sürükle: pan • Çimdikle: zoom • Çift dokun: reset' : 'Sürükle: pan • Çimdikle: zoom'),
              textAlign: TextAlign.center,
              style: const TextStyle(color: GraphStyle.textSecondary, fontSize: 11, fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
    );
  }
}

class _FullscreenActions extends StatelessWidget {
  const _FullscreenActions({
    required this.traceEnabled,
    required this.renderMode,
    required this.onTraceToggle,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onPanHint,
    required this.onReset,
    required this.onSettings,
  });

  final bool traceEnabled;
  final GraphRenderMode renderMode;
  final VoidCallback onTraceToggle;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onPanHint;
  final VoidCallback onReset;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _FullscreenAction(label: renderMode == GraphRenderMode.twoD ? (traceEnabled ? 'Trace On' : 'Trace Off') : '3D Surface', icon: renderMode == GraphRenderMode.twoD ? Icons.my_location_rounded : Icons.view_in_ar_rounded, onTap: renderMode == GraphRenderMode.twoD ? onTraceToggle : () {}),
          _FullscreenAction(label: 'Zoom +', icon: Icons.add_rounded, onTap: onZoomIn),
          _FullscreenAction(label: 'Zoom −', icon: Icons.remove_rounded, onTap: onZoomOut),
          _FullscreenAction(label: 'Pan', icon: Icons.pan_tool_alt_rounded, onTap: onPanHint),
          _FullscreenAction(label: 'Reset', icon: Icons.refresh_rounded, onTap: onReset),
          _FullscreenAction(label: 'Ayarlar', icon: Icons.tune_rounded, onTap: onSettings),
        ],
      ),
    );
  }
}

class _FullscreenAction extends StatelessWidget {
  const _FullscreenAction({required this.label, required this.icon, required this.onTap});

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: GraphStyle.cardAlt.withValues(alpha: 0.74),
            gradient: GraphStyle.controlGradient,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: GraphStyle.graphiteLine),
            boxShadow: GraphStyle.controlShadow(),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
            child: Row(
              children: <Widget>[
                Icon(icon, size: 15, color: GraphStyle.accent),
                const SizedBox(width: 6),
                Text(label, style: const TextStyle(color: GraphStyle.accent, fontSize: 12, fontWeight: FontWeight.w900)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
