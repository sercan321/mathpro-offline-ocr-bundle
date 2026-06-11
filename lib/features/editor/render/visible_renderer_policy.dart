enum MathRenderMode {
  nativeFlutterMath,
  plainTextFallback,
}

class VisibleRendererPolicy {
  const VisibleRendererPolicy._();

  static const MathRenderMode defaultMode = MathRenderMode.nativeFlutterMath;

  static bool shouldUseMathRenderer(String expression) {
    return expression.trim().isNotEmpty;
  }

  static bool isStructuralExpression(String expression) {
    final value = expression.trim();
    if (value.isEmpty) return false;
    return value.contains('√') ||
        value.contains('⁄') ||
        value.contains('□') ||
        value.contains('∫') ||
        value.contains('Σ') ||
        value.contains('Π') ||
        value.contains('lim') ||
        value.contains('^') ||
        value.contains('ⁿ') ||
        value.contains('²') ||
        value.contains('³') ||
        value.contains('⁻¹') ||
        value.contains('₁₀') ||
        value.contains('₂') ||
        value.contains('₍') ||
        value.contains('matrix') ||
        value.contains('vector') ||
        value.contains(';');
  }
}
