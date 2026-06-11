/// V172-M pixel QA cursor matrix contract.
///
/// This file does not claim real-device PASS.  It defines the minimum cursor
/// scenarios that must be exercised before MathPro can honestly call the
/// no-loupe cursor engine +95 / Photomath-grade.  The matrix is intentionally
/// source-controlled so future phases cannot silently forget fraction,
/// calculus, matrix, system, or differential-equation cursor families.
class PixelQACursorMatrixPolicy {
  const PixelQACursorMatrixPolicy._();

  static const String version = 'mathpro-v172m-pixel-qa-cursor-matrix-v1';

  static const bool realDevicePassClaimed = false;
  static const bool editorLoupeRequired = false;
  static const bool editorLongPressMenuRequired = false;
  static const bool greenDebugOverlayAllowed = false;

  static const List<String> requiredRoleFamilies = <String>[
    'linear',
    'functionArgument',
    'fractionNumerator',
    'fractionDenominator',
    'powerExponent',
    'subscript',
    'logBase',
    'sqrtValue',
    'integralLowerLimit',
    'integralUpperLimit',
    'integralBody',
    'integralDifferential',
    'derivativeOrder',
    'derivativeVariable',
    'matrixCell',
    'systemLeft',
    'systemRight',
  ];

  static const List<PixelQACursorCase> cases = <PixelQACursorCase>[
    PixelQACursorCase(
      id: 'plain-linear-number',
      expression: '123456',
      requiredRoles: <String>['linear'],
      acceptance: 'Every digit gap must place a visible no-loupe caret.',
    ),
    PixelQACursorCase(
      id: 'function-argument-number',
      expression: 'sin(300)',
      requiredRoles: <String>['functionArgument'],
      acceptance: 'Taps inside 300 must stay inside the function argument.',
    ),
    PixelQACursorCase(
      id: 'nested-function-depth',
      expression: 'ln(ln(8))',
      requiredRoles: <String>['functionArgument'],
      acceptance: 'Inner and outer function argument targets must remain distinct.',
    ),
    PixelQACursorCase(
      id: 'simple-fraction',
      expression: '3/4',
      requiredRoles: <String>['fractionNumerator', 'fractionDenominator'],
      acceptance: 'Numerator and denominator taps must not collapse to one coarse slot.',
    ),
    PixelQACursorCase(
      id: 'filled-fraction-local-offset',
      expression: '12/345',
      requiredRoles: <String>['fractionNumerator', 'fractionDenominator'],
      acceptance: 'Filled fraction slots must preserve local caret offsets.',
    ),
    PixelQACursorCase(
      id: 'power-exponent',
      expression: 'x²',
      requiredRoles: <String>['powerExponent'],
      acceptance: 'Exponent taps must resolve to the exponent slot without a loupe.',
    ),
    PixelQACursorCase(
      id: 'subscript-slot',
      expression: 'x₈',
      requiredRoles: <String>['subscript'],
      acceptance: 'Subscript taps must not create stray index-token corruption.',
    ),
    PixelQACursorCase(
      id: 'log-base-and-argument',
      expression: 'log₂(5)',
      requiredRoles: <String>['logBase', 'functionArgument'],
      acceptance: 'Base and argument targets must remain independently addressable.',
    ),
    PixelQACursorCase(
      id: 'sqrt-radicand',
      expression: '√(123)',
      requiredRoles: <String>['sqrtValue'],
      acceptance: 'Radicand digit gaps must receive the caret inside the root.',
    ),
    PixelQACursorCase(
      id: 'definite-integral',
      expression: '∫₀¹ x² dx',
      requiredRoles: <String>[
        'integralLowerLimit',
        'integralUpperLimit',
        'integralBody',
        'integralDifferential',
      ],
      acceptance: 'Integral limits, body, and differential variable must be separate targets.',
    ),
    PixelQACursorCase(
      id: 'second-derivative',
      expression: 'd²y/dx²',
      requiredRoles: <String>['derivativeOrder', 'derivativeVariable'],
      acceptance: 'Derivative order and variable areas must be selectable without textual menus.',
    ),
    PixelQACursorCase(
      id: 'matrix-2x2',
      expression: '[1 2; 3 4]',
      requiredRoles: <String>['matrixCell'],
      acceptance: 'Each matrix cell must be a row-major cursor target.',
    ),
    PixelQACursorCase(
      id: 'system-two-equations',
      expression: '{2x+y=5; x-y=1}',
      requiredRoles: <String>['systemLeft', 'systemRight'],
      acceptance: 'System cursor order must be left0, right0, left1, right1.',
    ),
    PixelQACursorCase(
      id: 'ode-second-order',
      expression: "y'' + 3y' + 2y = 0",
      requiredRoles: <String>['derivativeOrder', 'derivativeVariable', 'linear'],
      acceptance: 'ODE notation must retain derivative and linear equation targets.',
    ),
    PixelQACursorCase(
      id: 'long-mixed-expression',
      expression: 'sin(300)+cos(400)+log₂(500)+√(600)',
      requiredRoles: <String>['functionArgument', 'logBase', 'sqrtValue'],
      acceptance: 'Long mixed expressions must pan while keeping no-loupe tap precision.',
    ),
  ];

  static Set<String> coveredRoleFamilies() {
    return cases.expand((item) => item.requiredRoles).toSet();
  }

  static bool coversAllRequiredRoleFamilies() {
    final covered = coveredRoleFamilies();
    return requiredRoleFamilies.every(covered.contains);
  }

  static PixelQACursorCase? caseById(String id) {
    for (final item in cases) {
      if (item.id == id) return item;
    }
    return null;
  }
}

class PixelQACursorCase {
  const PixelQACursorCase({
    required this.id,
    required this.expression,
    required this.requiredRoles,
    required this.acceptance,
  });

  final String id;
  final String expression;
  final List<String> requiredRoles;
  final String acceptance;
}
