import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_production_graph_history_solution_adapter_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_state_adapter.dart';

void main() {
  test('V172-Q188 freezes production Graph History Solution adapter boundary', () {
    expect(MathLiveProductionGraphHistorySolutionAdapterPolicy.phase, 'V172-Q188');
    expect(MathLiveProductionGraphHistorySolutionAdapterPolicy.productionAdapterBindingFrozen, isTrue);
    expect(MathLiveProductionGraphHistorySolutionAdapterPolicy.consumesMathLiveLatexState, isTrue);
    expect(MathLiveProductionGraphHistorySolutionAdapterPolicy.feedsCalculatorController, isTrue);
    expect(MathLiveProductionGraphHistorySolutionAdapterPolicy.feedsGraphEligibility, isTrue);
    expect(MathLiveProductionGraphHistorySolutionAdapterPolicy.feedsHistoryPayload, isTrue);
    expect(MathLiveProductionGraphHistorySolutionAdapterPolicy.feedsSolutionEvaluatorCandidate, isTrue);
    expect(MathLiveProductionGraphHistorySolutionAdapterPolicy.graphCardMutationAllowed, isFalse);
    expect(MathLiveProductionGraphHistorySolutionAdapterPolicy.historyPanelMutationAllowed, isFalse);
    expect(MathLiveProductionGraphHistorySolutionAdapterPolicy.solutionStepsPanelMutationAllowed, isFalse);
    expect(MathLiveProductionGraphHistorySolutionAdapterPolicy.keyboardLayoutMutationAllowed, isFalse);
    expect(MathLiveProductionGraphHistorySolutionAdapterPolicy.productionBridgePublicApiMutationAllowed, isFalse);
    expect(MathLiveProductionGraphHistorySolutionAdapterPolicy.fakeGraphAllowed, isFalse);
    expect(MathLiveProductionGraphHistorySolutionAdapterPolicy.fakeHistoryAllowed, isFalse);
    expect(MathLiveProductionGraphHistorySolutionAdapterPolicy.fakeSolutionAllowed, isFalse);
    expect(MathLiveProductionGraphHistorySolutionAdapterPolicy.realDevicePassClaimed, isFalse);
    expect(MathLiveProductionGraphHistorySolutionAdapterPolicy.photomathLevelClaimed, isFalse);
  });

  test('production MathLive LaTeX snapshot promotes into a Q188 graphable envelope', () {
    final envelope = MathLiveProductionGraphHistorySolutionAdapterPolicy.buildProductionEnvelope(
      MathLiveEditorStateSnapshot.fromLatex(r'y=x^{2}'),
    );

    expect(envelope.phase, 'V172-Q188');
    expect(envelope.controllerExpression, contains('x^2'));
    expect(envelope.historyExpression, contains('x^2'));
    expect(envelope.solutionCandidateExpression, contains('x^2'));
    expect(envelope.graphEligibilityKind, 'graphableExplicit');
    expect(envelope.canOpenGraphDirectly, isTrue);
    expect(envelope.protectedUiMutationAllowed, isFalse);
    expect(envelope.fakeSolutionGenerated, isFalse);
    expect(envelope.photomathLevelClaimed, isFalse);
    expect(MathLiveProductionGraphHistorySolutionAdapterPolicy.canOpenGraphDirectly(envelope), isTrue);
  });

  test('Q188 keeps evaluation and history expressions sourced from MathLive state', () {
    final envelope = MathLiveProductionGraphHistorySolutionAdapterPolicy.buildProductionEnvelope(
      MathLiveEditorStateSnapshot.fromLatex(r'\frac{1}{2}+\frac{3}{4}'),
    );

    expect(envelope.phase, 'V172-Q188');
    expect(MathLiveProductionGraphHistorySolutionAdapterPolicy.expressionForController(envelope), contains('/'));
    expect(MathLiveProductionGraphHistorySolutionAdapterPolicy.expressionForEvaluation(envelope), contains('/'));
    expect(MathLiveProductionGraphHistorySolutionAdapterPolicy.expressionForHistory(envelope), contains('/'));
    expect(MathLiveProductionGraphHistorySolutionAdapterPolicy.canWriteRuntimeHistory(envelope), isTrue);
    expect(MathLiveProductionGraphHistorySolutionAdapterPolicy.shouldBlockFakeSolution(envelope), isFalse);
  });

  test('Q188 blocks fake solution confidence for open slots and advanced solver candidates', () {
    final openSlotEnvelope = MathLiveProductionGraphHistorySolutionAdapterPolicy.buildProductionEnvelope(
      MathLiveEditorStateSnapshot.fromLatex(r'\sqrt{#0}'),
    );
    expect(openSlotEnvelope.hasOpenSlots, isTrue);
    expect(MathLiveProductionGraphHistorySolutionAdapterPolicy.shouldBlockFakeSolution(openSlotEnvelope), isTrue);

    final advancedEnvelope = MathLiveProductionGraphHistorySolutionAdapterPolicy.buildProductionEnvelope(
      MathLiveEditorStateSnapshot.fromLatex(r'\int x^{2}\,dx'),
    );
    expect(advancedEnvelope.requiresAdvancedSolver, isTrue);
    expect(MathLiveProductionGraphHistorySolutionAdapterPolicy.shouldBlockFakeSolution(advancedEnvelope), isTrue);
  });
}
