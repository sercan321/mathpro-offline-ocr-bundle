/// Q51 — Structural Placeholder Restoration Repair.
///
/// This policy is deliberately string-level and post-edit: it does not change
/// the frozen keyboard, MORE tray, long-press popup, app shell, MathLabel,
/// Graph, History, or Solution surfaces. Its only job is to prevent structural
/// math templates from collapsing into half strings after deletion.
class StructuralPlaceholderRestorationPolicy {
  const StructuralPlaceholderRestorationPolicy._();

  static const String version = 'v172q51-structural-placeholder-restoration-repair';
  static const bool structuralPlaceholderRestorationAvailable = true;
  static const bool emptyStructuralSlotsRestoreToPlaceholder = true;
  static const bool halfTemplateStringsAllowed = false;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool caretLeadingRailHandledByQ52 = true;
  static const bool realDevicePlus95PassClaimed = false;

  static const List<String> protectedBrokenFinalForms = <String>[
    'sin()',
    'cos()',
    'tan()',
    'ln()',
    'log()',
    '9⁄',
    '9/',
    '⁄6',
    '/6',
    '√()',
    '∫(□)d',
  ];

  static String normalizeAfterEdit(String expression) {
    if (expression.trim().isEmpty) return expression;
    final protectedTokens = <String, String>{};
    var output = _protectDerivativeTokens(expression, protectedTokens);
    output = _normalizeEmptyFunctionCalls(output);
    output = _normalizeEmptyRoots(output);
    output = _normalizeHalfFractions(output);
    output = _normalizeEmptyIntegralSlots(output);
    output = _normalizeEmptyLogBaseSlots(output);
    return _restoreProtectedTokens(output, protectedTokens);
  }

  static String _protectDerivativeTokens(String source, Map<String, String> protectedTokens) {
    var output = source;
    const tokens = <String>['∂²/∂x²', '∂/∂x', 'd³/dx³', 'd²/dx²', 'd/dx'];
    for (var index = 0; index < tokens.length; index += 1) {
      final marker = '§MP_DERIVATIVE_$index§';
      protectedTokens[marker] = tokens[index];
      output = output.replaceAll(tokens[index], marker);
    }
    return output;
  }

  static String _restoreProtectedTokens(String source, Map<String, String> protectedTokens) {
    var output = source;
    for (final entry in protectedTokens.entries) {
      output = output.replaceAll(entry.key, entry.value);
    }
    return output;
  }

  static String _normalizeEmptyFunctionCalls(String source) {
    var output = source;
    const names = <String>[
      'sinh⁻¹', 'cosh⁻¹', 'tanh⁻¹', 'sin⁻¹', 'cos⁻¹', 'tan⁻¹', 'cot⁻¹',
      'asinh', 'acosh', 'atanh', 'asin', 'acos', 'atan', 'acot',
      'sinh', 'cosh', 'tanh', 'coth', 'sin', 'cos', 'tan', 'cot', 'sec', 'csc',
      'ln', 'log', 'Re', 'Im', 'arg', 'Arg', 'conj', 'cis', 'det', 'rank',
      'rref', 'eig', 'solve', 'round', 'sign', 'minor', 'cofactor', 'pinv',
      'proj', 'triple', 'unit', 'distance', 'EBOB', 'EKOK', 'Γ', 'f', 'g', 'h',
    ];
    for (final name in names) {
      output = output.replaceAllMapped(
        RegExp('${RegExp.escape(name)}\\(\\s*\\)'),
        (_) => '$name(□)',
      );
    }
    return output;
  }

  static String _normalizeEmptyRoots(String source) {
    var output = source;
    const rootPrefixes = <String>['ⁿ√', '³√', '∛', '√'];
    for (final prefix in rootPrefixes) {
      output = output.replaceAllMapped(
        RegExp('${RegExp.escape(prefix)}\\(\\s*\\)'),
        (_) => '$prefix(□)',
      );
    }
    for (final prefix in rootPrefixes) {
      if (output.endsWith(prefix)) output = '$output(□)';
    }
    return output;
  }

  static String _normalizeHalfFractions(String source) {
    var output = source;
    const atom = r'A-Za-z0-9πθλμφρ□';
    // Preserve normal derivative tokens via _protectDerivativeTokens, then
    // canonicalize only structural fraction slashes that occur between compact
    // math atoms or after/before an open structural side.
    output = output.replaceAllMapped(
      RegExp('([$atom\\)\\]])/([$atom\\(])'),
      (match) => '${match.group(1)}⁄${match.group(2)}',
    );
    output = output.replaceAllMapped(
      RegExp('(^|[+\\-−×÷=,;\\(\\[\\{])([⁄/])([$atom\\(])'),
      (match) => '${match.group(1)}□⁄${match.group(3)}',
    );
    output = output.replaceAllMapped(
      RegExp('([$atom\\)\\]])([⁄/])(?=\$|[+\\-−×÷=,;\\)\\]\\}])'),
      (match) => '${match.group(1)}⁄□',
    );
    return output;
  }

  static String _normalizeEmptyIntegralSlots(String source) {
    var output = source;
    if (!output.contains('∫')) return output;
    output = output.replaceAllMapped(
      RegExp(r'(∫(?:_\{[^}]*\}\^\{[^}]*\})?)\(\s*\)'),
      (match) => '${match.group(1)}(□)',
    );
    output = output.replaceAllMapped(
      RegExp(r'(\))d(?=$|[+\-−×÷=,;)\]}])'),
      (match) => '${match.group(1)}d□',
    );
    return output;
  }

  static String _normalizeEmptyLogBaseSlots(String source) {
    var output = source;
    output = output.replaceAllMapped(
      RegExp(r'log₍\s*₎\(([^)]*)\)'),
      (match) {
        final argument = (match.group(1) ?? '').trim();
        return 'log₍□₎(${argument.isEmpty ? '□' : argument})';
      },
    );
    output = output.replaceAllMapped(
      RegExp(r'log₍([^₎]*)₎\(\s*\)'),
      (match) {
        final base = (match.group(1) ?? '').trim();
        return 'log₍${base.isEmpty ? '□' : base}₎(□)';
      },
    );
    return output;
  }
}
