import '../features/editor/math_node.dart';

class PremiumMathKeySpec {
  const PremiumMathKeySpec({
    required this.label,
    required this.expression,
    required this.focusRole,
    required this.expectedRootKind,
    this.family = 'general',
    this.slotRoles = const <String>{},
    this.legacyAlias = false,
  });

  final String label;
  final String expression;
  final String focusRole;
  final MathNodeKind expectedRootKind;
  final String family;
  final Set<String> slotRoles;
  final bool legacyAlias;

  bool get requiresEditableSlot => slotRoles.isNotEmpty || expression.contains('□');
}

/// Central source-of-truth for MathPro's premium keyboard/MORE expression
/// surfaces. The visible key/chip label, inserted template, first focused slot,
/// expected structural node family, and audit family live together here so the
/// UI cannot silently drift back to raw strings such as asin(□), x_n, or
/// log_10(□).
class PremiumMathKeySpecs {
  const PremiumMathKeySpecs._();

  static const List<PremiumMathKeySpec> all = <PremiumMathKeySpec>[
    // Subscript / derivative order.
    PremiumMathKeySpec(label: 'xₙ', expression: 'x_□', focusRole: 'subscript', expectedRootKind: MathNodeKind.subscript, family: 'subscript', slotRoles: <String>{'subscript'}),
    PremiumMathKeySpec(label: 'x_□', expression: 'x_□', focusRole: 'subscript', expectedRootKind: MathNodeKind.subscript, family: 'subscript', slotRoles: <String>{'subscript'}),
    PremiumMathKeySpec(label: 'yₙ', expression: 'y_□', focusRole: 'subscript', expectedRootKind: MathNodeKind.subscript, family: 'subscript', slotRoles: <String>{'subscript'}),
    PremiumMathKeySpec(label: 'y_□', expression: 'y_□', focusRole: 'subscript', expectedRootKind: MathNodeKind.subscript, family: 'subscript', slotRoles: <String>{'subscript'}),
    PremiumMathKeySpec(label: 'Iₙ', expression: 'I_□', focusRole: 'subscript', expectedRootKind: MathNodeKind.subscript, family: 'subscript', slotRoles: <String>{'subscript'}),
    PremiumMathKeySpec(label: 'I_□', expression: 'I_□', focusRole: 'subscript', expectedRootKind: MathNodeKind.subscript, family: 'subscript', slotRoles: <String>{'subscript'}),
    PremiumMathKeySpec(label: 'y⁽□⁾', expression: 'y⁽□⁾', focusRole: 'derivativeOrder', expectedRootKind: MathNodeKind.box, family: 'derivative-order', slotRoles: <String>{'derivativeOrder'}),
    PremiumMathKeySpec(label: 'y⁽ⁿ⁾', expression: 'y⁽□⁾', focusRole: 'derivativeOrder', expectedRootKind: MathNodeKind.box, family: 'derivative-order', slotRoles: <String>{'derivativeOrder'}),


    // V150 long-term tree binding: fixed subscript, prime, overline, power,
    // signed imaginary, infinity and differential atoms must no longer be
    // invisible loose text from public keys.  They carry no open □ slot, but
    // they are spec-backed so key routing, parser, serializer and audits treat
    // them as mathematical AST tokens rather than arbitrary UI strings.
    PremiumMathKeySpec(label: 'x₁', expression: 'x₁', focusRole: 'structuralAtom', expectedRootKind: MathNodeKind.subscript, family: 'fixed-subscript'),
    PremiumMathKeySpec(label: 'x₂', expression: 'x₂', focusRole: 'structuralAtom', expectedRootKind: MathNodeKind.subscript, family: 'fixed-subscript'),
    PremiumMathKeySpec(label: 'y₁', expression: 'y₁', focusRole: 'structuralAtom', expectedRootKind: MathNodeKind.subscript, family: 'fixed-subscript'),
    PremiumMathKeySpec(label: 'y₂', expression: 'y₂', focusRole: 'structuralAtom', expectedRootKind: MathNodeKind.subscript, family: 'fixed-subscript'),
    PremiumMathKeySpec(label: 'z₁', expression: 'z₁', focusRole: 'structuralAtom', expectedRootKind: MathNodeKind.subscript, family: 'fixed-subscript'),
    PremiumMathKeySpec(label: 'z₂', expression: 'z₂', focusRole: 'structuralAtom', expectedRootKind: MathNodeKind.subscript, family: 'fixed-subscript'),
    PremiumMathKeySpec(label: 'A₁', expression: 'A₁', focusRole: 'structuralAtom', expectedRootKind: MathNodeKind.subscript, family: 'fixed-subscript'),
    PremiumMathKeySpec(label: 'A₂', expression: 'A₂', focusRole: 'structuralAtom', expectedRootKind: MathNodeKind.subscript, family: 'fixed-subscript'),
    PremiumMathKeySpec(label: 'B₁', expression: 'B₁', focusRole: 'structuralAtom', expectedRootKind: MathNodeKind.subscript, family: 'fixed-subscript'),
    PremiumMathKeySpec(label: 'B₂', expression: 'B₂', focusRole: 'structuralAtom', expectedRootKind: MathNodeKind.subscript, family: 'fixed-subscript'),
    PremiumMathKeySpec(label: 'I₂', expression: 'I₂', focusRole: 'structuralAtom', expectedRootKind: MathNodeKind.subscript, family: 'fixed-subscript'),
    PremiumMathKeySpec(label: 'I₃', expression: 'I₃', focusRole: 'structuralAtom', expectedRootKind: MathNodeKind.subscript, family: 'fixed-subscript'),
    PremiumMathKeySpec(label: 'y′', expression: 'y′', focusRole: 'structuralAtom', expectedRootKind: MathNodeKind.postfix, family: 'fixed-prime'),
    PremiumMathKeySpec(label: 'y″', expression: 'y″', focusRole: 'structuralAtom', expectedRootKind: MathNodeKind.postfix, family: 'fixed-prime'),
    PremiumMathKeySpec(label: 'y‴', expression: 'y‴', focusRole: 'structuralAtom', expectedRootKind: MathNodeKind.postfix, family: 'fixed-prime'),
    PremiumMathKeySpec(label: 'z̄', expression: 'z̄', focusRole: 'structuralAtom', expectedRootKind: MathNodeKind.postfix, family: 'overline'),
    PremiumMathKeySpec(label: 'i²', expression: 'i²', focusRole: 'structuralAtom', expectedRootKind: MathNodeKind.power, family: 'fixed-power'),
    PremiumMathKeySpec(label: '−i', expression: '−i', focusRole: 'structuralAtom', expectedRootKind: MathNodeKind.box, family: 'signed-complex-atom'),
    PremiumMathKeySpec(label: '+∞', expression: '+∞', focusRole: 'structuralAtom', expectedRootKind: MathNodeKind.box, family: 'infinity-atom'),
    PremiumMathKeySpec(label: '−∞', expression: '−∞', focusRole: 'structuralAtom', expectedRootKind: MathNodeKind.box, family: 'infinity-atom'),
    PremiumMathKeySpec(label: 'dx', expression: 'dx', focusRole: 'structuralAtom', expectedRootKind: MathNodeKind.box, family: 'differential-atom'),
    PremiumMathKeySpec(label: 'dy', expression: 'dy', focusRole: 'structuralAtom', expectedRootKind: MathNodeKind.box, family: 'differential-atom'),
    PremiumMathKeySpec(label: 'dt', expression: 'dt', focusRole: 'structuralAtom', expectedRootKind: MathNodeKind.box, family: 'differential-atom'),
    PremiumMathKeySpec(label: 'dθ', expression: 'dθ', focusRole: 'structuralAtom', expectedRootKind: MathNodeKind.box, family: 'differential-atom'),

    // Core structural input.
    PremiumMathKeySpec(label: '□/□', expression: '□⁄□', focusRole: 'fractionNumerator', expectedRootKind: MathNodeKind.fraction, family: 'fraction', slotRoles: <String>{'fractionNumerator', 'fractionDenominator'}),
    PremiumMathKeySpec(label: '□⁄□', expression: '□⁄□', focusRole: 'fractionNumerator', expectedRootKind: MathNodeKind.fraction, family: 'fraction', slotRoles: <String>{'fractionNumerator', 'fractionDenominator'}),
    PremiumMathKeySpec(label: 'karışık kesir', expression: '□⁄□', focusRole: 'fractionNumerator', expectedRootKind: MathNodeKind.fraction, family: 'fraction', slotRoles: <String>{'fractionNumerator', 'fractionDenominator'}),
    PremiumMathKeySpec(label: 'bileşik kesir', expression: '□⁄□', focusRole: 'fractionNumerator', expectedRootKind: MathNodeKind.fraction, family: 'fraction', slotRoles: <String>{'fractionNumerator', 'fractionDenominator'}),
    PremiumMathKeySpec(label: '√□', expression: '√(□)', focusRole: 'sqrtValue', expectedRootKind: MathNodeKind.sqrt, family: 'root', slotRoles: <String>{'sqrtValue'}),
    PremiumMathKeySpec(label: '∛□', expression: '³√(□)', focusRole: 'sqrtValue', expectedRootKind: MathNodeKind.indexedRoot, family: 'root', slotRoles: <String>{'sqrtValue'}),
    PremiumMathKeySpec(label: '³√', expression: '³√(□)', focusRole: 'sqrtValue', expectedRootKind: MathNodeKind.indexedRoot, family: 'root', slotRoles: <String>{'sqrtValue'}),
    PremiumMathKeySpec(label: '□√□', expression: '□√(□)', focusRole: 'rootIndex', expectedRootKind: MathNodeKind.indexedRoot, family: 'root', slotRoles: <String>{'rootIndex', 'sqrtValue'}),
    PremiumMathKeySpec(label: 'ⁿ√', expression: '□√(□)', focusRole: 'rootIndex', expectedRootKind: MathNodeKind.indexedRoot, family: 'root', slotRoles: <String>{'rootIndex', 'sqrtValue'}),
    PremiumMathKeySpec(label: '□^□', expression: '□^(□)', focusRole: 'powerExponent', expectedRootKind: MathNodeKind.power, family: 'power', slotRoles: <String>{'powerBase', 'powerExponent'}),
    PremiumMathKeySpec(label: '□²', expression: '□^(2)', focusRole: 'powerBase', expectedRootKind: MathNodeKind.power, family: 'power', slotRoles: <String>{'powerBase'}),
    PremiumMathKeySpec(label: '□³', expression: '□^(3)', focusRole: 'powerBase', expectedRootKind: MathNodeKind.power, family: 'power', slotRoles: <String>{'powerBase'}),
    PremiumMathKeySpec(label: '□ⁿ', expression: '□^(□)', focusRole: 'powerBase', expectedRootKind: MathNodeKind.power, family: 'power', slotRoles: <String>{'powerBase', 'powerExponent'}),
    PremiumMathKeySpec(label: '10^□', expression: '10^(□)', focusRole: 'powerExponent', expectedRootKind: MathNodeKind.power, family: 'power', slotRoles: <String>{'powerExponent'}),
    PremiumMathKeySpec(label: 'e^□', expression: 'e^(□)', focusRole: 'powerExponent', expectedRootKind: MathNodeKind.power, family: 'power', slotRoles: <String>{'powerExponent'}),
    PremiumMathKeySpec(label: 'e^(□)', expression: 'e^(□)', focusRole: 'powerExponent', expectedRootKind: MathNodeKind.power, family: 'power', slotRoles: <String>{'powerExponent'}),
    PremiumMathKeySpec(label: '|□|', expression: '|□|', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'wrapper', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'Mutlak', expression: '|□|', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'wrapper', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: '‖□‖', expression: '‖□‖', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'wrapper', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: '⌊□⌋', expression: '⌊□⌋', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'wrapper', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: '⌈□⌉', expression: '⌈□⌉', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'wrapper', slotRoles: <String>{'functionArgument'}),

    // Functions and trig. Legacy asin/acos/atan labels are accepted only as
    // parser aliases; public UI labels must use the inverse notation variants.
    PremiumMathKeySpec(label: 'sin', expression: 'sin(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'sin(□)', expression: 'sin(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'sin⁻¹(□)', expression: 'sin⁻¹(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'asin(□)', expression: 'sin⁻¹(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}, legacyAlias: true),
    PremiumMathKeySpec(label: 'sinh(□)', expression: 'sinh(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'sinh⁻¹(□)', expression: 'sinh⁻¹(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'asinh(□)', expression: 'sinh⁻¹(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}, legacyAlias: true),
    PremiumMathKeySpec(label: 'cos', expression: 'cos(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'cos(□)', expression: 'cos(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'cos⁻¹(□)', expression: 'cos⁻¹(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'acos(□)', expression: 'cos⁻¹(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}, legacyAlias: true),
    PremiumMathKeySpec(label: 'cosh(□)', expression: 'cosh(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'cosh⁻¹(□)', expression: 'cosh⁻¹(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'acosh(□)', expression: 'cosh⁻¹(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}, legacyAlias: true),
    PremiumMathKeySpec(label: 'tan', expression: 'tan(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'tan(□)', expression: 'tan(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'tan⁻¹(□)', expression: 'tan⁻¹(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'atan(□)', expression: 'tan⁻¹(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}, legacyAlias: true),
    PremiumMathKeySpec(label: 'tanh(□)', expression: 'tanh(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'tanh⁻¹(□)', expression: 'tanh⁻¹(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'atanh(□)', expression: 'tanh⁻¹(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}, legacyAlias: true),
    PremiumMathKeySpec(label: 'cot', expression: 'cot(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig-alias', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'cot(□)', expression: 'cot(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'cot⁻¹(□)', expression: 'cot⁻¹(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'acot', expression: 'cot⁻¹(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig-alias', slotRoles: <String>{'functionArgument'}, legacyAlias: true),
    PremiumMathKeySpec(label: 'acot(□)', expression: 'cot⁻¹(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}, legacyAlias: true),
    PremiumMathKeySpec(label: 'coth', expression: 'coth(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig-alias', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'coth(□)', expression: 'coth(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'sec', expression: 'sec(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig-alias', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'sec(□)', expression: 'sec(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'csc', expression: 'csc(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig-alias', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'csc(□)', expression: 'csc(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'trig', slotRoles: <String>{'functionArgument'}),

    // Log/function family.
    PremiumMathKeySpec(label: 'ln', expression: 'ln(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'log', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'ln(□)', expression: 'ln(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'log', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'log', expression: 'log(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'log', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'log(□)', expression: 'log(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'log', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'log₁₀(□)', expression: 'log₁₀(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.logBase, family: 'log', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'log₂(□)', expression: 'log₂(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.logBase, family: 'log', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'log_□(□)', expression: 'log₍□₎(□)', focusRole: 'logBase', expectedRootKind: MathNodeKind.logBase, family: 'log', slotRoles: <String>{'logBase', 'functionArgument'}),
    PremiumMathKeySpec(label: 'log₍□₎(□)', expression: 'log₍□₎(□)', focusRole: 'logBase', expectedRootKind: MathNodeKind.logBase, family: 'log', slotRoles: <String>{'logBase', 'functionArgument'}),
    PremiumMathKeySpec(label: 'Re(□)', expression: 'Re(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'complex', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'real(□)', expression: 'Re(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'complex-alias', slotRoles: <String>{'functionArgument'}, legacyAlias: true),
    PremiumMathKeySpec(label: 'Im(□)', expression: 'Im(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'complex', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'imag(□)', expression: 'Im(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'complex-alias', slotRoles: <String>{'functionArgument'}, legacyAlias: true),
    PremiumMathKeySpec(label: 'arg(□)', expression: 'arg(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'complex', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'Arg(□)', expression: 'arg(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'complex', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'conj(□)', expression: 'conj(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'complex', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'Eşlenik', expression: 'conj(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'complex', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'cis(□)', expression: 'cis(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'complex', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'e^(i□)', expression: 'e^(i□)', focusRole: 'powerExponent', expectedRootKind: MathNodeKind.power, family: 'complex-power', slotRoles: <String>{'powerExponent'}),

    // Calculus / operators.
    PremiumMathKeySpec(label: 'd/dx', expression: 'd/dx(□)', focusRole: 'derivativeBody', expectedRootKind: MathNodeKind.derivative, family: 'derivative', slotRoles: <String>{'derivativeBody'}),
    PremiumMathKeySpec(label: 'd/dx(□)', expression: 'd/dx(□)', focusRole: 'derivativeBody', expectedRootKind: MathNodeKind.derivative, family: 'derivative', slotRoles: <String>{'derivativeBody'}),
    PremiumMathKeySpec(label: 'd²/dx²(□)', expression: 'd²/dx²(□)', focusRole: 'derivativeBody', expectedRootKind: MathNodeKind.derivative, family: 'derivative', slotRoles: <String>{'derivativeBody'}),
    PremiumMathKeySpec(label: 'd³/dx³(□)', expression: 'd³/dx³(□)', focusRole: 'derivativeBody', expectedRootKind: MathNodeKind.derivative, family: 'derivative', slotRoles: <String>{'derivativeBody'}),
    PremiumMathKeySpec(label: '∂/∂x(□)', expression: '∂/∂x(□)', focusRole: 'derivativeBody', expectedRootKind: MathNodeKind.derivative, family: 'derivative', slotRoles: <String>{'derivativeBody'}),
    PremiumMathKeySpec(label: '∂²/∂x²(□)', expression: '∂²/∂x²(□)', focusRole: 'derivativeBody', expectedRootKind: MathNodeKind.derivative, family: 'derivative', slotRoles: <String>{'derivativeBody'}),
    PremiumMathKeySpec(label: '∫□dx', expression: '∫(□)dx', focusRole: 'integralBody', expectedRootKind: MathNodeKind.integral, family: 'integral', slotRoles: <String>{'integralBody'}),
    PremiumMathKeySpec(label: '∫ₐᵇ', expression: '∫_{□}^{□}(□)d□', focusRole: 'integralBody', expectedRootKind: MathNodeKind.integral, family: 'integral', slotRoles: <String>{'integralLowerLimit', 'integralUpperLimit', 'integralBody', 'integralDifferential'}),
    PremiumMathKeySpec(label: '∬', expression: '∬(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'integral', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: '∭', expression: '∭(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'integral', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: '∮', expression: '∮(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'integral', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'lim', expression: 'limₓ→□(□)', focusRole: 'limitTarget', expectedRootKind: MathNodeKind.limit, family: 'limit', slotRoles: <String>{'limitTarget', 'limitBody'}),
    PremiumMathKeySpec(label: 'lim x→□', expression: 'limₓ→□(□)', focusRole: 'limitTarget', expectedRootKind: MathNodeKind.limit, family: 'limit', slotRoles: <String>{'limitTarget', 'limitBody'}),
    PremiumMathKeySpec(label: 'lim x→∞', expression: 'limₓ→∞(□)', focusRole: 'limitBody', expectedRootKind: MathNodeKind.limit, family: 'limit', slotRoles: <String>{'limitBody'}),
    PremiumMathKeySpec(label: 'lim x→0⁺', expression: 'limₓ→0⁺(□)', focusRole: 'limitBody', expectedRootKind: MathNodeKind.limit, family: 'limit', slotRoles: <String>{'limitBody'}),
    PremiumMathKeySpec(label: 'lim x→0⁻', expression: 'limₓ→0⁻(□)', focusRole: 'limitBody', expectedRootKind: MathNodeKind.limit, family: 'limit', slotRoles: <String>{'limitBody'}),
    PremiumMathKeySpec(label: 'Σ', expression: 'Σ(□)', focusRole: 'sumBody', expectedRootKind: MathNodeKind.bigOperator, family: 'big-operator', slotRoles: <String>{'sumLowerLimit', 'sumUpperLimit', 'sumBody'}),
    PremiumMathKeySpec(label: 'Π', expression: 'Π(□)', focusRole: 'productBody', expectedRootKind: MathNodeKind.bigOperator, family: 'big-operator', slotRoles: <String>{'productLowerLimit', 'productUpperLimit', 'productBody'}),

    // Matrices / vectors.
    PremiumMathKeySpec(label: '[□ □]', expression: '[□ □; □ □]', focusRole: 'matrixCell', expectedRootKind: MathNodeKind.matrix, family: 'matrix', slotRoles: <String>{'matrixCell'}),
    PremiumMathKeySpec(label: '2×2', expression: '[□ □; □ □]', focusRole: 'matrixCell', expectedRootKind: MathNodeKind.matrix, family: 'matrix', slotRoles: <String>{'matrixCell'}),
    PremiumMathKeySpec(label: '2×2 Matris', expression: '[□ □; □ □]', focusRole: 'matrixCell', expectedRootKind: MathNodeKind.matrix, family: 'matrix', slotRoles: <String>{'matrixCell'}),
    PremiumMathKeySpec(label: '3×3', expression: '[□ □ □; □ □ □; □ □ □]', focusRole: 'matrixCell', expectedRootKind: MathNodeKind.matrix, family: 'matrix', slotRoles: <String>{'matrixCell'}),
    PremiumMathKeySpec(label: '4×4', expression: '[□ □ □ □; □ □ □ □; □ □ □ □; □ □ □ □]', focusRole: 'matrixCell', expectedRootKind: MathNodeKind.matrix, family: 'matrix', slotRoles: <String>{'matrixCell'}),
    PremiumMathKeySpec(label: 'm×n', expression: '[□ … □; … ; □ … □]', focusRole: 'matrixCell', expectedRootKind: MathNodeKind.matrix, family: 'matrix', slotRoles: <String>{'matrixCell'}),
    PremiumMathKeySpec(label: '[□]', expression: '[□; □]', focusRole: 'matrixCell', expectedRootKind: MathNodeKind.vector, family: 'vector', slotRoles: <String>{'matrixCell'}),
    PremiumMathKeySpec(label: '2D vektör', expression: '[□; □]', focusRole: 'matrixCell', expectedRootKind: MathNodeKind.vector, family: 'vector', slotRoles: <String>{'matrixCell'}),
    PremiumMathKeySpec(label: '3D vektör', expression: '[□; □; □]', focusRole: 'matrixCell', expectedRootKind: MathNodeKind.vector, family: 'vector', slotRoles: <String>{'matrixCell'}),
    PremiumMathKeySpec(label: 'nD vektör', expression: '[□; … ; □]', focusRole: 'matrixCell', expectedRootKind: MathNodeKind.vector, family: 'vector', slotRoles: <String>{'matrixCell'}),
    PremiumMathKeySpec(label: 'satır vektörü', expression: '[□ □]', focusRole: 'matrixCell', expectedRootKind: MathNodeKind.vector, family: 'vector', slotRoles: <String>{'matrixCell'}),
    PremiumMathKeySpec(label: 'sütun vektörü', expression: '[□; □]', focusRole: 'matrixCell', expectedRootKind: MathNodeKind.vector, family: 'vector', slotRoles: <String>{'matrixCell'}),

    // Named functions / solver-placeholder commands. Solver remains out of scope;
    // these are only premium editable input nodes.
    PremiumMathKeySpec(label: 'f(□)', expression: 'f(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'function', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'g(□)', expression: 'g(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'function', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'h(□)', expression: 'h(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'function', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'f(□,□)', expression: 'f(□,□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'function', slotRoles: <String>{'functionArgument', 'functionArgument2'}),
    PremiumMathKeySpec(label: 'Γ(□)', expression: 'Γ(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'function', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'İşaret', expression: 'sign(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'function', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'Yuvarla', expression: 'round(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'function', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'EBOB', expression: 'EBOB(□,□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'function', slotRoles: <String>{'functionArgument', 'functionArgument2'}),
    PremiumMathKeySpec(label: 'EKOK', expression: 'EKOK(□,□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'function', slotRoles: <String>{'functionArgument', 'functionArgument2'}),
    PremiumMathKeySpec(label: 'Asal mı?', expression: 'asal?(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'function', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'det(□)', expression: 'det(□)', focusRole: 'matrixCell', expectedRootKind: MathNodeKind.functionCall, family: 'linear-function', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'RREF', expression: 'rref(□)', focusRole: 'matrixCell', expectedRootKind: MathNodeKind.functionCall, family: 'linear-function', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'Rank', expression: 'rank(□)', focusRole: 'matrixCell', expectedRootKind: MathNodeKind.functionCall, family: 'linear-function', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'Özdeğer', expression: 'eig(□)', focusRole: 'matrixCell', expectedRootKind: MathNodeKind.functionCall, family: 'linear-function', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'Çöz', expression: 'solve(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'function', slotRoles: <String>{'functionArgument'}),

    // Phase-04 full-surface coverage: algebra/system/discrete/series labels.
    // These specs do not change key positions; they bind every high-risk public
    // chip/key to a canonical editable expression so audits can catch drift.
    PremiumMathKeySpec(label: 'Kuadratik', expression: '(-b±√(b²-4ac))⁄(2a)', focusRole: 'body', expectedRootKind: MathNodeKind.box, family: 'algebra'),
    PremiumMathKeySpec(label: '(x+y)²', expression: '(x+y)²', focusRole: 'body', expectedRootKind: MathNodeKind.box, family: 'algebra'),
    PremiumMathKeySpec(label: 'Euler', expression: 'r·e^(□)', focusRole: 'powerExponent', expectedRootKind: MathNodeKind.power, family: 'complex-power', slotRoles: <String>{'powerExponent'}),
    PremiumMathKeySpec(label: '{□=□', expression: '{□=□;□=□}', focusRole: 'systemLeft', expectedRootKind: MathNodeKind.piecewise, family: 'system', slotRoles: <String>{'systemLeft', 'systemRight'}),
    PremiumMathKeySpec(label: '{3 denklem', expression: '{□=□;□=□;□=□}', focusRole: 'systemLeft', expectedRootKind: MathNodeKind.piecewise, family: 'system', slotRoles: <String>{'systemLeft', 'systemRight'}),
    PremiumMathKeySpec(label: '{n denklem', expression: '{□=□;…;□=□}', focusRole: 'systemLeft', expectedRootKind: MathNodeKind.piecewise, family: 'system', slotRoles: <String>{'systemLeft', 'systemRight'}),
    PremiumMathKeySpec(label: '{≤ sistem', expression: '{□≤□;□≤□}', focusRole: 'systemLeft', expectedRootKind: MathNodeKind.piecewise, family: 'system', slotRoles: <String>{'systemLeft', 'systemRight'}),
    PremiumMathKeySpec(label: 'f∘g', expression: '(f∘g)(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'function-composition', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'Kalan', expression: '□ mod □', focusRole: 'body', expectedRootKind: MathNodeKind.box, family: 'discrete', slotRoles: <String>{'body'}),
    PremiumMathKeySpec(label: '□!', expression: '□!', focusRole: 'postfixTarget', expectedRootKind: MathNodeKind.postfix, family: 'postfix', slotRoles: <String>{'postfixTarget'}),
    PremiumMathKeySpec(label: '□P□', expression: '□P□', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'discrete', slotRoles: <String>{'functionArgument', 'functionArgument2'}),
    PremiumMathKeySpec(label: '□C□', expression: '□C□', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'discrete', slotRoles: <String>{'functionArgument', 'functionArgument2'}),
    PremiumMathKeySpec(label: 'minör', expression: 'minor(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'linear-function', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'kofaktör', expression: 'cofactor(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'linear-function', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'pseudo-inverse', expression: 'pinv(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'linear-function', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'Moore-Penrose', expression: 'pinv(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'linear-function', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'projeksiyon', expression: 'proj(□,□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'linear-function', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'karma çarpım', expression: 'triple(□,□,□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'linear-function', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'triple product', expression: 'triple(□,□,□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'linear-function', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'birim vektör', expression: 'unit(□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'linear-function', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: 'mesafe', expression: 'distance(□,□)', focusRole: 'functionArgument', expectedRootKind: MathNodeKind.functionCall, family: 'linear-function', slotRoles: <String>{'functionArgument'}),
    PremiumMathKeySpec(label: '□·□', expression: '□·□', focusRole: 'body', expectedRootKind: MathNodeKind.box, family: 'linear-function', slotRoles: <String>{'body'}),
    PremiumMathKeySpec(label: 'dot(□,□)', expression: '□·□', focusRole: 'body', expectedRootKind: MathNodeKind.box, family: 'linear-function-alias', slotRoles: <String>{'body'}, legacyAlias: true),
    PremiumMathKeySpec(label: '□×□', expression: '□×□', focusRole: 'body', expectedRootKind: MathNodeKind.box, family: 'linear-function', slotRoles: <String>{'body'}),
    PremiumMathKeySpec(label: 'cross(□,□)', expression: '□×□', focusRole: 'body', expectedRootKind: MathNodeKind.box, family: 'linear-function-alias', slotRoles: <String>{'body'}, legacyAlias: true),
    PremiumMathKeySpec(label: '0 matris', expression: '[0 0; 0 0]', focusRole: 'matrixCell', expectedRootKind: MathNodeKind.matrix, family: 'matrix', slotRoles: <String>{'matrixCell'}),
    PremiumMathKeySpec(label: '□⁻¹', expression: '□⁻¹', focusRole: 'postfixTarget', expectedRootKind: MathNodeKind.postfix, family: 'postfix', slotRoles: <String>{'postfixTarget'}),
    PremiumMathKeySpec(label: '□ᵀ', expression: '□ᵀ', focusRole: 'postfixTarget', expectedRootKind: MathNodeKind.postfix, family: 'postfix', slotRoles: <String>{'postfixTarget'}),
    PremiumMathKeySpec(label: '□ᴴ', expression: '□ᴴ', focusRole: 'postfixTarget', expectedRootKind: MathNodeKind.postfix, family: 'postfix', slotRoles: <String>{'postfixTarget'}),
    // Matrix symbol postfix long-press entries.  They are not placeholders,
    // but they are structural postfix forms and must not fall back to loose
    // text insertion from KeyConfig.
    PremiumMathKeySpec(label: 'A⁻¹', expression: 'A⁻¹', focusRole: 'postfixTarget', expectedRootKind: MathNodeKind.postfix, family: 'postfix', slotRoles: <String>{'postfixTarget'}),
    PremiumMathKeySpec(label: 'Aᵀ', expression: 'Aᵀ', focusRole: 'postfixTarget', expectedRootKind: MathNodeKind.postfix, family: 'postfix', slotRoles: <String>{'postfixTarget'}),
    PremiumMathKeySpec(label: 'B⁻¹', expression: 'B⁻¹', focusRole: 'postfixTarget', expectedRootKind: MathNodeKind.postfix, family: 'postfix', slotRoles: <String>{'postfixTarget'}),
    PremiumMathKeySpec(label: 'Bᵀ', expression: 'Bᵀ', focusRole: 'postfixTarget', expectedRootKind: MathNodeKind.postfix, family: 'postfix', slotRoles: <String>{'postfixTarget'}),
    PremiumMathKeySpec(label: 'dy/dx', expression: 'dy/dx', focusRole: 'derivativeBody', expectedRootKind: MathNodeKind.derivative, family: 'derivative'),
    PremiumMathKeySpec(label: 'd²y/dx²', expression: 'd²y/dx²', focusRole: 'derivativeBody', expectedRootKind: MathNodeKind.derivative, family: 'derivative'),
    PremiumMathKeySpec(label: '∫₀¹ f(x)', expression: '∫₀¹(□)dx', focusRole: 'integralBody', expectedRootKind: MathNodeKind.integral, family: 'integral', slotRoles: <String>{'integralBody'}),
    PremiumMathKeySpec(label: 'lim sin(x)/x', expression: 'limₓ→0(□)', focusRole: 'limitBody', expectedRootKind: MathNodeKind.limit, family: 'limit', slotRoles: <String>{'limitBody'}),
    PremiumMathKeySpec(label: 'Taylor', expression: 'f(□)=Σ□₌₀∞(f⁽□⁾(□)⁄□!)(□-□)^□', focusRole: 'seriesVariable', expectedRootKind: MathNodeKind.series, family: 'series', slotRoles: <String>{'seriesVariable', 'seriesIndex', 'seriesOrder', 'seriesCenter', 'seriesFactorial'}),
    PremiumMathKeySpec(label: 'Maclaurin', expression: 'f(□)=Σ□₌₀∞(f⁽□⁾(0)⁄□!)□^□', focusRole: 'seriesVariable', expectedRootKind: MathNodeKind.series, family: 'series', slotRoles: <String>{'seriesVariable', 'seriesIndex', 'seriesOrder', 'seriesFactorial'}),
    PremiumMathKeySpec(label: 'Geometrik', expression: 'Σ□₌₀∞□·□^□=□⁄(1-□)', focusRole: 'seriesVariable', expectedRootKind: MathNodeKind.series, family: 'series', slotRoles: <String>{'seriesIndex', 'seriesCoefficient', 'seriesRatio', 'seriesOrder'}),
    PremiumMathKeySpec(label: 'Binom', expression: '(1+□)^□=Σ□₌₀∞(□C□)□^□', focusRole: 'seriesVariable', expectedRootKind: MathNodeKind.series, family: 'series', slotRoles: <String>{'seriesVariable', 'seriesParameter', 'seriesIndex'}),
    PremiumMathKeySpec(label: 'eˣ serisi', expression: 'e^□=Σ□₌₀∞□^□⁄□!', focusRole: 'seriesVariable', expectedRootKind: MathNodeKind.series, family: 'series', slotRoles: <String>{'seriesVariable', 'seriesIndex', 'seriesOrder'}),
    PremiumMathKeySpec(label: 'sin serisi', expression: 'sin(□)=Σ□₌₀∞((-1)^□·□^(2□+1))⁄(2□+1)!', focusRole: 'seriesVariable', expectedRootKind: MathNodeKind.series, family: 'series', slotRoles: <String>{'seriesVariable', 'seriesIndex'}),
    PremiumMathKeySpec(label: 'cos serisi', expression: 'cos(□)=Σ□₌₀∞((-1)^□·□^(2□))⁄(2□)!', focusRole: 'seriesVariable', expectedRootKind: MathNodeKind.series, family: 'series', slotRoles: <String>{'seriesVariable', 'seriesIndex'}),
    PremiumMathKeySpec(label: 'ln serisi', expression: 'ln(1+□)=Σ□₌₁∞((-1)^(□+1)·□^□)⁄□', focusRole: 'seriesVariable', expectedRootKind: MathNodeKind.series, family: 'series', slotRoles: <String>{'seriesVariable', 'seriesIndex'}),
    PremiumMathKeySpec(label: 'arctan serisi', expression: 'arctan(□)=Σ□₌₀∞((-1)^□·□^(2□+1))⁄(2□+1)', focusRole: 'seriesVariable', expectedRootKind: MathNodeKind.series, family: 'series', slotRoles: <String>{'seriesVariable', 'seriesIndex'}),
  ];

  static PremiumMathKeySpec? specFor(String label) {
    for (final spec in all) {
      if (spec.label == label) return spec;
    }
    return null;
  }

  static Set<String> get labels => <String>{for (final spec in all) spec.label};

  static List<String> get duplicateLabels {
    final seen = <String>{};
    final duplicates = <String>{};
    for (final spec in all) {
      if (!seen.add(spec.label)) duplicates.add(spec.label);
    }
    return duplicates.toList(growable: false)..sort();
  }

  static Set<String> get protectedFamilies => <String>{
        'subscript',
        'derivative-order',
        'fraction',
        'root',
        'power',
        'wrapper',
        'trig',
        'log',
        'complex',
        'derivative',
        'integral',
        'limit',
        'big-operator',
        'matrix',
        'vector',
        'function',
        'linear-function',
        'system',
        'discrete',
        'postfix',
        'series',
        'algebra',
        'complex-power',
      };
}
