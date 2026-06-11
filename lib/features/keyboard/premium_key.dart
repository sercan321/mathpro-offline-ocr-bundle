import 'package:flutter/material.dart';

import '../../services/haptics_service.dart';
import '../../debug/latency/mathpro_latency_probe_q382r23.dart';
import '../../logic/premium_math_surface_policy.dart';
import '../../theme/mathpro_tokens.dart';
import '../../theme/mathpro_typography.dart';
import '../workspace/math_label.dart';
import '../formula_engine/unified_math_preview_policy.dart';
import 'long_press_indicator.dart';
import 'keyboard_long_press_anchor.dart';
import 'premium_key_feedback_safety_q382r20_policy.dart';
import 'keyboard_latency_closure_q382r24_policy.dart';

enum PremiumKeyVariant { number, operator, function, action }

class PremiumKey extends StatefulWidget {
  const PremiumKey({
    super.key,
    required this.label,
    required this.variant,
    this.compact = false,
    this.hasLongPress = false,
    this.onPressed,
    this.onLongPressed,
  });

  final String label;
  final PremiumKeyVariant variant;
  final bool compact;
  final bool hasLongPress;
  final ValueChanged<String>? onPressed;
  final ValueChanged<KeyboardLongPressAnchor>? onLongPressed;

  @override
  State<PremiumKey> createState() => _PremiumKeyState();
}

class _PremiumKeyState extends State<PremiumKey> {
  static const double _pressScale = 0.958;
  static const double _releaseScale = 1;

  bool _pressed = false;
  bool _tapDownDispatched = false;

  bool get _canDispatchOnTapDown => KeyboardLatencyClosureQ382R24Policy.dispatchOnTapDown(
        label: widget.label,
        activeTab: '',
        hasLongPress: widget.hasLongPress,
      );

  void _setPressed(bool value) {
    if (!mounted || _pressed == value) return;
    if (value) MathProLatencyProbeQ382R23.instance.recordPremiumKeyTapDown(widget.label);
    setState(() => _pressed = value);
  }

  void _handleTapDown(TapDownDetails _) {
    _setPressed(true);
    HapticsService.lightImpact();
    if (_canDispatchOnTapDown) {
      _tapDownDispatched = true;
      widget.onPressed?.call(widget.label);
    } else {
      _tapDownDispatched = false;
    }
  }

  void _handleTapCancel() {
    _tapDownDispatched = false;
    _setPressed(false);
  }

  void _handleTapUp(TapUpDetails _) => _setPressed(false);

  void _handleTap() {
    if (_tapDownDispatched) {
      _tapDownDispatched = false;
      return;
    }
    widget.onPressed?.call(widget.label);
  }

  void _handleLongPressStart(LongPressStartDetails _) {
    _setPressed(true);
    HapticsService.mediumImpact();
  }

  void _handleLongPressEnd(LongPressEndDetails _) {
    _setPressed(false);
  }

  KeyboardLongPressAnchor _measureLongPressAnchor() {
    final renderObject = context.findRenderObject();
    if (renderObject is RenderBox && renderObject.hasSize) {
      final size = renderObject.size;
      final topLeft = renderObject.localToGlobal(Offset.zero);
      return KeyboardLongPressAnchor(
        label: widget.label,
        globalCenter: renderObject.localToGlobal(Offset(size.width / 2, size.height / 2)),
        globalRect: topLeft & size,
      );
    }
    return KeyboardLongPressAnchor(
      label: widget.label,
      globalCenter: Offset.zero,
      globalRect: Rect.zero,
    );
  }

  void _handleLongPress() {
    widget.onLongPressed?.call(_measureLongPressAnchor());
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(widget.compact ? 14 : 22);

    return Semantics(
      button: true,
      label: _semanticLabelFor(widget.label),
      child: AnimatedScale(
        scale: _pressed ? _pressScale : _releaseScale,
        duration: PremiumKeyFeedbackSafetyQ382R20Policy.pressedScaleDuration,
        curve: Curves.easeOutCubic,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: _handleTapDown,
          onTapCancel: _handleTapCancel,
          onTapUp: _handleTapUp,
          onTap: _handleTap,
          onLongPressStart: widget.onLongPressed == null ? null : _handleLongPressStart,
          onLongPressEnd: widget.onLongPressed == null ? null : _handleLongPressEnd,
          onLongPress: widget.onLongPressed == null ? null : _handleLongPress,
          child: Container(
            key: ValueKey('mathpro-premium-key-${_stableKeyPart(widget.label)}'),
            constraints: const BoxConstraints.expand(),
            margin: const EdgeInsets.symmetric(vertical: 1),
            padding: EdgeInsets.symmetric(horizontal: widget.compact ? 3 : 4),
            decoration: _decorationFor(widget.label, widget.variant, radius: radius, pressed: _pressed),
            child: ClipRRect(
              borderRadius: radius,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (_isTemplateGlyph(widget.label)) const _TemplateKeySheen(),
                  if (_isActionLike(widget.label)) const _ActionKeySheen(),
                  const _GraphiteInnerRim(),
                  if (widget.hasLongPress && _shouldShowLongPressIndicator(widget.label)) LongPressIndicator(compact: widget.compact),
                  Center(child: _KeyLabel(label: widget.label, compact: widget.compact, variant: widget.variant)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String _stableKeyPart(String label) {
  return label.runes.map((rune) => rune.toRadixString(16)).join('-');
}

String _semanticLabelFor(String label) {
  switch (label) {
    case '□/□':
    case '□⁄□':
      return 'kesir şablonu';
    case '√□':
      return 'karekök şablonu';
    case '□^□':
      return 'üs şablonu';
    case '{□=□':
      return 'denklem sistemi şablonu';
    case '[□ □]':
      return 'matris şablonu';
    case '[□]':
      return 'vektör şablonu';
    case '□!':
      return 'faktöriyel';
    case '↵':
      return 'hesapla';
    case '⌫':
      return 'sil';
    default:
      return label;
  }
}


class _GraphiteInnerRim extends StatelessWidget {
  const _GraphiteInnerRim();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withValues(alpha: 0.044),
              Colors.white.withValues(alpha: 0.000),
              Colors.black.withValues(alpha: 0.082),
            ],
            stops: const [0.0, 0.46, 1.0],
          ),
        ),
      ),
    );
  }
}

class _TemplateKeySheen extends StatelessWidget {
  const _TemplateKeySheen();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.040),
            Colors.white.withValues(alpha: 0.000),
            MathProColors.accent.withValues(alpha: 0.024),
          ],
          stops: const [0.0, 0.50, 1.0],
        ),
      ),
    );
  }
}

class _ActionKeySheen extends StatelessWidget {
  const _ActionKeySheen();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withValues(alpha: 0.078),
            Colors.white.withValues(alpha: 0.00),
          ],
        ),
      ),
    );
  }
}

class _KeyLabel extends StatelessWidget {
  const _KeyLabel({required this.label, required this.compact, required this.variant});

  final String label;
  final bool compact;
  final PremiumKeyVariant variant;

  @override
  Widget build(BuildContext context) {
    final displayLabel = UnifiedMathPreviewPolicy.visibleDisplayLabel(label);
    final textColor = _textColorFor(label, variant);

    final content = Stack(
      alignment: Alignment.center,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            displayLabel,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: (compact ? MathProTypography.keyTextExpanded : MathProTypography.keyText).copyWith(
              color: textColor,
              fontWeight: _fontWeightFor(label),
              letterSpacing: _letterSpacingFor(label),
            ),
          ),
        ),
        if (displayLabel != label || _isTemplateGlyph(label))
          Opacity(
            opacity: 0,
            child: IgnorePointer(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: MathLabel(
                  label: label,
                  variant: compact ? MathLabelVariant.chip : MathLabelVariant.keycap,
                  color: textColor,
                ),
              ),
            ),
          ),
      ],
    );

    // V55 optical pass: keep the frozen key labels and layout untouched, but
    // compensate for glyph-specific visual centers so dense calculus/linear
    // algebra surfaces read like a single premium instrument panel.
    return Transform.translate(
      offset: _labelOffsetFor(label, compact: compact),
      child: Transform.scale(
        scale: _labelScaleFor(label, compact: compact),
        child: content,
      ),
    );
  }

  Color _textColorFor(String label, PremiumKeyVariant variant) {
    if (label == 'C' || label == '↵') return MathProColors.text;
    if (_isControl(label)) return MathProColors.textSoft;
    if (_isTemplateGlyph(label)) return const Color(0xFFEAF5F1);
    if (variant == PremiumKeyVariant.operator) return const Color(0xFFE5F0EE);
    return MathProColors.text;
  }

  FontWeight _fontWeightFor(String label) {
    if (_isControl(label) || _isOperator(label) || label == '↵') return FontWeight.w900;
    if (label.length <= 2 && !_isTemplateGlyph(label)) return FontWeight.w800;
    return FontWeight.w800;
  }

  double _letterSpacingFor(String label) {
    if (label == 'MORE') return 0.34;
    if (_isControl(label)) return -0.08;
    if (_isOperator(label) || label == '↵') return -0.28;
    return -0.16;
  }

  double _labelScaleFor(String label, {required bool compact}) {
    if (label == 'MORE') return compact ? 0.94 : 0.96;
    if (label == '⌫') return compact ? 0.97 : 1.0;
    if (label == '↵') return compact ? 1.02 : 1.05;
    if (_isOperator(label)) return compact ? 1.02 : 1.05;
    if (_isTemplateGlyph(label)) return compact ? 0.98 : 1.0;
    return 1.0;
  }

  Offset _labelOffsetFor(String label, {required bool compact}) {
    if (label == '∫' || label == '∫□dx' || label == '√□') return Offset(0, compact ? -0.35 : -0.55);
    if (label == 'Σ' || label == 'Π') return Offset(0, compact ? -0.25 : -0.45);
    if (label == 'd/dx' || label == 'dy/dx' || label.startsWith('d²')) return Offset(0, compact ? 0.20 : 0.35);
    if (label == 'MORE') return const Offset(0, -0.15);
    if (label == '↵') return const Offset(0, -0.35);
    return Offset.zero;
  }
}

PremiumKeyVariant premiumVariantForLabel(String label) {
  if (label == '↵') return PremiumKeyVariant.action;
  if (_isOperator(label)) return PremiumKeyVariant.operator;
  if (_isDanger(label) || _isControl(label)) return PremiumKeyVariant.function;
  return PremiumKeyVariant.number;
}

BoxDecoration _decorationFor(
  String label,
  PremiumKeyVariant variant, {
  required BorderRadius radius,
  required bool pressed,
}) {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: _gradientColors(label, variant, pressed: pressed),
    ),
    borderRadius: radius,
    border: Border.all(color: _borderColor(label, variant, pressed: pressed), width: _borderWidth(label, pressed: pressed)),
    boxShadow: pressed ? MathProShadows.keyPressed : _shadowFor(label, variant),
  );
}

List<Color> _gradientColors(String label, PremiumKeyVariant variant, {required bool pressed}) {
  final pressOverlay = pressed ? 0.045 : 0.0;
  if (label == 'C') {
    return [
      const Color(0xFFEFA447).withValues(alpha: 0.985 - pressOverlay),
      const Color(0xFFE08A24).withValues(alpha: 0.985),
      const Color(0xFF9E520F).withValues(alpha: 0.985),
    ];
  }
  if (label == '↵') {
    return [
      const Color(0xFF8FD2C8).withValues(alpha: 0.975 - pressOverlay),
      const Color(0xFF68AFA5).withValues(alpha: 0.975),
      const Color(0xFF4F837C).withValues(alpha: 0.975),
    ];
  }
  if (label == 'MORE') {
    return [
      const Color(0xFF262D31).withValues(alpha: 0.985 - pressOverlay),
      const Color(0xFF181D20).withValues(alpha: 0.985),
      const Color(0xFF0E1113).withValues(alpha: 0.985),
    ];
  }

  // V46: the whole keyboard reads as a quieter graphite/ceramic device body.
  // Template and math keys are still discoverable through rim/sheen/long-press
  // affordances, not through loud color islands.
  return [
    const Color(0xFF252A2E).withValues(alpha: 0.988 - pressOverlay),
    const Color(0xFF181D20).withValues(alpha: 0.988),
    const Color(0xFF0D1012).withValues(alpha: 0.988),
  ];
}

Color _borderColor(String label, PremiumKeyVariant variant, {required bool pressed}) {
  final boost = pressed ? 0.12 : 0.0;
  if (label == '↵') return Color.fromRGBO(235, 255, 250, 0.24 + boost);
  if (label == 'C') return Color.fromRGBO(255, 235, 208, 0.23 + boost);
  if (label == 'MORE') return Color.fromRGBO(230, 238, 240, 0.13 + boost);
  if (_isTemplateGlyph(label)) return Color.fromRGBO(150, 214, 203, 0.17 + boost);
  if (variant == PremiumKeyVariant.operator) return Color.fromRGBO(224, 239, 236, 0.130 + boost);
  return Color.fromRGBO(230, 238, 240, 0.110 + boost);
}

double _borderWidth(String label, {required bool pressed}) {
  if (pressed) return 1.25;
  if (_isTemplateGlyph(label) || label == '↵' || label == 'C') return 1.05;
  return 0.90;
}

List<BoxShadow> _shadowFor(String label, PremiumKeyVariant variant) {
  if (label == '↵') return MathProShadows.actionKey;
  if (_isTemplateGlyph(label)) return MathProShadows.templateKey;
  return MathProShadows.key;
}

bool _isOperator(String label) => const {'÷', '×', '−', '+', '=', '%'}.contains(label);
bool _isDanger(String label) => const {'C', 'AC'}.contains(label);
bool _isControl(String label) => const {'⌫', 'MORE'}.contains(label);
bool _isActionLike(String label) => label == '↵' || label == 'C';

bool _shouldShowLongPressIndicator(String label) {
  // V40: show a clear but small premium affordance on every key that really
  // has long-press alternatives. Number/action keys do not expose long-press
  // options in the source map, so this stays informative without adding fake
  // hints.
  return true;
}

bool _isTemplateGlyph(String label) => PremiumMathSurfacePolicy.isTemplateSurface(label);
