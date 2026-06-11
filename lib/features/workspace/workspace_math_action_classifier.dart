import 'workspace_math_action.dart';

/// Conservative Q382 classifier. It deliberately uses safe lexical signals and
/// returns [WorkspaceExpressionKind.unsupported] when confidence is low; no CAS
/// or fake solver claim is made here.
class WorkspaceMathActionClassifier {
  const WorkspaceMathActionClassifier._();

  static WorkspaceExpressionKind classify(String expression) {
    final raw = expression.trim();
    if (raw.isEmpty) return WorkspaceExpressionKind.emptyExpression;
    final normalized = _normalize(raw);

    if (_looksLikeMatrix(normalized)) return WorkspaceExpressionKind.matrixExpression;
    if (_looksLikeSystem(raw)) return WorkspaceExpressionKind.linearSystem;
    if (_containsLimit(normalized)) return WorkspaceExpressionKind.limitExpression;
    if (_containsIntegral(normalized)) return WorkspaceExpressionKind.calculusIntegralExpression;
    if (_containsDerivative(normalized)) return WorkspaceExpressionKind.calculusDerivativeExpression;

    final hasEquals = normalized.contains('=');
    final hasVariable = RegExp(r'[a-zA-Z]').hasMatch(normalized);
    final hasTrig = RegExp(r'(sin|cos|tan|cot|sec|csc)', caseSensitive: false).hasMatch(normalized);
    final hasLog = RegExp(r'(log|ln)', caseSensitive: false).hasMatch(normalized);
    final hasExp = normalized.contains('e^') || RegExp(r'\^\(?[a-zA-Z]').hasMatch(normalized);
    final hasAbs = normalized.contains('|') || normalized.contains('abs(');
    final hasRadical = normalized.contains('sqrt') || normalized.contains('√');
    final hasComplex = RegExp(r'(^|[^a-zA-Z])i([^a-zA-Z]|$)').hasMatch(normalized) ||
        normalized.contains('complex') ||
        RegExp(r'(^|[^a-zA-Z])z([^a-zA-Z]|$)').hasMatch(normalized);
    final hasRational = normalized.contains('/') || normalized.contains('frac');

    if (hasTrig) return hasEquals ? WorkspaceExpressionKind.trigonometricEquation : WorkspaceExpressionKind.trigonometricExpression;
    if (hasLog) return WorkspaceExpressionKind.logarithmicExpression;
    if (hasExp && hasEquals) return WorkspaceExpressionKind.exponentialEquation;
    if (hasAbs) return WorkspaceExpressionKind.absoluteValueEquation;
    if (hasRadical) return WorkspaceExpressionKind.radicalEquation;
    if (hasComplex && hasVariable && hasEquals) return WorkspaceExpressionKind.complexEquation;
    if (hasComplex && !hasEquals) return WorkspaceExpressionKind.complexNumberExpression;
    if (hasRational) return hasEquals ? WorkspaceExpressionKind.rationalEquation : WorkspaceExpressionKind.rationalExpression;
    if (hasEquals && hasVariable) {
      return _degreeEstimate(normalized) >= 3
          ? WorkspaceExpressionKind.higherDegreePolynomialEquation
          : WorkspaceExpressionKind.polynomialEquation;
    }
    if (hasVariable) {
      return _looksPolynomial(normalized) ? WorkspaceExpressionKind.polynomialExpression : WorkspaceExpressionKind.algebraicExpression;
    }
    if (RegExp(r'^[0-9+\-*/().,\s^]+$').hasMatch(normalized)) return WorkspaceExpressionKind.numericExpression;
    return WorkspaceExpressionKind.unsupported;
  }

  static String? variableFor(String expression) {
    final match = RegExp(r'[xyz]', caseSensitive: false).firstMatch(expression);
    return match?.group(0)?.toLowerCase();
  }

  static String _normalize(String input) {
    return input
        .replaceAll('²', '^2')
        .replaceAll('³', '^3')
        .replaceAll('−', '-')
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('\\frac', 'frac')
        .replaceAll('\\sqrt', 'sqrt')
        .replaceAll('\\sin', 'sin')
        .replaceAll('\\cos', 'cos')
        .replaceAll('\\tan', 'tan')
        .replaceAll('\\log', 'log')
        .replaceAll('\\ln', 'ln')
        .replaceAll('\\int', 'int')
        .replaceAll('\\lim', 'lim')
        .toLowerCase();
  }

  static bool _containsDerivative(String expression) {
    return expression.contains('d/d') || expression.contains('derivative') || RegExp(r"[fgy]'\(").hasMatch(expression);
  }

  static bool _containsIntegral(String expression) => expression.contains('int') || expression.contains('∫');

  static bool _containsLimit(String expression) => expression.contains('lim') || expression.contains('limit');

  static bool _looksLikeMatrix(String expression) {
    return expression.contains('[[') || expression.contains('matrix') || expression.contains('pmatrix') || expression.contains('bmatrix');
  }

  static bool _looksLikeSystem(String expression) {
    final lineBreakCount = RegExp(r'\n').allMatches(expression).length;
    final equalsCount = '='.allMatches(expression).length;
    return lineBreakCount >= 1 && equalsCount >= 2;
  }

  static bool _looksPolynomial(String expression) {
    if (!RegExp(r'[a-zA-Z]').hasMatch(expression)) return false;
    return !RegExp(r'(sin|cos|tan|log|ln|sqrt|int|lim|matrix|frac)', caseSensitive: false).hasMatch(expression);
  }

  static int _degreeEstimate(String expression) {
    var degree = 1;
    for (final match in RegExp(r'\^(\d+)').allMatches(expression)) {
      final parsed = int.tryParse(match.group(1) ?? '');
      if (parsed != null && parsed > degree) degree = parsed;
    }
    return degree;
  }
}
