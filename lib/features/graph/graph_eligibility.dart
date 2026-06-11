import 'graph_models.dart';

class GraphEligibility {
  const GraphEligibility._();

  static GraphEligibilityResult classify({required String expression, required String result}) {
    final cleanExpression = _clean(expression);
    final cleanResult = _clean(result).replaceFirst(RegExp(r'^=\s*'), '');

    if (cleanExpression.isEmpty) {
      return const GraphEligibilityResult(
        kind: GraphEligibilityKind.notGraphable,
        message: 'Grafik çizmek için önce bir ifade yaz.',
      );
    }

    final lower = cleanExpression.toLowerCase();
    final hasX = _hasVariable(lower, 'x');
    final hasY = _hasVariable(lower, 'y');
    final hasEquality = cleanExpression.contains('=');
    final startsWithYEquals = RegExp(r'^\s*y\s*=').hasMatch(lower);
    final startsWithZEquals = RegExp(r'^\s*z\s*=').hasMatch(lower);

    if (startsWithZEquals) {
      final rightSide = cleanExpression.split('=').skip(1).join('=').trim();
      final normalizedRight = _normalizeMath(rightSide);
      final rightHasX = _hasVariable(normalizedRight.toLowerCase(), 'x');
      final rightHasY = _hasVariable(normalizedRight.toLowerCase(), 'y');
      final rightNumeric = double.tryParse(normalizedRight.replaceAll(',', '.'));
      if (rightHasX || rightHasY || rightNumeric != null) {
        return GraphEligibilityResult(
          kind: GraphEligibilityKind.graphableExplicit,
          normalizedExpression: normalizedRight,
          message: '3D yüzey grafik için hazır.',
        );
      }
    }

    if (startsWithYEquals) {
      final rightSide = cleanExpression.split('=').skip(1).join('=').trim();
      final normalizedRight = _normalizeMath(rightSide);
      final rightHasX = _hasVariable(normalizedRight.toLowerCase(), 'x');
      final rightHasY = _hasVariable(normalizedRight.toLowerCase(), 'y');
      final rightNumeric = double.tryParse(normalizedRight.replaceAll(',', '.'));
      if (rightHasX && !rightHasY) {
        return GraphEligibilityResult(
          kind: GraphEligibilityKind.graphableExplicit,
          normalizedExpression: normalizedRight,
          message: 'Açık fonksiyon grafik için hazır.',
        );
      }
      if (!rightHasX && !rightHasY && rightNumeric != null) {
        return GraphEligibilityResult(
          kind: GraphEligibilityKind.graphableExplicit,
          normalizedExpression: _formatConstant(rightNumeric),
          constantValue: rightNumeric,
          message: 'Sabit fonksiyon grafik için hazır.',
        );
      }
    }

    if (hasX && hasY && hasEquality) {
      return const GraphEligibilityResult(
        kind: GraphEligibilityKind.implicitPending,
        message: 'Bu denklem türü ileri grafik modunda desteklenecek. Şimdilik y = f(x) veya z = f(x,y) biçimindeki ifadeleri çizebilirim.',
      );
    }

    if (hasX || hasY) {
      final normalized = _normalizeMath(cleanExpression);
      return GraphEligibilityResult(
        kind: GraphEligibilityKind.graphableExplicit,
        normalizedExpression: normalized,
        message: hasY ? '3D yüzey grafik için hazır.' : 'x içeren ifade grafik için hazır.',
      );
    }

    final numeric = double.tryParse(cleanResult.replaceAll(',', '.'));
    if (!hasX && !hasY && numeric != null) {
      return GraphEligibilityResult(
        kind: GraphEligibilityKind.constantSuggestion,
        normalizedExpression: _formatConstant(numeric),
        constantValue: numeric,
        message: 'Bu ifade değişken içermiyor. İstersen sonucu sabit fonksiyon olarak çizebilirim.',
      );
    }

    return const GraphEligibilityResult(
      kind: GraphEligibilityKind.notGraphable,
      message: 'Bu ifade şimdilik grafik moduna uygun değil.',
    );
  }

  static GraphExpression expressionFromEligibility({
    required String originalExpression,
    required GraphEligibilityResult result,
  }) {
    final normalized = result.normalizedExpression ?? '0';
    final type = result.kind == GraphEligibilityKind.constantSuggestion || result.constantValue != null ? GraphType.constant : GraphType.explicit;
    final yMin = result.constantValue == null ? -10.0 : result.constantValue! - 5.0;
    final yMax = result.constantValue == null ? 10.0 : result.constantValue! + 5.0;
    return GraphExpression(
      originalExpression: originalExpression,
      normalizedExpression: normalized,
      type: type,
      yMin: yMin == yMax ? yMin - 1 : yMin,
      yMax: yMin == yMax ? yMax + 1 : yMax,
    );
  }

  static bool _hasVariable(String expression, String variable) {
    return RegExp('(^|[^a-zA-Z])$variable([^a-zA-Z]|\$)').hasMatch(expression);
  }

  static String _clean(String value) => value.trim().replaceAll('−', '-').replaceAll('×', '*').replaceAll('÷', '/');

  static String _normalizeMath(String value) {
    return _clean(value)
        .replaceAll('²', '^2')
        .replaceAll('³', '^3')
        .replaceAll('√x', 'sqrt(x)')
        .replaceAll('√(x)', 'sqrt(x)')
        .replaceAll('√(', 'sqrt(')
        .replaceAll('ln(', 'log(')
        .replaceAll('log₁₀(', 'log10(')
        .replaceAll('log₂(', 'log2(')
        .replaceAll('π', 'pi')
        .replaceAll('−', '-');
  }

  static String _formatConstant(double value) {
    if ((value - value.roundToDouble()).abs() < 1e-10) return value.round().toString();
    return value.toStringAsFixed(6).replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '');
  }
}
