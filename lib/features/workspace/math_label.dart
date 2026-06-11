import 'package:flutter/material.dart';

import '../../theme/mathpro_tokens.dart';
import '../formula_engine/unified_math_preview_policy.dart';
import '../../theme/mathpro_typography.dart';
import '../../logic/math_key_visual_contract.dart';

enum MathLabelVariant { keycap, chip, inline }

class MathLabel extends StatelessWidget {
  const MathLabel({
    super.key,
    required this.label,
    this.variant = MathLabelVariant.keycap,
    this.color,
    this.textAlign = TextAlign.center,
  });

  final String label;
  final MathLabelVariant variant;
  final Color? color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final compact = variant == MathLabelVariant.keycap || variant == MathLabelVariant.chip;
    final resolvedColor = color ?? MathProColors.text;
    final displayLabel = UnifiedMathPreviewPolicy.canonicalPreviewLabel(label);

    if (compact) {
      switch (displayLabel) {
        case '□/□':
        case '□⁄□':
        case 'frac':
          return Stack(
            alignment: Alignment.center,
            children: [
              _FractionGlyph(variant: variant, color: resolvedColor),
              Opacity(
                opacity: 0,
                child: Text(
                  '□⁄□',
                  maxLines: 1,
                  style: _styleFor('□⁄□', variant).copyWith(color: resolvedColor),
                ),
              ),
            ],
          );
        case '√□':
          return _withHiddenText('√□', _RootGlyph(variant: variant, color: resolvedColor), resolvedColor);
        case '□^□':
          return _PowerGlyph(variant: variant, color: resolvedColor);
        case '|□|':
          return _withHiddenText('|□|', _AbsGlyph(variant: variant, color: resolvedColor), resolvedColor);
        case '□!':
          return _withHiddenText('□!', _FactorialGlyph(variant: variant, color: resolvedColor), resolvedColor);
        case 'd/dx':
          return _withHiddenText('d/dx', _DerivativeGlyph(variant: variant, color: resolvedColor), resolvedColor);
        case '∫□dx':
          return _withHiddenText('∫□dx', _IntegralDxGlyph(variant: variant, color: resolvedColor), resolvedColor);
        case 'lim':
          return _withHiddenText('lim', _LimitGlyph(variant: variant, color: resolvedColor), resolvedColor);
        case 'Σ':
          return _withHiddenText('Σ', _SummationGlyph(variant: variant, color: resolvedColor, operator: 'Σ'), resolvedColor);
        case 'Π':
          return _withHiddenText('Π', _SummationGlyph(variant: variant, color: resolvedColor, operator: 'Π'), resolvedColor);
        case '{□=□':
          return _SystemGlyph(variant: variant, color: resolvedColor);
        case '[□ □]':
          return _MatrixGlyph(variant: variant, color: resolvedColor);
        case '[□]':
          return _VectorGlyph(variant: variant, color: resolvedColor);
        case '∫ₐᵇ':
          return _BoundedIntegralGlyph(variant: variant, color: resolvedColor);
      }
      final extendedGlyph = _buildExtendedCompactGlyph(displayLabel, resolvedColor);
      if (extendedGlyph != null) {
        return extendedGlyph;
      }
    }

    return Text(
      _normalizeCompact(displayLabel, compact: compact),
      maxLines: 1,
      overflow: TextOverflow.visible,
      textAlign: textAlign,
      style: _styleFor(displayLabel, variant).copyWith(color: resolvedColor),
    );
  }

  Widget _withHiddenText(String originalLabel, Widget child, Color resolvedColor) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Opacity(
          opacity: 0,
          child: Text(
            originalLabel,
            maxLines: 1,
            style: _styleFor(originalLabel, variant).copyWith(color: resolvedColor),
          ),
        ),
      ],
    );
  }


  Widget? _buildExtendedCompactGlyph(String value, Color resolvedColor) {
    const subscriptGlyphs = <String, Map<String, Object>>{
      'x₁': {'base': 'x', 'sub': '1', 'placeholder': false},
      'x₂': {'base': 'x', 'sub': '2', 'placeholder': false},
      'xₙ': {'base': 'x', 'sub': '', 'placeholder': true},
      'x_□': {'base': 'x', 'sub': '', 'placeholder': true},
      'y₁': {'base': 'y', 'sub': '1', 'placeholder': false},
      'y₂': {'base': 'y', 'sub': '2', 'placeholder': false},
      'yₙ': {'base': 'y', 'sub': '', 'placeholder': true},
      'y_□': {'base': 'y', 'sub': '', 'placeholder': true},
      'A₁': {'base': 'A', 'sub': '1', 'placeholder': false},
      'A₂': {'base': 'A', 'sub': '2', 'placeholder': false},
      'B₁': {'base': 'B', 'sub': '1', 'placeholder': false},
      'B₂': {'base': 'B', 'sub': '2', 'placeholder': false},
      'I₂': {'base': 'I', 'sub': '2', 'placeholder': false},
      'I₃': {'base': 'I', 'sub': '3', 'placeholder': false},
      'Iₙ': {'base': 'I', 'sub': '', 'placeholder': true},
      'I_□': {'base': 'I', 'sub': '', 'placeholder': true},
    };

    if (subscriptGlyphs.containsKey(value)) {
      final data = subscriptGlyphs[value]!;
      return _withHiddenText(
        value,
        _SubscriptGlyph(
          variant: variant,
          color: resolvedColor,
          baseText: data['base']! as String,
          subscriptText: data['sub']! as String,
          subscriptPlaceholder: data['placeholder']! as bool,
        ),
        resolvedColor,
      );
    }

    final compactLogMatch = RegExp(r'^log₍([^₎]+)₎\(([^()]*)\)$').firstMatch(value);
    if (compactLogMatch != null) {
      final base = compactLogMatch.group(1)!;
      final argument = compactLogMatch.group(2)!;
      return _withHiddenText(
        value,
        _LogGlyph(
          variant: variant,
          color: resolvedColor,
          subscriptText: base == '□' ? '' : base,
          subscriptPlaceholder: base == '□',
          argumentText: argument == '□' || argument.isEmpty ? null : argument,
        ),
        resolvedColor,
      );
    }

    final compactLimitMatch = RegExp(r'^lim₍([^→₎]+)→([^₎]+)₎\((.*)\)$').firstMatch(value);
    if (compactLimitMatch != null) {
      final variable = compactLimitMatch.group(1)!;
      final target = compactLimitMatch.group(2)!;
      final body = compactLimitMatch.group(3)!;
      return _withHiddenText(
        value,
        _LimitBodyTargetGlyph(
          variant: variant,
          color: resolvedColor,
          targetPrefix: '$variable→$target',
          bodyText: body == '□' || body.isEmpty ? null : body,
        ),
        resolvedColor,
      );
    }

    switch (value) {
      case 'y′':
        return _withHiddenText(value, _PrimeGlyph(variant: variant, color: resolvedColor, baseText: 'y', primeText: '′'), resolvedColor);
      case 'y″':
        return _withHiddenText(value, _PrimeGlyph(variant: variant, color: resolvedColor, baseText: 'y', primeText: '″'), resolvedColor);
      case 'y‴':
        return _withHiddenText(value, _PrimeGlyph(variant: variant, color: resolvedColor, baseText: 'y', primeText: '‴'), resolvedColor);
      case 'y⁽ⁿ⁾':
      case 'y⁽□⁾':
        return _withHiddenText(value, _PrimeGlyph(variant: variant, color: resolvedColor, baseText: 'y', primeText: '(□)'), resolvedColor);
      case '∛□':
      case '³√(□)':
        return _withHiddenText('³√', _IndexedRootGlyph(variant: variant, color: resolvedColor, indexText: '3'), resolvedColor);
      case '□√□':
      case '□√(□)':
      case 'ⁿ√(□)':
        return _withHiddenText('□√□', _IndexedRootGlyph(variant: variant, color: resolvedColor, indexPlaceholder: true), resolvedColor);
      case 'e^□':
        return _withHiddenText(value, _ExponentialGlyph(variant: variant, color: resolvedColor, baseText: 'e'), resolvedColor);
      case '10^□':
        return _withHiddenText(value, _ExponentialGlyph(variant: variant, color: resolvedColor, baseText: '10'), resolvedColor);
      case 'e^(i□)':
        return _withHiddenText(value, _ExponentialGlyph(variant: variant, color: resolvedColor, baseText: 'e', exponentPrefix: 'i'), resolvedColor);
      case '□²':
        return _withHiddenText(value, _SpecificPowerGlyph(variant: variant, color: resolvedColor, exponentText: '2'), resolvedColor);
      case '□³':
        return _withHiddenText(value, _SpecificPowerGlyph(variant: variant, color: resolvedColor, exponentText: '3'), resolvedColor);
      case '□ⁿ':
        return _withHiddenText(value, _SpecificPowerGlyph(variant: variant, color: resolvedColor, exponentPlaceholder: true), resolvedColor);
      case '□⁻¹':
        return _withHiddenText(value, _SpecificPowerGlyph(variant: variant, color: resolvedColor, exponentText: '−1'), resolvedColor);
      case '□ᵀ':
        return _withHiddenText(value, _SpecificPowerGlyph(variant: variant, color: resolvedColor, exponentText: 'T'), resolvedColor);
      case '□ᴴ':
        return _withHiddenText(value, _SpecificPowerGlyph(variant: variant, color: resolvedColor, exponentText: 'H'), resolvedColor);
      case '□C□':
        return _withHiddenText(value, _BinarySlotOperatorGlyph(variant: variant, color: resolvedColor, operator: 'C'), resolvedColor);
      case '□P□':
        return _withHiddenText(value, _BinarySlotOperatorGlyph(variant: variant, color: resolvedColor, operator: 'P'), resolvedColor);
      case 'log₁₀(□)':
        return _withHiddenText(value, _LogGlyph(variant: variant, color: resolvedColor, subscriptText: '10'), resolvedColor);
      case 'log₂(□)':
        return _withHiddenText(value, _LogGlyph(variant: variant, color: resolvedColor, subscriptText: '2'), resolvedColor);
      case 'log_□(□)':
      case 'log₍□₎(□)':
        return _withHiddenText(value, _LogGlyph(variant: variant, color: resolvedColor, subscriptPlaceholder: true), resolvedColor);
      case '∫(□)dx':
        return _withHiddenText(value, _IntegralTemplateGlyph(variant: variant, color: resolvedColor), resolvedColor);
      case '∫_{□}^{□}(□)d□':
        return _withHiddenText(value, _DefiniteIntegralTemplateGlyph(variant: variant, color: resolvedColor), resolvedColor);
      case '∫₀¹(□)dx':
        return _withHiddenText(value, _DefiniteIntegralTemplateGlyph(variant: variant, color: resolvedColor, lowerText: '0', upperText: '1', differentialText: 'dx'), resolvedColor);
      case '∫₀¹ f(x)':
        return _withHiddenText(value, _DefiniteIntegralTemplateGlyph(variant: variant, color: resolvedColor, lowerText: '0', upperText: '1', bodyText: 'f(x)', differentialText: 'dx'), resolvedColor);
      case 'Σ(□)':
        return _withHiddenText(value, _BigOperatorTemplateGlyph(variant: variant, color: resolvedColor, operator: 'Σ'), resolvedColor);
      case 'Π(□)':
        return _withHiddenText(value, _BigOperatorTemplateGlyph(variant: variant, color: resolvedColor, operator: 'Π'), resolvedColor);
      case 'limₓ→□(□)':
        return _withHiddenText(value, _LimitBodyTargetGlyph(variant: variant, color: resolvedColor, targetPrefix: 'x→', targetPlaceholder: true), resolvedColor);
      case 'limₓ→∞(□)':
        return _withHiddenText(value, _LimitBodyTargetGlyph(variant: variant, color: resolvedColor, targetPrefix: 'x→∞'), resolvedColor);
      case 'limₓ→0(□)':
        return _withHiddenText(value, _LimitBodyTargetGlyph(variant: variant, color: resolvedColor, targetPrefix: 'x→0'), resolvedColor);
      case 'limₓ→0⁺(□)':
        return _withHiddenText(value, _LimitBodyTargetGlyph(variant: variant, color: resolvedColor, targetPrefix: 'x→0⁺'), resolvedColor);
      case 'limₓ→0⁻(□)':
        return _withHiddenText(value, _LimitBodyTargetGlyph(variant: variant, color: resolvedColor, targetPrefix: 'x→0⁻'), resolvedColor);
      case 'lim sin(x)/x':
        return _withHiddenText(value, _LimitBodyTargetGlyph(variant: variant, color: resolvedColor, targetPrefix: 'x→0', bodyText: 'sin(x)/x'), resolvedColor);
      case 'ln(□)':
        return _withHiddenText(value, _FunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'ln'), resolvedColor);
      case 'sin(□)':
        return _withHiddenText(value, _FunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'sin'), resolvedColor);
      case 'cos(□)':
        return _withHiddenText(value, _FunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'cos'), resolvedColor);
      case 'tan(□)':
        return _withHiddenText(value, _FunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'tan'), resolvedColor);
            case 'sin⁻¹(□)':
        return _withHiddenText('sin⁻¹(□)', _InverseFunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'sin'), resolvedColor);
            case 'cos⁻¹(□)':
        return _withHiddenText('cos⁻¹(□)', _InverseFunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'cos'), resolvedColor);
            case 'tan⁻¹(□)':
        return _withHiddenText('tan⁻¹(□)', _InverseFunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'tan'), resolvedColor);
      case 'sinh(□)':
        return _withHiddenText(value, _FunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'sinh'), resolvedColor);
      case 'cosh(□)':
        return _withHiddenText(value, _FunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'cosh'), resolvedColor);
      case 'tanh(□)':
        return _withHiddenText(value, _FunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'tanh'), resolvedColor);
      case 'cot(□)':
        return _withHiddenText(value, _FunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'cot'), resolvedColor);
      case 'sec(□)':
        return _withHiddenText(value, _FunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'sec'), resolvedColor);
      case 'csc(□)':
        return _withHiddenText(value, _FunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'csc'), resolvedColor);
      case 'coth(□)':
        return _withHiddenText(value, _FunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'coth'), resolvedColor);
            case 'cot⁻¹(□)':
        return _withHiddenText('cot⁻¹(□)', _InverseFunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'cot'), resolvedColor);
            case 'sinh⁻¹(□)':
        return _withHiddenText('sinh⁻¹(□)', _InverseFunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'sinh'), resolvedColor);
            case 'cosh⁻¹(□)':
        return _withHiddenText('cosh⁻¹(□)', _InverseFunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'cosh'), resolvedColor);
            case 'tanh⁻¹(□)':
        return _withHiddenText('tanh⁻¹(□)', _InverseFunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'tanh'), resolvedColor);
      case 'Re(□)':
        return _withHiddenText(value, _FunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'Re'), resolvedColor);
      case 'Im(□)':
        return _withHiddenText(value, _FunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'Im'), resolvedColor);
      case 'arg(□)':
        return _withHiddenText(value, _FunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'arg'), resolvedColor);
      case 'cis(□)':
        return _withHiddenText(value, _FunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'cis'), resolvedColor);
      case 'Γ(□)':
        return _withHiddenText(value, _FunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'Γ'), resolvedColor);
      case 'det(□)':
        return _withHiddenText(value, _FunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'det'), resolvedColor);
      case 'f(□)':
        return _withHiddenText(value, _FunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'f'), resolvedColor);
      case 'g(□)':
        return _withHiddenText(value, _FunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'g'), resolvedColor);
      case 'h(□)':
        return _withHiddenText(value, _FunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'h'), resolvedColor);
      case 'f(□,□)':
        return _withHiddenText(value, _FunctionArgumentGlyph(variant: variant, color: resolvedColor, functionLabel: 'f', argumentCount: 2), resolvedColor);
      case 'd/dx(□)':
        return _withHiddenText(value, _FractionDerivativeGlyph(variant: variant, color: resolvedColor, numerator: 'd', denominator: 'dx', trailingArgumentSlot: true), resolvedColor);
      case 'd²/dx²(□)':
        return _withHiddenText(value, _FractionDerivativeGlyph(variant: variant, color: resolvedColor, numerator: 'd²', denominator: 'dx²', trailingArgumentSlot: true), resolvedColor);
      case 'd³/dx³(□)':
        return _withHiddenText(value, _FractionDerivativeGlyph(variant: variant, color: resolvedColor, numerator: 'd³', denominator: 'dx³', trailingArgumentSlot: true), resolvedColor);
      case '∂/∂x(□)':
        return _withHiddenText(value, _FractionDerivativeGlyph(variant: variant, color: resolvedColor, numerator: '∂', denominator: '∂x', trailingArgumentSlot: true), resolvedColor);
      case '∂²/∂x²(□)':
        return _withHiddenText(value, _FractionDerivativeGlyph(variant: variant, color: resolvedColor, numerator: '∂²', denominator: '∂x²', trailingArgumentSlot: true), resolvedColor);
      case 'dy/dx':
        return _withHiddenText(value, _FractionDerivativeGlyph(variant: variant, color: resolvedColor, numerator: 'dy', denominator: 'dx'), resolvedColor);
      case 'd²y/dx²':
        return _withHiddenText(value, _FractionDerivativeGlyph(variant: variant, color: resolvedColor, numerator: 'd²y', denominator: 'dx²'), resolvedColor);
      case 'lim x→□':
        return _withHiddenText(value, _LimitTargetGlyph(variant: variant, color: resolvedColor, target: 'x→', usePlaceholder: true), resolvedColor);
      case 'lim x→∞':
        return _withHiddenText(value, _LimitTargetGlyph(variant: variant, color: resolvedColor, target: 'x→∞'), resolvedColor);
      case 'lim x→0⁺':
        return _withHiddenText(value, _LimitTargetGlyph(variant: variant, color: resolvedColor, target: 'x→0⁺'), resolvedColor);
      case 'lim x→0⁻':
        return _withHiddenText(value, _LimitTargetGlyph(variant: variant, color: resolvedColor, target: 'x→0⁻'), resolvedColor);
    }
    return null;
  }

  String _normalizeCompact(String value, {required bool compact}) {
    if (!compact) return value;
    switch (value) {
      case 'frac':
      case '□/□':
      case '□⁄□':
        return '□⁄□';
      case '| |':
      case '|□|':
        return '|□|';
      case '‖ ‖':
      case '‖□‖':
        return '‖□‖';
      case '□^□':
        return '□^□';
      case '∫□dx':
        return '∫□dx';
      case '{□=□':
        return '{□=□';
      case 'log₍□₎(□)':
        return 'logₙ';
      case 'log₁₀(□)':
        return 'log₁₀';
      case 'log₂(□)':
        return 'log₂';
      case 'ln(□)':
        return 'ln';
      case '∛□':
        return '³√';
      case '□√□':
        return 'ⁿ√';
      default:
        return value;
    }
  }

  TextStyle _styleFor(String value, MathLabelVariant variant) {
    final compact = variant == MathLabelVariant.keycap || variant == MathLabelVariant.chip;
    final profile = MathKeyVisualContract.profileFor(value);
    final weight = switch (profile.weightClass) {
      'regular' => FontWeight.w400,
      'semibold' => FontWeight.w600,
      _ => FontWeight.w500,
    };

    return TextStyle(
      fontFamily: MathProTypography.mathFontFamily,
      color: MathProColors.text,
      fontSize: compact ? profile.compactFontSize : profile.inlineFontSize,
      fontWeight: weight,
      letterSpacing: profile.letterSpacing,
      height: profile.height,
    );
  }
}

class _FractionGlyph extends StatelessWidget {
  const _FractionGlyph({required this.variant, required this.color});

  final MathLabelVariant variant;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    final width = isChip ? 52.0 : 35.0;
    final height = isChip ? 46.0 : 27.0;
    final boxSize = isChip ? 11.4 : 7.0;
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _SlotBox(size: boxSize, color: color),
          Padding(
            padding: EdgeInsets.symmetric(vertical: isChip ? 3.0 : 1.35),
            child: Container(width: width * 0.58, height: 1.05, color: color.withValues(alpha: 0.86)),
          ),
          _SlotBox(size: boxSize, color: color),
        ],
      ),
    );
  }
}

class _PowerGlyph extends StatelessWidget {
  const _PowerGlyph({required this.variant, required this.color});

  final MathLabelVariant variant;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    final width = isChip ? 58.0 : 40.0;
    final height = isChip ? 48.0 : 32.5;
    final baseSize = isChip ? 14.2 : 9.4;
    final exponentSize = isChip ? 9.8 : 7.0;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(left: isChip ? 12 : 8, bottom: isChip ? 12 : 7.5, child: _SlotBox(size: baseSize, color: color)),
          Positioned(left: isChip ? 33 : 24, top: isChip ? 8.2 : 5.5, child: _SlotBox(size: exponentSize, color: color)),
        ],
      ),
    );
  }
}


class _RootGlyph extends StatelessWidget {
  const _RootGlyph({required this.variant, required this.color});

  final MathLabelVariant variant;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    final width = isChip ? 54.0 : 34.0;
    final height = isChip ? 40.0 : 27.0;
    final slotSize = isChip ? 13.0 : 8.4;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(child: CustomPaint(painter: _RootPainter(color: color, isChip: isChip))),
          Positioned(left: isChip ? 31 : 20, bottom: isChip ? 9.4 : 6.4, child: _SlotBox(size: slotSize, color: color)),
        ],
      ),
    );
  }
}

class _RootPainter extends CustomPainter {
  const _RootPainter({required this.color, required this.isChip});

  final Color color;
  final bool isChip;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.94)
      ..strokeWidth = isChip ? 2.10 : 1.65
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final left = size.width * 0.10;
    final mid1 = size.width * 0.25;
    final mid2 = size.width * 0.36;
    final top = size.height * 0.20;
    final base = size.height * 0.76;
    final overbarEnd = size.width * 0.86;
    final path = Path()
      ..moveTo(left, size.height * 0.60)
      ..lineTo(mid1, base)
      ..lineTo(mid2, top)
      ..lineTo(overbarEnd, top);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _RootPainter oldDelegate) => oldDelegate.color != color || oldDelegate.isChip != isChip;
}

class _IntegralDxGlyph extends StatelessWidget {
  const _IntegralDxGlyph({required this.variant, required this.color});

  final MathLabelVariant variant;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    final width = isChip ? 84.0 : 56.0;
    final height = isChip ? 48.0 : 30.0;
    final integralSize = isChip ? 31.0 : 21.5;
    final boxSize = isChip ? 10.2 : 7.4;
    final dxSize = isChip ? 13.2 : 9.8;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: isChip ? 7 : 3.8,
            top: isChip ? 2 : 0,
            child: Text(
              '∫',
              style: TextStyle(
                fontFamily: MathProTypography.mathFontFamily,
                color: color,
                fontSize: integralSize,
                fontWeight: FontWeight.w500,
                height: 1.0,
                letterSpacing: -1.8,
              ),
            ),
          ),
          Positioned(left: isChip ? 37 : 24.5, top: isChip ? 18 : 10.8, child: _SlotBox(size: boxSize, color: color)),
          Positioned(
            right: isChip ? 8 : 5,
            bottom: isChip ? 11 : 6.6,
            child: Text(
              'dx',
              style: TextStyle(
                fontFamily: MathProTypography.mathFontFamily,
                color: color.withValues(alpha: 0.94),
                fontSize: dxSize,
                fontWeight: FontWeight.w500,
                height: 1.0,
                letterSpacing: -0.55,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummationGlyph extends StatelessWidget {
  const _SummationGlyph({required this.variant, required this.color, this.operator = 'Σ'});

  final MathLabelVariant variant;
  final Color color;
  final String operator;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    return SizedBox(
      width: isChip ? 56 : 36,
      height: isChip ? 44 : 29,
      child: Center(
        child: Text(
          operator,
          maxLines: 1,
          style: TextStyle(
            fontFamily: MathProTypography.mathFontFamily,
            color: color,
            fontSize: isChip ? 25.0 : 18.4,
            fontWeight: FontWeight.w500,
            height: 0.95,
            letterSpacing: -0.9,
          ),
        ),
      ),
    );
  }
}

class _DerivativeGlyph extends StatelessWidget {
  const _DerivativeGlyph({required this.variant, required this.color});

  final MathLabelVariant variant;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    final width = isChip ? 64.0 : 42.0;
    final height = isChip ? 40.0 : 28.0;
    final numeratorSize = isChip ? 14.0 : 9.4;
    final denominatorSize = isChip ? 12.8 : 8.7;
    final ruleWidth = isChip ? 33.0 : 22.0;

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: isChip ? 3.2 : 1.8,
            child: Text(
              'd',
              style: TextStyle(
                fontFamily: MathProTypography.mathFontFamily,
                color: color,
                fontSize: numeratorSize,
                fontWeight: FontWeight.w500,
                height: 1.0,
                letterSpacing: -0.35,
              ),
            ),
          ),
          Positioned(
            top: isChip ? 19.0 : 13.0,
            child: Text(
              'dx',
              style: TextStyle(
                fontFamily: MathProTypography.mathFontFamily,
                color: color.withValues(alpha: 0.96),
                fontSize: denominatorSize,
                fontWeight: FontWeight.w500,
                height: 1.0,
                letterSpacing: -0.45,
              ),
            ),
          ),
          Positioned(
            top: isChip ? 17.1 : 11.5,
            child: Container(
              width: ruleWidth,
              height: isChip ? 1.25 : 1.05,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.94),
                borderRadius: BorderRadius.circular(1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LimitGlyph extends StatelessWidget {
  const _LimitGlyph({required this.variant, required this.color});

  final MathLabelVariant variant;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    return Text(
      'lim',
      maxLines: 1,
      style: TextStyle(
        fontFamily: MathProTypography.mathFontFamily,
        color: color,
        fontSize: isChip ? 16.2 : 12.2,
        fontWeight: FontWeight.w500,
        height: 1.0,
        letterSpacing: -0.18,
      ),
    );
  }
}

class _FactorialGlyph extends StatelessWidget {
  const _FactorialGlyph({required this.variant, required this.color});

  final MathLabelVariant variant;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    final slot = isChip ? 11.4 : 8.2;
    return SizedBox(
      width: isChip ? 54 : 35,
      height: isChip ? 36 : 26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _SlotBox(size: slot, color: color),
          SizedBox(width: isChip ? 5 : 3.5),
          Text(
            '!',
            style: TextStyle(
              fontFamily: MathProTypography.mathFontFamily,
              color: color,
              fontSize: isChip ? 20.5 : 14.8,
              fontWeight: FontWeight.w500,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}


class _BinarySlotOperatorGlyph extends StatelessWidget {
  const _BinarySlotOperatorGlyph({
    required this.variant,
    required this.color,
    required this.operator,
  });

  final MathLabelVariant variant;
  final Color color;
  final String operator;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    final slotSize = isChip ? 11.2 : 7.8;
    final operatorSize = isChip ? 12.6 : 9.2;
    final gap = isChip ? 3.4 : 2.2;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _SlotBox(size: slotSize, color: color),
        SizedBox(width: gap),
        Text(
          operator,
          style: TextStyle(
            fontFamily: MathProTypography.mathFontFamily,
            color: color.withValues(alpha: 0.96),
            fontSize: operatorSize,
            fontWeight: FontWeight.w500,
            height: 1.0,
            letterSpacing: -0.2,
          ),
        ),
        SizedBox(width: gap),
        _SlotBox(size: slotSize, color: color),
      ],
    );
  }
}

class _AbsGlyph extends StatelessWidget {
  const _AbsGlyph({required this.variant, required this.color});

  final MathLabelVariant variant;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    final slot = isChip ? 12.5 : 8.2;
    final barHeight = isChip ? 30.0 : 21.0;
    final barWidth = isChip ? 1.65 : 1.25;
    return SizedBox(
      width: isChip ? 54 : 35,
      height: isChip ? 36 : 26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _AbsBar(width: barWidth, height: barHeight, color: color),
          SizedBox(width: isChip ? 6 : 4),
          _SlotBox(size: slot, color: color),
          SizedBox(width: isChip ? 6 : 4),
          _AbsBar(width: barWidth, height: barHeight, color: color),
        ],
      ),
    );
  }
}

class _AbsBar extends StatelessWidget {
  const _AbsBar({required this.width, required this.height, required this.color});

  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(width),
      ),
    );
  }
}

class _SystemGlyph extends StatelessWidget {
  const _SystemGlyph({required this.variant, required this.color});

  final MathLabelVariant variant;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    final width = isChip ? 74.0 : 43.0;
    final height = isChip ? 54.0 : 29.0;
    final fontSize = isChip ? 28.0 : 18.0;
    final boxSize = isChip ? 8.5 : 6.1;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: isChip ? 6 : 2,
            top: isChip ? 6 : 3,
            child: Text(
              '{',
              style: TextStyle(
                fontFamily: MathProTypography.mathFontFamily,
                color: color,
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                height: 1.0,
              ),
            ),
          ),
          Positioned(right: isChip ? 7 : 3.5, top: isChip ? 10 : 4.5, child: _EquationRow(boxSize: boxSize, color: color)),
          Positioned(right: isChip ? 7 : 3.5, bottom: isChip ? 10 : 4.5, child: _EquationRow(boxSize: boxSize, color: color)),
        ],
      ),
    );
  }
}

class _MatrixGlyph extends StatelessWidget {
  const _MatrixGlyph({required this.variant, required this.color});

  final MathLabelVariant variant;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    final width = isChip ? 56.0 : 38.0;
    final height = isChip ? 52.0 : 29.0;
    final boxSize = isChip ? 9.0 : 6.4;
    return _BracketedGlyph(
      width: width,
      height: height,
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(mainAxisSize: MainAxisSize.min, children: [_SlotBox(size: boxSize, color: color), SizedBox(width: isChip ? 7 : 4), _SlotBox(size: boxSize, color: color)]),
          SizedBox(height: isChip ? 6 : 3),
          Row(mainAxisSize: MainAxisSize.min, children: [_SlotBox(size: boxSize, color: color), SizedBox(width: isChip ? 7 : 4), _SlotBox(size: boxSize, color: color)]),
        ],
      ),
    );
  }
}

class _VectorGlyph extends StatelessWidget {
  const _VectorGlyph({required this.variant, required this.color});

  final MathLabelVariant variant;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    final width = isChip ? 46.0 : 30.0;
    final height = isChip ? 52.0 : 29.0;
    final boxSize = isChip ? 9.0 : 6.4;
    return _BracketedGlyph(
      width: width,
      height: height,
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _SlotBox(size: boxSize, color: color),
          SizedBox(height: isChip ? 6 : 3.5),
          _SlotBox(size: boxSize, color: color),
        ],
      ),
    );
  }
}

class _BracketedGlyph extends StatelessWidget {
  const _BracketedGlyph({required this.width, required this.height, required this.color, required this.child});

  final double width;
  final double height;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(left: 2, top: 3, bottom: 3, child: _BracketSide(color: color, left: true)),
          Positioned(right: 2, top: 3, bottom: 3, child: _BracketSide(color: color, left: false)),
          child,
        ],
      ),
    );
  }
}

class _BracketSide extends StatelessWidget {
  const _BracketSide({required this.color, required this.left});

  final Color color;
  final bool left;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 5,
      child: CustomPaint(painter: _BracketPainter(color: color, left: left)),
    );
  }
}

class _BracketPainter extends CustomPainter {
  const _BracketPainter({required this.color, required this.left});

  final Color color;
  final bool left;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.9)
      ..strokeWidth = 1.15
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final x = left ? size.width : 0.0;
    final inner = left ? 0.0 : size.width;
    final path = Path()
      ..moveTo(x, 0)
      ..lineTo(inner, 0)
      ..moveTo(x, 0)
      ..lineTo(x, size.height)
      ..moveTo(x, size.height)
      ..lineTo(inner, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _BracketPainter oldDelegate) => oldDelegate.color != color || oldDelegate.left != left;
}

class _EquationRow extends StatelessWidget {
  const _EquationRow({required this.boxSize, required this.color});

  final double boxSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SlotBox(size: boxSize, color: color),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: boxSize * 0.55),
          child: Container(
            width: boxSize * 1.15,
            height: 1.2,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ),
        _SlotBox(size: boxSize, color: color),
      ],
    );
  }
}

class _BoundedIntegralGlyph extends StatelessWidget {
  const _BoundedIntegralGlyph({required this.variant, required this.color});

  final MathLabelVariant variant;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    final width = isChip ? 94.0 : 60.0;
    final height = isChip ? 72.0 : 40.0;
    final boxSize = isChip ? 13.2 : 9.2;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            left: isChip ? 14 : 8,
            top: isChip ? 2 : -1,
            child: Text(
              '∫',
              maxLines: 1,
              overflow: TextOverflow.visible,
              style: TextStyle(
                fontFamily: MathProTypography.mathFontFamily,
                color: color,
                fontSize: isChip ? 51 : 31,
                fontWeight: FontWeight.w600,
                height: 1.0,
              ),
            ),
          ),
          Positioned(left: isChip ? 61 : 34, top: isChip ? 8 : 2, child: _SlotBox(size: boxSize, color: color)),
          Positioned(left: isChip ? 59 : 33, bottom: isChip ? 8 : 2, child: _SlotBox(size: boxSize, color: color)),
        ],
      ),
    );
  }
}



class _SubscriptGlyph extends StatelessWidget {
  const _SubscriptGlyph({
    required this.variant,
    required this.color,
    required this.baseText,
    this.subscriptText = '',
    this.subscriptPlaceholder = false,
  });

  final MathLabelVariant variant;
  final Color color;
  final String baseText;
  final String subscriptText;
  final bool subscriptPlaceholder;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    return SizedBox(
      width: isChip ? 38 : 26,
      height: isChip ? 42 : 28,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: isChip ? 7 : 4,
            top: isChip ? 6 : 4,
            child: Text(
              baseText,
              style: TextStyle(
                fontFamily: MathProTypography.mathFontFamily,
                color: color,
                fontSize: isChip ? 24 : 16,
                fontWeight: FontWeight.w600,
                height: 1.0,
              ),
            ),
          ),
          Positioned(
            left: isChip ? 22 : 14.5,
            bottom: isChip ? 5 : 3,
            child: subscriptPlaceholder
                ? _SlotBox(size: isChip ? 8.8 : 6.0, color: color)
                : Text(
                    subscriptText,
                    style: TextStyle(
                      fontFamily: MathProTypography.mathFontFamily,
                      color: color.withValues(alpha: 0.95),
                      fontSize: isChip ? 12 : 8.5,
                      fontWeight: FontWeight.w600,
                      height: 1.0,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _PrimeGlyph extends StatelessWidget {
  const _PrimeGlyph({
    required this.variant,
    required this.color,
    required this.baseText,
    required this.primeText,
  });

  final MathLabelVariant variant;
  final Color color;
  final String baseText;
  final String primeText;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    return SizedBox(
      width: isChip ? 56 : 36,
      height: isChip ? 42 : 28,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: isChip ? 8 : 5,
            bottom: isChip ? 5 : 3,
            child: Text(
              baseText,
              style: TextStyle(
                fontFamily: MathProTypography.mathFontFamily,
                color: color,
                fontSize: isChip ? 24 : 16,
                fontWeight: FontWeight.w600,
                height: 1.0,
              ),
            ),
          ),
          Positioned(
            left: isChip ? 27 : 17.5,
            top: isChip ? 3.8 : 2.0,
            child: primeText == '(□)'
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('(', style: TextStyle(fontFamily: MathProTypography.mathFontFamily, color: color, fontSize: isChip ? 12 : 9, fontWeight: FontWeight.w600, height: 1.0)),
                      _SlotBox(size: isChip ? 8.2 : 5.8, color: color),
                      Text(')', style: TextStyle(fontFamily: MathProTypography.mathFontFamily, color: color, fontSize: isChip ? 12 : 9, fontWeight: FontWeight.w600, height: 1.0)),
                    ],
                  )
                : Text(
                    primeText,
                    style: TextStyle(
                      fontFamily: MathProTypography.mathFontFamily,
                      color: color.withValues(alpha: 0.96),
                      fontSize: isChip ? 15 : 10.5,
                      fontWeight: FontWeight.w600,
                      height: 1.0,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _ExponentialGlyph extends StatelessWidget {
  const _ExponentialGlyph({
    required this.variant,
    required this.color,
    required this.baseText,
    this.exponentPrefix,
  });

  final MathLabelVariant variant;
  final Color color;
  final String baseText;
  final String? exponentPrefix;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    final baseFontSize = isChip ? (baseText == '10' ? 20.0 : 23.0) : (baseText == '10' ? 13.5 : 15.5);
    final slotSize = isChip ? 8.8 : 6.1;
    final exponentFontSize = isChip ? 10.8 : 7.8;
    final baseLeft = isChip ? 8.0 : 5.0;
    final baseBottom = isChip ? 6.0 : 4.0;
    final exponentLeft = baseText == '10'
        ? (isChip ? 29.0 : 19.0)
        : (isChip ? 20.0 : 13.2);

    return SizedBox(
      width: isChip ? (baseText == '10' ? 64 : 48) : (baseText == '10' ? 44 : 32),
      height: isChip ? 42 : 28,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: baseLeft,
            bottom: baseBottom,
            child: Text(
              baseText,
              style: TextStyle(
                fontFamily: MathProTypography.mathFontFamily,
                color: color,
                fontSize: baseFontSize,
                fontWeight: FontWeight.w600,
                height: 1.0,
              ),
            ),
          ),
          Positioned(
            left: exponentLeft,
            top: isChip ? 5 : 3,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (exponentPrefix != null)
                  Padding(
                    padding: EdgeInsets.only(right: isChip ? 1.6 : 1.0, top: isChip ? 0.4 : 0.2),
                    child: Text(
                      exponentPrefix!,
                      style: TextStyle(
                        fontFamily: MathProTypography.mathFontFamily,
                        color: color,
                        fontSize: exponentFontSize,
                        fontWeight: FontWeight.w600,
                        height: 1.0,
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(top: isChip ? 0.4 : 0.2),
                  child: _SlotBox(size: slotSize, color: color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecificPowerGlyph extends StatelessWidget {
  const _SpecificPowerGlyph({
    required this.variant,
    required this.color,
    this.exponentText = '',
    this.exponentPlaceholder = false,
  });

  final MathLabelVariant variant;
  final Color color;
  final String exponentText;
  final bool exponentPlaceholder;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    return SizedBox(
      width: isChip ? 54 : 36,
      height: isChip ? 42 : 29,
      child: Stack(
        children: [
          Positioned(left: isChip ? 8 : 5, bottom: isChip ? 5 : 3, child: _SlotBox(size: isChip ? 12.5 : 8.6, color: color)),
          Positioned(
            right: isChip ? 5 : 3,
            top: isChip ? 5 : 3,
            child: exponentPlaceholder
                ? _SlotBox(size: isChip ? 8.6 : 5.8, color: color)
                : Text(
                    exponentText,
                    style: TextStyle(
                      fontFamily: MathProTypography.mathFontFamily,
                      color: color,
                      fontSize: isChip ? 11 : 8,
                      fontWeight: FontWeight.w600,
                      height: 1.0,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _LogGlyph extends StatelessWidget {
  const _LogGlyph({
    required this.variant,
    required this.color,
    this.subscriptText = '',
    this.subscriptPlaceholder = false,
    this.argumentText,
  });

  final MathLabelVariant variant;
  final Color color;
  final String subscriptText;
  final bool subscriptPlaceholder;
  final String? argumentText;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    final slot = isChip ? 9.0 : 6.2;
    final argumentFontSize = isChip ? 10.6 : 7.5;
    return SizedBox(
      width: isChip ? 82 : 54,
      height: isChip ? 44 : 30,
      child: Stack(
        children: [
          Positioned(
            left: isChip ? 2 : 1,
            bottom: isChip ? 7 : 4,
            child: Text(
              'log',
              style: TextStyle(
                fontFamily: MathProTypography.mathFontFamily,
                color: color,
                fontSize: isChip ? 20.5 : 13.4,
                fontWeight: FontWeight.w600,
                height: 1.0,
              ),
            ),
          ),
          Positioned(
            left: isChip ? 27 : 17.4,
            bottom: isChip ? 4.2 : 2.3,
            child: subscriptPlaceholder
                ? _SlotBox(size: isChip ? 8.2 : 5.4, color: color)
                : Text(
                    subscriptText,
                    style: TextStyle(
                      fontFamily: MathProTypography.mathFontFamily,
                      color: color.withValues(alpha: 0.96),
                      fontSize: isChip ? 10.5 : 7.5,
                      fontWeight: FontWeight.w600,
                      height: 1.0,
                    ),
                  ),
          ),
          Positioned(
            right: isChip ? 2 : 0,
            top: isChip ? 9 : 5.4,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('(', style: TextStyle(fontFamily: MathProTypography.mathFontFamily, color: color, fontSize: isChip ? 13 : 9.5, fontWeight: FontWeight.w600, height: 1.0)),
                argumentText == null
                    ? _SlotBox(size: slot, color: color)
                    : ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: isChip ? 22 : 14),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            argumentText!,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: MathProTypography.mathFontFamily,
                              color: color.withValues(alpha: 0.96),
                              fontSize: argumentFontSize,
                              fontWeight: FontWeight.w600,
                              height: 1.0,
                            ),
                          ),
                        ),
                      ),
                Text(')', style: TextStyle(fontFamily: MathProTypography.mathFontFamily, color: color, fontSize: isChip ? 13 : 9.5, fontWeight: FontWeight.w600, height: 1.0)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IndexedRootGlyph extends StatelessWidget {
  const _IndexedRootGlyph({
    required this.variant,
    required this.color,
    this.indexText = '',
    this.indexPlaceholder = false,
  });

  final MathLabelVariant variant;
  final Color color;
  final String indexText;
  final bool indexPlaceholder;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    final width = isChip ? 62.0 : 39.0;
    final height = isChip ? 42.0 : 28.0;
    final valueSlot = isChip ? 12.6 : 8.2;
    final indexSlot = isChip ? 8.0 : 5.5;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            left: isChip ? 8.0 : 5.0,
            child: CustomPaint(painter: _RootPainter(color: color, isChip: isChip)),
          ),
          Positioned(
            left: isChip ? 1.5 : 0.8,
            top: isChip ? 2.0 : 1.1,
            child: indexPlaceholder
                ? _SlotBox(size: indexSlot, color: color)
                : Text(
                    indexText,
                    style: TextStyle(
                      fontFamily: MathProTypography.mathFontFamily,
                      color: color.withValues(alpha: 0.96),
                      fontSize: isChip ? 11.0 : 7.8,
                      fontWeight: FontWeight.w600,
                      height: 1.0,
                    ),
                  ),
          ),
          Positioned(left: isChip ? 39 : 24.5, bottom: isChip ? 9.2 : 6.1, child: _SlotBox(size: valueSlot, color: color)),
        ],
      ),
    );
  }
}

class _InverseFunctionArgumentGlyph extends StatelessWidget {
  const _InverseFunctionArgumentGlyph({
    required this.variant,
    required this.color,
    required this.functionLabel,
  });

  final MathLabelVariant variant;
  final Color color;
  final String functionLabel;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    final width = isChip ? (functionLabel.length >= 4 ? 92.0 : 80.0) : (functionLabel.length >= 4 ? 62.0 : 52.0);
    final height = isChip ? 38.0 : 26.0;
    final baseFont = isChip ? 18.0 : 12.5;
    final exponentFont = isChip ? 9.0 : 6.5;
    final slot = isChip ? 9.4 : 6.4;
    final baseWidth = functionLabel.length >= 4 ? (isChip ? 41.0 : 27.0) : (isChip ? 28.0 : 18.4);

    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: baseWidth + (isChip ? 12 : 8),
              height: height,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 0,
                    bottom: isChip ? 6.2 : 4.0,
                    child: Text(
                      functionLabel,
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontFamily: MathProTypography.mathFontFamily,
                        color: color,
                        fontSize: baseFont,
                        fontWeight: FontWeight.w600,
                        height: 1.0,
                        letterSpacing: -0.28,
                      ),
                    ),
                  ),
                  Positioned(
                    left: baseWidth,
                    top: isChip ? 3.4 : 2.0,
                    child: Text(
                      '−1',
                      style: TextStyle(
                        fontFamily: MathProTypography.mathFontFamily,
                        color: color.withValues(alpha: 0.96),
                        fontSize: exponentFont,
                        fontWeight: FontWeight.w600,
                        height: 1.0,
                        letterSpacing: -0.25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: isChip ? 1.0 : 0.6),
            Text('(', style: TextStyle(fontFamily: MathProTypography.mathFontFamily, color: color, fontSize: isChip ? 13.5 : 9.6, fontWeight: FontWeight.w600, height: 1.0)),
            _SlotBox(size: slot, color: color),
            Text(')', style: TextStyle(fontFamily: MathProTypography.mathFontFamily, color: color, fontSize: isChip ? 13.5 : 9.6, fontWeight: FontWeight.w600, height: 1.0)),
          ],
        ),
      ),
    );
  }
}

class _FunctionArgumentGlyph extends StatelessWidget {
  const _FunctionArgumentGlyph({
    required this.variant,
    required this.color,
    required this.functionLabel,
    this.argumentCount = 1,
  });

  final MathLabelVariant variant;
  final Color color;
  final String functionLabel;
  final int argumentCount;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    final slot = isChip ? 10.0 : 6.8;
    final functionFontSize = isChip ? 18.2 : 12.7;
    final parenFontSize = isChip ? 14.5 : 10.2;
    final commaFontSize = isChip ? 12.0 : 8.5;
    final width = isChip ? (argumentCount == 1 ? 80.0 : 96.0) : (argumentCount == 1 ? 52.0 : 64.0);
    final height = isChip ? 34.0 : 24.0;

    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                functionLabel,
                maxLines: 1,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  fontFamily: MathProTypography.mathFontFamily,
                  color: color,
                  fontSize: functionFontSize,
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                ),
              ),
              SizedBox(width: isChip ? 1.4 : 0.9),
              Padding(
                padding: EdgeInsets.only(top: isChip ? 0.2 : 0.1),
                child: Text(
                  '(',
                  style: TextStyle(
                    fontFamily: MathProTypography.mathFontFamily,
                    color: color,
                    fontSize: parenFontSize,
                    fontWeight: FontWeight.w600,
                    height: 1.0,
                  ),
                ),
              ),
              _SlotBox(size: slot, color: color),
              if (argumentCount == 2) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isChip ? 1.4 : 1.0),
                  child: Text(
                    ',',
                    style: TextStyle(
                      fontFamily: MathProTypography.mathFontFamily,
                      color: color,
                      fontSize: commaFontSize,
                      fontWeight: FontWeight.w600,
                      height: 1.0,
                    ),
                  ),
                ),
                _SlotBox(size: slot, color: color),
              ],
              Padding(
                padding: EdgeInsets.only(top: isChip ? 0.2 : 0.1),
                child: Text(
                  ')',
                  style: TextStyle(
                    fontFamily: MathProTypography.mathFontFamily,
                    color: color,
                    fontSize: parenFontSize,
                    fontWeight: FontWeight.w600,
                    height: 1.0,
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

class _FractionDerivativeGlyph extends StatelessWidget {
  const _FractionDerivativeGlyph({
    required this.variant,
    required this.color,
    required this.numerator,
    required this.denominator,
    this.trailingArgumentSlot = false,
  });

  final MathLabelVariant variant;
  final Color color;
  final String numerator;
  final String denominator;
  final bool trailingArgumentSlot;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    final width = isChip ? (trailingArgumentSlot ? 94.0 : 66.0) : (trailingArgumentSlot ? 62.0 : 42.0);
    final height = isChip ? 46.0 : 31.0;
    final stackWidth = isChip ? 50.0 : 33.0;
    final textSize = isChip ? 11.9 : 8.2;
    final ruleWidth = isChip ? 35.0 : 23.0;

    return SizedBox(
      width: width,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: stackWidth,
            height: height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: isChip ? 3.6 : 1.8,
                  child: Text(
                    numerator,
                    style: TextStyle(
                      fontFamily: MathProTypography.mathFontFamily,
                      color: color,
                      fontSize: textSize,
                      fontWeight: FontWeight.w600,
                      height: 1.0,
                      letterSpacing: -0.35,
                    ),
                  ),
                ),
                Positioned(
                  top: isChip ? 25 : 16.4,
                  child: Text(
                    denominator,
                    style: TextStyle(
                      fontFamily: MathProTypography.mathFontFamily,
                      color: color.withValues(alpha: 0.96),
                      fontSize: textSize,
                      fontWeight: FontWeight.w600,
                      height: 1.0,
                      letterSpacing: -0.35,
                    ),
                  ),
                ),
                Positioned(
                  top: isChip ? 22.2 : 14.5,
                  child: Container(
                    width: ruleWidth,
                    height: isChip ? 1.25 : 1.05,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.94),
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (trailingArgumentSlot) ...[
            SizedBox(width: isChip ? 4 : 3),
            Text('(', style: TextStyle(fontFamily: MathProTypography.mathFontFamily, color: color, fontSize: isChip ? 12.5 : 9, fontWeight: FontWeight.w600, height: 1.0)),
            _SlotBox(size: isChip ? 8.4 : 5.8, color: color),
            Text(')', style: TextStyle(fontFamily: MathProTypography.mathFontFamily, color: color, fontSize: isChip ? 12.5 : 9, fontWeight: FontWeight.w600, height: 1.0)),
          ],
        ],
      ),
    );
  }
}

class _LimitTargetGlyph extends StatelessWidget {
  const _LimitTargetGlyph({
    required this.variant,
    required this.color,
    required this.target,
    this.usePlaceholder = false,
  });

  final MathLabelVariant variant;
  final Color color;
  final String target;
  final bool usePlaceholder;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    return SizedBox(
      width: isChip ? 58 : 39,
      height: isChip ? 38 : 27,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: isChip ? 1 : 0,
            child: Text(
              'lim',
              style: TextStyle(
                fontFamily: MathProTypography.mathFontFamily,
                color: color,
                fontSize: isChip ? 14.0 : 10.2,
                fontWeight: FontWeight.w500,
                height: 1.0,
              ),
            ),
          ),
          Positioned(
            bottom: isChip ? 2 : 1,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  target,
                  style: TextStyle(
                    fontFamily: MathProTypography.mathFontFamily,
                    color: color.withValues(alpha: 0.94),
                    fontSize: isChip ? 9.6 : 7.0,
                    fontWeight: FontWeight.w600,
                    height: 1.0,
                  ),
                ),
                if (usePlaceholder) ...[
                  SizedBox(width: isChip ? 1.5 : 1),
                  _SlotBox(size: isChip ? 6.7 : 4.8, color: color),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _IntegralTemplateGlyph extends StatelessWidget {
  const _IntegralTemplateGlyph({required this.variant, required this.color});

  final MathLabelVariant variant;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    final width = isChip ? 92.0 : 60.0;
    final height = isChip ? 54.0 : 34.0;
    final integralSize = isChip ? 39.0 : 25.0;
    final slot = isChip ? 11.0 : 7.4;
    final dxSize = isChip ? 12.0 : 8.4;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            left: isChip ? 5 : 2.5,
            top: isChip ? 1 : 0,
            child: Text(
              '∫',
              style: TextStyle(
                fontFamily: MathProTypography.mathFontFamily,
                color: color,
                fontSize: integralSize,
                fontWeight: FontWeight.w500,
                height: 1.0,
                letterSpacing: -1.6,
              ),
            ),
          ),
          Positioned(left: isChip ? 35 : 22.5, top: isChip ? 18 : 11.2, child: _SlotBox(size: slot, color: color)),
          Positioned(
            right: isChip ? 8 : 4.5,
            bottom: isChip ? 13 : 8,
            child: Text(
              'dx',
              style: TextStyle(
                fontFamily: MathProTypography.mathFontFamily,
                color: color.withValues(alpha: 0.94),
                fontSize: dxSize,
                fontWeight: FontWeight.w500,
                height: 1.0,
                letterSpacing: -0.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DefiniteIntegralTemplateGlyph extends StatelessWidget {
  const _DefiniteIntegralTemplateGlyph({
    required this.variant,
    required this.color,
    this.lowerText,
    this.upperText,
    this.bodyText,
    this.differentialText,
  });

  final MathLabelVariant variant;
  final Color color;
  final String? lowerText;
  final String? upperText;
  final String? bodyText;
  final String? differentialText;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    final width = isChip ? 128.0 : 82.0;
    final height = isChip ? 72.0 : 42.0;
    final integralSize = isChip ? 44.0 : 27.0;
    final limitSlot = isChip ? 8.8 : 5.8;
    final bodySlot = isChip ? 11.0 : 7.4;
    final limitTextSize = isChip ? 10.2 : 7.2;
    final bodyTextSize = isChip ? 12.4 : 8.4;
    final dxText = differentialText ?? 'd□';
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            left: isChip ? 11 : 6.0,
            top: isChip ? 5 : 1.0,
            child: Text(
              '∫',
              style: TextStyle(
                fontFamily: MathProTypography.mathFontFamily,
                color: color,
                fontSize: integralSize,
                fontWeight: FontWeight.w500,
                height: 1.0,
                letterSpacing: -1.6,
              ),
            ),
          ),
          Positioned(
            left: isChip ? 43 : 26.5,
            top: isChip ? 4 : 1.6,
            child: _IntegralLimitSlotOrText(text: upperText, slotSize: limitSlot, fontSize: limitTextSize, color: color),
          ),
          Positioned(
            left: isChip ? 42 : 26.0,
            bottom: isChip ? 4 : 1.6,
            child: _IntegralLimitSlotOrText(text: lowerText, slotSize: limitSlot, fontSize: limitTextSize, color: color),
          ),
          Positioned(
            left: isChip ? 63 : 39.0,
            top: isChip ? 29 : 16.6,
            child: bodyText == null
                ? _SlotBox(size: bodySlot, color: color)
                : Text(
                    bodyText!,
                    style: TextStyle(
                      fontFamily: MathProTypography.mathFontFamily,
                      color: color.withValues(alpha: 0.96),
                      fontSize: bodyTextSize,
                      fontWeight: FontWeight.w500,
                      height: 1.0,
                      letterSpacing: -0.35,
                    ),
                  ),
          ),
          Positioned(
            right: isChip ? 8 : 4.0,
            bottom: isChip ? 20 : 12.0,
            child: dxText == 'd□'
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('d', style: TextStyle(fontFamily: MathProTypography.mathFontFamily, color: color.withValues(alpha: 0.94), fontSize: isChip ? 12.0 : 8.0, fontWeight: FontWeight.w500, height: 1.0)),
                      _SlotBox(size: isChip ? 7.6 : 5.0, color: color),
                    ],
                  )
                : Text(
                    dxText,
                    style: TextStyle(fontFamily: MathProTypography.mathFontFamily, color: color.withValues(alpha: 0.94), fontSize: isChip ? 12.0 : 8.0, fontWeight: FontWeight.w500, height: 1.0),
                  ),
          ),
        ],
      ),
    );
  }
}

class _IntegralLimitSlotOrText extends StatelessWidget {
  const _IntegralLimitSlotOrText({required this.text, required this.slotSize, required this.fontSize, required this.color});

  final String? text;
  final double slotSize;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (text == null) return _SlotBox(size: slotSize, color: color);
    return Text(
      text!,
      style: TextStyle(
        fontFamily: MathProTypography.mathFontFamily,
        color: color.withValues(alpha: 0.96),
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        height: 1.0,
      ),
    );
  }
}

class _BigOperatorTemplateGlyph extends StatelessWidget {
  const _BigOperatorTemplateGlyph({required this.variant, required this.color, required this.operator});

  final MathLabelVariant variant;
  final Color color;
  final String operator;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    final width = isChip ? 96.0 : 62.0;
    final height = isChip ? 66.0 : 40.0;
    final opSize = isChip ? 30.0 : 19.0;
    final limitSlot = isChip ? 8.4 : 5.8;
    final bodySlot = isChip ? 10.4 : 7.0;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: isChip ? 10 : 6,
            top: isChip ? 16 : 9,
            child: Text(
              operator,
              style: TextStyle(
                fontFamily: MathProTypography.mathFontFamily,
                color: color,
                fontSize: opSize,
                fontWeight: FontWeight.w500,
                height: 0.95,
                letterSpacing: -0.85,
              ),
            ),
          ),
          Positioned(left: isChip ? 43 : 27, top: isChip ? 4 : 1.8, child: _SlotBox(size: limitSlot, color: color)),
          Positioned(left: isChip ? 42 : 26.5, bottom: isChip ? 4 : 1.8, child: _SlotBox(size: limitSlot, color: color)),
          Positioned(left: isChip ? 61 : 39, top: isChip ? 28 : 17, child: _SlotBox(size: bodySlot, color: color)),
        ],
      ),
    );
  }
}

class _LimitBodyTargetGlyph extends StatelessWidget {
  const _LimitBodyTargetGlyph({
    required this.variant,
    required this.color,
    required this.targetPrefix,
    this.targetPlaceholder = false,
    this.bodyText,
  });

  final MathLabelVariant variant;
  final Color color;
  final String targetPrefix;
  final bool targetPlaceholder;
  final String? bodyText;

  @override
  Widget build(BuildContext context) {
    final isChip = variant == MathLabelVariant.chip;
    final width = isChip ? (bodyText == null ? 112.0 : 132.0) : (bodyText == null ? 72.0 : 86.0);
    final height = isChip ? 48.0 : 31.0;
    final naturalWidth = bodyText == null
        ? width
        : width + (isChip ? 54.0 : 42.0);
    final bodySlot = isChip ? 10.4 : 7.0;
    final targetSlot = isChip ? 7.4 : 5.0;
    final bodyFont = isChip ? 11.8 : 8.2;

    return SizedBox(
      width: width,
      height: height,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
        child: SizedBox(
          width: naturalWidth,
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: isChip ? 54 : 35,
                height: height,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: isChip ? 3.0 : 1.5,
                      child: Text(
                        'lim',
                        style: TextStyle(
                          fontFamily: MathProTypography.mathFontFamily,
                          color: color,
                          fontSize: isChip ? 14.4 : 10.4,
                          fontWeight: FontWeight.w500,
                          height: 1.0,
                          letterSpacing: -0.14,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: isChip ? 3.0 : 1.4,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            targetPrefix,
                            style: TextStyle(
                              fontFamily: MathProTypography.mathFontFamily,
                              color: color.withValues(alpha: 0.94),
                              fontSize: isChip ? 8.2 : 5.9,
                              fontWeight: FontWeight.w500,
                              height: 1.0,
                              letterSpacing: -0.10,
                            ),
                          ),
                          if (targetPlaceholder) ...[
                            SizedBox(width: isChip ? 1.3 : 0.8),
                            _SlotBox(size: targetSlot, color: color),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: isChip ? 3.0 : 2.0),
              bodyText == null
                  ? _SlotBox(size: bodySlot, color: color)
                  : Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          bodyText!,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            fontFamily: MathProTypography.mathFontFamily,
                            color: color.withValues(alpha: 0.96),
                            fontSize: bodyFont,
                            fontWeight: FontWeight.w600,
                            height: 1.0,
                            letterSpacing: -0.35,
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

class _SlotBox extends StatelessWidget {
  const _SlotBox({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.080),
            color.withValues(alpha: 0.032),
          ],
        ),
        borderRadius: BorderRadius.circular(size <= 7 ? 1.45 : 2.05),
        border: Border.all(color: color.withValues(alpha: 0.72), width: size <= 7 ? 0.78 : 0.92),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.055),
            blurRadius: size <= 7 ? 2.6 : 4.0,
            spreadRadius: -1.8,
          ),
        ],
      ),
      child: SizedBox(width: size, height: size),
    );
  }
}
