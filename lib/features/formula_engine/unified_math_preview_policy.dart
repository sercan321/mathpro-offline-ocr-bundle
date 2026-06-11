import 'math_expression_render_bridge.dart';
import 'legacy_raw_math_renderer_cleanup_policy.dart';
import '../../logic/premium_math_surface_policy.dart';
import '../../logic/mathpro_regression_gate.dart';

/// Central preview policy for every compact math surface.
///
/// This file intentionally does not change keyboard mappings.  It only decides
/// how an existing label should be normalized and how much visual room that
/// label needs in keycaps, MORE chips and long-press cards.  The goal is to
/// prevent the old drift where a symbol looked acceptable in one surface but
/// clipped or leaked programmer syntax in another.
class UnifiedMathPreviewPolicy {
  const UnifiedMathPreviewPolicy._();

  static const String version = 'mathpro-v107-unified-math-preview-policy';

  static String canonicalPreviewLabel(String label) {
    final firstPass = MathProRegressionGate.guardVisibleLabel(
      LegacyRawMathRendererCleanupPolicy.canonicalVisibleMath(
        PremiumMathSurfacePolicy.canonicalDisplayLabel(label.trim()),
      ),
    );
    if (firstPass.isEmpty) return firstPass;

    // V168: visible UI labels must never be replaced by their hidden
    // template/AST contract expressions.  The contract expression belongs to
    // ActionUtils/NodeFactory, not to keycaps, MORE chips or long-press cards.
    // Only raw programmer leak forms are canonicalized here.  Human-readable
    // labels such as Taylor, Kuadratik, EBOB, EKOK, 2×2 Matris and RREF stay
    // exactly human-readable on screen.
    if (_shouldRunExpressionCanonicalizer(firstPass)) {
      return MathProRegressionGate.guardVisibleLabel(
        MathExpressionRenderBridge.canonicalDisplayExpression(firstPass),
      );
    }
    return MathProRegressionGate.guardVisibleLabel(
      LegacyRawMathRendererCleanupPolicy.canonicalVisibleMath(firstPass),
    );
  }

  /// V170 visible label restoration: this value is what the user sees on
  /// keycaps, MORE chips and long-press chips. It must stay human-readable and
  /// premium; hidden AST/template expressions are handled by ActionUtils and
  /// NodeFactory, not rendered directly onto the keyboard surface.
  static String visibleDisplayLabel(String label) {
    final raw = label.trim();
    if (raw.isEmpty) return raw;
    final direct = _visibleLabelOverrides[raw];
    if (direct != null) return direct;
    final canonical = canonicalPreviewLabel(raw);
    final canonicalOverride = _visibleLabelOverrides[canonical];
    if (canonicalOverride != null) return canonicalOverride;
    return canonical;
  }




  /// V169 visual contract: a label may be a valid math action without being
  /// drawn as a structural MathLabel glyph. Human-readable names and bare
  /// function keys must stay as clean premium text; their hidden template/AST
  /// expression belongs to ActionUtils/NodeFactory only.
  static bool shouldRenderMathGlyph(String label) {
    final display = canonicalPreviewLabel(label);
    if (_humanReadableTextLabels.contains(display)) return false;
    if (_bareFunctionTextLabels.contains(display)) return false;
    if (_plainAtomicTextLabels.contains(display)) return false;
    return _containsStructuralGlyphSyntax(display) || _structuralVisualLabels.contains(display);
  }

  static bool isHumanReadableTextLabel(String label) {
    final display = canonicalPreviewLabel(label);
    return _humanReadableTextLabels.contains(display) || _bareFunctionTextLabels.contains(display);
  }

  static bool shouldUseMathPreview(String label) {
    final display = canonicalPreviewLabel(label);
    if (_humanReadableTextLabels.contains(display) || _bareFunctionTextLabels.contains(display)) return false;
    return PremiumMathSurfacePolicy.isMathSurface(display) ||
        MathExpressionRenderBridge.exposesProgrammerToken(label) ||
        _containsCompactMathSyntax(display);
  }

  static double longPressChipWidth(String label) {
    final display = canonicalPreviewLabel(label);
    if (_ultraWidePreviewLabels.contains(display) || _looksLikeLongSeries(display)) return 164.0;
    if (_extraWidePreviewLabels.contains(display) || _looksLikeCalculusPreview(display)) return 150.0;
    if (_widePreviewLabels.contains(display) || _looksLikeFunctionPreview(display)) return 134.0;
    if (shouldUseMathPreview(display)) return 122.0;
    return 104.0;
  }

  static double moreChipMinWidth(String label, {required bool compact}) {
    final display = canonicalPreviewLabel(label);
    if (_ultraWidePreviewLabels.contains(display) || _looksLikeLongSeries(display)) {
      return compact ? 96.0 : 112.0;
    }
    if (_extraWidePreviewLabels.contains(display) || _looksLikeCalculusPreview(display)) {
      return compact ? 84.0 : 98.0;
    }
    if (_widePreviewLabels.contains(display) || _looksLikeFunctionPreview(display)) {
      return compact ? 68.0 : 78.0;
    }
    if (shouldUseMathPreview(display)) return compact ? 54.0 : 64.0;
    if (display.length >= 10) return compact ? 72.0 : 84.0;
    if (display.length >= 7) return compact ? 58.0 : 68.0;
    return compact ? 42.0 : 48.0;
  }

  static double moreChipMaxWidth(String label, {required bool compact}) {
    final display = canonicalPreviewLabel(label);
    if (_ultraWidePreviewLabels.contains(display) || _looksLikeLongSeries(display)) {
      return compact ? 148.0 : 172.0;
    }
    if (_extraWidePreviewLabels.contains(display) || _looksLikeCalculusPreview(display)) {
      return compact ? 126.0 : 148.0;
    }
    if (_widePreviewLabels.contains(display) || _looksLikeFunctionPreview(display)) {
      return compact ? 108.0 : 126.0;
    }
    return compact ? 96.0 : 112.0;
  }

  static bool needsViewportProtection(String label) {
    final display = canonicalPreviewLabel(label);
    return _ultraWidePreviewLabels.contains(display) ||
        _extraWidePreviewLabels.contains(display) ||
        _looksLikeLongSeries(display) ||
        _looksLikeCalculusPreview(display) ||
        display.contains('log') ||
        display.contains('lim') ||
        display.contains('∫') ||
        display.contains('Σ') ||
        display.contains('Π');
  }

  static bool _shouldRunExpressionCanonicalizer(String value) {
    return LegacyRawMathRendererCleanupPolicy.exposesVisibleRawMath(value) ||
        MathExpressionRenderBridge.exposesProgrammerToken(value) ||
        value.contains('lim_') ||
        value.contains('lim x→') ||
        value.contains('log(') ||
        value.contains('∫₀¹') ||
        value.contains('Σᵢ₌₁ⁿ') ||
        value.contains('Πᵢ₌₁ⁿ') ||
        value.contains('asin(') ||
        value.contains('acos(') ||
        value.contains('atan(') ||
        value.contains('asinh(') ||
        value.contains('acosh(') ||
        value.contains('atanh(');
  }

  static bool _containsStructuralGlyphSyntax(String value) {
    return value.contains('□') ||
        value.contains('∫') ||
        value.contains('Σ') ||
        value.contains('Π') ||
        value.contains('√') ||
        value.contains('⁄') ||
        value.contains('⌊') ||
        value.contains('⌈') ||
        value.contains('‖') ||
        value.contains('{') ||
        value.contains('⁻¹') ||
        value.contains('ᵀ') ||
        value.contains('ᴴ');
  }

  static bool _containsCompactMathSyntax(String value) {
    return value.contains('□') ||
        value.contains('∫') ||
        value.contains('Σ') ||
        value.contains('Π') ||
        value.contains('√') ||
        value.contains('⁄') ||
        value.contains('₍') ||
        value.contains('₎') ||
        value.contains('⁻') ||
        value.contains('²') ||
        value.contains('³') ||
        value.contains('ⁿ') ||
        value.contains('ₙ') ||
        value.contains('∞') ||
        value.contains('≤') ||
        value.contains('≥') ||
        value.contains('{') ||
        value.contains('[');
  }

  static bool _looksLikeFunctionPreview(String value) {
    return RegExp(r'^(?:sin|cos|tan|sinh|cosh|tanh|ln|log|det|arg|cis|Re|Im|f|g|h)\(').hasMatch(value) ||
        value.contains('⁻¹(□)') ||
        value.contains('log₍') ||
        value.contains('log_□');
  }

  static bool _looksLikeCalculusPreview(String value) {
    return value.startsWith('lim') ||
        value.contains('∫') ||
        value.contains('Σ(') ||
        value.contains('Π(') ||
        value.contains('d/dx') ||
        value.contains('∂/∂x');
  }

  static bool _looksLikeLongSeries(String value) {
    return value.contains('serisi') ||
        value == 'Taylor' ||
        value == 'Maclaurin' ||
        value == 'Geometrik' ||
        value == 'Binom' ||
        value.contains('Σ□₌');
  }


  static const Map<String, String> _visibleLabelOverrides = <String, String>{
    // Core template keys: never show raw editable placeholder syntax on keycaps.
    '□/□': 'a⁄b',
    '□⁄□': 'a⁄b',
    'frac': 'a⁄b',
    '√□': '√x',
    '∛□': '∛x',
    '³√': '∛x',
    '□√□': 'ⁿ√x',
    'ⁿ√': 'ⁿ√x',
    'ⁿ√(□)': 'ⁿ√x',
    '□^□': 'xʸ',
    '□²': 'x²',
    '□³': 'x³',
    '□ⁿ': 'xⁿ',
    '10^□': '10ˣ',
    'e^□': 'eˣ',
    'e^(i□)': 'eⁱˣ',
    '□⁻¹': 'x⁻¹',
    '□ᵀ': 'Aᵀ',
    '□ᴴ': 'Aᴴ',
    '□!': 'x!',
    '□C□': 'nCr',
    '□P□': 'nPr',
    'Γ(□)': 'Γ(x)',
    '|□|': '|x|',
    '‖□‖': '‖x‖',
    '⌊□⌋': '⌊x⌋',
    '⌈□⌉': '⌈x⌉',

    // Function templates: display readable math, not slot-source strings.
    'sin(□)': 'sin(x)',
    'sin⁻¹(□)': 'sin⁻¹(x)',
    'sinh(□)': 'sinh(x)',
    'sinh⁻¹(□)': 'sinh⁻¹(x)',
    'cos(□)': 'cos(x)',
    'cos⁻¹(□)': 'cos⁻¹(x)',
    'cosh(□)': 'cosh(x)',
    'cosh⁻¹(□)': 'cosh⁻¹(x)',
    'tan(□)': 'tan(x)',
    'tan⁻¹(□)': 'tan⁻¹(x)',
    'tanh(□)': 'tanh(x)',
    'tanh⁻¹(□)': 'tanh⁻¹(x)',
    'cot(□)': 'cot(x)',
    'cot⁻¹(□)': 'cot⁻¹(x)',
    'coth(□)': 'coth(x)',
    'sec(□)': 'sec(x)',
    'csc(□)': 'csc(x)',
    'ln(□)': 'ln(x)',
    'log(□)': 'log(x)',
    'log₁₀(□)': 'log₁₀(x)',
    'log₂(□)': 'log₂(x)',
    'log_□(□)': 'logₐ(x)',
    'log₍□₎(□)': 'logₐ(x)',
    'det(□)': 'det(A)',
    'Re(□)': 'Re(z)',
    'real(□)': 'Re(z)',
    'Im(□)': 'Im(z)',
    'imag(□)': 'Im(z)',
    'arg(□)': 'arg(z)',
    'Arg(□)': 'Arg(z)',
    'conj(□)': 'conj(z)',
    'cis(□)': 'cis(x)',
    'f(□)': 'f(x)',
    'g(□)': 'g(x)',
    'h(□)': 'h(x)',
    'f(□,□)': 'f(x,y)',
    'f∘g': 'f∘g',

    // Calculus / structural operators.
    'd/dx(□)': 'd/dx',
    'd²/dx²(□)': 'd²/dx²',
    'd³/dx³(□)': 'd³/dx³',
    '∂/∂x(□)': '∂/∂x',
    '∂²/∂x²(□)': '∂²/∂x²',
    '∫□dx': '∫dx',
    '∫(□)dx': '∫f dx',
    '∫_{□}^{□}(□)d□': '∫ₐᵇ f dx',
    '∫₀¹(□)dx': '∫₀¹ f dx',
    'lim x→□': 'lim x→a',
    'limₓ→□(□)': 'limₓ→a f',
    'limₓ→∞(□)': 'limₓ→∞ f',
    'limₓ→0(□)': 'limₓ→0 f',
    'limₓ→0⁺(□)': 'limₓ→0⁺ f',
    'limₓ→0⁻(□)': 'limₓ→0⁻ f',
    'Σ(□)': 'Σ',
    'Π(□)': 'Π',
    'y⁽□⁾': 'y⁽ⁿ⁾',

    // Algebra / matrix templates.
    '{□=□': 'Sistem',
    '{3 denklem': '3 Denklem',
    '{n denklem': 'n Denklem',
    '{≤ sistem': 'Eşitsizlik',
    '[□ □]': 'Matris',
    '[□]': 'Vektör',
    '2×2': '2×2 Matris',
    '3×3': '3×3 Matris',
    '4×4': '4×4 Matris',
    'm×n': 'm×n Matris',
    'Iₙ': 'Iₙ',
    'I_□': 'Iₙ',
    'x_□': 'xₙ',
    'y_□': 'yₙ',

    // Vector operations.
    '□·□': 'a·b',
    'dot(□,□)': 'dot(a,b)',
    '□×□': 'a×b',
    'cross(□,□)': 'cross(a,b)',
    'proj(□,□)': 'proj(a,b)',
    'triple(□,□,□)': 'triple(a,b,c)',
  };


  static const Set<String> _humanReadableTextLabels = <String>{
    'Kuadratik',
    'Taylor',
    'Maclaurin',
    'Geometrik',
    'Binom',
    'eˣ serisi',
    'sin serisi',
    'cos serisi',
    'ln serisi',
    'arctan serisi',
    'Kalan',
    'EBOB',
    'EKOK',
    'Asal mı?',
    'İşaret',
    'Mutlak',
    'Yuvarla',
    'RREF',
    'Rank',
    'Özdeğer',
    'Çöz',
    '0 matris',
    '2×2 Matris',
    '3×3 Matris',
    'm×n',
    '2D vektör',
    '3D vektör',
    'nD vektör',
    'satır vektörü',
    'sütun vektörü',
    'Moore-Penrose',
    'projeksiyon',
    'karma çarpım',
    'birim vektör',
    'mesafe',
    'minör',
    'kofaktör',
    'Eşlenik',
  };

  static const Set<String> _bareFunctionTextLabels = <String>{
    'sin', 'cos', 'tan', 'ln', 'log', 'lim', 'd/dx', 'dy/dx',
    'sinh', 'cosh', 'tanh', 'cot', 'sec', 'csc', 'arg', 'Arg', 'cis', 'Re', 'Im', 'det',
  };

  static const Set<String> _plainAtomicTextLabels = <String>{
    'x', 'y', 'z', 'a', 'b', 'c', 'n', 'm', 'k', 'r', 'A', 'B', 'I',
    'π', 'e', 'i', 'θ', 'λ', 'μ', 'φ', 'ρ', '∞', '+∞', '−∞', '−i',
    'rad', 'deg', 'dx', 'dy', 'dt', 'dθ',
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.',
    '+', '−', '×', '÷', '%', '=', '<', '>', '≤', '≥', '≠', '≈', '≡', ',', ';', '(', ')', '[', ']',
  };

  static const Set<String> _structuralVisualLabels = <String>{
    '□/□', '□⁄□', '√□', '∛□', '□√□', '□^□', '□²', '□³', '□ⁿ',
    '□!', '□C□', '□P□', '|□|', '‖□‖', '∫□dx', '∫ₐᵇ',
    '□⁻¹', '□ᵀ', '□ᴴ', '□·□', '□×□', '[□ □]', '[□]', '{□=□', '{3 denklem', '{n denklem', '{≤ sistem',
    'f(□)', 'g(□)', 'h(□)', 'f(□,□)', 'f∘g',
  };

  static const Set<String> _widePreviewLabels = <String>{
    'log_□(□)',
    'log₍□₎(□)',
    'log₁₀(□)',
    'log₂(□)',
    'sin⁻¹(□)',
    'cos⁻¹(□)',
    'tan⁻¹(□)',
    'sinh⁻¹(□)',
    'cosh⁻¹(□)',
    'tanh⁻¹(□)',
    'd/dx(□)',
    'd²/dx²(□)',
    'd³/dx³(□)',
    '∂/∂x(□)',
    '∂²/∂x²(□)',
    'f(□,□)',
    '{□=□',
    '{≤ sistem',
    'det(□)',
  };

  static const Set<String> _extraWidePreviewLabels = <String>{
    '∫ₐᵇ',
    '∫(□)dx',
    '∫_{□}^{□}(□)d□',
    '∫₀¹(□)dx',
    '∫₀¹ f(x)',
    'limₓ→□(□)',
    'limₓ→∞(□)',
    'limₓ→0(□)',
    'limₓ→0⁺(□)',
    'limₓ→0⁻(□)',
    'lim sin(x)/x',
    'Σ(□)',
    'Π(□)',
    '2×2 Matris',
    '3×3 Matris',
    'm×n',
  };

  static const Set<String> _ultraWidePreviewLabels = <String>{
    'Taylor',
    'Maclaurin',
    'Geometrik',
    'Binom',
    'eˣ serisi',
    'sin serisi',
    'cos serisi',
    'ln serisi',
    'arctan serisi',
    'Kuadratik',
  };
}
