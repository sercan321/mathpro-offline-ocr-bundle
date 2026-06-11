import 'mathlive_graph_eligibility_adapter_policy.dart';
import 'mathlive_history_adapter_policy.dart';
import 'mathlive_solution_evaluator_candidate_adapter_policy.dart';
import 'mathlive_state_adapter.dart';
import 'mathlive_state_normalization_hardening_policy.dart';

/// V172-Q146 — MathLive Runtime Sync Binding Policy.
///
/// Q146 is a real main-app binding phase after the premium MathLive surface,
/// template coverage, caret fluidity, and state-authority repairs. The rule is:
/// the visible MathLive snapshot is the single source for CalculatorController,
/// Graph, History, and Solution candidate payloads. This phase does not mutate
/// protected Graph/History/Solution UI files, does not fake solver capability,
/// and does not claim real-device/Photomath PASS without user-side evidence.
class MathLiveRuntimeSyncBindingPolicy {
  const MathLiveRuntimeSyncBindingPolicy._();

  static const String phase = 'V172-Q146';
  static const String snapshotSource = 'q146-mathlive-runtime-sync-snapshot';
  static const String evaluationSource = 'q146-mathlive-runtime-sync-evaluation';

  static const bool mathLiveSnapshotFeedsCalculatorController = true;
  static const bool mathLiveSnapshotFeedsGraphEligibility = true;
  static const bool mathLiveSnapshotFeedsHistoryPayload = true;
  static const bool mathLiveSnapshotFeedsSolutionCandidate = true;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool historyControllerMutationAllowed = false;
  static const bool graphCardMutationAllowed = false;
  static const bool solutionStepsPanelMutationAllowed = false;
  static const bool fakeSolutionAllowed = false;
  static const bool fakeGraphAllowed = false;
  static const bool realDevicePassClaimed = false;
  static const bool photomathLevelClaimed = false;

  static MathLiveRuntimeSyncEnvelope buildEnvelope(
    MathLiveEditorStateSnapshot snapshot, {
    String fallbackExpression = '',
  }) {
    final normalized = MathLiveStateNormalizationHardeningPolicy.normalizeSnapshot(snapshot);
    final graph = MathLiveGraphEligibilityAdapterPolicy.classifyNormalized(normalized);
    final history = MathLiveHistoryAdapterPolicy.buildEntryEnvelope(snapshot);
    final solution = MathLiveSolutionEvaluatorCandidateAdapterPolicy.buildCandidateEnvelope(snapshot);
    final controllerExpression = _firstNonEmpty(<String>[
      normalized.normalizedExpression,
      normalized.evaluatorCandidateExpression,
      normalized.historyPayloadExpression,
      snapshot.normalizedLatex,
      snapshot.plainText,
      fallbackExpression,
    ]);
    return MathLiveRuntimeSyncEnvelope(
      phase: phase,
      sourceLatex: normalized.sourceLatex,
      normalizedExpression: normalized.normalizedExpression,
      controllerExpression: controllerExpression,
      evaluatorCandidateExpression: normalized.evaluatorCandidateExpression,
      graphCandidateExpression: normalized.graphCandidateExpression,
      historyExpression: history.inputExpression.trim().isEmpty ? controllerExpression : history.inputExpression,
      solutionCandidateExpression: solution.solutionCandidateExpression,
      graphEligibilityKind: graph.eligibilityKind,
      graphEligibilityMessage: graph.eligibilityMessage,
      graphNormalizedExpression: graph.graphNormalizedExpression,
      graphCanOpenDirectly: graph.canOpenGraphDirectly,
      graphAsksForConstantSuggestion: graph.asksForConstantSuggestion,
      graphImplicitPending: graph.implicitPending,
      graphNotGraphable: graph.notGraphable,
      hasGraphExpression: graph.graphExpression != null,
      evaluatorDisplayValue: solution.evaluatorDisplayValue,
      evaluatorUnsupportedReason: solution.evaluatorUnsupportedReason,
      semanticKind: solution.semanticKind,
      semanticTitle: solution.semanticTitle,
      semanticDescription: solution.semanticDescription,
      hasEvaluatorResult: solution.hasEvaluatorResult,
      requiresAdvancedSolver: solution.requiresAdvancedSolver,
      hasOpenSlots: controllerExpression.contains('□'),
      evaluateRequested: snapshot.evaluateRequested,
      protectedUiMutationAllowed: false,
      fakeSolutionGenerated: false,
      photomathLevelClaimed: false,
    );
  }

  static String expressionForController(MathLiveRuntimeSyncEnvelope envelope) {
    return envelope.controllerExpression.trim();
  }

  static String expressionForEvaluation(MathLiveRuntimeSyncEnvelope envelope) {
    final candidate = envelope.evaluatorCandidateExpression.trim();
    if (candidate.isNotEmpty) return candidate;
    return envelope.controllerExpression.trim();
  }

  static String expressionForHistory(MathLiveRuntimeSyncEnvelope envelope) {
    final history = envelope.historyExpression.trim();
    if (history.isNotEmpty) return history;
    return envelope.controllerExpression.trim();
  }

  static bool shouldBlockFakeSolution(MathLiveRuntimeSyncEnvelope envelope) {
    return envelope.requiresAdvancedSolver || envelope.evaluatorUnsupportedReason.trim().isNotEmpty || envelope.hasOpenSlots;
  }

  static String _firstNonEmpty(List<String> values) {
    for (final value in values) {
      final trimmed = value.trim();
      if (trimmed.isNotEmpty) return trimmed;
    }
    return '';
  }
}

class MathLiveRuntimeSyncEnvelope {
  const MathLiveRuntimeSyncEnvelope({
    required this.phase,
    required this.sourceLatex,
    required this.normalizedExpression,
    required this.controllerExpression,
    required this.evaluatorCandidateExpression,
    required this.graphCandidateExpression,
    required this.historyExpression,
    required this.solutionCandidateExpression,
    required this.graphEligibilityKind,
    required this.graphEligibilityMessage,
    required this.graphNormalizedExpression,
    required this.graphCanOpenDirectly,
    required this.graphAsksForConstantSuggestion,
    required this.graphImplicitPending,
    required this.graphNotGraphable,
    required this.hasGraphExpression,
    required this.evaluatorDisplayValue,
    required this.evaluatorUnsupportedReason,
    required this.semanticKind,
    required this.semanticTitle,
    required this.semanticDescription,
    required this.hasEvaluatorResult,
    required this.requiresAdvancedSolver,
    required this.hasOpenSlots,
    required this.evaluateRequested,
    required this.protectedUiMutationAllowed,
    required this.fakeSolutionGenerated,
    required this.photomathLevelClaimed,
  });

  final String phase;
  final String sourceLatex;
  final String normalizedExpression;
  final String controllerExpression;
  final String evaluatorCandidateExpression;
  final String graphCandidateExpression;
  final String historyExpression;
  final String solutionCandidateExpression;
  final String graphEligibilityKind;
  final String graphEligibilityMessage;
  final String graphNormalizedExpression;
  final bool graphCanOpenDirectly;
  final bool graphAsksForConstantSuggestion;
  final bool graphImplicitPending;
  final bool graphNotGraphable;
  final bool hasGraphExpression;
  final String evaluatorDisplayValue;
  final String evaluatorUnsupportedReason;
  final String semanticKind;
  final String semanticTitle;
  final String semanticDescription;
  final bool hasEvaluatorResult;
  final bool requiresAdvancedSolver;
  final bool hasOpenSlots;
  final bool evaluateRequested;
  final bool protectedUiMutationAllowed;
  final bool fakeSolutionGenerated;
  final bool photomathLevelClaimed;

  bool get canOpenGraphDirectly => graphCanOpenDirectly && hasGraphExpression;
  bool get asksForConstantGraph => graphAsksForConstantSuggestion;
  bool get hasControllerExpression => controllerExpression.trim().isNotEmpty;

  Map<String, Object?> toJson() => <String, Object?>{
        'phase': phase,
        'sourceLatex': sourceLatex,
        'normalizedExpression': normalizedExpression,
        'controllerExpression': controllerExpression,
        'evaluatorCandidateExpression': evaluatorCandidateExpression,
        'graphCandidateExpression': graphCandidateExpression,
        'historyExpression': historyExpression,
        'solutionCandidateExpression': solutionCandidateExpression,
        'graphEligibilityKind': graphEligibilityKind,
        'graphEligibilityMessage': graphEligibilityMessage,
        'graphNormalizedExpression': graphNormalizedExpression,
        'graphCanOpenDirectly': graphCanOpenDirectly,
        'graphAsksForConstantSuggestion': graphAsksForConstantSuggestion,
        'graphImplicitPending': graphImplicitPending,
        'graphNotGraphable': graphNotGraphable,
        'hasGraphExpression': hasGraphExpression,
        'evaluatorDisplayValue': evaluatorDisplayValue,
        'evaluatorUnsupportedReason': evaluatorUnsupportedReason,
        'semanticKind': semanticKind,
        'semanticTitle': semanticTitle,
        'semanticDescription': semanticDescription,
        'hasEvaluatorResult': hasEvaluatorResult,
        'requiresAdvancedSolver': requiresAdvancedSolver,
        'hasOpenSlots': hasOpenSlots,
        'evaluateRequested': evaluateRequested,
        'protectedUiMutationAllowed': protectedUiMutationAllowed,
        'fakeSolutionGenerated': fakeSolutionGenerated,
        'photomathLevelClaimed': photomathLevelClaimed,
      };
}
