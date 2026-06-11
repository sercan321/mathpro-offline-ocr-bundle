import 'mathlive_state_adapter.dart';

/// V172-Q102 — MathLive State Normalization Hardening.
///
/// Q102 is a package-side normalization layer only. It converts MathLive Lab
/// state snapshots into deterministic MathPro candidate strings for future
/// Graph / History / Solution / evaluator adapters, but it does not mount
/// MathLive in the main workspace, does not make MathLive the default editor,
/// does not mutate protected UI surfaces, and does not claim cursor PASS.
class MathLiveStateNormalizationHardeningPolicy {
  const MathLiveStateNormalizationHardeningPolicy._();

  static const String phase = 'V172-Q102';
  static const String verifierScript = 'tool/verify_mathlive_state_normalization.mjs';
  static const String reportJson = 'tool/reports/mathlive_state_normalization_report.json';
  static const String reportMarkdown = 'tool/reports/mathlive_state_normalization_report.md';
  static const bool packageSideNormalizerImplemented = true;
  static const bool q101LabSmokeEvidenceClosureRequiredForActivation = true;
  static const bool mayRunWithoutRuntimeForStaticSamples = true;
  static const bool writesCanonicalSmokeEvidence = false;
  static const bool installsRuntimeFiles = false;
  static const bool graphUiMutationAllowed = false;
  static const bool historyUiMutationAllowed = false;
  static const bool solutionUiMutationAllowed = false;
  static const bool mainEditorSwitchAllowed = false;
  static const bool mainEditorMountAllowed = false;
  static const bool mathLiveEnabledByDefault = false;
  static const bool legacyCursorDeletionAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool cursorPassClaimAllowed = false;
  static const bool photomathWolframClaimAllowed = false;
  static const String mainEditorStateAuthorityActivationPhase = 'V172-Q144';

  static MathLiveStateNormalizationReadiness evaluateReadiness({
    required bool normalizerPolicyPresent,
    required bool deterministicSampleSuitePasses,
    required bool q101LabSmokeEvidenceClosed,
    required bool protectedSurfacesUnchanged,
    required bool graphHistorySolutionUiUntouched,
    required bool mainEditorStillLegacy,
    required bool noRuntimeEvidenceFaked,
    required bool noCanonicalSmokeEvidenceWritten,
  }) {
    final blockers = <String>[];
    if (!normalizerPolicyPresent) blockers.add('Q102 normalization policy is missing');
    if (!deterministicSampleSuitePasses) blockers.add('Q102 deterministic normalization samples did not pass');
    if (!q101LabSmokeEvidenceClosed) blockers.add('Q101 Lab smoke evidence closure has not passed; Q102 may not activate runtime flow');
    if (!protectedSurfacesUnchanged) blockers.add('protected UI surfaces changed');
    if (!graphHistorySolutionUiUntouched) blockers.add('Graph/History/Solution UI surfaces changed');
    if (!mainEditorStillLegacy) blockers.add('main editor did not remain legacy/default');
    if (!noRuntimeEvidenceFaked) blockers.add('runtime evidence was faked');
    if (!noCanonicalSmokeEvidenceWritten) blockers.add('canonical smoke evidence was written during Q102');

    final packageReady = normalizerPolicyPresent && deterministicSampleSuitePasses && protectedSurfacesUnchanged && graphHistorySolutionUiUntouched && mainEditorStillLegacy && noRuntimeEvidenceFaked && noCanonicalSmokeEvidenceWritten;
    final activationReady = packageReady && q101LabSmokeEvidenceClosed;
    return MathLiveStateNormalizationReadiness(
      status: activationReady
          ? 'MATHLIVE_STATE_NORMALIZATION_READY_FOR_Q103_BINDING'
          : packageReady
              ? 'MATHLIVE_STATE_NORMALIZATION_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED'
              : 'BLOCKED_MATHLIVE_STATE_NORMALIZATION_HARDENING',
      blockers: blockers,
      packageSideNormalizationReady: packageReady,
      mayProceedToQ103Binding: activationReady,
      maySwitchMainEditor: false,
      mayMountMainEditor: false,
      mayDeleteLegacyCursor: false,
      mayClaimCursorPass: false,
    );
  }

  static MathLiveNormalizedExpression normalizeSnapshot(MathLiveEditorStateSnapshot snapshot) {
    final source = snapshot.normalizedLatex.trim().isNotEmpty ? snapshot.normalizedLatex : snapshot.latex;
    final normalized = normalizeLatexToExpression(source);
    final plain = snapshot.plainText.trim().isNotEmpty ? snapshot.plainText.trim() : normalized.plainText;
    return normalized.copyWith(
      sourceLatex: snapshot.latex,
      plainText: plain,
      mathJson: snapshot.mathJson,
      evaluateRequested: snapshot.evaluateRequested,
      hasFocus: snapshot.hasFocus,
      sourceDiagnostic: snapshot.parseDiagnostic,
      labSafetyWarning: snapshot.isSafeForLabOnlyConsumption ? '' : 'q102-lab-state-safety-warning',
    );
  }

  static MathLiveNormalizedExpression normalizeLatexForMathPro(String latex) => normalizeLatexToExpression(latex);

  static MathLiveNormalizedExpression normalizeLatexToExpression(String latex) {
    final canonicalLatex = _canonicalLatex(latex);
    final expression = _latexToMathProExpression(canonicalLatex);
    final plain = _latexToPlainText(canonicalLatex, expression);
    final lower = expression.toLowerCase();
    final containsX = _hasVariable(lower, 'x');
    final containsY = _hasVariable(lower, 'y');
    final graphIntent = _classifyGraphIntent(expression, containsX: containsX, containsY: containsY);
    final evaluatorIntent = _classifyEvaluatorIntent(expression, containsX: containsX, containsY: containsY);
    final notes = <String>[];
    if (expression.contains('□')) notes.add('open-placeholder-slot');
    if (canonicalLatex.contains(r'\begin')) notes.add('advanced-tex-environment-preserved-for-later-parser');
    if (canonicalLatex.contains(r'\int')) notes.add('integral-normalization-is-parser-candidate-only');
    return MathLiveNormalizedExpression(
      phase: phase,
      sourceLatex: latex,
      canonicalLatex: canonicalLatex,
      normalizedExpression: expression,
      plainText: plain,
      mathJson: null,
      evaluateRequested: false,
      hasFocus: false,
      historyPayloadExpression: expression,
      graphCandidateExpression: graphIntent == 'notGraphable' ? '' : expression.replaceFirst(RegExp(r'^y='), ''),
      solutionCandidateExpression: expression,
      evaluatorCandidateExpression: expression,
      containsVariableX: containsX,
      containsVariableY: containsY,
      graphIntent: graphIntent,
      evaluatorIntent: evaluatorIntent,
      sourceDiagnostic: 'q102-direct-latex-normalization',
      labSafetyWarning: '',
      normalizationNotes: notes,
    );
  }

  static String _canonicalLatex(String value) {
    return value
        .replaceAll('\u00a0', ' ')
        .replaceAll('\u2212', '-')
        .replaceAll('−', '-')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  static String _latexToMathProExpression(String latex) {
    var value = latex;
    if (value.isEmpty) return '';
    value = value
        .replaceAll(r'\left', '')
        .replaceAll(r'\right', '')
        .replaceAll(r'\,', '')
        .replaceAll(r'\;', '')
        .replaceAll(r'\:', '')
        .replaceAll(r'\cdot', '*')
        .replaceAll(r'\times', '*')
        .replaceAll(r'\div', '/')
        .replaceAll(r'\pi', 'pi')
        .replaceAll('π', 'pi')
        .replaceAll(r'\theta', 'theta')
        .replaceAll(r'\infty', 'infinity');

    value = _replaceMathLivePlaceholders(value);
    value = _replaceOperatorName(value);
    value = _replaceSimpleFractions(value);
    value = _replaceSimpleSquareRoots(value);
    value = _replaceSimpleLogBases(value);
    value = _replaceFunctionCommands(value);
    value = _replaceBracedPowersAndSubscripts(value);
    value = value
        .replaceAll(RegExp(r'\s+'), '')
        .replaceAll('{', '')
        .replaceAll('}', '')
        .replaceAll('[', '(')
        .replaceAll(']', ')');
    return value;
  }

  static String _replaceMathLivePlaceholders(String input) {
    return input
        .replaceAll(RegExp(r'\\placeholder\s*\{[^{}]*\}'), '□')
        .replaceAll(RegExp(r'#\?|#0|#@'), '□');
  }

  static String _replaceOperatorName(String input) {
    return input.replaceAllMapped(RegExp(r'\\operatorname\{([^{}]+)\}'), (match) => match.group(1) ?? '');
  }

  static String _replaceSimpleFractions(String input) {
    var value = input;
    final pattern = RegExp(r'\\frac\{([^{}]+)\}\{([^{}]+)\}');
    while (pattern.hasMatch(value)) {
      value = value.replaceAllMapped(pattern, (match) => '(${match.group(1)})/(${match.group(2)})');
    }
    return value;
  }

  static String _replaceSimpleSquareRoots(String input) {
    var value = input;
    final indexed = RegExp(r'\\sqrt\[([^\[\]{}]+)\]\{([^{}]+)\}');
    value = value.replaceAllMapped(indexed, (match) => 'root_${match.group(1)}(${match.group(2)})');
    final simple = RegExp(r'\\sqrt\{([^{}]+)\}');
    while (simple.hasMatch(value)) {
      value = value.replaceAllMapped(simple, (match) => 'sqrt(${match.group(1)})');
    }
    return value;
  }

  static String _replaceSimpleLogBases(String input) {
    var value = input;
    final bracedWithParens = RegExp(r'\\log_\{([^{}]+)\}\(([^()]*)\)');
    value = value.replaceAllMapped(bracedWithParens, (match) => 'log_${match.group(1)}(${match.group(2)})');
    final simpleWithParens = RegExp(r'\\log_([^\\\s{}()]+)\(([^()]*)\)');
    value = value.replaceAllMapped(simpleWithParens, (match) => 'log_${match.group(1)}(${match.group(2)})');
    final bracedWithBody = RegExp(r'\\log_\{([^{}]+)\}\{([^{}]+)\}');
    value = value.replaceAllMapped(bracedWithBody, (match) => 'log_${match.group(1)}(${match.group(2)})');
    return value.replaceAll(r'\log', 'log');
  }

  static String _replaceFunctionCommands(String input) {
    return input
        .replaceAll(r'\sin', 'sin')
        .replaceAll(r'\cos', 'cos')
        .replaceAll(r'\tan', 'tan')
        .replaceAll(r'\ln', 'ln')
        .replaceAll(r'\exp', 'exp');
  }

  static String _replaceBracedPowersAndSubscripts(String input) {
    var value = input;
    value = value.replaceAllMapped(RegExp(r'\^\{([^{}]+)\}'), (match) => '^${match.group(1)}');
    value = value.replaceAllMapped(RegExp(r'_\{([^{}]+)\}'), (match) => '_${match.group(1)}');
    return value;
  }

  static String _latexToPlainText(String canonicalLatex, String expression) {
    if (canonicalLatex.isEmpty) return '';
    var value = canonicalLatex
        .replaceAll(r'\left', '')
        .replaceAll(r'\right', '')
        .replaceAll(r'\times', '×')
        .replaceAll(r'\div', '÷')
        .replaceAll(r'\pi', 'π')
        .replaceAll(r'\theta', 'θ')
        .replaceAll(r'\infty', '∞')
        .replaceAll(r'\sin', 'sin')
        .replaceAll(r'\cos', 'cos')
        .replaceAll(r'\tan', 'tan')
        .replaceAll(r'\ln', 'ln')
        .replaceAll(r'\log', 'log')
        .replaceAll(r'\sqrt{}', '√□')
        .replaceAll(r'\frac{}{}', '□/□');
    value = value.replaceAllMapped(RegExp(r'\\operatorname\{([^{}]+)\}'), (match) => match.group(1) ?? '');
    value = value.replaceAll(RegExp(r'\s+'), ' ').replaceAll('{', '').replaceAll('}', '').trim();
    return value.isEmpty ? expression : value;
  }

  static bool _hasVariable(String lowerExpression, String variable) {
    return RegExp('(^|[^a-zA-Z])$variable([^a-zA-Z]|\$)').hasMatch(lowerExpression);
  }

  static String _classifyGraphIntent(String expression, {required bool containsX, required bool containsY}) {
    if (expression.trim().isEmpty) return 'empty';
    if (RegExp(r'^y=').hasMatch(expression) && containsX) return 'graphableExplicit';
    if (containsX && containsY && expression.contains('=')) return 'implicitPending';
    if (containsX && !containsY) return 'graphableExplicit';
    if (!containsX && !containsY && _looksNumericCandidate(expression)) return 'constantSuggestion';
    return 'notGraphable';
  }

  static String _classifyEvaluatorIntent(String expression, {required bool containsX, required bool containsY}) {
    if (expression.trim().isEmpty) return 'empty';
    if (expression.contains('□')) return 'templateOpenSlot';
    if (containsX || containsY) return 'symbolicCandidate';
    if (_looksNumericCandidate(expression)) return 'numericCandidate';
    return 'parserCandidate';
  }

  static bool _looksNumericCandidate(String expression) {
    return RegExp(r'^[0-9+\-*/().,^_a-zA-Z]+$').hasMatch(expression) && !expression.contains('=');
  }
}

class MathLiveStateNormalizationReadiness {
  const MathLiveStateNormalizationReadiness({
    required this.status,
    required this.blockers,
    required this.packageSideNormalizationReady,
    required this.mayProceedToQ103Binding,
    required this.maySwitchMainEditor,
    required this.mayMountMainEditor,
    required this.mayDeleteLegacyCursor,
    required this.mayClaimCursorPass,
  });

  final String status;
  final List<String> blockers;
  final bool packageSideNormalizationReady;
  final bool mayProceedToQ103Binding;
  final bool maySwitchMainEditor;
  final bool mayMountMainEditor;
  final bool mayDeleteLegacyCursor;
  final bool mayClaimCursorPass;

  bool get isBlockedForActivation => !mayProceedToQ103Binding;
}

class MathLiveNormalizedExpression {
  const MathLiveNormalizedExpression({
    required this.phase,
    required this.sourceLatex,
    required this.canonicalLatex,
    required this.normalizedExpression,
    required this.plainText,
    required this.mathJson,
    required this.evaluateRequested,
    required this.hasFocus,
    required this.historyPayloadExpression,
    required this.graphCandidateExpression,
    required this.solutionCandidateExpression,
    required this.evaluatorCandidateExpression,
    required this.containsVariableX,
    required this.containsVariableY,
    required this.graphIntent,
    required this.evaluatorIntent,
    required this.sourceDiagnostic,
    required this.labSafetyWarning,
    required this.normalizationNotes,
  });

  final String phase;
  final String sourceLatex;
  final String canonicalLatex;
  final String normalizedExpression;
  final String plainText;
  final Object? mathJson;
  final bool evaluateRequested;
  final bool hasFocus;
  final String historyPayloadExpression;
  final String graphCandidateExpression;
  final String solutionCandidateExpression;
  final String evaluatorCandidateExpression;
  final bool containsVariableX;
  final bool containsVariableY;
  final String graphIntent;
  final String evaluatorIntent;
  final String sourceDiagnostic;
  final String labSafetyWarning;
  final List<String> normalizationNotes;

  bool get hasHistoryPayload => historyPayloadExpression.trim().isNotEmpty;
  bool get hasSolutionPayload => solutionCandidateExpression.trim().isNotEmpty;
  bool get isGraphCandidate => graphIntent == 'graphableExplicit' || graphIntent == 'constantSuggestion';
  bool get isSafePackageSideCandidate => labSafetyWarning.isEmpty;

  MathLiveNormalizedExpression copyWith({
    String? sourceLatex,
    String? plainText,
    Object? mathJson,
    bool? evaluateRequested,
    bool? hasFocus,
    String? sourceDiagnostic,
    String? labSafetyWarning,
  }) {
    return MathLiveNormalizedExpression(
      phase: phase,
      sourceLatex: sourceLatex ?? this.sourceLatex,
      canonicalLatex: canonicalLatex,
      normalizedExpression: normalizedExpression,
      plainText: plainText ?? this.plainText,
      mathJson: mathJson ?? this.mathJson,
      evaluateRequested: evaluateRequested ?? this.evaluateRequested,
      hasFocus: hasFocus ?? this.hasFocus,
      historyPayloadExpression: historyPayloadExpression,
      graphCandidateExpression: graphCandidateExpression,
      solutionCandidateExpression: solutionCandidateExpression,
      evaluatorCandidateExpression: evaluatorCandidateExpression,
      containsVariableX: containsVariableX,
      containsVariableY: containsVariableY,
      graphIntent: graphIntent,
      evaluatorIntent: evaluatorIntent,
      sourceDiagnostic: sourceDiagnostic ?? this.sourceDiagnostic,
      labSafetyWarning: labSafetyWarning ?? this.labSafetyWarning,
      normalizationNotes: normalizationNotes,
    );
  }

  Map<String, Object?> toJson() => <String, Object?>{
        'phase': phase,
        'sourceLatex': sourceLatex,
        'canonicalLatex': canonicalLatex,
        'normalizedExpression': normalizedExpression,
        'plainText': plainText,
        'mathJson': mathJson,
        'evaluateRequested': evaluateRequested,
        'hasFocus': hasFocus,
        'historyPayloadExpression': historyPayloadExpression,
        'graphCandidateExpression': graphCandidateExpression,
        'solutionCandidateExpression': solutionCandidateExpression,
        'evaluatorCandidateExpression': evaluatorCandidateExpression,
        'containsVariableX': containsVariableX,
        'containsVariableY': containsVariableY,
        'graphIntent': graphIntent,
        'evaluatorIntent': evaluatorIntent,
        'sourceDiagnostic': sourceDiagnostic,
        'labSafetyWarning': labSafetyWarning,
        'normalizationNotes': normalizationNotes,
      };
}
