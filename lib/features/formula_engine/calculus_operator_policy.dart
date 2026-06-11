import '../editor/math_node.dart';

/// Central policy for calculus / advanced operator families.
///
/// This is not a solver layer. It is a display + parse hygiene contract that
/// keeps limit, integral, derivative, Σ/Π, and series templates from drifting
/// into one-off programmer strings after slot editing.
class CalculusOperatorPolicy {
  const CalculusOperatorPolicy._();

  static const String version = 'mathpro-v104-calculus-operator-policy';

  static const Set<MathNodeKind> calculusFamilies = <MathNodeKind>{
    MathNodeKind.limit,
    MathNodeKind.integral,
    MathNodeKind.derivative,
    MathNodeKind.bigOperator,
    MathNodeKind.series,
  };

  static bool isCalculusFamily(MathNodeKind kind) => calculusFamilies.contains(kind);

  static String canonicalDisplayForCalculusFamilies(String expression) {
    var value = expression.trim();
    if (value.isEmpty) return value;

    value = _canonicalizeLimit(value);
    value = _canonicalizeBigOperators(value);
    value = _canonicalizeIntegral(value);
    value = _canonicalizeDerivative(value);
    return value;
  }

  static String _canonicalizeLimit(String value) {
    var output = value;
    output = output.replaceAllMapped(
      RegExp(r'lim_?([A-Za-zπθλ])\s*→\s*([^()]+)\(([^()]*)\)'),
      (match) => 'lim₍${match.group(1)!}→${match.group(2)!.trim()}₎(${match.group(3)!.trim()})',
    );
    output = output.replaceAllMapped(
      RegExp(r'lim\s+([A-Za-zπθλ])\s*→\s*([^()]+)\(([^()]*)\)'),
      (match) => 'lim₍${match.group(1)!}→${match.group(2)!.trim()}₎(${match.group(3)!.trim()})',
    );
    output = output
        .replaceAll('lim x→□', 'lim₍x→□₎(□)')
        .replaceAll('lim x→∞', 'lim₍x→∞₎(□)')
        .replaceAll('lim x→0⁺', 'lim₍x→0⁺₎(□)')
        .replaceAll('lim x→0⁻', 'lim₍x→0⁻₎(□)')
        .replaceAll('limₓ→□(□)', 'lim₍x→□₎(□)')
        .replaceAll('limₓ→∞(□)', 'lim₍x→∞₎(□)')
        .replaceAll('limₓ→0⁺(□)', 'lim₍x→0⁺₎(□)')
        .replaceAll('limₓ→0⁻(□)', 'lim₍x→0⁻₎(□)')
        .replaceAll('limₓ→ₐ(□)', 'lim₍x→a₎(□)')
        .replaceAll('limₓ→ₐ⁺(□)', 'lim₍x→a⁺₎(□)')
        .replaceAll('limₓ→ₐ⁻(□)', 'lim₍x→a⁻₎(□)');
    return output;
  }

  static String _canonicalizeBigOperators(String value) {
    var output = value;
    output = output.replaceAllMapped(
      RegExp(r'Σ([A-Za-zπθλ□]+)₌([^∞()]+)∞\(([^()]*)\)'),
      (match) => 'Σ_{${match.group(1)!}=${match.group(2)!.trim()}}^{∞}(${match.group(3)!.trim()})',
    );
    output = output.replaceAllMapped(
      RegExp(r'Π([A-Za-zπθλ□]+)₌([^∞()]+)∞\(([^()]*)\)'),
      (match) => 'Π_{${match.group(1)!}=${match.group(2)!.trim()}}^{∞}(${match.group(3)!.trim()})',
    );
    output = output.replaceAllMapped(
      RegExp(r'Σᵢ₌₁ⁿ\(([^()]*)\)'),
      (match) => 'Σ_{i=1}^{n}(${match.group(1)!.trim()})',
    );
    output = output.replaceAllMapped(
      RegExp(r'Πᵢ₌₁ⁿ\(([^()]*)\)'),
      (match) => 'Π_{i=1}^{n}(${match.group(1)!.trim()})',
    );
    return output;
  }

  static String _canonicalizeIntegral(String value) {
    var output = value;
    output = output.replaceAllMapped(
      RegExp(r'∫₀¹\(([^()]*)\)d([A-Za-z0-9πθλ□]+)'),
      (match) => '∫_{0}^{1}(${match.group(1)!.trim()})d${match.group(2)!.trim()}',
    );
    output = output.replaceAllMapped(
      RegExp(r'∫ₐᵇ\(([^()]*)\)d([A-Za-z0-9πθλ□]+)'),
      (match) => '∫_{a}^{b}(${match.group(1)!.trim()})d${match.group(2)!.trim()}',
    );
    return output;
  }

  static String _canonicalizeDerivative(String value) {
    return value
        .replaceAll('∂/∂x(□)', '∂/∂x(□)')
        .replaceAll('d/dx(□)', 'd/dx(□)');
  }
}
