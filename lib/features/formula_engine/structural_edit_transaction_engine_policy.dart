import 'structural_placeholder_restoration_policy.dart';

/// Q60 — Structural Edit Transaction Engine.
///
/// This policy is a post-edit transaction finalizer for the existing MathPro
/// cursor/editor engine. It does not change keyboard, MORE, long-press, app
/// shell, MathLabel, Graph, History, or Solution surfaces. Its job is to make
/// every insert/delete/template transaction pass through a single structural
/// normalization gate so half-template results such as `9/`, `sin()`, `√()`
/// or a bare differential `d` cannot survive as final editor state.
class StructuralEditTransactionEnginePolicy {
  const StructuralEditTransactionEnginePolicy._();

  static const bool structuralEditTransactionEngineAvailable = true;
  static const bool halfTemplateFinalStateAllowed = false;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool realDevicePlus95PassClaimed = false;
  static const String version = 'mathpro-v172-q60-structural-edit-transaction-engine';

  static const Set<String> protectedBrokenFinalForms = <String>{
    'sin()',
    'cos()',
    'tan()',
    'ln()',
    'log()',
    '√()',
    'ⁿ√()',
    '³√()',
    '9/',
    '9⁄',
    '/6',
    '⁄6',
    'd',
  };

  static bool isEditTransactionSource(String source) {
    final normalized = source.toLowerCase();
    return normalized.contains('insert') ||
        normalized.contains('backspace') ||
        normalized.contains('delete') ||
        normalized.contains('clear') ||
        normalized.contains('paste') ||
        normalized.contains('duplicate') ||
        normalized.contains('cut') ||
        normalized.contains('template') ||
        normalized.contains('transaction') ||
        normalized.contains('restore');
  }

  static bool mustNormalizeAfterEdit({required String before, required String after, required String source}) {
    if (before == after) return false;
    if (after.trim().isEmpty) return false;
    return isEditTransactionSource(source) || _looksStructural(after) || _containsBrokenFinalShape(after);
  }

  static String finalizeExpression({required String before, required String after, required String source}) {
    if (!mustNormalizeAfterEdit(before: before, after: after, source: source)) return after;
    return normalizeTransactionResult(after);
  }

  static String normalizeTransactionResult(String expression) {
    final restored = StructuralPlaceholderRestorationPolicy.normalizeAfterEdit(expression);
    return _restoreRemainingTransactionShapes(restored);
  }

  static bool isSafeFinalExpression(String expression) {
    final normalized = normalizeTransactionResult(expression);
    if (normalized != expression) return false;
    return !_containsBrokenFinalShape(expression);
  }

  static bool restoresToPlaceholder(String expression) => normalizeTransactionResult(expression).contains('□');

  static String transactionLabel(String source) => 'q60-transaction:$source';

  static bool _looksStructural(String expression) {
    return expression.contains('□') ||
        expression.contains('⁄') ||
        expression.contains('/') ||
        expression.contains('√') ||
        expression.contains('∫') ||
        expression.contains('log') ||
        expression.contains('sin') ||
        expression.contains('cos') ||
        expression.contains('tan') ||
        expression.contains('ln');
  }

  static bool _containsBrokenFinalShape(String expression) {
    if (RegExp(r'\b(?:sin|cos|tan|ln|log)\(\s*\)').hasMatch(expression)) return true;
    if (RegExp(r'(?:√|³√|ⁿ√)\(\s*\)').hasMatch(expression)) return true;
    if (RegExp(r'(^|[+\-−×÷=,(\[{])[/⁄][A-Za-z0-9πθλμφρ□]').hasMatch(expression)) return true;
    if (RegExp(r'[A-Za-z0-9πθλμφρ□)\]}][/⁄](?=$|[+\-−×÷=,)\]}])').hasMatch(expression)) return true;
    if (RegExp(r'\)d(?=$|[+\-−×÷=,)\]}])').hasMatch(expression)) return true;
    return false;
  }

  static String _restoreRemainingTransactionShapes(String expression) {
    var output = expression;
    output = output.replaceAllMapped(
      RegExp(r'\b(sin|cos|tan|ln|log)\(\s*\)'),
      (match) => '${match.group(1)}(□)',
    );
    output = output.replaceAllMapped(
      RegExp(r'(√|³√|ⁿ√)\(\s*\)'),
      (match) => '${match.group(1)}(□)',
    );
    output = output.replaceAllMapped(
      RegExp(r'(^|[+\-−×÷=,(\[{])([/⁄])([A-Za-z0-9πθλμφρ□])'),
      (match) => '${match.group(1)}□⁄${match.group(3)}',
    );
    output = output.replaceAllMapped(
      RegExp(r'([A-Za-z0-9πθλμφρ□)\]}])([/⁄])(?=$|[+\-−×÷=,)\]}])'),
      (match) => '${match.group(1)}⁄□',
    );
    output = output.replaceAllMapped(
      RegExp(r'(\))d(?=$|[+\-−×÷=,)\]}])'),
      (match) => '${match.group(1)}d□',
    );
    return output;
  }
}
