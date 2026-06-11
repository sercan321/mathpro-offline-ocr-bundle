import 'mathlive_runtime_evidence_closure_policy.dart';
import 'mathlive_state_adapter.dart';
import 'mathlive_state_normalization_hardening_policy.dart';
import 'mathlive_graph_eligibility_adapter_policy.dart';
import 'mathlive_history_adapter_policy.dart';
import 'mathlive_solution_evaluator_candidate_adapter_policy.dart';

/// V172-Q92 — MathLive Graph / History / Solution Adapter Hardening.
///
/// This phase is package-side adapter hardening only. It does not mount
/// MathLive in the main workspace, does not change Graph/History/Solution UI
/// files, and does not claim runtime/device success. It defines the safe data
/// envelope that later phases can use once Q91 evidence closure is genuinely
/// verified.
class MathLiveGraphHistorySolutionAdapterPolicy {
  const MathLiveGraphHistorySolutionAdapterPolicy._();

  static const String phase = 'V172-Q92';
  static const bool packageSideAdapterImplemented = true;
  static const bool q91EvidenceClosureRequired = true;
  static const bool runtimeEvidenceMayBeFaked = false;
  static const bool graphUiMutationAllowed = false;
  static const bool historyUiMutationAllowed = false;
  static const bool solutionUiMutationAllowed = false;
  static const bool mainEditorSwitchAllowed = false;
  static const bool mainEditorMountAllowed = false;
  static const bool legacyEditorRemainsDefault = true;
  static const bool legacyEditorRemainsRollback = true;
  static const bool physicalLegacyDeletionAllowed = false;
  static const bool cursorPassClaimAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;

  static MathLiveGraphHistorySolutionAdapterReadiness evaluateReadiness({
    required MathLiveRuntimeEvidenceClosureVerdict q91Verdict,
    required bool adapterPolicyPresent,
    required bool latexNormalizerPresent,
    required bool graphBridgePresent,
    required bool historyEnvelopePresent,
    required bool solutionEnvelopePresent,
    required bool protectedSurfacesUnchanged,
    required bool noGraphHistorySolutionUiMutation,
    required bool noMainEditorSwitch,
  }) {
    final issues = <String>[];
    if (!q91Verdict.evidenceClosureReady) {
      issues.add('Q91 runtime/evidence closure has not verified');
    }
    if (!adapterPolicyPresent) issues.add('Q92 adapter policy is missing');
    if (!latexNormalizerPresent) issues.add('MathLive LaTeX normalizer is missing');
    if (!graphBridgePresent) issues.add('Graph eligibility bridge is missing');
    if (!historyEnvelopePresent) issues.add('History envelope bridge is missing');
    if (!solutionEnvelopePresent) issues.add('Solution/evaluator envelope bridge is missing');
    if (!protectedSurfacesUnchanged) issues.add('protected UI surfaces changed');
    if (!noGraphHistorySolutionUiMutation) {
      issues.add('Graph/History/Solution UI files were mutated during Q92');
    }
    if (!noMainEditorSwitch) issues.add('main editor switched during Q92');

    final ready = issues.isEmpty;
    return MathLiveGraphHistorySolutionAdapterReadiness(
      status: ready ? 'MATHLIVE_GHS_ADAPTER_READY_FOR_Q93_FLAG' : 'BLOCKED_MATHLIVE_GHS_ADAPTER_HARDENING',
      issues: issues,
      adapterReadyForFlaggedMainEditor: ready,
      maySwitchMainEditor: false,
      mayDeleteLegacyCursor: false,
      mayClaimCursorPass: false,
    );
  }

  static MathLiveGraphHistorySolutionEnvelope buildEnvelope(MathLiveEditorStateSnapshot snapshot) {
    final normalized = MathLiveStateNormalizationHardeningPolicy.normalizeSnapshot(snapshot);
    final graphEligibility = MathLiveGraphEligibilityAdapterPolicy.classifyNormalized(normalized);
    final historyEnvelope = MathLiveHistoryAdapterPolicy.buildEntryEnvelope(snapshot);
    final solutionEnvelope = MathLiveSolutionEvaluatorCandidateAdapterPolicy.buildCandidateEnvelope(snapshot);
    return MathLiveGraphHistorySolutionEnvelope(
      phase: phase,
      sourceLatex: snapshot.latex,
      normalizedExpression: normalized.normalizedExpression,
      plainText: snapshot.plainText,
      mathJson: snapshot.mathJson,
      evaluateRequested: snapshot.evaluateRequested,
      historyInputExpression: historyEnvelope.inputExpression,
      historyInputMethod: historyEnvelope.inputEngine,
      graphEligibilityKind: graphEligibility.eligibilityKind,
      graphNormalizedExpression: graphEligibility.graphNormalizedExpression,
      solutionInputExpression: solutionEnvelope.solutionCandidateExpression,
      evaluatorDisplayValue: solutionEnvelope.evaluatorDisplayValue,
      evaluatorUnsupportedReason: solutionEnvelope.evaluatorUnsupportedReason,
      semanticType: solutionEnvelope.evaluatorSemanticType,
      diagnostic: snapshot.isSafeForLabOnlyConsumption
          ? 'q92-envelope-built-through-q103-graph-eligibility-adapter-q104-history-adapters-and-q105-solution-adapters'
          : 'q92-envelope-built-through-q103-graph-eligibility-adapter-q104-history-adapters-and-q105-solution-adapters-with-lab-safety-warning',
    );
  }
}

class MathLiveLatexNormalizer {
  const MathLiveLatexNormalizer._();

  static String toMathProExpression(String latex) {
    return MathLiveStateNormalizationHardeningPolicy.normalizeLatexForMathPro(latex).normalizedExpression;
  }


}

class MathLiveGraphHistorySolutionAdapterReadiness {
  const MathLiveGraphHistorySolutionAdapterReadiness({
    required this.status,
    required this.issues,
    required this.adapterReadyForFlaggedMainEditor,
    required this.maySwitchMainEditor,
    required this.mayDeleteLegacyCursor,
    required this.mayClaimCursorPass,
  });

  final String status;
  final List<String> issues;
  final bool adapterReadyForFlaggedMainEditor;
  final bool maySwitchMainEditor;
  final bool mayDeleteLegacyCursor;
  final bool mayClaimCursorPass;

  bool get isBlocked => !adapterReadyForFlaggedMainEditor;
}

class MathLiveGraphHistorySolutionEnvelope {
  const MathLiveGraphHistorySolutionEnvelope({
    required this.phase,
    required this.sourceLatex,
    required this.normalizedExpression,
    required this.plainText,
    required this.mathJson,
    required this.evaluateRequested,
    required this.historyInputExpression,
    required this.historyInputMethod,
    required this.graphEligibilityKind,
    required this.graphNormalizedExpression,
    required this.solutionInputExpression,
    required this.evaluatorDisplayValue,
    required this.evaluatorUnsupportedReason,
    required this.semanticType,
    required this.diagnostic,
  });

  final String phase;
  final String sourceLatex;
  final String normalizedExpression;
  final String plainText;
  final Object? mathJson;
  final bool evaluateRequested;
  final String historyInputExpression;
  final String historyInputMethod;
  final String graphEligibilityKind;
  final String graphNormalizedExpression;
  final String solutionInputExpression;
  final String evaluatorDisplayValue;
  final String evaluatorUnsupportedReason;
  final String semanticType;
  final String diagnostic;

  bool get hasHistoryPayload => historyInputExpression.trim().isNotEmpty && historyInputMethod == 'mathlive';
  bool get hasSolutionPayload => solutionInputExpression.trim().isNotEmpty;
  bool get isGraphCandidate => graphEligibilityKind == 'graphableExplicit' || graphEligibilityKind == 'constantSuggestion';

  Map<String, Object?> toJson() => <String, Object?>{
        'phase': phase,
        'sourceLatex': sourceLatex,
        'normalizedExpression': normalizedExpression,
        'plainText': plainText,
        'mathJson': mathJson,
        'evaluateRequested': evaluateRequested,
        'historyInputExpression': historyInputExpression,
        'historyInputMethod': historyInputMethod,
        'graphEligibilityKind': graphEligibilityKind,
        'graphNormalizedExpression': graphNormalizedExpression,
        'solutionInputExpression': solutionInputExpression,
        'evaluatorDisplayValue': evaluatorDisplayValue,
        'evaluatorUnsupportedReason': evaluatorUnsupportedReason,
        'semanticType': semanticType,
        'diagnostic': diagnostic,
      };
}
