import 'mathlive_production_graph_history_solution_adapter_policy.dart';
import 'mathlive_runtime_sync_binding_policy.dart';
import 'mathlive_state_adapter.dart';

/// V172-Q202 — Graph / History / Solution Production State Finalization.
///
/// Q202 is the final static source-truth gate for downstream Graph, History,
/// Solution, Evaluate, and CalculatorController payloads in the active
/// MathLive production editor. It deliberately keeps protected Graph/History/
/// Solution UI files untouched. The rule is: downstream consumers may use only
/// the normalized MathLive production snapshot, never the AppShell visible
/// fallback mirror or a stale CalculatorController shadow expression.
class MathLiveProductionGraphHistorySolutionStateFinalizationPolicy {
  const MathLiveProductionGraphHistorySolutionStateFinalizationPolicy._();

  static const String phase = 'V172-Q202';
  static const String fullPhase = 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION';
  static const String baseline = 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION';

  static const String snapshotSource = 'q202-production-state-finalized-mathlive-snapshot';
  static const String evaluationSource = 'q202-production-state-finalized-evaluation';
  static const String historySource = 'q202-production-state-finalized-history';
  static const String graphSource = 'q202-production-state-finalized-graph';

  static const bool graphSourceMustBeMathLiveProductionState = true;
  static const bool historySourceMustBeMathLiveProductionState = true;
  static const bool solutionSourceMustBeMathLiveProductionState = true;
  static const bool evaluationSourceMustBeMathLiveProductionState = true;
  static const bool calculatorControllerSourceMustBeMathLiveProductionState = true;
  static const bool fallbackExpressionMayFeedGraphHistorySolution = false;
  static const bool visibleFallbackMirrorMayFeedGraphHistorySolution = false;
  static const bool staleCalculatorShadowMayFeedGraphHistorySolution = false;
  static const bool openPlaceholderMayGenerateFakeResult = false;
  static const bool openPlaceholderMayOpenGraph = false;
  static const bool openPlaceholderMayWriteRuntimeHistory = false;
  static const bool fakeGraphAllowed = false;
  static const bool fakeHistoryAllowed = false;
  static const bool fakeSolutionAllowed = false;
  static const bool graphUiMutationAllowed = false;
  static const bool graphControllerMutationAllowed = false;
  static const bool historyControllerMutationAllowed = false;
  static const bool historyPanelMutationAllowed = false;
  static const bool solutionStepsPanelMutationAllowed = false;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimed = false;
  static const bool finalReleasePassClaimed = false;

  static MathLiveProductionGraphHistorySolutionStateEnvelope buildFinalizedProductionEnvelope(
    MathLiveEditorStateSnapshot snapshot,
  ) {
    final runtime = MathLiveProductionGraphHistorySolutionAdapterPolicy.buildProductionEnvelope(
      snapshot,
      fallbackExpression: '',
    );
    return MathLiveProductionGraphHistorySolutionStateEnvelope.fromRuntime(runtime);
  }

  static String expressionForController(MathLiveProductionGraphHistorySolutionStateEnvelope envelope) {
    return envelope.controllerExpression.trim();
  }

  static String expressionForEvaluation(MathLiveProductionGraphHistorySolutionStateEnvelope envelope) {
    if (envelope.hasOpenSlots || envelope.fakeSolutionGenerated) return '';
    final candidate = envelope.evaluatorCandidateExpression.trim();
    if (candidate.isNotEmpty) return candidate;
    return envelope.controllerExpression.trim();
  }

  static String expressionForHistory(MathLiveProductionGraphHistorySolutionStateEnvelope envelope) {
    if (!canWriteRuntimeHistory(envelope)) return '';
    final history = envelope.historyExpression.trim();
    if (history.isNotEmpty) return history;
    return envelope.controllerExpression.trim();
  }

  static String expressionForGraph(MathLiveProductionGraphHistorySolutionStateEnvelope envelope) {
    if (envelope.hasOpenSlots || envelope.fakeSolutionGenerated) return '';
    final graph = envelope.graphCandidateExpression.trim();
    if (graph.isNotEmpty) return graph;
    return envelope.controllerExpression.trim();
  }

  static bool canOpenGraphDirectly(MathLiveProductionGraphHistorySolutionStateEnvelope envelope) {
    return !envelope.hasOpenSlots && !envelope.fakeSolutionGenerated && envelope.graphCanOpenDirectly;
  }

  static bool canWriteRuntimeHistory(MathLiveProductionGraphHistorySolutionStateEnvelope envelope) {
    return !envelope.hasOpenSlots &&
        !envelope.fakeSolutionGenerated &&
        envelope.hasControllerExpression &&
        !envelope.protectedUiMutationAllowed;
  }

  static bool shouldBlockFakeSolution(MathLiveProductionGraphHistorySolutionStateEnvelope envelope) {
    return envelope.hasOpenSlots ||
        envelope.fakeSolutionGenerated ||
        envelope.requiresAdvancedSolver ||
        envelope.evaluatorUnsupportedReason.trim().isNotEmpty;
  }

  static bool _containsOpenSlot(String value) {
    return value.contains('□') ||
        value.contains(r'\placeholder') ||
        value.contains('#0') ||
        value.contains('#?') ||
        value.contains('#@');
  }

  static String _firstNonEmpty(Iterable<String> values) {
    for (final value in values) {
      final trimmed = value.trim();
      if (trimmed.isNotEmpty) return trimmed;
    }
    return '';
  }
}

class MathLiveProductionGraphHistorySolutionStateEnvelope {
  const MathLiveProductionGraphHistorySolutionStateEnvelope({
    required this.phase,
    required this.sourceTruth,
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
    required this.fallbackExpressionIgnored,
  });

  factory MathLiveProductionGraphHistorySolutionStateEnvelope.fromRuntime(MathLiveRuntimeSyncEnvelope runtime) {
    final hasOpenSlots = runtime.hasOpenSlots ||
        MathLiveProductionGraphHistorySolutionStateFinalizationPolicy._containsOpenSlot(runtime.controllerExpression) ||
        MathLiveProductionGraphHistorySolutionStateFinalizationPolicy._containsOpenSlot(runtime.evaluatorCandidateExpression) ||
        MathLiveProductionGraphHistorySolutionStateFinalizationPolicy._containsOpenSlot(runtime.graphCandidateExpression) ||
        MathLiveProductionGraphHistorySolutionStateFinalizationPolicy._containsOpenSlot(runtime.historyExpression) ||
        MathLiveProductionGraphHistorySolutionStateFinalizationPolicy._containsOpenSlot(runtime.solutionCandidateExpression);
    final graphCandidate = hasOpenSlots
        ? ''
        : MathLiveProductionGraphHistorySolutionStateFinalizationPolicy._firstNonEmpty(<String>[
            runtime.graphCandidateExpression,
            runtime.graphNormalizedExpression,
            runtime.controllerExpression,
          ]);
    final historyExpression = hasOpenSlots ? '' : runtime.historyExpression.trim();
    final evaluatorCandidate = hasOpenSlots ? '' : runtime.evaluatorCandidateExpression.trim();
    final solutionCandidate = hasOpenSlots ? '' : runtime.solutionCandidateExpression.trim();

    return MathLiveProductionGraphHistorySolutionStateEnvelope(
      phase: MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.phase,
      sourceTruth: 'mathlive-production-state-only',
      sourceLatex: runtime.sourceLatex,
      normalizedExpression: runtime.normalizedExpression,
      controllerExpression: runtime.controllerExpression.trim(),
      evaluatorCandidateExpression: evaluatorCandidate,
      graphCandidateExpression: graphCandidate,
      historyExpression: historyExpression,
      solutionCandidateExpression: solutionCandidate,
      graphEligibilityKind: runtime.graphEligibilityKind,
      graphEligibilityMessage: runtime.graphEligibilityMessage,
      graphNormalizedExpression: hasOpenSlots ? '' : runtime.graphNormalizedExpression,
      graphCanOpenDirectly: !hasOpenSlots && runtime.canOpenGraphDirectly,
      graphAsksForConstantSuggestion: !hasOpenSlots && runtime.asksForConstantGraph,
      graphImplicitPending: !hasOpenSlots && runtime.graphImplicitPending,
      graphNotGraphable: hasOpenSlots || runtime.graphNotGraphable,
      hasGraphExpression: !hasOpenSlots && runtime.hasGraphExpression,
      evaluatorDisplayValue: hasOpenSlots ? '' : runtime.evaluatorDisplayValue,
      evaluatorUnsupportedReason: runtime.evaluatorUnsupportedReason,
      semanticKind: runtime.semanticKind,
      semanticTitle: runtime.semanticTitle,
      semanticDescription: runtime.semanticDescription,
      hasEvaluatorResult: !hasOpenSlots && runtime.hasEvaluatorResult,
      requiresAdvancedSolver: runtime.requiresAdvancedSolver,
      hasOpenSlots: hasOpenSlots,
      evaluateRequested: runtime.evaluateRequested,
      protectedUiMutationAllowed: false,
      fakeSolutionGenerated: false,
      photomathLevelClaimed: false,
      fallbackExpressionIgnored: true,
    );
  }

  final String phase;
  final String sourceTruth;
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
  final bool fallbackExpressionIgnored;

  bool get canOpenGraphDirectly => graphCanOpenDirectly && hasGraphExpression;
  bool get asksForConstantGraph => graphAsksForConstantSuggestion;
  bool get hasControllerExpression => controllerExpression.trim().isNotEmpty;

  Map<String, Object?> toJson() => <String, Object?>{
        'phase': phase,
        'sourceTruth': sourceTruth,
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
        'fallbackExpressionIgnored': fallbackExpressionIgnored,
      };
}
