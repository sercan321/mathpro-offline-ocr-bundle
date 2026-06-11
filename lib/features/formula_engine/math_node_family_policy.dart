import '../editor/math_node.dart';

/// Central policy for the primary editable math families.
///
/// V103 is intentionally not a solver. This file is the lightweight contract
/// that keeps Fraction / Power / Root / Function / Log from drifting back into
/// one-off string hacks across editor, preview, hit-test and render surfaces.
class MathNodeFamilyPolicy {
  const MathNodeFamilyPolicy._();

  static const String version = 'mathpro-v103-primary-family-policy';

  static const Set<MathNodeKind> primaryFamilies = <MathNodeKind>{
    MathNodeKind.fraction,
    MathNodeKind.power,
    MathNodeKind.subscript,
    MathNodeKind.sqrt,
    MathNodeKind.indexedRoot,
    MathNodeKind.functionCall,
    MathNodeKind.logBase,
  };

  static bool isPrimaryFamily(MathNodeKind kind) => primaryFamilies.contains(kind);

  static String canonicalDisplayForPrimaryFamilies(String expression) {
    var value = expression.trim();
    if (value.isEmpty) return value;

    final protectsSeriesTemplate = value.contains('Σ') || value.contains('Π');
    final protectsDerivativeTemplate = _looksLikeDerivativeTemplate(value);
    value = _canonicalizeLegacyProgrammerFunctions(value);
    value = _canonicalizeLogBase(value);
    if (!protectsSeriesTemplate && !protectsDerivativeTemplate) {
      value = _canonicalizePower(value);
      value = _canonicalizeRoot(value);
      value = _canonicalizeFraction(value);
    }
    value = _canonicalizeSubscript(value);
    return value;
  }

  static bool _looksLikeDerivativeTemplate(String value) {
    return RegExp(r'^(?:d/dx|d²/dx²|d³/dx³|∂/∂x|∂²/∂x²)\(').hasMatch(value.trim()) ||
        RegExp(r'^(?:dy/dx|d²y/dx²)$').hasMatch(value.trim());
  }

  static String _canonicalizeLegacyProgrammerFunctions(String value) {
    const replacements = <String, String>{
      'asin': 'sin⁻¹',
      'acos': 'cos⁻¹',
      'atan': 'tan⁻¹',
      'acot': 'cot⁻¹',
      'asinh': 'sinh⁻¹',
      'acosh': 'cosh⁻¹',
      'atanh': 'tanh⁻¹',
    };
    var output = value;
    for (final entry in replacements.entries) {
      output = output.replaceAllMapped(
        RegExp('\\b${entry.key}\\s*\\('),
        (_) => '${entry.value}(',
      );
    }
    return output;
  }

  static String _canonicalizeLogBase(String value) {
    var output = value;
    output = output.replaceAll('log_□(□)', 'log₍□₎(□)');
    output = output.replaceAllMapped(RegExp(r'log\(([^()]*)\)\(([^()]*)\)'), (match) {
      return 'log₍${match.group(1)!.trim()}₎(${match.group(2)!.trim()})';
    });
    output = output.replaceAllMapped(RegExp(r'log_\(([^()]*)\)\(([^()]*)\)'), (match) {
      return 'log₍${match.group(1)!.trim()}₎(${match.group(2)!.trim()})';
    });
    output = output.replaceAllMapped(RegExp(r'log_([A-Za-z0-9πθλ□]+)\(([^()]*)\)'), (match) {
      return 'log₍${match.group(1)!.trim()}₎(${match.group(2)!.trim()})';
    });
    return output;
  }

  static String _canonicalizePower(String value) {
    var output = value;
    output = output.replaceAllMapped(RegExp(r'([A-Za-z0-9πθλ□]+)\^([A-Za-z0-9πθλ□]+)(?![A-Za-z0-9πθλ□])'), (match) {
      return '${match.group(1)}^(${match.group(2)})';
    });
    output = _canonicalizeStandaloneSuperscript(output, '²', '2');
    output = _canonicalizeStandaloneSuperscript(output, '³', '3');
    output = _canonicalizeStandaloneSuperscript(output, 'ⁿ', 'n');
    output = _canonicalizeStandaloneSuperscript(output, '⁻¹', '-1');
    return output;
  }

  static String _canonicalizeStandaloneSuperscript(String value, String superscript, String exponent) {
    final pattern = RegExp('(^|[^A-Za-z])([A-Za-zπθλ])${RegExp.escape(superscript)}');
    return value.replaceAllMapped(pattern, (match) {
      return '${match.group(1) ?? ''}${match.group(2)}^($exponent)';
    });
  }

  static String _canonicalizeRoot(String value) {
    var output = value;
    output = output.replaceAll('∛□', '³√(□)');
    output = output.replaceAllMapped(RegExp(r'√([A-Za-z0-9πθλ□]+)(?![A-Za-z0-9πθλ□])'), (match) {
      return '√(${match.group(1)})';
    });
    output = output.replaceAllMapped(RegExp(r'³√([A-Za-z0-9πθλ□]+)(?![A-Za-z0-9πθλ□])'), (match) {
      return '³√(${match.group(1)})';
    });
    output = output.replaceAllMapped(RegExp(r'ⁿ√([A-Za-z0-9πθλ□]+)(?![A-Za-z0-9πθλ□])'), (match) {
      return 'ⁿ√(${match.group(1)})';
    });
    return output;
  }

  static String _canonicalizeSubscript(String value) {
    return value
        .replaceAll('x_n', 'x_□')
        .replaceAll('y_n', 'y_□')
        .replaceAll('log_10', 'log₁₀')
        .replaceAll('log_2', 'log₂');
  }

  static String _canonicalizeFraction(String value) {
    // Keep derivative tokens like d/dx intact; only normalize explicit numeric
    // and placeholder slash templates into the structural fraction glyph.
    return value.replaceAllMapped(
      RegExp(r'(□|\d+(?:\.\d+)?)\/(□|\d+(?:\.\d+)?)'),
      (match) => '${match.group(1)}⁄${match.group(2)}',
    );
  }
}
