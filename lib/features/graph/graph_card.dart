import 'package:flutter/material.dart';

import 'graph_models.dart';
import 'graph_curve_painter.dart';
import 'graph_interaction_overlay.dart';
import 'graph_style.dart';
import 'graph_surface.dart';
import 'graph_surface_3d.dart';
import 'graph_trace_overlay.dart';

class GraphCard extends StatefulWidget {
  const GraphCard({
    super.key,
    required this.expression,
    required this.onClose,
    required this.onFullscreen,
    required this.onSettings,
    this.onTraceToggle,
    this.onReset,
    this.onZoomIn,
    this.onZoomOut,
    this.renderMode = GraphRenderMode.twoD,
    this.onRenderModeChanged,
  });

  final GraphExpression expression;
  final VoidCallback onClose;
  final VoidCallback onFullscreen;
  final VoidCallback onSettings;
  final VoidCallback? onTraceToggle;
  final VoidCallback? onReset;
  final VoidCallback? onZoomIn;
  final VoidCallback? onZoomOut;
  final GraphRenderMode renderMode;
  final ValueChanged<GraphRenderMode>? onRenderModeChanged;

  @override
  State<GraphCard> createState() => _GraphCardState();
}

class _GraphCardState extends State<GraphCard> with SingleTickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<Offset> _slide;
  String? _lastExpressionKey;

  @override
  void initState() {
    super.initState();
    _lastExpressionKey = _animationKey(widget.expression);
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
      reverseDuration: const Duration(milliseconds: 180),
    )..forward();
    final curved = CurvedAnimation(parent: _entranceController, curve: Curves.easeOutCubic, reverseCurve: Curves.easeInCubic);
    _fade = Tween<double>(begin: 0, end: 1).animate(curved);
    _scale = Tween<double>(begin: 0.965, end: 1).animate(curved);
    _slide = Tween<Offset>(begin: const Offset(0, 0.045), end: Offset.zero).animate(curved);
  }

  @override
  void didUpdateWidget(covariant GraphCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    final nextKey = _animationKey(widget.expression);
    if (nextKey != _lastExpressionKey) {
      _lastExpressionKey = nextKey;
      _entranceController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: ScaleTransition(
            scale: _scale,
            alignment: Alignment.topCenter,
            child: AnimatedContainer(
              key: const ValueKey('mathpro-premium-graph-card'),
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOutCubic,
              decoration: BoxDecoration(
                color: GraphStyle.card,
                gradient: GraphStyle.cardGradient,
                borderRadius: GraphStyle.cardRadius,
                border: Border.all(color: widget.expression.traceEnabled ? GraphStyle.accent.withValues(alpha: 0.36) : GraphStyle.graphiteLine),
                boxShadow: _premiumShadow(widget.expression.traceEnabled),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final cardHeight = constraints.maxHeight.isFinite ? constraints.maxHeight : 188.0;
                  final cardWidth = constraints.maxWidth.isFinite ? constraints.maxWidth : 360.0;
                  final pixelTight = cardHeight < 112 || cardWidth < 310;
                  final tight = pixelTight || cardHeight < 130;
                  final compact = tight || cardHeight < 158 || cardWidth < 350;
                  // Q225: canvas dominance pass.  The card must feel like a graph
                  // preview, not a control sheet, so chrome is intentionally thin.
                  final outerPadding = pixelTight ? 4.0 : tight ? 5.0 : compact ? 7.0 : 10.0;
                  final headerGap = pixelTight ? 2.0 : tight ? 3.0 : compact ? 4.0 : 5.0;
                  final infoGap = pixelTight ? 2.0 : tight ? 3.0 : compact ? 4.0 : 5.0;

                  return Padding(
                    padding: EdgeInsets.all(outerPadding),
                    child: Column(
                      children: <Widget>[
                        _GraphHeader(
                          expression: widget.expression,
                          renderMode: widget.renderMode,
                          compact: compact,
                          tight: tight,
                          onRenderModeChanged: widget.onRenderModeChanged,
                          onClose: widget.onClose,
                          onFullscreen: widget.onFullscreen,
                          onSettings: widget.onSettings,
                        ),
                        SizedBox(height: headerGap),
                        Expanded(
                          child: _GraphCanvasPreview(
                            expression: widget.expression,
                            renderMode: widget.renderMode,
                            compact: compact,
                            tight: tight,
                            pixelTight: pixelTight,
                            onZoomIn: widget.onZoomIn,
                            onZoomOut: widget.onZoomOut,
                          ),
                        ),
                        SizedBox(height: infoGap),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 180),
                          child: _GraphInfoRow(
                            key: ValueKey('value-${widget.renderMode.name}-${_surfaceKey(widget.expression)}'),
                            expression: widget.expression,
                            renderMode: widget.renderMode,
                            compact: compact,
                            tight: tight,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget _surfaceTransition(Widget child, Animation<double> animation) {
    final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic, reverseCurve: Curves.easeInCubic);
    return FadeTransition(
      opacity: curved,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.985, end: 1).animate(curved),
        child: child,
      ),
    );
  }

  static String _animationKey(GraphExpression expression) => expression.historyIdentityKey;

  static String _surfaceKey(GraphExpression expression) {
    return '${expression.historyIdentityKey}|${expression.xMin.toStringAsFixed(3)}|${expression.xMax.toStringAsFixed(3)}|${expression.yMin.toStringAsFixed(3)}|${expression.yMax.toStringAsFixed(3)}|${expression.traceEnabled}|${expression.showCriticalPoints}|${expression.showRootPoints}|${expression.showExtremaPoints}|${expression.showInterceptPoints}|${expression.graphColor.toARGB32()}';
  }

  static List<BoxShadow> _premiumShadow(bool traceEnabled) {
    return <BoxShadow>[
      ...GraphStyle.cardShadowFor(traceEnabled),
    ];
  }
}

class _GraphCanvasPreview extends StatelessWidget {
  const _GraphCanvasPreview({
    required this.expression,
    required this.renderMode,
    required this.compact,
    required this.tight,
    required this.pixelTight,
    required this.onZoomIn,
    required this.onZoomOut,
  });

  final GraphExpression expression;
  final GraphRenderMode renderMode;
  final bool compact;
  final bool tight;
  final bool pixelTight;
  final VoidCallback? onZoomIn;
  final VoidCallback? onZoomOut;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight.isFinite ? constraints.maxHeight : 120.0;
        final width = constraints.maxWidth.isFinite ? constraints.maxWidth : 320.0;
        final canvasPixelTight = pixelTight || height < 96 || width < 220;
        final canvasCompact = compact || canvasPixelTight || height < 128 || width < 270;
        final overlayAllowed = renderMode == GraphRenderMode.twoD && expression.traceEnabled && height >= 96 && width >= 200;
        final radius = canvasPixelTight ? 12.0 : tight ? 15.0 : compact ? 17.0 : 20.0;
        return ClipRRect(
          key: const ValueKey('mathpro-graph-canvas-preview'),
          borderRadius: BorderRadius.circular(radius),
          child: Stack(
            key: const ValueKey('mathpro-graph-canvas-fit-guard-q223'),
            fit: StackFit.expand,
            clipBehavior: Clip.hardEdge,
            children: <Widget>[
              Positioned.fill(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 260),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  transitionBuilder: _GraphCardState._surfaceTransition,
                  child: renderMode == GraphRenderMode.twoD
                      ? GraphInteractiveSurface(
                          key: ValueKey('graph-surface-2d-interactive-${_GraphCardState._surfaceKey(expression)}'),
                          expression: expression,
                          compact: canvasCompact,
                          pixelTight: canvasPixelTight,
                          child: GraphSurface(
                            key: ValueKey('graph-surface-2d-${_GraphCardState._surfaceKey(expression)}'),
                            expression: expression,
                            compact: canvasCompact,
                            pixelTight: canvasPixelTight,
                          ),
                        )
                      : GraphSurface3D(
                          key: ValueKey('graph-surface-3d-${_GraphCardState._surfaceKey(expression)}'),
                          expression: expression,
                          compact: canvasCompact || canvasPixelTight,
                        ),
                ),
              ),
              Positioned.fill(child: IgnorePointer(child: _GraphGlassSheen(traceEnabled: expression.traceEnabled))),
              Positioned(
                left: compact ? 8 : 12,
                top: compact ? 8 : 12,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  child: overlayAllowed
                      ? GraphTraceOverlay(
                          key: const ValueKey('mathpro-preview-trace-overlay'),
                          xLabel: '0.00',
                          yLabel: _GraphValueFormatter.valueAtOrigin(expression),
                        )
                      : const SizedBox.shrink(key: ValueKey('mathpro-preview-trace-hidden')),
                ),
              ),
              Positioned(
                right: canvasPixelTight ? 6 : compact ? 8 : 12,
                bottom: canvasPixelTight ? 6 : compact ? 8 : 12,
                child: _GraphFloatingZoomControls(
                  compact: compact,
                  pixelTight: canvasPixelTight,
                  onZoomIn: onZoomIn,
                  onZoomOut: onZoomOut,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GraphGlassSheen extends StatelessWidget {
  const _GraphGlassSheen({required this.traceEnabled});

  final bool traceEnabled;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Colors.white.withValues(alpha: traceEnabled ? 0.052 : 0.034),
            Colors.transparent,
            GraphStyle.accent.withValues(alpha: traceEnabled ? 0.050 : 0.022),
          ],
          stops: const <double>[0.0, 0.48, 1.0],
        ),
      ),
    );
  }
}

class _GraphHeader extends StatelessWidget {
  const _GraphHeader({
    required this.expression,
    required this.renderMode,
    required this.compact,
    required this.tight,
    required this.onClose,
    required this.onFullscreen,
    required this.onSettings,
    this.onRenderModeChanged,
  });

  final GraphExpression expression;
  final GraphRenderMode renderMode;
  final bool compact;
  final bool tight;
  final ValueChanged<GraphRenderMode>? onRenderModeChanged;
  final VoidCallback onClose;
  final VoidCallback onFullscreen;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    final iconSize = tight ? 24.0 : compact ? 26.0 : 28.0;
    return SizedBox(
      height: tight ? 25 : compact ? 27 : 30,
      child: Row(
        children: <Widget>[
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            width: iconSize,
            height: iconSize,
            decoration: BoxDecoration(
              color: GraphStyle.cardAlt,
              gradient: GraphStyle.controlGradient,
              borderRadius: BorderRadius.circular(tight ? 10 : 11),
              border: Border.all(color: expression.traceEnabled ? GraphStyle.accent.withValues(alpha: 0.48) : GraphStyle.graphiteLine),
              boxShadow: GraphStyle.controlShadow(active: expression.traceEnabled),
            ),
            child: Icon(Icons.show_chart_rounded, color: GraphStyle.accent, size: tight ? 14 : 16),
          ),
          SizedBox(width: tight ? 7 : 8),
          Text(
            'Grafik',
            style: TextStyle(
              color: GraphStyle.text,
              fontSize: tight ? 13.2 : 14.2,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.1,
            ),
          ),
          const Spacer(),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _GraphRenderModeToggle(
                    mode: renderMode,
                    compact: compact,
                    tight: tight,
                    onChanged: onRenderModeChanged ?? (_) {},
                  ),
                  SizedBox(width: tight ? 5 : 7),
                  _GraphIconButton(tooltip: 'Tam ekran', icon: Icons.open_in_full_rounded, compact: compact, tight: tight, onPressed: onFullscreen),
                  _GraphIconButton(tooltip: 'Ayarlar', icon: Icons.tune_rounded, compact: compact, tight: tight, onPressed: onSettings),
                  _GraphIconButton(tooltip: 'Kapat', icon: Icons.close_rounded, compact: compact, tight: tight, onPressed: onClose),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _GraphInfoRow extends StatelessWidget {
  const _GraphInfoRow({super.key, required this.expression, required this.renderMode, required this.compact, required this.tight});

  final GraphExpression expression;
  final GraphRenderMode renderMode;
  final bool compact;
  final bool tight;

  @override
  Widget build(BuildContext context) {
    final left = 'x  0.00    y  ${_GraphValueFormatter.valueAtOrigin(expression)}';
    final right = renderMode == GraphRenderMode.twoD ? _windowSummary2D(expression) : _windowSummary3D(expression);
    final height = tight ? 18.0 : compact ? 20.0 : 22.0;
    return SizedBox(
      key: const ValueKey('mathpro-graph-compact-info-row'),
      height: height,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: _InfoPill(
              key: const ValueKey('mathpro-graph-xy-readout'),
              text: left,
              compact: compact,
              alignLeft: true,
            ),
          ),
          SizedBox(width: tight ? 7 : 9),
          Expanded(
            flex: 11,
            child: _InfoPill(
              key: const ValueKey('mathpro-graph-window-summary'),
              text: right,
              compact: compact,
              alignLeft: false,
            ),
          ),
        ],
      ),
    );
  }

  static String _windowSummary2D(GraphExpression expression) {
    return 'x[${_GraphValueFormatter.format(expression.xMin)},${_GraphValueFormatter.format(expression.xMax)}]  y[${_GraphValueFormatter.format(expression.yMin)},${_GraphValueFormatter.format(expression.yMax)}]';
  }

  static String _windowSummary3D(GraphExpression expression) {
    return 'x[${_GraphValueFormatter.format(expression.xMin)},${_GraphValueFormatter.format(expression.xMax)}]  y[${_GraphValueFormatter.format(expression.yMin)},${_GraphValueFormatter.format(expression.yMax)}]';
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({super.key, required this.text, required this.compact, required this.alignLeft});

  final String text;
  final bool compact;
  final bool alignLeft;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: GraphStyle.cardAlt.withValues(alpha: 0.58),
        gradient: GraphStyle.controlGradient,
        borderRadius: BorderRadius.circular(compact ? 12 : 14),
        border: Border.all(color: GraphStyle.graphiteLine),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: compact ? 7 : 9, vertical: compact ? 2 : 3),
        child: Align(
          alignment: alignLeft ? Alignment.centerLeft : Alignment.centerRight,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: alignLeft ? Alignment.centerLeft : Alignment.centerRight,
            child: Text(
              text,
              maxLines: 1,
              style: TextStyle(
                color: GraphStyle.text.withValues(alpha: 0.92),
                fontSize: compact ? 9.6 : 10.2,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.05,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GraphFloatingZoomControls extends StatelessWidget {
  const _GraphFloatingZoomControls({required this.compact, required this.pixelTight, required this.onZoomIn, required this.onZoomOut});

  final bool compact;
  final bool pixelTight;
  final VoidCallback? onZoomIn;
  final VoidCallback? onZoomOut;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _FloatingZoomButton(
          key: const ValueKey('mathpro-graph-floating-zoom-out'),
          icon: Icons.remove_rounded,
          compact: compact,
          pixelTight: pixelTight,
          onTap: onZoomOut ?? () {},
        ),
        SizedBox(width: compact ? 6 : 8),
        _FloatingZoomButton(
          key: const ValueKey('mathpro-graph-floating-zoom-in'),
          icon: Icons.add_rounded,
          compact: compact,
          pixelTight: pixelTight,
          onTap: onZoomIn ?? () {},
        ),
      ],
    );
  }
}

class _FloatingZoomButton extends StatefulWidget {
  const _FloatingZoomButton({super.key, required this.icon, required this.compact, required this.pixelTight, required this.onTap});

  final IconData icon;
  final bool compact;
  final bool pixelTight;
  final VoidCallback onTap;

  @override
  State<_FloatingZoomButton> createState() => _FloatingZoomButtonState();
}

class _FloatingZoomButtonState extends State<_FloatingZoomButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final size = widget.pixelTight ? 26.0 : widget.compact ? 30.0 : 35.0;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 90),
        curve: Curves.easeOutCubic,
        scale: _pressed ? 0.90 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOutCubic,
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: GraphStyle.cardAlt.withValues(alpha: _pressed ? 0.88 : 0.70),
            gradient: _pressed ? null : GraphStyle.controlGradient,
            shape: BoxShape.circle,
            border: Border.all(color: _pressed ? GraphStyle.accent.withValues(alpha: 0.42) : GraphStyle.tealBorder.withValues(alpha: 0.58)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurRadius: _pressed ? 15 : 11,
                spreadRadius: -8,
                color: GraphStyle.accent.withValues(alpha: _pressed ? 0.24 : 0.15),
              ),
            ],
          ),
          child: Icon(widget.icon, color: GraphStyle.accent, size: widget.pixelTight ? 16 : widget.compact ? 18 : 21),
        ),
      ),
    );
  }
}

class _GraphRenderModeToggle extends StatelessWidget {
  const _GraphRenderModeToggle({required this.mode, required this.compact, required this.tight, required this.onChanged});

  final GraphRenderMode mode;
  final bool compact;
  final bool tight;
  final ValueChanged<GraphRenderMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Graph render mode 2D 3D selector',
      button: true,
      child: AnimatedContainer(
        key: const ValueKey('mathpro-graph-2d-3d-elite-toggle'),
        duration: const Duration(milliseconds: 170),
        curve: Curves.easeOutCubic,
        height: tight ? 24 : compact ? 26 : 30,
        width: tight ? 70 : compact ? 76 : 84,
        padding: EdgeInsets.all(tight ? 1.5 : 2.5),
        decoration: BoxDecoration(
          color: GraphStyle.cardAlt.withValues(alpha: 0.62),
          gradient: GraphStyle.controlGradient,
          borderRadius: BorderRadius.circular(tight ? 13 : 15),
          border: Border.all(color: GraphStyle.accent.withValues(alpha: 0.24)),
          boxShadow: GraphStyle.controlShadow(active: mode == GraphRenderMode.threeD),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: _GraphModeSegment(
                label: '2D',
                mode: GraphRenderMode.twoD,
                active: mode == GraphRenderMode.twoD,
                compact: compact,
                onTap: () => onChanged(GraphRenderMode.twoD),
              ),
            ),
            SizedBox(width: tight ? 2 : 3),
            Expanded(
              child: _GraphModeSegment(
                label: '3D',
                mode: GraphRenderMode.threeD,
                active: mode == GraphRenderMode.threeD,
                compact: compact,
                onTap: () => onChanged(GraphRenderMode.threeD),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GraphModeSegment extends StatefulWidget {
  const _GraphModeSegment({required this.label, required this.mode, required this.active, required this.compact, required this.onTap});

  final String label;
  final GraphRenderMode mode;
  final bool active;
  final bool compact;
  final VoidCallback onTap;

  @override
  State<_GraphModeSegment> createState() => _GraphModeSegmentState();
}

class _GraphModeSegmentState extends State<_GraphModeSegment> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.active;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 90),
        curve: Curves.easeOutCubic,
        scale: _pressed ? 0.94 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 170),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: active ? GraphStyle.accent.withValues(alpha: 0.17) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: active ? GraphStyle.accent.withValues(alpha: 0.42) : Colors.transparent),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (!widget.compact) ...<Widget>[
                  CustomPaint(
                    size: const Size(14, 14),
                    painter: _GraphModeIconPainter(mode: widget.mode, active: active),
                  ),
                  const SizedBox(width: 3),
                ],
                Text(
                  widget.label,
                  style: TextStyle(
                    color: active ? GraphStyle.text : GraphStyle.textSecondary,
                    fontSize: widget.compact ? 9.8 : 10.2,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GraphModeIconPainter extends CustomPainter {
  const _GraphModeIconPainter({required this.mode, required this.active});

  final GraphRenderMode mode;
  final bool active;

  @override
  void paint(Canvas canvas, Size size) {
    final color = active ? GraphStyle.accent : GraphStyle.textSecondary.withValues(alpha: 0.72);
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.45
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    if (mode == GraphRenderMode.twoD) {
      final axis = Path()
        ..moveTo(size.width * 0.16, size.height * 0.78)
        ..lineTo(size.width * 0.84, size.height * 0.78)
        ..moveTo(size.width * 0.20, size.height * 0.82)
        ..lineTo(size.width * 0.20, size.height * 0.18);
      canvas.drawPath(axis, paint..color = color.withValues(alpha: active ? 0.72 : 0.48));
      final curve = Path()
        ..moveTo(size.width * 0.18, size.height * 0.64)
        ..cubicTo(size.width * 0.36, size.height * 0.72, size.width * 0.42, size.height * 0.30, size.width * 0.62, size.height * 0.42)
        ..cubicTo(size.width * 0.72, size.height * 0.48, size.width * 0.78, size.height * 0.22, size.width * 0.88, size.height * 0.24);
      canvas.drawPath(curve, paint..color = color);
      return;
    }

    final front = Rect.fromLTWH(size.width * 0.20, size.height * 0.34, size.width * 0.42, size.height * 0.42);
    final dx = size.width * 0.18;
    final dy = -size.height * 0.16;
    final back = front.translate(dx, dy);
    canvas.drawRect(front, paint..color = color);
    canvas.drawRect(back, paint..color = color.withValues(alpha: active ? 0.74 : 0.52));
    for (final pair in <List<Offset>>[
      <Offset>[front.topLeft, back.topLeft],
      <Offset>[front.topRight, back.topRight],
      <Offset>[front.bottomLeft, back.bottomLeft],
      <Offset>[front.bottomRight, back.bottomRight],
    ]) {
      canvas.drawLine(pair[0], pair[1], paint..color = color.withValues(alpha: active ? 0.88 : 0.58));
    }
  }

  @override
  bool shouldRepaint(covariant _GraphModeIconPainter oldDelegate) {
    return oldDelegate.mode != mode || oldDelegate.active != active;
  }
}

class _GraphIconButton extends StatefulWidget {
  const _GraphIconButton({required this.tooltip, required this.icon, required this.compact, required this.tight, required this.onPressed});

  final String tooltip;
  final IconData icon;
  final bool compact;
  final bool tight;
  final VoidCallback onPressed;

  @override
  State<_GraphIconButton> createState() => _GraphIconButtonState();
}

class _GraphIconButtonState extends State<_GraphIconButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final size = widget.tight ? 24.0 : widget.compact ? 26.0 : 30.0;
    return Tooltip(
      message: widget.tooltip,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapCancel: () => setState(() => _pressed = false),
        onTapUp: (_) => setState(() => _pressed = false),
        onTap: widget.onPressed,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 90),
          curve: Curves.easeOutCubic,
          scale: _pressed ? 0.88 : 1,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 140),
            curve: Curves.easeOutCubic,
            width: size,
            height: size,
            margin: EdgeInsets.only(left: widget.tight ? 3 : 4),
            decoration: BoxDecoration(
              color: _pressed ? GraphStyle.accent.withValues(alpha: 0.13) : GraphStyle.cardAlt.withValues(alpha: 0.52),
              gradient: _pressed ? null : GraphStyle.controlGradient,
              borderRadius: BorderRadius.circular(widget.tight ? 12 : 14),
              border: Border.all(color: _pressed ? GraphStyle.accent.withValues(alpha: 0.34) : GraphStyle.graphiteLine),
            ),
            child: Icon(widget.icon, color: _pressed ? GraphStyle.accent : GraphStyle.textSecondary, size: widget.tight ? 14 : 16),
          ),
        ),
      ),
    );
  }
}

class _GraphValueFormatter {
  const _GraphValueFormatter._();

  static String valueAtOrigin(GraphExpression expression) {
    if (expression.type == GraphType.constant) return expression.normalizedExpression;
    final evaluator = GraphExpressionEvaluator(expression.normalizedExpression);
    final y = evaluator.evaluate(0);
    if (y == null || y.isNaN || y.isInfinite) return '—';
    return format(y);
  }

  static String format(double value) {
    if ((value - value.roundToDouble()).abs() < 1e-8) return value.round().toString();
    return value.toStringAsFixed(2);
  }
}
