import '../features/editor/math_node.dart';
import 'premium_math_key_specs.dart';

/// V133: single registry layer for visible math templates.
///
/// This is intentionally a contract layer, not a keyboard layout file.  Key
/// positions, tab order, MORE placement and long-press ordering stay in
/// KeyConfig/ActionUtils.  This registry owns what a visible math label means:
/// the canonical template expression, first focus role, expected node family,
/// required slot roles and compact visual family.  New keyboard, MORE and
/// long-press entries should be added here before they are exposed publicly.
class MathTemplateContract {
  const MathTemplateContract({
    required this.id,
    required this.label,
    required this.expression,
    required this.focusRole,
    required this.expectedRootKind,
    required this.family,
    this.slotRoles = const <String>{},
    this.visualFamily = 'general',
    this.aliases = const <String>{},
  });

  final String id;
  final String label;
  final String expression;
  final String focusRole;
  final MathNodeKind expectedRootKind;
  final String family;
  final Set<String> slotRoles;
  final String visualFamily;
  final Set<String> aliases;

  bool get requiresEditableSlot => slotRoles.isNotEmpty || expression.contains('□');
}

class MathTemplateContractRegistry {
  const MathTemplateContractRegistry._();

  static const List<MathTemplateContract> contracts = <MathTemplateContract>[
    MathTemplateContract(
      id: 'fraction.basic',
      label: '□/□',
      aliases: <String>{'□⁄□', 'frac', 'karışık kesir', 'bileşik kesir'},
      expression: '□⁄□',
      focusRole: 'fractionNumerator',
      expectedRootKind: MathNodeKind.fraction,
      family: 'fraction',
      visualFamily: 'fraction',
      slotRoles: <String>{'fractionNumerator', 'fractionDenominator'},
    ),
    MathTemplateContract(
      id: 'root.sqrt',
      label: '√□',
      aliases: <String>{'√'},
      expression: '√(□)',
      focusRole: 'sqrtValue',
      expectedRootKind: MathNodeKind.sqrt,
      family: 'root',
      visualFamily: 'root',
      slotRoles: <String>{'sqrtValue'},
    ),
    MathTemplateContract(
      id: 'root.indexed',
      label: '□√□',
      aliases: <String>{'ⁿ√', 'ⁿ√(□)'},
      expression: '□√(□)',
      focusRole: 'rootIndex',
      expectedRootKind: MathNodeKind.indexedRoot,
      family: 'root',
      visualFamily: 'root',
      slotRoles: <String>{'rootIndex', 'sqrtValue'},
    ),
    MathTemplateContract(
      id: 'power.generic',
      label: '□^□',
      aliases: <String>{'^'},
      expression: '□^(□)',
      focusRole: 'powerExponent',
      expectedRootKind: MathNodeKind.power,
      family: 'power',
      visualFamily: 'power',
      slotRoles: <String>{'powerBase', 'powerExponent'},
    ),
    MathTemplateContract(
      id: 'postfix.factorial',
      label: '□!',
      expression: '□!',
      focusRole: 'postfixTarget',
      expectedRootKind: MathNodeKind.postfix,
      family: 'postfix',
      visualFamily: 'postfix',
      slotRoles: <String>{'postfixTarget'},
    ),
    MathTemplateContract(
      id: 'postfix.inverse',
      label: '□⁻¹',
      expression: '□⁻¹',
      focusRole: 'postfixTarget',
      expectedRootKind: MathNodeKind.postfix,
      family: 'postfix',
      visualFamily: 'postfix',
      slotRoles: <String>{'postfixTarget'},
    ),
    MathTemplateContract(
      id: 'postfix.transpose',
      label: '□ᵀ',
      expression: '□ᵀ',
      focusRole: 'postfixTarget',
      expectedRootKind: MathNodeKind.postfix,
      family: 'postfix',
      visualFamily: 'postfix',
      slotRoles: <String>{'postfixTarget'},
    ),
    MathTemplateContract(
      id: 'postfix.hermitian',
      label: '□ᴴ',
      expression: '□ᴴ',
      focusRole: 'postfixTarget',
      expectedRootKind: MathNodeKind.postfix,
      family: 'postfix',
      visualFamily: 'postfix',
      slotRoles: <String>{'postfixTarget'},
    ),
    MathTemplateContract(
      id: 'discrete.combination',
      label: '□C□',
      expression: '□C□',
      focusRole: 'functionArgument',
      expectedRootKind: MathNodeKind.functionCall,
      family: 'discrete',
      visualFamily: 'binary-slot-operator',
      slotRoles: <String>{'functionArgument', 'functionArgument2'},
    ),
    MathTemplateContract(
      id: 'discrete.permutation',
      label: '□P□',
      expression: '□P□',
      focusRole: 'functionArgument',
      expectedRootKind: MathNodeKind.functionCall,
      family: 'discrete',
      visualFamily: 'binary-slot-operator',
      slotRoles: <String>{'functionArgument', 'functionArgument2'},
    ),
    MathTemplateContract(
      id: 'function.generic.one_arg',
      label: 'f(□)',
      expression: 'f(□)',
      focusRole: 'functionArgument',
      expectedRootKind: MathNodeKind.functionCall,
      family: 'function',
      visualFamily: 'function',
      slotRoles: <String>{'functionArgument'},
    ),
    MathTemplateContract(
      id: 'function.generic.two_args',
      label: 'f(□,□)',
      expression: 'f(□,□)',
      focusRole: 'functionArgument',
      expectedRootKind: MathNodeKind.functionCall,
      family: 'function',
      visualFamily: 'function',
      slotRoles: <String>{'functionArgument', 'functionArgument2'},
    ),
    MathTemplateContract(
      id: 'function.composition.call',
      label: 'f∘g',
      expression: '(f∘g)(□)',
      focusRole: 'functionArgument',
      expectedRootKind: MathNodeKind.functionCall,
      family: 'function-composition',
      visualFamily: 'function',
      slotRoles: <String>{'functionArgument'},
    ),
    MathTemplateContract(
      id: 'trig.inverse.sin',
      label: 'sin⁻¹(□)',
      aliases: <String>{'asin(□)', 'sin⁻¹()'},
      expression: 'sin⁻¹(□)',
      focusRole: 'functionArgument',
      expectedRootKind: MathNodeKind.functionCall,
      family: 'trig',
      visualFamily: 'function',
      slotRoles: <String>{'functionArgument'},
    ),
    MathTemplateContract(
      id: 'trig.inverse.cos',
      label: 'cos⁻¹(□)',
      aliases: <String>{'acos(□)', 'cos⁻¹()'},
      expression: 'cos⁻¹(□)',
      focusRole: 'functionArgument',
      expectedRootKind: MathNodeKind.functionCall,
      family: 'trig',
      visualFamily: 'function',
      slotRoles: <String>{'functionArgument'},
    ),
    MathTemplateContract(
      id: 'trig.inverse.tan',
      label: 'tan⁻¹(□)',
      aliases: <String>{'atan(□)', 'tan⁻¹()'},
      expression: 'tan⁻¹(□)',
      focusRole: 'functionArgument',
      expectedRootKind: MathNodeKind.functionCall,
      family: 'trig',
      visualFamily: 'function',
      slotRoles: <String>{'functionArgument'},
    ),
    MathTemplateContract(
      id: 'log.custom_base',
      label: 'log_□(□)',
      aliases: <String>{'log₍□₎(□)', 'logₙ()'},
      expression: 'log₍□₎(□)',
      focusRole: 'logBase',
      expectedRootKind: MathNodeKind.logBase,
      family: 'log',
      visualFamily: 'log',
      slotRoles: <String>{'logBase', 'functionArgument'},
    ),
    MathTemplateContract(
      id: 'limit.editable',
      label: 'lim',
      aliases: <String>{'lim x→□'},
      expression: 'limₓ→□(□)',
      focusRole: 'limitTarget',
      expectedRootKind: MathNodeKind.limit,
      family: 'limit',
      visualFamily: 'limit',
      slotRoles: <String>{'limitTarget', 'limitBody'},
    ),
    MathTemplateContract(
      id: 'limit.infinity',
      label: 'lim x→∞',
      expression: 'limₓ→∞(□)',
      focusRole: 'limitBody',
      expectedRootKind: MathNodeKind.limit,
      family: 'limit',
      visualFamily: 'limit',
      slotRoles: <String>{'limitBody'},
    ),
    MathTemplateContract(
      id: 'integral.indefinite',
      label: '∫□dx',
      aliases: <String>{'∫'},
      expression: '∫(□)dx',
      focusRole: 'integralBody',
      expectedRootKind: MathNodeKind.integral,
      family: 'integral',
      visualFamily: 'integral',
      slotRoles: <String>{'integralBody'},
    ),
    MathTemplateContract(
      id: 'integral.definite',
      label: '∫ₐᵇ',
      expression: '∫_{□}^{□}(□)d□',
      focusRole: 'integralBody',
      expectedRootKind: MathNodeKind.integral,
      family: 'integral',
      visualFamily: 'integral',
      slotRoles: <String>{'integralLowerLimit', 'integralUpperLimit', 'integralBody', 'integralDifferential'},
    ),
    MathTemplateContract(
      id: 'bigop.sum',
      label: 'Σ',
      expression: 'Σ(□)',
      focusRole: 'sumBody',
      expectedRootKind: MathNodeKind.bigOperator,
      family: 'big-operator',
      visualFamily: 'big-operator',
      slotRoles: <String>{'sumLowerLimit', 'sumUpperLimit', 'sumBody'},
    ),
    MathTemplateContract(
      id: 'bigop.product',
      label: 'Π',
      expression: 'Π(□)',
      focusRole: 'productBody',
      expectedRootKind: MathNodeKind.bigOperator,
      family: 'big-operator',
      visualFamily: 'big-operator',
      slotRoles: <String>{'productLowerLimit', 'productUpperLimit', 'productBody'},
    ),
    MathTemplateContract(
      id: 'series.taylor',
      label: 'Taylor',
      expression: 'f(□)=Σ□₌₀∞(f⁽□⁾(□)⁄□!)(□-□)^□',
      focusRole: 'seriesVariable',
      expectedRootKind: MathNodeKind.series,
      family: 'series',
      visualFamily: 'series',
      slotRoles: <String>{'seriesVariable', 'seriesIndex', 'seriesOrder', 'seriesCenter', 'seriesFactorial'},
    ),
    MathTemplateContract(
      id: 'series.maclaurin',
      label: 'Maclaurin',
      expression: 'f(□)=Σ□₌₀∞(f⁽□⁾(0)⁄□!)□^□',
      focusRole: 'seriesVariable',
      expectedRootKind: MathNodeKind.series,
      family: 'series',
      visualFamily: 'series',
      slotRoles: <String>{'seriesVariable', 'seriesIndex', 'seriesOrder', 'seriesFactorial'},
    ),
    MathTemplateContract(
      id: 'series.geometric',
      label: 'Geometrik',
      expression: 'Σ□₌₀∞□·□^□=□⁄(1-□)',
      focusRole: 'seriesVariable',
      expectedRootKind: MathNodeKind.series,
      family: 'series',
      visualFamily: 'series',
      slotRoles: <String>{'seriesIndex', 'seriesCoefficient', 'seriesRatio', 'seriesOrder'},
    ),
    MathTemplateContract(
      id: 'series.binomial',
      label: 'Binom',
      expression: '(1+□)^□=Σ□₌₀∞(□C□)□^□',
      focusRole: 'seriesVariable',
      expectedRootKind: MathNodeKind.series,
      family: 'series',
      visualFamily: 'series',
      slotRoles: <String>{'seriesVariable', 'seriesParameter', 'seriesIndex'},
    ),
    MathTemplateContract(
      id: 'series.exp',
      label: 'eˣ serisi',
      expression: 'e^□=Σ□₌₀∞□^□⁄□!',
      focusRole: 'seriesVariable',
      expectedRootKind: MathNodeKind.series,
      family: 'series',
      visualFamily: 'series',
      slotRoles: <String>{'seriesVariable', 'seriesIndex', 'seriesOrder', 'seriesFactorial'},
    ),
    MathTemplateContract(
      id: 'series.sin',
      label: 'sin serisi',
      expression: 'sin(□)=Σ□₌₀∞((-1)^□·□^(2□+1))⁄(2□+1)!',
      focusRole: 'seriesVariable',
      expectedRootKind: MathNodeKind.series,
      family: 'series',
      visualFamily: 'series',
      slotRoles: <String>{'seriesVariable', 'seriesIndex', 'seriesOrder', 'seriesFactorial'},
    ),
    MathTemplateContract(
      id: 'series.cos',
      label: 'cos serisi',
      expression: 'cos(□)=Σ□₌₀∞((-1)^□·□^(2□))⁄(2□)!',
      focusRole: 'seriesVariable',
      expectedRootKind: MathNodeKind.series,
      family: 'series',
      visualFamily: 'series',
      slotRoles: <String>{'seriesVariable', 'seriesIndex', 'seriesOrder', 'seriesFactorial'},
    ),
    MathTemplateContract(
      id: 'series.ln',
      label: 'ln serisi',
      expression: 'ln(1+□)=Σ□₌₁∞((-1)^(□+1)·□^□)⁄□',
      focusRole: 'seriesVariable',
      expectedRootKind: MathNodeKind.series,
      family: 'series',
      visualFamily: 'series',
      slotRoles: <String>{'seriesVariable', 'seriesIndex', 'seriesOrder'},
    ),
    MathTemplateContract(
      id: 'series.arctan',
      label: 'arctan serisi',
      expression: 'arctan(□)=Σ□₌₀∞((-1)^□·□^(2□+1))⁄(2□+1)',
      focusRole: 'seriesVariable',
      expectedRootKind: MathNodeKind.series,
      family: 'series',
      visualFamily: 'series',
      slotRoles: <String>{'seriesVariable', 'seriesIndex', 'seriesOrder'},
    ),
  ];

  static MathTemplateContract? contractFor(String label) {
    final normalized = label.trim();
    for (final contract in contracts) {
      if (contract.label == normalized || contract.aliases.contains(normalized)) {
        return contract;
      }
    }

    // V133: premium key specs are now registry-compatible fallback contracts.
    // This prevents public keyboard/MORE/long-press labels from silently
    // drifting back to loose ActionUtils strings while the explicit registry
    // is expanded phase by phase. Explicit contracts above still win whenever
    // they need richer visualFamily/alias metadata.
    final spec = PremiumMathKeySpecs.specFor(normalized);
    if (spec == null) return null;
    return MathTemplateContract(
      id: 'premium.${spec.family}.${spec.label}',
      label: spec.label,
      expression: spec.expression,
      focusRole: spec.focusRole,
      expectedRootKind: spec.expectedRootKind,
      family: spec.family,
      visualFamily: _visualFamilyForPremiumFamily(spec.family),
      slotRoles: spec.slotRoles,
    );
  }

  static String _visualFamilyForPremiumFamily(String family) {
    if (family.contains('series')) return 'series';
    if (family.contains('integral')) return 'integral';
    if (family.contains('limit')) return 'limit';
    if (family.contains('derivative')) return 'derivative';
    if (family.contains('matrix')) return 'matrix';
    if (family.contains('vector')) return 'matrix';
    if (family.contains('log')) return 'log';
    if (family.contains('trig')) return 'function';
    if (family.contains('function')) return 'function';
    if (family.contains('postfix')) return 'postfix';
    if (family.contains('root')) return 'root';
    if (family.contains('fraction')) return 'fraction';
    return 'general';
  }

  static String canonicalExpressionFor(String label) => contractFor(label)?.expression ?? label;
  static String? focusRoleFor(String label) => contractFor(label)?.focusRole;
  static Set<String> slotRolesFor(String label) => contractFor(label)?.slotRoles ?? const <String>{};
  static String? visualFamilyFor(String label) => contractFor(label)?.visualFamily;

  static Set<String> get explicitLabels => <String>{
        for (final contract in contracts) contract.label,
        for (final contract in contracts) ...contract.aliases,
      };

  static Set<String> get labels => <String>{
        ...explicitLabels,
        ...PremiumMathKeySpecs.labels,
      };
}
