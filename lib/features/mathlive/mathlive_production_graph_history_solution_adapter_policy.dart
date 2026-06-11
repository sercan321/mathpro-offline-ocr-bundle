import 'mathlive_runtime_sync_binding_policy.dart';
import 'mathlive_state_adapter.dart';

/// V172-Q188 — Production Graph / History / Solution Adapter Binding.
///
/// Q188 is the production adapter boundary after the Q184-Q187 minimal
/// MathLive surface/HTML/bridge/template contract. It does not redesign Graph,
/// History, Solution, keyboard, MORE, long-press, or solver UI. It only promotes
/// the active MathLive LaTeX runtime snapshot into one auditable production
/// envelope for CalculatorController, Graph eligibility, History records,
/// Solution/evaluator candidates, and evaluate requests.
class MathLiveProductionGraphHistorySolutionAdapterPolicy {
  const MathLiveProductionGraphHistorySolutionAdapterPolicy._();

  static const String phase = 'V172-Q188';
  static const String snapshotSource = 'q188-production-mathlive-adapter-snapshot';
  static const String evaluationSource = 'q188-production-mathlive-adapter-evaluation';
  static const String q202FinalizedProductionStateSuccessor = 'V172-Q202';
  static const bool q202FinalizesProductionStateTruth = true;

  static const bool productionAdapterBindingFrozen = true;
  static const bool usesMinimalProductionSurface = true;
  static const bool consumesMathLiveLatexState = true;
  static const bool feedsCalculatorController = true;
  static const bool feedsGraphEligibility = true;
  static const bool feedsHistoryPayload = true;
  static const bool feedsSolutionEvaluatorCandidate = true;
  static const bool graphCardMutationAllowed = false;
  static const bool graphControllerMutationAllowed = false;
  static const bool historyControllerMutationAllowed = false;
  static const bool historyPanelMutationAllowed = false;
  static const bool solutionStepsPanelMutationAllowed = false;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool productionBridgePublicApiMutationAllowed = false;
  static const bool fakeGraphAllowed = false;
  static const bool fakeHistoryAllowed = false;
  static const bool fakeSolutionAllowed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool realDevicePassClaimed = false;
  static const bool photomathLevelClaimed = false;

  static MathLiveRuntimeSyncEnvelope buildProductionEnvelope(
    MathLiveEditorStateSnapshot snapshot, {
    String fallbackExpression = '',
  }) {
    final base = MathLiveRuntimeSyncBindingPolicy.buildEnvelope(
      snapshot,
      fallbackExpression: fallbackExpression,
    );
    return _promoteToQ188(base);
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
    return envelope.requiresAdvancedSolver ||
        envelope.evaluatorUnsupportedReason.trim().isNotEmpty ||
        envelope.hasOpenSlots;
  }

  static bool canWriteRuntimeHistory(MathLiveRuntimeSyncEnvelope envelope) {
    return envelope.hasControllerExpression &&
        !envelope.fakeSolutionGenerated &&
        !envelope.protectedUiMutationAllowed;
  }

  static bool canOpenGraphDirectly(MathLiveRuntimeSyncEnvelope envelope) {
    return envelope.canOpenGraphDirectly && !envelope.fakeSolutionGenerated;
  }

  static MathLiveRuntimeSyncEnvelope _promoteToQ188(MathLiveRuntimeSyncEnvelope base) {
    return MathLiveRuntimeSyncEnvelope(
      phase: phase,
      sourceLatex: base.sourceLatex,
      normalizedExpression: base.normalizedExpression,
      controllerExpression: base.controllerExpression,
      evaluatorCandidateExpression: base.evaluatorCandidateExpression,
      graphCandidateExpression: base.graphCandidateExpression,
      historyExpression: base.historyExpression,
      solutionCandidateExpression: base.solutionCandidateExpression,
      graphEligibilityKind: base.graphEligibilityKind,
      graphEligibilityMessage: base.graphEligibilityMessage,
      graphNormalizedExpression: base.graphNormalizedExpression,
      graphCanOpenDirectly: base.graphCanOpenDirectly,
      graphAsksForConstantSuggestion: base.graphAsksForConstantSuggestion,
      graphImplicitPending: base.graphImplicitPending,
      graphNotGraphable: base.graphNotGraphable,
      hasGraphExpression: base.hasGraphExpression,
      evaluatorDisplayValue: base.evaluatorDisplayValue,
      evaluatorUnsupportedReason: base.evaluatorUnsupportedReason,
      semanticKind: base.semanticKind,
      semanticTitle: base.semanticTitle,
      semanticDescription: base.semanticDescription,
      hasEvaluatorResult: base.hasEvaluatorResult,
      requiresAdvancedSolver: base.requiresAdvancedSolver,
      hasOpenSlots: base.hasOpenSlots,
      evaluateRequested: base.evaluateRequested,
      protectedUiMutationAllowed: false,
      fakeSolutionGenerated: false,
      photomathLevelClaimed: false,
    );
  }
}
