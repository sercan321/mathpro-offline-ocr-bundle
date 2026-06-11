import '../graph/graph_eligibility.dart';
import '../graph/graph_models.dart';
import '../../logic/evaluator_bridge.dart';
import 'mathlive_state_adapter.dart';
import 'mathlive_state_normalization_hardening_policy.dart';

/// V172-Q103 — Graph Eligibility Adapter Real Binding.
///
/// Q103 binds MathLive's normalized package-side expression payload to the
/// existing GraphEligibility classifier without mutating graph_card.dart,
/// History/Solution UI, the keyboard, AppShell, or the legacy cursor stack. It
/// is still an adapter/contract phase: runtime smoke evidence, real-device
/// cursor court evidence, and explicit main-editor activation remain blocked.
class MathLiveGraphEligibilityAdapterPolicy {
  const MathLiveGraphEligibilityAdapterPolicy._();

  static const String phase = 'V172-Q103';
  static const String verifierScript = 'tool/verify_mathlive_graph_eligibility_adapter.mjs';
  static const String reportJson = 'tool/reports/mathlive_graph_eligibility_adapter_report.json';
  static const String reportMarkdown = 'tool/reports/mathlive_graph_eligibility_adapter_report.md';
  static const bool packageSideGraphEligibilityAdapterImplemented = true;
  static const bool q102StateNormalizationRequired = true;
  static const bool q101LabSmokeEvidenceClosureRequiredForRuntimeActivation = true;
  static const bool graphCardMutationAllowed = false;
  static const bool graphUiMutationAllowed = false;
  static const bool historyUiMutationAllowed = false;
  static const bool solutionUiMutationAllowed = false;
  static const bool keyboardMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool mainEditorSwitchAllowed = false;
  static const bool mainEditorMountAllowed = false;
  static const bool mathLiveEnabledByDefault = false;
  static const bool legacyCursorDeletionAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool cursorPassClaimAllowed = false;
  static const bool fakeConstantGraphAllowed = false;

  static MathLiveGraphEligibilityAdapterReadiness evaluateReadiness({
    required bool adapterPolicyPresent,
    required bool deterministicGraphEligibilitySamplesPass,
    required bool q102StateNormalizationReady,
    required bool q101LabSmokeEvidenceClosed,
    required bool protectedSurfacesUnchanged,
    required bool graphCardUntouched,
    required bool graphHistorySolutionUiUntouched,
    required bool mainEditorStillLegacy,
    required bool noFakeConstantGraph,
    required bool noRuntimeEvidenceFaked,
  }) {
    final blockers = <String>[];
    if (!adapterPolicyPresent) blockers.add('Q103 graph eligibility adapter policy is missing');
    if (!deterministicGraphEligibilitySamplesPass) blockers.add('Q103 deterministic graph eligibility samples did not pass');
    if (!q102StateNormalizationReady) blockers.add('Q102 state normalization is not package-ready');
    if (!q101LabSmokeEvidenceClosed) blockers.add('Q101 Lab smoke evidence closure has not passed; Q103 must remain package-side only');
    if (!protectedSurfacesUnchanged) blockers.add('protected UI surfaces changed');
    if (!graphCardUntouched) blockers.add('graph_card.dart changed during Q103');
    if (!graphHistorySolutionUiUntouched) blockers.add('Graph/History/Solution UI surfaces changed');
    if (!mainEditorStillLegacy) blockers.add('main editor did not remain legacy/default');
    if (!noFakeConstantGraph) blockers.add('fake constant graph suggestion was produced without evaluator success');
    if (!noRuntimeEvidenceFaked) blockers.add('runtime evidence was faked');

    final packageReady = adapterPolicyPresent &&
        deterministicGraphEligibilitySamplesPass &&
        q102StateNormalizationReady &&
        protectedSurfacesUnchanged &&
        graphCardUntouched &&
        graphHistorySolutionUiUntouched &&
        mainEditorStillLegacy &&
        noFakeConstantGraph &&
        noRuntimeEvidenceFaked;
    final runtimeReady = packageReady && q101LabSmokeEvidenceClosed;
    return MathLiveGraphEligibilityAdapterReadiness(
      status: runtimeReady
          ? 'MATHLIVE_GRAPH_ELIGIBILITY_ADAPTER_READY_FOR_RUNTIME_BINDING'
          : packageReady
              ? 'MATHLIVE_GRAPH_ELIGIBILITY_ADAPTER_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED'
              : 'BLOCKED_MATHLIVE_GRAPH_ELIGIBILITY_ADAPTER',
      blockers: blockers,
      packageSideGraphEligibilityReady: packageReady,
      mayProceedToRuntimeGraphBinding: runtimeReady,
      maySwitchMainEditor: false,
      mayMountMainEditor: false,
      mayDeleteLegacyCursor: false,
      mayClaimCursorPass: false,
      mayMutateGraphCard: false,
    );
  }

  static MathLiveGraphEligibilityEnvelope classifySnapshot(MathLiveEditorStateSnapshot snapshot) {
    final normalized = MathLiveStateNormalizationHardeningPolicy.normalizeSnapshot(snapshot);
    return classifyNormalized(normalized);
  }

  static MathLiveGraphEligibilityEnvelope classifyLatex(String latex) {
    final normalized = MathLiveStateNormalizationHardeningPolicy.normalizeLatexForMathPro(latex);
    return classifyNormalized(normalized);
  }

  static MathLiveGraphEligibilityEnvelope classifyNormalized(MathLiveNormalizedExpression normalized) {
    final expression = normalized.normalizedExpression;
    final evaluation = EvaluatorBridge.evaluateBasic(expression);
    final evaluationDisplay = evaluation.displayValue ?? '';
    final eligibility = GraphEligibility.classify(
      expression: expression,
      result: evaluationDisplay,
    );
    final graphExpression = eligibility.canOpenDirectly || eligibility.asksForConstant
        ? GraphEligibility.expressionFromEligibility(
            originalExpression: expression,
            result: eligibility,
          )
        : null;
    final fakeConstantBlocked = normalized.graphIntent == 'constantSuggestion' &&
        eligibility.kind != GraphEligibilityKind.constantSuggestion &&
        !evaluation.isSuccess;

    return MathLiveGraphEligibilityEnvelope(
      phase: phase,
      sourceLatex: normalized.sourceLatex,
      normalizedExpression: expression,
      q102GraphIntent: normalized.graphIntent,
      evaluatorDisplayValue: evaluationDisplay,
      evaluatorSemanticType: evaluation.semanticType ?? '',
      evaluatorUnsupportedReason: evaluation.unsupportedReason ?? '',
      eligibilityKind: eligibility.kind.name,
      eligibilityMessage: eligibility.message,
      graphNormalizedExpression: eligibility.normalizedExpression ?? '',
      constantValue: eligibility.constantValue,
      canOpenGraphDirectly: eligibility.canOpenDirectly,
      asksForConstantSuggestion: eligibility.asksForConstant,
      implicitPending: eligibility.kind == GraphEligibilityKind.implicitPending,
      notGraphable: eligibility.kind == GraphEligibilityKind.notGraphable,
      graphExpression: graphExpression,
      fakeConstantSuggestionBlocked: fakeConstantBlocked,
      graphCardMutationAllowed: false,
      mainEditorSwitchAllowed: false,
      legacyCursorDeletionAllowed: false,
    );
  }
}

class MathLiveGraphEligibilityAdapterReadiness {
  const MathLiveGraphEligibilityAdapterReadiness({
    required this.status,
    required this.blockers,
    required this.packageSideGraphEligibilityReady,
    required this.mayProceedToRuntimeGraphBinding,
    required this.maySwitchMainEditor,
    required this.mayMountMainEditor,
    required this.mayDeleteLegacyCursor,
    required this.mayClaimCursorPass,
    required this.mayMutateGraphCard,
  });

  final String status;
  final List<String> blockers;
  final bool packageSideGraphEligibilityReady;
  final bool mayProceedToRuntimeGraphBinding;
  final bool maySwitchMainEditor;
  final bool mayMountMainEditor;
  final bool mayDeleteLegacyCursor;
  final bool mayClaimCursorPass;
  final bool mayMutateGraphCard;

  bool get isRuntimeBlocked => !mayProceedToRuntimeGraphBinding;
}

class MathLiveGraphEligibilityEnvelope {
  const MathLiveGraphEligibilityEnvelope({
    required this.phase,
    required this.sourceLatex,
    required this.normalizedExpression,
    required this.q102GraphIntent,
    required this.evaluatorDisplayValue,
    required this.evaluatorSemanticType,
    required this.evaluatorUnsupportedReason,
    required this.eligibilityKind,
    required this.eligibilityMessage,
    required this.graphNormalizedExpression,
    required this.constantValue,
    required this.canOpenGraphDirectly,
    required this.asksForConstantSuggestion,
    required this.implicitPending,
    required this.notGraphable,
    required this.graphExpression,
    required this.fakeConstantSuggestionBlocked,
    required this.graphCardMutationAllowed,
    required this.mainEditorSwitchAllowed,
    required this.legacyCursorDeletionAllowed,
  });

  final String phase;
  final String sourceLatex;
  final String normalizedExpression;
  final String q102GraphIntent;
  final String evaluatorDisplayValue;
  final String evaluatorSemanticType;
  final String evaluatorUnsupportedReason;
  final String eligibilityKind;
  final String eligibilityMessage;
  final String graphNormalizedExpression;
  final double? constantValue;
  final bool canOpenGraphDirectly;
  final bool asksForConstantSuggestion;
  final bool implicitPending;
  final bool notGraphable;
  final GraphExpression? graphExpression;
  final bool fakeConstantSuggestionBlocked;
  final bool graphCardMutationAllowed;
  final bool mainEditorSwitchAllowed;
  final bool legacyCursorDeletionAllowed;

  bool get isGraphCandidate => canOpenGraphDirectly || asksForConstantSuggestion || implicitPending;
  bool get requiresAdvancedGraphMode => implicitPending;
  bool get hasDirectGraphExpression => graphExpression != null;

  Map<String, Object?> toJson() => <String, Object?>{
        'phase': phase,
        'sourceLatex': sourceLatex,
        'normalizedExpression': normalizedExpression,
        'q102GraphIntent': q102GraphIntent,
        'evaluatorDisplayValue': evaluatorDisplayValue,
        'evaluatorSemanticType': evaluatorSemanticType,
        'evaluatorUnsupportedReason': evaluatorUnsupportedReason,
        'eligibilityKind': eligibilityKind,
        'eligibilityMessage': eligibilityMessage,
        'graphNormalizedExpression': graphNormalizedExpression,
        'constantValue': constantValue,
        'canOpenGraphDirectly': canOpenGraphDirectly,
        'asksForConstantSuggestion': asksForConstantSuggestion,
        'implicitPending': implicitPending,
        'notGraphable': notGraphable,
        'hasDirectGraphExpression': hasDirectGraphExpression,
        'fakeConstantSuggestionBlocked': fakeConstantSuggestionBlocked,
        'graphCardMutationAllowed': graphCardMutationAllowed,
        'mainEditorSwitchAllowed': mainEditorSwitchAllowed,
        'legacyCursorDeletionAllowed': legacyCursorDeletionAllowed,
      };
}
