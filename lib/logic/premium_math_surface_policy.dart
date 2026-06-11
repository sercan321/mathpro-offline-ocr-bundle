import 'premium_math_key_specs.dart';

/// Visual source-of-truth for MathPro math surfaces.
///
/// This is intentionally UI-facing and separate from solver/CAS concerns.  It
/// answers one question for keyboard keys, MORE chips and long-press options:
/// should this label be treated as a premium mathematical surface rather than a
/// plain text chip?  Keeping that decision centralized prevents the old drift
/// where a label looked good in one surface but fell back to raw text in another.
class PremiumMathSurfacePolicy {
  const PremiumMathSurfacePolicy._();

  static const Set<String> internalProgrammerLabels = <String>{
    'asin(□)',
    'acos(□)',
    'atan(□)',
    'asinh(□)',
    'acosh(□)',
    'atanh(□)',
    'acot',
    'acot(□)',
  };

  static const Map<String, String> canonicalDisplayLabels = <String, String>{
    'asin(□)': 'sin⁻¹(□)',
    'acos(□)': 'cos⁻¹(□)',
    'atan(□)': 'tan⁻¹(□)',
    'asinh(□)': 'sinh⁻¹(□)',
    'acosh(□)': 'cosh⁻¹(□)',
    'atanh(□)': 'tanh⁻¹(□)',
    'acot': 'cot⁻¹(□)',
    'acot(□)': 'cot⁻¹(□)',
    'logₙ()': 'log_□(□)',
    'log₁₀()': 'log₁₀(□)',
    'log₂()': 'log₂(□)',
    'sin⁻¹()': 'sin⁻¹(□)',
    'cos⁻¹()': 'cos⁻¹(□)',
    'tan⁻¹()': 'tan⁻¹(□)',
    '| |': '|□|',
    '‖ ‖': '‖□‖',
    'frac': '□/□',
  };

  static String canonicalDisplayLabel(String label) => canonicalDisplayLabels[label] ?? label;

  static bool isInternalProgrammerLabel(String label) => internalProgrammerLabels.contains(label);

  static bool isMathSurface(String label) {
    final display = canonicalDisplayLabel(label);
    if (PremiumMathKeySpecs.labels.contains(display)) return true;
    if (_namedMathSurfaces.contains(display)) return true;
    return _containsMathSyntax(display);
  }

  static bool isTemplateSurface(String label) {
    final display = canonicalDisplayLabel(label);
    if (PremiumMathKeySpecs.labels.contains(display)) return true;
    return display.contains('□') ||
        display.contains('∫') ||
        display.contains('Σ') ||
        display.contains('Π') ||
        display.contains('√') ||
        display.contains('⁄') ||
        display.contains('⌊') ||
        display.contains('⌈') ||
        display.contains('‖') ||
        display.contains('{');
  }

  static double longPressChipWidth(String label) {
    final display = canonicalDisplayLabel(label);
    if (_extraWideSurfaces.contains(display)) return 148;
    if (_wideSurfaces.contains(display)) return 136;
    if (isMathSurface(display)) return 122;
    return 104;
  }

  static double moreChipMinWidth(String label, {required bool compact}) {
    final display = canonicalDisplayLabel(label);
    if (_extraWideSurfaces.contains(display)) return compact ? 84 : 98;
    if (_wideSurfaces.contains(display)) return compact ? 72 : 84;
    if (isMathSurface(display)) return compact ? 50 : 58;
    if (display.length >= 10) return compact ? 72 : 84;
    if (display.length >= 7) return compact ? 58 : 68;
    return compact ? 42 : 48;
  }

  static const Set<String> _namedMathSurfaces = <String>{
    'sin',
    'cos',
    'tan',
    'ln',
    'log',
    'lim',
    'd/dx',
    'dy/dx',
    'RREF',
    'Rank',
    'Özdeğer',
    'Çöz',
    'EBOB',
    'EKOK',
    'Asal mı?',
    'İşaret',
    'Mutlak',
    'Yuvarla',
    'Taylor',
    'Maclaurin',
    'Geometrik',
    'Binom',
    'eˣ serisi',
    'sin serisi',
    'cos serisi',
    'ln serisi',
    'arctan serisi',
  };

  static const Set<String> _wideSurfaces = <String>{
    'log_□(□)',
    'log₍□₎(□)',
    'sin⁻¹(□)',
    'cos⁻¹(□)',
    'tan⁻¹(□)',
    'sinh⁻¹(□)',
    'cosh⁻¹(□)',
    'tanh⁻¹(□)',
    'cot⁻¹(□)',
    'd/dx(□)',
    'd²/dx²(□)',
    'd³/dx³(□)',
    '∂/∂x(□)',
    '∂²/∂x²(□)',
    'lim x→□',
    'lim x→∞',
    'lim x→0⁺',
    'lim x→0⁻',
    'f(□,□)',
    'EBOB',
    'EKOK',
    'Asal mı?',
    'projeksiyon',
    'karma çarpım',
    'triple product',
    'birim vektör',
    'Moore-Penrose',
  };

  static const Set<String> _extraWideSurfaces = <String>{
    'Maclaurin',
    'Geometrik',
    'eˣ serisi',
    'sin serisi',
    'cos serisi',
    'ln serisi',
    'arctan serisi',
    'Kuadratik',
    '∫₀¹ f(x)',
    '∫(□)dx',
    '∫_{□}^{□}(□)d□',
    '∫₀¹(□)dx',
    'Σ(□)',
    'Π(□)',
    'lim sin(x)/x',
    'limₓ→□(□)',
    'limₓ→∞(□)',
    'limₓ→0(□)',
    'limₓ→0⁺(□)',
    'limₓ→0⁻(□)',
    '2×2 Matris',
    'pseudo-inverse',
    'nD vektör',
    'satır vektörü',
    'sütun vektörü',
  };

  static bool _containsMathSyntax(String value) {
    return value.contains('□') ||
        value.contains('∫') ||
        value.contains('Σ') ||
        value.contains('Π') ||
        value.contains('√') ||
        value.contains('⁄') ||
        value.contains('⁻') ||
        value.contains('ᵀ') ||
        value.contains('ᴴ') ||
        value.contains('²') ||
        value.contains('³') ||
        value.contains('ⁿ') ||
        value.contains('ₙ') ||
        value.contains('ₐ') ||
        value.contains('₀') ||
        value.contains('·') ||
        value.contains('×') ||
        value.contains('‖') ||
        value.contains('⌊') ||
        value.contains('⌈') ||
        value.contains('∞') ||
        value.contains('π') ||
        value.contains('θ') ||
        value.contains('λ') ||
        value.contains('z̄') ||
        value.contains('i²');
  }
}
