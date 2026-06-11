import 'package:flutter/material.dart';

import '../../theme/mathpro_tokens.dart';
import '../../theme/mathpro_typography.dart';
import '../editor/render/math_render_surface.dart';
import 'solution_step_models.dart';

class _SolutionPanelMotion {
  const _SolutionPanelMotion._();

  static const Duration panelSettle = Duration(milliseconds: 180);
  static const Duration contentSettle = Duration(milliseconds: 160);
  static const Duration controlFeedback = Duration(milliseconds: 120);
  static const Curve enterCurve = Curves.easeOutCubic;
}


class _SolutionStepsPalette {
  const _SolutionStepsPalette._();

  // V56 panel cohesion palette: aligned with GraphStyle and HistoryStyle so
  // graph/history/solution surfaces feel like one graphite-glass family.
  static const Color shellTop = Color(0xFF14181A);
  static const Color shellMid = Color(0xFF0D1012);
  static const Color shellBottom = Color(0xFF050607);
  static const Color hairline = Color(0xFF2A2E33);
  static const Color accent = Color(0xFF74BEB4);
}

class SolutionStepsPanel extends StatefulWidget {
  const SolutionStepsPanel({
    super.key,
    required this.snapshot,
    required this.panelState,
    required this.onClose,
    required this.onToggleExpanded,
  });

  final SolutionStepsSnapshot snapshot;
  final SolutionStepsPanelState panelState;
  final VoidCallback onClose;
  final VoidCallback onToggleExpanded;

  @override
  State<SolutionStepsPanel> createState() => _SolutionStepsPanelState();
}

class _SolutionStepsPanelState extends State<SolutionStepsPanel> {
  static const double _dragDistanceThreshold = 42;
  static const double _dragVelocityThreshold = 40;

  double _dragOffset = 0;
  bool _dragConsumed = false;

  void _resetDrag() {
    _dragOffset = 0;
    _dragConsumed = false;
  }

  void _commitDragDirection({required bool expand}) {
    if (_dragConsumed) return;
    if (expand && !widget.panelState.isExpanded) {
      _dragConsumed = true;
      widget.onToggleExpanded();
    } else if (!expand && widget.panelState.isExpanded) {
      _dragConsumed = true;
      widget.onToggleExpanded();
    }
  }

  void _handleVerticalDragUpdate(DragUpdateDetails details) {
    if (_dragConsumed) return;
    _dragOffset += details.delta.dy;
    if (_dragOffset <= -_dragDistanceThreshold) {
      _commitDragDirection(expand: true);
    } else if (_dragOffset >= _dragDistanceThreshold) {
      _commitDragDirection(expand: false);
    }
  }

  void _handleVerticalDragEnd(DragEndDetails details) {
    if (_dragConsumed) return;
    final velocity = details.primaryVelocity ?? 0;
    if (velocity <= -_dragVelocityThreshold) {
      _commitDragDirection(expand: true);
    } else if (velocity >= _dragVelocityThreshold) {
      _commitDragDirection(expand: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final expanded = widget.panelState.isExpanded;
    return GestureDetector(
      key: const ValueKey('mathpro-solution-panel-drag-surface'),
      behavior: HitTestBehavior.translucent,
      onVerticalDragStart: (_) => _resetDrag(),
      onVerticalDragUpdate: _handleVerticalDragUpdate,
      onVerticalDragEnd: _handleVerticalDragEnd,
      child: DecoratedBox(
        key: const ValueKey('mathpro-solution-steps-panel'),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              _SolutionStepsPalette.shellTop,
              _SolutionStepsPalette.shellMid,
              _SolutionStepsPalette.shellBottom,
            ],
            stops: <double>[0.0, 0.56, 1.0],
          ),
          border: Border.all(color: _SolutionStepsPalette.hairline, width: 0.9),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              blurRadius: 24,
              spreadRadius: -18,
              color: Color.fromRGBO(0, 0, 0, 0.88),
              offset: Offset(0, -12),
            ),
            BoxShadow(
              blurRadius: 14,
              spreadRadius: -14,
              color: Color.fromRGBO(116, 190, 180, 0.22),
              offset: Offset(0, -2),
            ),
          ],
        ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        child: TweenAnimationBuilder<double>(
          key: ValueKey('mathpro-solution-panel-content-motion-${widget.panelState.name}'),
          tween: Tween<double>(begin: 0, end: 1),
          duration: _SolutionPanelMotion.contentSettle,
          curve: _SolutionPanelMotion.enterCurve,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, (1 - value) * 10),
                child: child,
              ),
            );
          },
          child: Column(
            children: <Widget>[
              const SizedBox(height: 6),
              AnimatedContainer(
                key: const ValueKey('mathpro-solution-steps-handle'),
                duration: _SolutionPanelMotion.controlFeedback,
                curve: _SolutionPanelMotion.enterCurve,
                width: expanded ? 52 : 44,
                height: 4,
                decoration: BoxDecoration(
                  color: _SolutionStepsPalette.accent.withValues(alpha: expanded ? 0.68 : 0.48),
                  borderRadius: BorderRadius.circular(MathProRadius.pill),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      blurRadius: expanded ? 13 : 8,
                      spreadRadius: -6,
                      color: _SolutionStepsPalette.accent.withValues(alpha: expanded ? 0.45 : 0.22),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 8, 10, 6),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                            _SolutionStepsPalette.accent.withValues(alpha: 0.18),
                            Colors.white.withValues(alpha: 0.035),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(color: _SolutionStepsPalette.accent.withValues(alpha: 0.28)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            blurRadius: 14,
                            spreadRadius: -10,
                            color: _SolutionStepsPalette.accent.withValues(alpha: 0.28),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.format_list_numbered_rounded, color: _SolutionStepsPalette.accent, size: 16),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Çözüm Adımları',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: MathProTypography.keyText.copyWith(fontSize: 15.2, fontWeight: FontWeight.w900, letterSpacing: -0.16),
                          ),
                        ],
                      ),
                    ),
                    _PanelStatePill(expanded: expanded),
                    const SizedBox(width: 6),
                    _PanelActionButton(
                      key: const ValueKey('mathpro-solution-panel-expand-button'),
                      icon: expanded ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded,
                      tooltip: expanded ? 'Orta boya al' : 'Genişlet',
                      active: expanded,
                      onPressed: widget.onToggleExpanded,
                    ),
                    const SizedBox(width: 6),
                    _PanelActionButton(
                      key: const ValueKey('mathpro-solution-panel-close-button'),
                      icon: Icons.close_rounded,
                      tooltip: 'Kapat',
                      onPressed: widget.onClose,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: widget.snapshot.steps.isEmpty
                    ? _EmptySolutionSteps(snapshot: widget.snapshot)
                    : ListView.separated(
                        key: const ValueKey('mathpro-solution-steps-scroll'),
                        padding: const EdgeInsets.fromLTRB(14, 2, 14, 14),
                        physics: const BouncingScrollPhysics(),
                        cacheExtent: 320,
                        itemCount: widget.snapshot.steps.length,
                        separatorBuilder: (context, index) => const _StepSeparator(),
                        itemBuilder: (context, index) => _AnimatedStepItem(
                          step: widget.snapshot.steps[index],
                          animate: widget.snapshot.steps.length <= 6,
                        ),
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

class _PanelStatePill extends StatelessWidget {
  const _PanelStatePill({required this.expanded});

  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      key: const ValueKey('mathpro-solution-panel-state-pill'),
      duration: _SolutionPanelMotion.controlFeedback,
      curve: _SolutionPanelMotion.enterCurve,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: _SolutionStepsPalette.accent.withValues(alpha: expanded ? 0.14 : 0.07),
        borderRadius: BorderRadius.circular(MathProRadius.pill),
        border: Border.all(color: _SolutionStepsPalette.accent.withValues(alpha: expanded ? 0.34 : 0.16)),
        boxShadow: expanded
            ? const <BoxShadow>[
                BoxShadow(
                  blurRadius: 13,
                  spreadRadius: -10,
                  color: Color.fromRGBO(127, 199, 184, 0.48),
                ),
              ]
            : const <BoxShadow>[],
      ),
      child: Text(
        expanded ? 'Geniş' : 'Orta',
        style: MathProTypography.workspaceHint.copyWith(
          color: expanded ? _SolutionStepsPalette.accent : MathProColors.textFaint,
          fontSize: 9.4,
          height: 1,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.22,
        ),
      ),
    );
  }
}

class _PanelActionButton extends StatelessWidget {
  const _PanelActionButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.active = false,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onPressed,
          child: AnimatedContainer(
            duration: _SolutionPanelMotion.controlFeedback,
            curve: _SolutionPanelMotion.enterCurve,
            width: 38,
            height: 36,
            decoration: BoxDecoration(
              color: active ? _SolutionStepsPalette.accent.withValues(alpha: 0.13) : Colors.white.withValues(alpha: 0.040),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: active ? _SolutionStepsPalette.accent.withValues(alpha: 0.38) : Colors.white.withValues(alpha: 0.075),
              ),
              boxShadow: active
                  ? const <BoxShadow>[
                      BoxShadow(
                        blurRadius: 14,
                        spreadRadius: -9,
                        color: Color.fromRGBO(127, 199, 184, 0.46),
                      ),
                    ]
                  : const <BoxShadow>[],
            ),
            child: Icon(icon, color: active ? _SolutionStepsPalette.accent : MathProColors.textSoft, size: 19),
          ),
        ),
      ),
    );
  }
}

class _AnimatedStepItem extends StatelessWidget {
  const _AnimatedStepItem({
    required this.step,
    required this.animate,
  });

  final SolutionStep step;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final content = RepaintBoundary(child: _SolutionStepItem(step: step));
    if (!animate) return content;
    return TweenAnimationBuilder<double>(
      key: ValueKey('mathpro-solution-step-motion-${step.index}'),
      tween: Tween<double>(begin: 0, end: 1),
      duration: _SolutionPanelMotion.panelSettle,
      curve: _SolutionPanelMotion.enterCurve,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 6),
            child: child,
          ),
        );
      },
      child: content,
    );
  }
}

class _SolutionStepItem extends StatelessWidget {
  const _SolutionStepItem({required this.step});

  final SolutionStep step;

  @override
  Widget build(BuildContext context) {
    const accent = _SolutionStepsPalette.accent;
    return Semantics(
      label: 'Çözüm adımı ${step.index}: ${step.title}',
      container: true,
      child: Padding(
        key: ValueKey('mathpro-solution-step-item-${step.index}'),
        padding: const EdgeInsets.fromLTRB(0, 9, 0, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _StepNumberChip(step: step, accent: accent),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _StepTitle(step: step),
                  if (step.description.trim().isNotEmpty) ...<Widget>[
                    const SizedBox(height: 5),
                    Text(
                      step.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: MathProTypography.workspaceHint.copyWith(
                        color: MathProColors.textMuted,
                        fontSize: 11.2,
                        height: 1.30,
                        letterSpacing: 0.02,
                      ),
                    ),
                  ],
                  if (step.hasMathLine) ...<Widget>[
                    const SizedBox(height: 8),
                    _MathLineInline(step: step, accent: accent),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepNumberChip extends StatelessWidget {
  const _StepNumberChip({required this.step, required this.accent});

  final SolutionStep step;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey('mathpro-solution-step-badge-${step.index}'),
      width: 32,
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: accent.withValues(alpha: step.isLimitation ? 0.13 : 0.10),
        borderRadius: BorderRadius.circular(MathProRadius.pill),
        border: Border.all(color: accent.withValues(alpha: step.isLimitation ? 0.30 : 0.22)),
      ),
      child: Text(
        step.index.toString().padLeft(2, '0'),
        style: MathProTypography.keyText.copyWith(
          fontSize: 10.6,
          color: accent.withValues(alpha: step.isLimitation ? 0.92 : 0.86),
          fontWeight: FontWeight.w900,
          letterSpacing: -0.12,
          height: 1,
        ),
      ),
    );
  }
}

class _StepTitle extends StatelessWidget {
  const _StepTitle({required this.step});

  final SolutionStep step;

  @override
  Widget build(BuildContext context) {
    return Text(
      step.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: MathProTypography.keyText.copyWith(
        fontSize: 13.4,
        fontWeight: FontWeight.w800,
        height: 1.14,
        letterSpacing: -0.05,
        color: step.isLimitation ? MathProColors.textSoft : MathProColors.text,
      ),
    );
  }
}

class _MathLineInline extends StatelessWidget {
  const _MathLineInline({required this.step, required this.accent});

  final SolutionStep step;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final mathLine = step.mathLine!.trim();
    return DecoratedBox(
      key: ValueKey('mathpro-solution-step-math-line-${step.index}'),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: accent.withValues(alpha: 0.22), width: 1.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 9, top: 1, bottom: 1),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              key: ValueKey('mathpro-solution-step-math-scroll-${step.index}'),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: MathRenderSurface(
                    expression: mathLine,
                    role: MathRenderSurfaceRole.inline,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _StepSeparator extends StatelessWidget {
  const _StepSeparator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 43),
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              _SolutionStepsPalette.accent.withValues(alpha: 0.13),
              Colors.white.withValues(alpha: 0.035),
              Colors.transparent,
            ],
            stops: const <double>[0, 0.48, 1],
          ),
        ),
      ),
    );
  }
}

class _EmptySolutionSteps extends StatelessWidget {
  const _EmptySolutionSteps({required this.snapshot});

  final SolutionStepsSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final hasExpression = snapshot.expression.trim().isNotEmpty;
    final message = hasExpression
        ? 'Bu ifade için çözüm adımı yok.'
        : 'İfade girildiğinde çözüm adımları burada görünür.';
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          key: const ValueKey('mathpro-solution-steps-scroll'),
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Text(
                  message,
                  key: const ValueKey('mathpro-solution-empty-state-message'),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: MathProTypography.workspaceHint.copyWith(
                    color: MathProColors.textFaint.withValues(alpha: 0.86),
                    fontSize: 12.2,
                    height: 1.34,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.02,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
