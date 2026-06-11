import 'premium_math_key_specs.dart';
import 'math_template_contract_registry.dart';

class TemplateSpec {
  const TemplateSpec({
    required this.label,
    required this.expression,
    this.focusRole,
  });

  final String label;
  final String expression;
  final String? focusRole;
}

class MorePanelCategory {
  const MorePanelCategory({
    required this.title,
    required this.labels,
  });

  final String title;
  final List<String> labels;
}


class ActionUtils {
  const ActionUtils._();

  static const List<TemplateSpec> premiumTemplates = <TemplateSpec>[
    TemplateSpec(label: 'Kuadratik', expression: '(-b±√(b²-4ac))⁄(2a)'),
    TemplateSpec(label: '(x+y)²', expression: '(x+y)²'),
    TemplateSpec(label: '∫₀¹ f(x)', expression: '∫₀¹(□)dx', focusRole: 'integralBody'),
    TemplateSpec(label: 'lim sin(x)/x', expression: 'limₓ→0(□)', focusRole: 'limitBody'),
    TemplateSpec(label: '2×2 Matris', expression: '[□ □; □ □]', focusRole: 'matrixCell'),
    TemplateSpec(label: '□·□', expression: '[□ □ □]·[□ □ □]', focusRole: 'matrixCell'),
    TemplateSpec(label: 'Euler', expression: 'r·e^(□)', focusRole: 'powerExponent'),
    TemplateSpec(label: 'Σ Seri', expression: 'Σ(□)', focusRole: 'sumBody'),
    TemplateSpec(label: '‖□‖', expression: '‖□‖', focusRole: 'functionArgument'),
    TemplateSpec(label: 'EBOB', expression: 'EBOB(□,□)', focusRole: 'functionArgument'),
    TemplateSpec(label: 'EKOK', expression: 'EKOK(□,□)', focusRole: 'functionArgument'),
    TemplateSpec(label: 'Mutlak', expression: '|□|', focusRole: 'functionArgument'),
    TemplateSpec(label: 'Yuvarla', expression: 'round(□)', focusRole: 'functionArgument'),
    TemplateSpec(label: 'cot(□)', expression: 'cot(□)', focusRole: 'functionArgument'),
    TemplateSpec(label: 'cot⁻¹(□)', expression: 'cot⁻¹(□)', focusRole: 'functionArgument'),
    TemplateSpec(label: 'coth(□)', expression: 'coth(□)', focusRole: 'functionArgument'),
    TemplateSpec(label: 'sec(□)', expression: 'sec(□)', focusRole: 'functionArgument'),
    TemplateSpec(label: 'csc(□)', expression: 'csc(□)', focusRole: 'functionArgument'),
    TemplateSpec(label: 'RREF', expression: 'rref(□)', focusRole: 'matrixCell'),
    TemplateSpec(label: 'Rank', expression: 'rank(□)', focusRole: 'matrixCell'),
    TemplateSpec(label: 'Özdeğer', expression: 'eig(□)', focusRole: 'matrixCell'),
    TemplateSpec(label: 'Çöz', expression: 'solve(□)', focusRole: 'functionArgument'),
  ];
  static const List<MorePanelCategory> morePanelCategories = <MorePanelCategory>[
    MorePanelCategory(
      title: 'Yapı',
      labels: <String>[
        'Kuadratik', '2×2 Matris', '(x+y)²', '∫₀¹ f(x)', 'lim sin(x)/x',
        '□/□', '□^□', '√□', '|□|', '{□=□', '[□ □]', '[□]', '□·□', '‖□‖',
      ],
    ),
    MorePanelCategory(
      title: 'Fonksiyon',
      labels: <String>[
        'f(□)', 'g(□)', 'h(□)', 'f(□,□)', 'f∘g', 'e^□', 'ln(□)',
        'log₁₀(□)', 'log₂(□)', 'log_□(□)', '⌊□⌋', '⌈□⌉', 'İşaret', 'Mutlak',
      ],
    ),
    MorePanelCategory(
      title: 'Trig',
      labels: <String>[
        'sin', 'cos', 'tan', 'cot(□)', 'sin⁻¹(□)', 'cos⁻¹(□)', 'tan⁻¹(□)', 'cot⁻¹(□)',
        'sinh(□)', 'cosh(□)', 'tanh(□)', 'sinh⁻¹(□)', 'cosh⁻¹(□)', 'tanh⁻¹(□)',
        'coth(□)', 'sec(□)', 'csc(□)', 'deg', 'rad',
      ],
    ),
    MorePanelCategory(
      title: 'Kalkülüs',
      labels: <String>[
        'd/dx', 'd²/dx²(□)', '∂/∂x(□)', '∂²/∂x²(□)', '∫□dx', '∫ₐᵇ',
        '∬', '∭', 'lim', 'lim x→∞', 'lim x→0⁺', 'lim x→0⁻', 'Σ', 'Π', 'Taylor', 'Maclaurin', 'Geometrik', 'Binom', 'eˣ serisi', 'sin serisi', 'cos serisi', 'ln serisi', 'arctan serisi',
      ],
    ),
    MorePanelCategory(
      title: 'Ayrık',
      labels: <String>[
        '□!', '□P□', '□C□', 'Γ(□)', 'Kalan', 'EBOB', 'EKOK', 'Asal mı?',
        '⌊□⌋', '⌈□⌉', 'Yuvarla', 'İşaret',
      ],
    ),
    MorePanelCategory(
      title: 'Kompleks',
      labels: <String>[
        'i', '−i', 'i²', 'z̄', 'Re(□)', 'Im(□)', 'arg(□)', 'Arg(□)',
        '|□|', 'θ', 'e^(i□)', 'cis(□)', 'r', 'ρ',
      ],
    ),
    MorePanelCategory(
      title: 'Lineer',
      labels: <String>[
        '2×2', '3×3', '4×4', 'm×n', 'I', '0 matris', 'A', 'B',
        'det(□)', '□⁻¹', '□ᵀ', '□ᴴ', 'RREF', 'Rank', 'Özdeğer', 'Çöz',
      ],
    ),
  ];

  static String defaultMoreCategoryForTab(String activeTab) {
    switch (activeTab) {
      case 'Cebir':
        return 'Fonksiyon';
      case 'Kalkülüs':
        return 'Kalkülüs';
      case 'Kompleks':
        return 'Kompleks';
      case 'Lineer Cebir':
        return 'Lineer';
      case 'Temel':
      default:
        return 'Yapı';
    }
  }

  static TemplateSpec templateSpecForStructure(String label) {
    final contract = MathTemplateContractRegistry.contractFor(label);
    if (contract != null) {
      return TemplateSpec(
        label: contract.label,
        expression: contract.expression,
        focusRole: contract.focusRole,
      );
    }
    final premiumMathSpec = PremiumMathKeySpecs.specFor(label);
    if (premiumMathSpec != null) {
      return TemplateSpec(
        label: premiumMathSpec.label,
        expression: premiumMathSpec.expression,
        focusRole: premiumMathSpec.focusRole,
      );
    }
    for (final spec in premiumTemplates) {
      if (spec.label == label) return spec;
    }
    return TemplateSpec(label: label, expression: templateForStructure(label), focusRole: _defaultFocusRole(label));
  }

  static String templateForStructure(String label) => MathTemplateContractRegistry.contractFor(label)?.expression ?? _templateExpression(label);

  static String _templateExpression(String label) {
    switch (label) {
      case 'xₙ':
      case 'x_□':
        return 'x_□';
      case 'yₙ':
      case 'y_□':
        return 'y_□';
      case 'Iₙ':
      case 'I_□':
        return 'I_□';
      case 'y⁽□⁾':
      case 'y⁽ⁿ⁾':
        return 'y⁽□⁾';
      case 'Kuadratik':
        return '(-b±√(b²-4ac))⁄(2a)';
      case '(x+y)²':
      case '(x+y)^2':
        return '(x+y)²';
      case '∫₀¹ f(x)':
        return '∫₀¹(□)dx';
      case 'lim sin(x)/x':
        return 'limₓ→0(□)';
      case '2×2 Matris':
      case '2x2 Matris':
        return '[□ □; □ □]';
      case 'Dot Product':
        return '[□ □ □]·[□ □ □]';
      case 'Euler':
        return 'r·e^(□)';
      case 'Σ Seri':
        return 'Σ(□)';
      case '‖□‖':
      case 'Norm':
        return '‖□‖';
      case 'frac':
      case '□/□':
      case '□⁄□':
      case 'karışık kesir':
      case 'bileşik kesir':
        return '□⁄□';
      case '√':
      case '√□':
        return '√(□)';
      case '³√':
      case '∛□':
        return '³√(□)';
      case 'ⁿ√':
      case '□√□':
        return '□√(□)';
      case '^':
      case '□^□':
        return '□^(□)';
      case 'x²':
        return 'x^(2)';
      case '□²':
        return '□^(2)';
      case 'x³':
        return 'x^(3)';
      case '□³':
        return '□^(3)';
      case 'xⁿ':
        return 'x^(□)';
      case '□ⁿ':
        return '□^(□)';
      case 'x⁻¹':
        return 'x^(−1)';
      case '□⁻¹':
        return '□⁻¹';
      case '10^□':
        return '10^(□)';
      case 'e^□':
      case 'e^(□)':
        return 'e^(□)';
      case '()':
        return '(□)';
      case '| |':
      case '|□|':
        return '|□|';
      case '⌊□⌋':
        return '⌊□⌋';
      case '⌈□⌉':
        return '⌈□⌉';
      case 'İşaret':
        return 'sign(□)';
      case '‖ ‖':
        return '‖□‖';
      case 'sin':
      case 'sin()':
      case 'sin(□)':
        return 'sin(□)';
      case 'asin(□)':
      case 'sin⁻¹()':
      case 'sin⁻¹(□)':
        return 'sin⁻¹(□)';
      case 'sinh()':
      case 'sinh(□)':
        return 'sinh(□)';
      case 'asinh(□)':
      case 'sinh⁻¹(□)':
        return 'sinh⁻¹(□)';
      case 'cos':
      case 'cos()':
      case 'cos(□)':
        return 'cos(□)';
      case 'acos(□)':
      case 'cos⁻¹()':
      case 'cos⁻¹(□)':
        return 'cos⁻¹(□)';
      case 'cosh()':
      case 'cosh(□)':
        return 'cosh(□)';
      case 'acosh(□)':
      case 'cosh⁻¹(□)':
        return 'cosh⁻¹(□)';
      case 'tan':
      case 'tan()':
      case 'tan(□)':
        return 'tan(□)';
      case 'atan(□)':
      case 'tan⁻¹()':
      case 'tan⁻¹(□)':
        return 'tan⁻¹(□)';
      case 'tanh()':
      case 'tanh(□)':
        return 'tanh(□)';
      case 'atanh(□)':
      case 'tanh⁻¹(□)':
        return 'tanh⁻¹(□)';
      case 'ln':
      case 'ln(□)':
      case 'ln()':
        return 'ln(□)';
      case 'log':
      case 'log()':
      case 'log(□)':
        return 'log(□)';
      case 'log₁₀(□)':
      case 'log₁₀()':
        return 'log₁₀(□)';
      case 'log₂(□)':
      case 'log₂()':
        return 'log₂(□)';
      case 'log_□(□)':
      case 'log₍□₎(□)':
      case 'logₙ()':
        return 'log₍□₎(□)';
      case '{□=□':
        return '{□=□;□=□}';
      case '{3 denklem':
        return '{□=□;□=□;□=□}';
      case '{n denklem':
        return '{□=□;…;□=□}';
      case '{≤ sistem':
        return '{□≤□;□≤□}';
      case 'f(□)':
        return 'f(□)';
      case 'g(□)':
        return 'g(□)';
      case 'h(□)':
        return 'h(□)';
      case 'f(□,□)':
        return 'f(□,□)';
      case 'f∘g':
        return '(f∘g)(□)';
      case '□!':
        return '□!';
      case '□P□':
        return '□P□';
      case '□C□':
        return '□C□';
      case 'Γ(□)':
        return 'Γ(□)';
      case 'Kalan':
        return '□ mod □';
      case 'EBOB':
        return 'EBOB(□,□)';
      case 'EKOK':
        return 'EKOK(□,□)';
      case 'Asal mı?':
        return 'asal?(□)';
      case '∫':
      case '∫□dx':
        return '∫(□)dx';
      case '∫ₐᵇ':
        return '∫_{□}^{□}(□)d□';
      case '∬':
        return '∬(□)';
      case '∭':
        return '∭(□)';
      case '∮':
        return '∮(□)';
      case 'd/dx':
      case 'd/dx(□)':
        return 'd/dx(□)';
      case 'd²/dx²':
      case 'd²/dx²(□)':
        return 'd²/dx²(□)';
      case 'd³/dx³':
      case 'd³/dx³(□)':
        return 'd³/dx³(□)';
      case '∂/∂x':
      case '∂/∂x(□)':
        return '∂/∂x(□)';
      case '∂²/∂x²(□)':
        return '∂²/∂x²(□)';
      case 'dy/dx':
        return 'dy/dx';
      case 'd²y/dx²':
        return 'd²y/dx²';
      case 'lim':
        return 'limₓ→□(□)';
      case 'lim x→□':
        return 'limₓ→□(□)';
      case 'lim x→∞':
        return 'limₓ→∞(□)';
      case 'lim x→0⁺':
        return 'limₓ→0⁺(□)';
      case 'lim x→0⁻':
        return 'limₓ→0⁻(□)';
      case 'Σ':
        return 'Σ(□)';
      case 'Π':
        return 'Π(□)';
      case 'Taylor':
        return 'f(□)=Σ□₌₀∞(f⁽□⁾(□)⁄□!)(□-□)^□';
      case 'Maclaurin':
        return 'f(□)=Σ□₌₀∞(f⁽□⁾(0)⁄□!)□^□';
      case 'Geometrik':
        return 'Σ□₌₀∞□·□^□=□⁄(1-□)';
      case 'Binom':
        return '(1+□)^□=Σ□₌₀∞(□C□)□^□';
      case 'eˣ serisi':
        return 'e^□=Σ□₌₀∞□^□⁄□!';
      case 'sin serisi':
        return 'sin(□)=Σ□₌₀∞((-1)^□·□^(2□+1))⁄(2□+1)!';
      case 'cos serisi':
        return 'cos(□)=Σ□₌₀∞((-1)^□·□^(2□))⁄(2□)!';
      case 'ln serisi':
        return 'ln(1+□)=Σ□₌₁∞((-1)^(□+1)·□^□)⁄□';
      case 'arctan serisi':
        return 'arctan(□)=Σ□₌₀∞((-1)^□·□^(2□+1))⁄(2□+1)';
      case 'Re(□)':
      case 'real(□)':
      case 'Re()':
        return 'Re(□)';
      case 'Im(□)':
      case 'imag(□)':
      case 'Im()':
        return 'Im(□)';
      case 'arg(□)':
      case 'Arg(□)':
      case 'arg()':
        return 'arg(□)';
      case 'conj(□)':
      case 'Eşlenik':
        return 'conj(□)';
      case 'cis(□)':
      case 'cis()':
        return 'cis(□)';
      case 'e^(i□)':
        return 'e^(i□)';
      case '[□ □]':
      case 'matrix':
      case '2×2':
        return '[□ □; □ □]';
      case '3×3':
        return '[□ □ □; □ □ □; □ □ □]';
      case '4×4':
        return '[□ □ □ □; □ □ □ □; □ □ □ □; □ □ □ □]';
      case 'm×n':
        return '[□ … □; … ; □ … □]';
      case '[□]':
      case 'vector':
      case '2D vektör':
        return '[□; □]';
      case '3D vektör':
        return '[□; □; □]';
      case 'nD vektör':
        return '[□; … ; □]';
      case 'satır vektörü':
        return '[□ □]';
      case 'sütun vektörü':
        return '[□; □]';
      case 'det(□)':
        return 'det(□)';
      case 'minör':
        return 'minor(□)';
      case 'kofaktör':
        return 'cofactor(□)';
      case 'pseudo-inverse':
      case 'Moore-Penrose':
        return 'pinv(□)';
      case '□ᵀ':
        return '□ᵀ';
      case '□ᴴ':
        return '□ᴴ';
      case '□·□':
      case 'dot(□,□)':
        return '□·□';
      case 'projeksiyon':
        return 'proj(□,□)';
      case '□×□':
      case 'cross(□,□)':
        return '□×□';
      case 'triple product':
      case 'karma çarpım':
        return 'triple(□,□,□)';
      case 'birim vektör':
        return 'unit(□)';
      case 'mesafe':
        return 'distance(□,□)';
      case 'Mutlak':
        return '|□|';
      case 'Yuvarla':
        return 'round(□)';
      case 'cot':
      case 'cot(□)':
        return 'cot(□)';
      case 'acot':
      case 'acot(□)':
      case 'cot⁻¹(□)':
        return 'cot⁻¹(□)';
      case 'coth':
      case 'coth(□)':
        return 'coth(□)';
      case 'sec':
      case 'sec(□)':
        return 'sec(□)';
      case 'csc':
      case 'csc(□)':
        return 'csc(□)';
      case 'RREF':
        return 'rref(□)';
      case 'Rank':
        return 'rank(□)';
      case 'Özdeğer':
        return 'eig(□)';
      case 'Çöz':
        return 'solve(□)';
      default:
        return label;
    }
  }

  static String? _defaultFocusRole(String label) {
    final contractRole = MathTemplateContractRegistry.focusRoleFor(label);
    if (contractRole != null) return contractRole;
    switch (label) {
      case 'xₙ':
      case 'x_□':
      case 'yₙ':
      case 'y_□':
      case 'Iₙ':
      case 'I_□':
        return 'subscript';
      case 'y⁽□⁾':
      case 'y⁽ⁿ⁾':
        return 'derivativeOrder';
      case 'frac':
      case '□/□':
      case '□⁄□':
      case 'karışık kesir':
      case 'bileşik kesir':
        return 'fractionNumerator';
      case '√':
      case '√□':
      case '³√':
      case '∛□':
        return 'sqrtValue';
      case 'ⁿ√':
      case '□√□':
        return 'rootIndex';
      case '^':
      case '□^□':
      case 'e^□':
      case '10^□':
        return 'powerExponent';
      case '()':
      case '| |':
      case '|□|':
      case '‖ ‖':
      case '‖□‖':
      case 'sin':
      case 'sin()':
      case 'sin(□)':
      case 'asin(□)':
      case 'sin⁻¹(□)':
      case 'sinh()':
      case 'sinh(□)':
      case 'asinh(□)':
      case 'sinh⁻¹(□)':
      case 'cos':
      case 'cos()':
      case 'cos(□)':
      case 'acos(□)':
      case 'cos⁻¹(□)':
      case 'cosh()':
      case 'cosh(□)':
      case 'acosh(□)':
      case 'cosh⁻¹(□)':
      case 'tan':
      case 'tan()':
      case 'tan(□)':
      case 'atan(□)':
      case 'tan⁻¹(□)':
      case 'tanh()':
      case 'tanh(□)':
      case 'atanh(□)':
      case 'tanh⁻¹(□)':
      case 'ln':
      case 'ln(□)':
      case 'ln()':
      case 'log':
      case 'log(□)':
      case 'log₁₀(□)':
      case 'log₂(□)':
      case 'log_□(□)':
      case 'Re(□)':
      case 'Im(□)':
      case 'arg(□)':
      case 'conj(□)':
      case 'cis(□)':
      case 'f(□)':
      case 'g(□)':
      case 'h(□)':
      case 'f(□,□)':
      case 'Γ(□)':
      case 'EBOB':
      case 'EKOK':
      case 'Asal mı?':
        return 'functionArgument';
      case 'd/dx':
      case 'd/dx(□)':
      case 'd²/dx²':
      case 'd²/dx²(□)':
      case 'd³/dx³':
      case 'd³/dx³(□)':
      case '∂/∂x':
      case '∂/∂x(□)':
      case '∂²/∂x²(□)':
      case 'dy/dx':
      case 'd²y/dx²':
        return 'derivativeBody';
      case '∫':
      case '∫□dx':
      case '∫ₐᵇ':
      case '∬':
      case '∭':
      case '∮':
        return 'integralBody';
      case 'lim':
      case 'lim x→□':
      case 'lim x→∞':
      case 'lim x→0⁺':
      case 'lim x→0⁻':
        return 'limitTarget';
      case 'Σ':
        return 'sumBody';
      case 'Π':
        return 'productBody';
      case 'Taylor':
      case 'Maclaurin':
      case 'Geometrik':
      case 'Binom':
      case 'eˣ serisi':
      case 'sin serisi':
      case 'cos serisi':
      case 'ln serisi':
      case 'arctan serisi':
        return 'seriesVariable';
      case '[□ □]':
      case 'matrix':
      case '2×2':
      case '3×3':
      case '4×4':
      case 'm×n':
      case '[□]':
      case 'vector':
      case '2D vektör':
      case '3D vektör':
      case 'nD vektör':
      case 'satır vektörü':
      case 'sütun vektörü':
        return 'matrixCell';
      case 'Mutlak':
      case 'Yuvarla':
      case 'Eşlenik':
      case 'karma çarpım':
        return 'functionArgument';
      case 'cot':
      case 'cot(□)':
      case 'acot':
      case 'acot(□)':
      case 'cot⁻¹(□)':
      case 'coth':
      case 'coth(□)':
      case 'sec':
      case 'sec(□)':
      case 'csc':
      case 'csc(□)':
      case 'Çöz':
        return 'functionArgument';
      case 'RREF':
      case 'Rank':
      case 'Özdeğer':
      case 'Moore-Penrose':
        return 'matrixCell';
      default:
        return null;
    }
  }
}
