import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_production_graph_history_solution_state_finalization_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_state_adapter.dart';

void main() {
  test('V172-Q202 locks Graph/History/Solution to MathLive production state', () {
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.phase, 'V172-Q202');
    expect(
      MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.fullPhase,
      'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION',
    );
    expect(
      MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.baseline,
      'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION',
    );
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.graphSourceMustBeMathLiveProductionState, isTrue);
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.historySourceMustBeMathLiveProductionState, isTrue);
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.solutionSourceMustBeMathLiveProductionState, isTrue);
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.evaluationSourceMustBeMathLiveProductionState, isTrue);
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.fallbackExpressionMayFeedGraphHistorySolution, isFalse);
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.visibleFallbackMirrorMayFeedGraphHistorySolution, isFalse);
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.staleCalculatorShadowMayFeedGraphHistorySolution, isFalse);
  });

  test('V172-Q202 blocks open-placeholder fake graph/history/evaluation payloads', () {
    final envelope = MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.buildFinalizedProductionEnvelope(
      MathLiveEditorStateSnapshot.fromLatex(r'\frac{\placeholder{}}{\placeholder{}}'),
    );
    expect(envelope.sourceTruth, 'mathlive-production-state-only');
    expect(envelope.fallbackExpressionIgnored, isTrue);
    expect(envelope.hasOpenSlots, isTrue);
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.expressionForEvaluation(envelope), isEmpty);
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.expressionForHistory(envelope), isEmpty);
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.expressionForGraph(envelope), isEmpty);
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.canOpenGraphDirectly(envelope), isFalse);
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.canWriteRuntimeHistory(envelope), isFalse);
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.shouldBlockFakeSolution(envelope), isTrue);
  });

  test('V172-Q202 keeps red-line UI mutation and PASS claims blocked', () {
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.graphUiMutationAllowed, isFalse);
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.graphControllerMutationAllowed, isFalse);
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.historyControllerMutationAllowed, isFalse);
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.historyPanelMutationAllowed, isFalse);
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.solutionStepsPanelMutationAllowed, isFalse);
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.keyboardLayoutMutationAllowed, isFalse);
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.moreInventoryMutationAllowed, isFalse);
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.longPressOrderMutationAllowed, isFalse);
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.flutterTestPassClaimedByAssistant, isFalse);
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.flutterRunPassClaimedByAssistant, isFalse);
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.androidRealDevicePassClaimed, isFalse);
    expect(MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.finalReleasePassClaimed, isFalse);
  });
}
