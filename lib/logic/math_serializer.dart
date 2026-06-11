class MathSerializer {
  const MathSerializer._();

  static String expressionToDisplay(List<String> tokens) {
    if (tokens.isEmpty) return '';
    return tokens.join();
  }

  static String normalizeForEvaluation(String expression) {
    return expression
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('−', '-')
        .replaceAll('π', '3.141592653589793')
        .replaceAll('∞', 'Infinity');
  }
}
