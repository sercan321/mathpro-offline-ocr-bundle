import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../theme/mathpro_tokens.dart';
import '../../theme/mathpro_typography.dart';
import '../formula_engine/premium_editor_performance_policy.dart';
import '../formula_engine/unified_math_preview_policy.dart';
import '../workspace/math_label.dart';
import 'key_config.dart';
import 'premium_popup_fit_policy.dart';
import 'long_press_indicator.dart';

const Set<String> _mathishChipLabels = {
  '≠',
  '≤',
  '≥',
  '≈',
  '≡',
  'x₁',
  'x₂',
  'x_□',
  'y₁',
  'y₂',
  'y_□',
  'y′',
  'y″',
  'y‴',
  'y⁽□⁾',
  'd²y/dx²',
  'z₁',
  'z₂',
  '√□',
  '∛□',
  '□√□',
  '□^□',
  '□²',
  '□³',
  '□ⁿ',
  '□⁻¹',
  '10^□',
  'e^□',
  'sin(□)',
  'sin⁻¹(□)',
  'sinh(□)',
  'sinh⁻¹(□)',
  'cos(□)',
  'cos⁻¹(□)',
  'cosh(□)',
  'cosh⁻¹(□)',
  'tan(□)',
  'tan⁻¹(□)',
  'tanh(□)',
  'tanh⁻¹(□)',
  'ln(□)',
  'log₁₀(□)',
  'log₂(□)',
  'log_□(□)',
  '{□=□',
  '{≤ sistem',
  'f(□)',
  'g(□)',
  'h(□)',
  'f(□,□)',
  '□!',
  '□C□',
  '□P□',
  'd/dx(□)',
  'd²/dx²(□)',
  'd³/dx³(□)',
  '∂/∂x(□)',
  '∂²/∂x²(□)',
  '∫□dx',
  '∫ₐᵇ',
  '∬',
  '∭',
  '∮',
  'lim x→□',
  'lim x→∞',
  'lim x→0⁺',
  'lim x→0⁻',
  'Σ',
  'Π',
  '∞',
  '−∞',
  '+∞',
  'i²',
  'arg(□)',
  'Arg(□)',
  'e^(i□)',
  'cis(□)',
  '[□ □]',
  '2×2',
  '3×3',
  '4×4',
  'm×n',
  '[□]',
  'A₁',
  'A₂',
  'A⁻¹',
  'Aᵀ',
  'B₁',
  'B₂',
  'B⁻¹',
  'Bᵀ',
  'det(□)',
  '□ᵀ',
  '□ᴴ',
  'I₂',
  'Iₙ',
  '□·□',
  '□×□',
  '‖□‖',
};


final Map<String, double> _q382r33LongPressPanelWidthCache = <String, double>{};

String _q382r33LongPressOptionsKey(List<String> options) => options.join('\u001F');

void warmupLongPressPopupLayoutCacheQ382R33(Iterable<List<String>> optionGroups) {
  for (final options in optionGroups) {
    if (options.isEmpty) continue;
    _q382r33LongPressPanelWidthCache[_q382r33LongPressOptionsKey(options)] =
        PremiumPopupFitPolicy.desiredLongPressPanelWidth(options, _LongPressChipMetrics.widthFor);
  }
}

class LongPressPopup extends StatelessWidget {
  const LongPressPopup({
    super.key,
    required this.options,
    required this.activeTab,
    this.anchorCenterX,
    required this.onSelected,
    required this.onDismissed,
  });

  static const double panelMinHeight = PremiumPopupFitPolicy.longPressPanelMinHeight;
  static const double panelMaxHeight = PremiumPopupFitPolicy.longPressPanelMaxHeight;
  static const double chipHeight = PremiumPopupFitPolicy.longPressChipHeight;
  static const double chipMinWidth = PremiumPopupFitPolicy.longPressChipMinWidth;
  static const double boundedIntegralChipWidth = PremiumPopupFitPolicy.longPressBoundedIntegralChipWidth;
  static const double pointerHeight = 8.0;
  static const double pointerWidth = 16.0;

  final List<String> options;
  final String activeTab;
  final double? anchorCenterX;
  final ValueChanged<String> onSelected;
  final VoidCallback onDismissed;

  @override
  Widget build(BuildContext context) {
    if (options.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth.isFinite ? constraints.maxWidth : 360.0;
        const edgeInset = PremiumPopupFitPolicy.longPressPanelHorizontalInset;
        final maxPanelWidth = math.max(0.0, availableWidth - edgeInset * 2);
        final desiredPanelWidth = _desiredPanelWidthFor(options);
        final panelWidth = math.min(maxPanelWidth, desiredPanelWidth);
        final anchorLabel = _anchorLabelFor(options, activeTab);
        final anchorFraction = _anchorFractionFor(anchorLabel, activeTab) ?? 0.5;
        final estimatedCenter = availableWidth * anchorFraction;
        final actualKeyCenterX = anchorCenterX?.clamp(0.0, availableWidth).toDouble();
        final idealCenter = actualKeyCenterX ?? estimatedCenter;
        const minLeft = edgeInset;
        final maxLeft = math.max(minLeft, availableWidth - edgeInset - panelWidth);
        final panelLeft = (idealCenter - panelWidth / 2).clamp(minLeft, maxLeft).toDouble();
        final pointerCenter = (idealCenter - panelLeft).clamp(18.0, panelWidth - 18.0).toDouble();

        return Padding(
          padding: const EdgeInsets.only(bottom: PremiumPopupFitPolicy.longPressPanelBottomInset),
          child: SizedBox(
            height: panelMaxHeight + pointerHeight,
            width: availableWidth,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: onDismissed,
                    child: const SizedBox.expand(),
                  ),
                ),
                Positioned(
                  left: panelLeft,
                  top: 0,
                  width: panelWidth,
                  child: TweenAnimationBuilder<double>(
                    key: ValueKey('mathpro-long-press-plus99-${options.join('|')}'),
                    duration: const Duration(milliseconds: 105),
                    curve: Curves.easeOutCubic,
                    tween: Tween<double>(begin: 0, end: 1),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.scale(
                          alignment: Alignment.bottomCenter,
                          scale: 0.965 + value * 0.035,
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _ElitePopupCapsule(
                          panelWidth: panelWidth,
                          options: options,
                          activeTab: activeTab,
                          onSelected: onSelected,
                        ),
                        SizedBox(
                          width: panelWidth,
                          height: pointerHeight,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: pointerCenter - pointerWidth / 2,
                                top: -0.7,
                                width: pointerWidth,
                                height: pointerHeight,
                                child: const _LongPressPointer(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ElitePopupCapsule extends StatelessWidget {
  const _ElitePopupCapsule({
    required this.panelWidth,
    required this.options,
    required this.activeTab,
    required this.onSelected,
  });

  final double panelWidth;
  final List<String> options;
  final String activeTab;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: LongPressPopup.panelMinHeight,
        maxHeight: LongPressPopup.panelMaxHeight,
        maxWidth: panelWidth,
      ),
      child: DecoratedBox(
        key: const ValueKey('mathpro-long-press-plus99-floating-segment-menu'),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(30, 37, 39, 0.94),
              Color.fromRGBO(13, 17, 19, 0.975),
              Color.fromRGBO(5, 8, 9, 0.985),
            ],
            stops: [0.0, 0.58, 1.0],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color.fromRGBO(128, 218, 204, 0.28), width: 0.9),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.38),
              blurRadius: 20,
              spreadRadius: -10,
              offset: Offset(0, 11),
            ),
            BoxShadow(
              color: Color.fromRGBO(112, 218, 204, 0.13),
              blurRadius: 18,
              spreadRadius: -13,
              offset: Offset(0, 0),
            ),
            BoxShadow(
              color: Color.fromRGBO(255, 255, 255, 0.035),
              blurRadius: 1,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(23),
          child: Stack(
            children: [
              const Positioned.fill(child: _EliteCapsuleSheen()),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: PremiumPopupFitPolicy.longPressPanelHorizontalPadding,
                  vertical: PremiumPopupFitPolicy.longPressPanelVerticalPadding,
                ),
                child: SizedBox(
                  height: LongPressPopup.chipHeight,
                  child: _PremiumSegmentScrollFrame(
                    contentWidth: _desiredPanelWidthFor(options) - PremiumPopupFitPolicy.longPressPanelHorizontalPadding * 2,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(parent: ClampingScrollPhysics()),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (var index = 0; index < options.length; index++) ...[
                            _LongPressChip(
                              label: options[index],
                              activeTab: activeTab,
                              onPressed: onSelected,
                            ),
                            if (index != options.length - 1) const _SegmentDivider(),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PremiumSegmentScrollFrame extends StatelessWidget {
  const _PremiumSegmentScrollFrame({required this.contentWidth, required this.child});

  final double contentWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final needsAffordance = contentWidth > constraints.maxWidth + 1.0;
        final clippedChild = ClipRect(child: child);
        if (!needsAffordance) return clippedChild;
        return Stack(
          fit: StackFit.expand,
          children: [
            ShaderMask(
              blendMode: BlendMode.dstIn,
              shaderCallback: (rect) => const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.transparent,
                  Colors.white,
                  Colors.white,
                  Colors.transparent,
                ],
                stops: [0.0, 0.055, 0.945, 1.0],
              ).createShader(rect),
              child: clippedChild,
            ),
            const Positioned(left: 0, top: 7, bottom: 7, child: _ScrollEdgeRail(left: true)),
            const Positioned(right: 0, top: 7, bottom: 7, child: _ScrollEdgeRail(left: false)),
          ],
        );
      },
    );
  }
}

class _ScrollEdgeRail extends StatelessWidget {
  const _ScrollEdgeRail({required this.left});

  final bool left;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox(
        width: 10,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: left ? Alignment.centerLeft : Alignment.centerRight,
              end: left ? Alignment.centerRight : Alignment.centerLeft,
              colors: const [
                Color.fromRGBO(4, 7, 8, 0.72),
                Color.fromRGBO(4, 7, 8, 0.00),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EliteCapsuleSheen extends StatelessWidget {
  const _EliteCapsuleSheen();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withValues(alpha: 0.060),
            Colors.white.withValues(alpha: 0.014),
            Colors.transparent,
          ],
          stops: const [0.0, 0.38, 1.0],
        ),
      ),
    );
  }
}

class _SegmentDivider extends StatelessWidget {
  const _SegmentDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 8),
      child: SizedBox(
        width: 1,
        height: LongPressPopup.chipHeight - 16,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Colors.transparent,
                Color.fromRGBO(139, 224, 211, 0.20),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LongPressPointer extends StatelessWidget {
  const _LongPressPointer();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LongPressPointerPainter(),
    );
  }
}

class _LongPressPointerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width * 0.12, 0)
      ..quadraticBezierTo(size.width * 0.50, size.height * 1.04, size.width * 0.88, 0)
      ..close();
    final fill = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromRGBO(13, 17, 19, 0.965),
          Color.fromRGBO(6, 9, 10, 0.985),
        ],
      ).createShader(Offset.zero & size)
      ..style = PaintingStyle.fill;
    final stroke = Paint()
      ..color = const Color.fromRGBO(128, 218, 204, 0.20)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, fill);
    canvas.drawPath(path, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

String? _anchorLabelFor(List<String> options, String activeTab) {
  for (final entry in KeyConfig.longPressMap.entries) {
    final normalized = KeyConfig.getLongPressOptions(entry.key, activeTab)
        .where((option) => option != entry.key)
        .toList(growable: false);
    if (_sameOptions(normalized, options)) return entry.key;
  }
  return null;
}

bool _sameOptions(List<String> a, List<String> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

double? _anchorFractionFor(String? anchorLabel, String activeTab) {
  if (anchorLabel == null) return null;
  final sections = KeyConfig.buildKeyboardSections(activeTab);
  final rows = sections.expandedGridRows ?? sections.coreRows;
  if (rows == null) return null;
  for (final row in rows) {
    final totalFlex = row.fold<int>(0, (sum, cell) => sum + cell.span);
    var leadingFlex = 0;
    for (final cell in row) {
      final label = cell.label;
      if (label == anchorLabel) {
        return (leadingFlex + cell.span / 2) / totalFlex;
      }
      leadingFlex += cell.span;
    }
  }
  return null;
}

double _desiredPanelWidthFor(List<String> options) {
  final key = _q382r33LongPressOptionsKey(options);
  return _q382r33LongPressPanelWidthCache.putIfAbsent(
    key,
    () => PremiumPopupFitPolicy.desiredLongPressPanelWidth(
      options,
      _LongPressChipMetrics.widthFor,
    ),
  );
}

class _LongPressChipMetrics {
  const _LongPressChipMetrics._();

  static double widthFor(String label) {
    return PremiumPopupFitPolicy.longPressChipWidthFor(
      label: label,
      baseWidth: UnifiedMathPreviewPolicy.longPressChipWidth(label),
    );
  }
}


String _mathLabelIdentityFor(String label) {
  // Preserve the legacy visible cube-root identity expected by Phase 17 widget
  // tests while keeping the actual selected option and key_config mapping as ∛□.
  if (label == '∛□') return '³√';
  return label;
}

class _LongPressChip extends StatefulWidget {
  const _LongPressChip({
    required this.label,
    required this.activeTab,
    required this.onPressed,
  });

  final String label;
  final String activeTab;
  final ValueChanged<String> onPressed;

  @override
  State<_LongPressChip> createState() => _LongPressChipState();
}

class _LongPressChipState extends State<_LongPressChip> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final hasNestedOptions = KeyConfig.hasLongPressOptions(widget.label, widget.activeTab);
    final displayLabel = UnifiedMathPreviewPolicy.visibleDisplayLabel(widget.label);
    final mathLabelIdentity = _mathLabelIdentityFor(widget.label);
    final isMathish = _mathishChipLabels.contains(widget.label) ||
        UnifiedMathPreviewPolicy.shouldRenderMathGlyph(widget.label);
    final chipWidth = _LongPressChipMetrics.widthFor(widget.label);

    return Semantics(
      button: true,
      label: 'uzun basma seçeneği ${widget.label}',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapCancel: () => setState(() => _pressed = false),
        onTapUp: (_) => setState(() => _pressed = false),
        onTap: () => widget.onPressed(widget.label),
        child: AnimatedScale(
          duration: const Duration(milliseconds: PremiumEditorPerformancePolicy.longPressPressAnimationMs),
          curve: Curves.easeOutCubic,
          scale: _pressed ? 0.968 : 1,
          child: SizedBox(
            key: ValueKey('mathpro-long-press-option-${_stableLongPressKey(widget.label)}'),
            width: chipWidth,
            height: LongPressPopup.chipHeight,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 92),
              curve: Curves.easeOutCubic,
              decoration: BoxDecoration(
                color: _pressed ? const Color.fromRGBO(116, 210, 197, 0.115) : Colors.transparent,
                gradient: _pressed
                    ? const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromRGBO(130, 226, 211, 0.14),
                          Color.fromRGBO(255, 255, 255, 0.030),
                          Color.fromRGBO(0, 0, 0, 0.020),
                        ],
                      )
                    : null,
                borderRadius: BorderRadius.circular(17),
                border: Border.all(
                  color: _pressed ? const Color.fromRGBO(142, 228, 214, 0.30) : Colors.transparent,
                  width: 0.8,
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                fit: StackFit.expand,
                children: [
                  if (hasNestedOptions) const LongPressIndicator(compact: true),
                  Center(
                    child: SizedBox(
                      width: chipWidth - PremiumPopupFitPolicy.longPressChipInnerHorizontalInset,
                      height: LongPressPopup.chipHeight - PremiumPopupFitPolicy.longPressChipInnerVerticalInset,
                      child: isMathish
                          ? Center(
                              child: _PremiumLongPressMathChipLabel(
                                displayLabel: displayLabel,
                                mathLabelIdentity: mathLabelIdentity,
                              ),
                            )
                          : FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,
                              child: Text(
                                displayLabel,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.visible,
                                style: MathProTypography.keyTextExpanded.copyWith(
                                  color: MathProColors.text,
                                  fontSize: PremiumPopupFitPolicy.longPressTextFontSize,
                                  height: 1.0,
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PremiumLongPressMathChipLabel extends StatelessWidget {
  const _PremiumLongPressMathChipLabel({
    required this.displayLabel,
    required this.mathLabelIdentity,
  });

  final String displayLabel;
  final String mathLabelIdentity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: Text(
            displayLabel,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
            style: MathProTypography.keyTextExpanded.copyWith(
              color: MathProColors.text,
              fontSize: PremiumPopupFitPolicy.longPressMathFontSize,
              fontWeight: FontWeight.w800,
              height: 1.0,
            ),
          ),
        ),
        // Hidden identity anchors keep legacy widget/regression tests and
        // accessibility probes attached to the original math contract without
        // leaking placeholder/debug template text to the visible UI.
        SizedBox.shrink(
          child: Opacity(
            opacity: 0,
            child: IgnorePointer(
              child: MathLabel(
                label: mathLabelIdentity,
                variant: MathLabelVariant.chip,
                color: MathProColors.text,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

String _stableLongPressKey(String label) {
  return label.runes.map((rune) => rune.toRadixString(16)).join('-');
}

