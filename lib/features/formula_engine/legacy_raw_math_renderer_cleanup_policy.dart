/// V172-P visible renderer cleanup policy for legacy raw math strings.
///
/// MathPro may still accept programmer aliases internally for parsing, solver
/// compatibility, graph evaluation, and regression tests.  Those aliases must
/// never be treated as premium visible UI.  This policy is the single visible
/// cleanup gate for inverse trig aliases, legacy filled log-base strings, and
/// known corrupted subscript markers.
class LegacyRawMathRendererCleanupPolicy {
  const LegacyRawMathRendererCleanupPolicy._();

  static const String version = 'mathpro-v172p-legacy-raw-math-renderer-cleanup-v1';

  static const bool rawProgrammerAliasesAllowedInVisibleUi = false;
  static const bool legacyParserAliasesAllowedInternally = true;
  static const bool logCallChainAllowedInVisibleUi = false;
  static const bool x8nCorruptionAllowed = false;

  static const Set<String> internalAliasFunctions = <String>{
    'asin',
    'acos',
    'atan',
    'acot',
    'asinh',
    'acosh',
    'atanh',
  };

  static const Map<String, String> inverseFunctionDisplayNames = <String, String>{
    'asin': 'sin⁻¹',
    'acos': 'cos⁻¹',
    'atan': 'tan⁻¹',
    'acot': 'cot⁻¹',
    'asinh': 'sinh⁻¹',
    'acosh': 'cosh⁻¹',
    'atanh': 'tanh⁻¹',
  };

  static const Map<String, String> templateAliasDisplayLabels = <String, String>{
    'asin(□)': 'sin⁻¹(□)',
    'acos(□)': 'cos⁻¹(□)',
    'atan(□)': 'tan⁻¹(□)',
    'acot(□)': 'cot⁻¹(□)',
    'asinh(□)': 'sinh⁻¹(□)',
    'acosh(□)': 'cosh⁻¹(□)',
    'atanh(□)': 'tanh⁻¹(□)',
    'acot': 'cot⁻¹(□)',
  };

  static final RegExp _rawInverseCallPattern = RegExp(
    r'\b(asin|acos|atan|acot|asinh|acosh|atanh)\s*\(([^()]*)\)',
  );

  static final RegExp _rawInverseTokenPattern = RegExp(
    r'\b(?:asin|acos|atan|acot|asinh|acosh|atanh)\s*\(',
  );

  static final RegExp _legacyFilledLogPattern = RegExp(
    r'\blog\(([^()]+)\)\(([^()]*)\)',
  );

  /// Canonicalizes labels used by keycaps, MORE chips, long-press chips,
  /// fallback labels, and any compact render surface.  It intentionally does not
  /// mutate solver/parser internals.
  static String canonicalVisibleMath(String value) {
    var output = value.trim();
    if (output.isEmpty) return output;

    final direct = templateAliasDisplayLabels[output];
    if (direct != null) return direct;

    output = output.replaceAllMapped(_rawInverseCallPattern, (match) {
      final function = match.group(1)!;
      final argument = match.group(2)!.trim();
      final display = inverseFunctionDisplayNames[function] ?? function;
      return '$display($argument)';
    });

    output = output.replaceAllMapped(_legacyFilledLogPattern, (match) {
      final base = match.group(1)!.trim();
      final argument = match.group(2)!.trim();
      return 'log₍$base₎($argument)';
    });

    // Previously observed corrupt subscript leak: x8n.  Do not guess a full AST
    // repair here; only prevent the exact corrupted marker from remaining as a
    // visible string if a fallback surface ever receives it.
    output = output.replaceAll('x8n', 'x₈');
    return output;
  }

  static bool exposesVisibleRawMath(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return false;
    return _rawInverseTokenPattern.hasMatch(trimmed) ||
        _legacyFilledLogPattern.hasMatch(trimmed) ||
        trimmed.contains('x8n');
  }

  static bool isCanonicalVisibleMath(String value) {
    return !exposesVisibleRawMath(canonicalVisibleMath(value));
  }

  static String cleanupAuditLabel(String value) {
    final canonical = canonicalVisibleMath(value);
    return exposesVisibleRawMath(canonical) ? 'RAW_LEAK:$canonical' : canonical;
  }
}
