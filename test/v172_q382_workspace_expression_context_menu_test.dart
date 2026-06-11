import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/solution/solution_step_models.dart';
import 'package:mathpro_flutter_phase17/features/workspace/workspace_expression_context_menu.dart';
import 'package:mathpro_flutter_phase17/features/workspace/workspace_expression_context_menu_q382_policy.dart';
import 'package:mathpro_flutter_phase17/features/workspace/workspace_math_action.dart';
import 'package:mathpro_flutter_phase17/features/workspace/workspace_math_action_classifier.dart';
import 'package:mathpro_flutter_phase17/features/workspace/workspace_math_action_resolver.dart';
import 'package:mathpro_flutter_phase17/features/workspace/workspace_math_action_state.dart';

void main() {
  test('Q382 policy freezes floating menu and no fake solver contract', () {
    expect(WorkspaceExpressionContextMenuQ382Policy.phase, 'V172-Q382-WORKSPACE-EXPRESSION-CONTEXT-MENU-ACTION-INTENT');
    expect(WorkspaceExpressionContextMenuQ382Policy.riskRepairPhase, 'V172-Q382R1-WORKSPACE-CONTEXT-MENU-RISK-REPAIR');
    expect(WorkspaceExpressionContextMenuQ382Policy.handlerGuardRepairPhase, 'V172-Q382R2-WORKSPACE-CONTEXT-MENU-HANDLER-GUARD-REPAIR');
    expect(WorkspaceExpressionContextMenuQ382Policy.solutionIntentInjectionRepairPhase, 'V172-Q382R3-WORKSPACE-CONTEXT-MENU-SOLUTION-INTENT-INJECTION-REPAIR');
    expect(WorkspaceExpressionContextMenuQ382Policy.testSyntaxRepairPhase, 'V172-Q382R4-WORKSPACE-CONTEXT-MENU-TEST-SYNTAX-REPAIR');
    expect(WorkspaceExpressionContextMenuQ382Policy.unsupportedActionAndEditorSemanticsRepairPhase, 'V172-Q382R5-WORKSPACE-CONTEXT-MENU-UNSUPPORTED-ACTION-AND-EDITOR-SEMANTICS-REPAIR');
    expect(WorkspaceExpressionContextMenuQ382Policy.dismissAndHitZoneHardeningPhase, 'V172-Q382R6-WORKSPACE-CONTEXT-MENU-DISMISS-HITZONE-HARDENING');
    expect(WorkspaceExpressionContextMenuQ382Policy.analyzeTestLogRepairPhase, 'V172-Q382R7-WORKSPACE-CONTEXT-MENU-ANALYZE-TEST-LOG-REPAIR');
    expect(WorkspaceExpressionContextMenuQ382Policy.baseline, 'V172-Q381R1-CAMERA-OCR-RUNTIME-RISK-REPAIR');
    expect(WorkspaceExpressionContextMenuQ382Policy.floatingOverlayDoesNotResizeWorkspace, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.internalScrollWhenActionsOverflow, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.safeHitZonePreservesMathLiveCaretLongPress, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.selectedActionChipEnabled, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.solutionMetadataRoutingEnabled, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.fakeSolverResultsBlocked, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.q381R1OcrSafetyPreserved, isTrue);
    expect(WorkspaceExpressionContextMenu.fakeSolverResultBlocked, isTrue);
    expect(WorkspaceExpressionContextMenu.overlayEntryRemovalGuarded, isTrue);
    expect(WorkspaceExpressionContextMenu.maxHeightNeverExceedsSafeArea, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.overlayEntryRemovalGuarded, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.menuMaxHeightNeverExceedsSafeArea, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.unsupportedActionHandlerGuarded, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.unsupportedActionDoesNotReuseGenericResultAsHandlerOutput, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.selectedActionIntentStepInjectedExactlyOnce, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.selectedActionIntentInjectionAvoidsObjectIdentityContains, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.contextMenuTestClosureSyntaxRepaired, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.q382R3VerifierRemainsBackwardCompatible, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.unsupportedActionsDisabledBeforeSelection, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.staleResultSuppressedForUnsupportedIntent, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.editorReplacementActionsUseExplicitLabels, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.selectAllShowsVisibleTargetChip, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.contextMenuUsesAllResolvedActionsForInternalScroll, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.mathLiveContextMenuSyncResultChecked, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.androidBackDismissesOverlayBeforeRoutePop, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.safeHitZoneUsabilityHardenedWithoutCoveringMathLive, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.expressionEditClearsContextStateWithSetState, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.q382R6WidgetContractsCoveredByTests, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.q382R7AnalyzerWarningsRepaired, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.q382R7LegacyTestExpectationsRepaired, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.q382R7UnsupportedIntentNoFakeResultCopyPreserved, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.legacyOnnxExpectationRepairPhase, 'V172-Q382R8-WORKSPACE-CONTEXT-MENU-LEGACY-ONNX-EXPECTATION-REPAIR');
    expect(WorkspaceExpressionContextMenuQ382Policy.q382R8LegacyOnnxRuntimeExpectationsGuarded, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.q382R8Q352Q353Q354SuccessorAwarenessRepaired, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.q382R8RuntimeBehaviorUnchanged, isTrue);

    expect(WorkspaceExpressionContextMenuQ382Policy.legacyCameraReviewCopyExpectationRepairPhase,
        'V172-Q382R9-WORKSPACE-CONTEXT-MENU-LEGACY-CAMERA-REVIEW-COPY-EXPECTATION-REPAIR');
    expect(WorkspaceExpressionContextMenuQ382Policy.q382R9LegacyCameraReviewCopyExpectationsGuarded, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.q382R9Q239Q243Q277LegacyTestsSuccessorAware, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.q382R9RuntimeBehaviorUnchanged, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.legacyCameraReviewFinalAnalyzeTestExpectationRepairPhase,
        'V172-Q382R10-WORKSPACE-CONTEXT-MENU-FINAL-ANALYZE-TEST-EXPECTATION-REPAIR');
    expect(WorkspaceExpressionContextMenuQ382Policy.q382R10PreferContainsAnalyzerRepairApplied, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.q382R10Q239CLegacyOcrNextPhaseCopyGuarded, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.q382R10RuntimeBehaviorUnchanged, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.analyzeQ239BCopyExpectationRepairPhase,
        'V172-Q382R11-WORKSPACE-CONTEXT-MENU-ANALYZE-Q239B-COPY-EXPECTATION-REPAIR');
    expect(WorkspaceExpressionContextMenuQ382Policy.q382R11ConstDeclarationAnalyzerInfoRepaired, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.q382R11Q239BWorkspaceCameraInvocationGuarded, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.q382R11Q239CLegacyOcrCopyExpectationGuarded, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.q382R11RuntimeBehaviorUnchanged, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.kotlinCompileAndQ239BExpectationRepairPhase, 'V172-Q382R12-WORKSPACE-CONTEXT-MENU-KOTLIN-COMPILE-Q239B-EXPECTATION-REPAIR');
    expect(WorkspaceExpressionContextMenuQ382Policy.q382R12KotlinVocabularySidecarBooleanPrecedenceRepaired, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.q382R12Q239BMoreIconExpectationAllowsQ382ContextMenu, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.q382R12RuntimeBehaviorUnchanged, isTrue);
    expect(WorkspaceExpressionContextMenu.handlerGuardRepairPhase, 'V172-Q382R2-WORKSPACE-CONTEXT-MENU-HANDLER-GUARD-REPAIR');
    expect(WorkspaceExpressionContextMenu.unsupportedActionHandlerGuarded, isTrue);
    expect(WorkspaceExpressionContextMenu.dismissAndHitZoneHardeningPhase, 'V172-Q382R6-WORKSPACE-CONTEXT-MENU-DISMISS-HITZONE-HARDENING');
    expect(WorkspaceExpressionContextMenu.androidBackDismissesOverlayBeforeRoutePop, isTrue);
    expect(WorkspaceExpressionContextMenu.safeHitZoneUsabilityHardenedWithoutCoveringMathLive, isTrue);
  });


  test('Q382R6 hardens dismiss, hit-zone and expression-edit cleanup contracts', () {
    expect(WorkspaceExpressionContextMenuQ382Policy.dismissAndHitZoneHardeningPhase, 'V172-Q382R6-WORKSPACE-CONTEXT-MENU-DISMISS-HITZONE-HARDENING');
    expect(WorkspaceExpressionContextMenuQ382Policy.androidBackDismissesOverlayBeforeRoutePop, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.safeHitZoneUsabilityHardenedWithoutCoveringMathLive, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.expressionEditClearsContextStateWithSetState, isTrue);
    expect(WorkspaceExpressionContextMenuQ382Policy.q382R6WidgetContractsCoveredByTests, isTrue);
    expect(WorkspaceExpressionContextMenu.androidBackDismissesOverlayBeforeRoutePop, isTrue);
    expect(WorkspaceExpressionContextMenu.safeHitZoneUsabilityHardenedWithoutCoveringMathLive, isTrue);
  });

  test('classifier detects polynomial, trig, rational, complex and unsupported shells', () {
    expect(WorkspaceMathActionClassifier.classify('x^2 - 5x + 6'), WorkspaceExpressionKind.polynomialExpression);
    expect(WorkspaceMathActionClassifier.classify('x^2 - 5x + 6 = 0'), WorkspaceExpressionKind.polynomialEquation);
    expect(WorkspaceMathActionClassifier.classify('sin(x) = 1/2'), WorkspaceExpressionKind.trigonometricEquation);
    expect(WorkspaceMathActionClassifier.classify('1/(x-1) + 1/(x+1)'), WorkspaceExpressionKind.rationalExpression);
    expect(WorkspaceMathActionClassifier.classify('3 + 4i'), WorkspaceExpressionKind.complexNumberExpression);
    expect(WorkspaceMathActionClassifier.classify(''), WorkspaceExpressionKind.emptyExpression);
  });

  test('resolver proposes relevant math actions without claiming fake engine support', () {
    final polynomial = WorkspaceMathActionResolver.resolve('x^2 - 5x + 6');
    expect(polynomial.expressionKind, WorkspaceExpressionKind.polynomialExpression);
    expect(polynomial.actions.map((action) => action.id), containsAll(<String>['simplify', 'factor', 'expand', 'roots']));
    expect(polynomial.actions.where((action) => action.id == 'factor').single.enabled, isFalse);
    expect(polynomial.actions.every((action) => action.supportedByCurrentEngine == false), isTrue);
    expect(polynomial.actions.where((action) => action.requiresSolverHandler).every((action) => !action.enabled), isTrue);

    final trig = WorkspaceMathActionResolver.resolve('sin(x) = 1/2');
    expect(trig.actions.map((action) => action.id), containsAll(<String>['trigSimplify', 'trigSolve', 'generalSolution']));
    expect(trig.actions.where((action) => action.id == 'trigSolve').single.enabled, isFalse);

    final complex = WorkspaceMathActionResolver.resolve('3 + 4i');
    expect(complex.actions.map((action) => action.id), containsAll(<String>['realImaginary', 'modulus', 'argument', 'polarForm']));
  });

  test('selected action stores expression fingerprint and invalidates on edit', () {
    final resolution = WorkspaceMathActionResolver.resolve('x^2 - 5x + 6');
    final action = resolution.actions.where((candidate) => candidate.id == 'factor').single;
    final selected = WorkspaceSelectedMathAction.fromAction(
      action: action,
      expressionKind: resolution.expressionKind,
      expression: resolution.expression,
      variable: resolution.variable,
    );
    expect(selected.id, 'factor');
    expect(selected.shortLabel, 'Çarpanlarına Ayır');
    expect(selected.requiresSolverHandler, isTrue);
    expect(selected.supportedByCurrentEngine, isFalse);
    expect(selected.hasUnsupportedSolverHandler, isTrue);
    expect(selected.isStillValidFor('x^2 - 5x + 6'), isTrue);
    expect(selected.isStillValidFor('x^2 - 5x + 7'), isFalse);
  });

  test('solution snapshot carries selected action metadata without fake result', () {
    final snapshot = SolutionStepsComposer.compose(
      expression: 'x^2 - 5x + 6',
      result: '—',
      unsupportedReason: 'Bu ifade için gerçek handler yok.',
      selectedActionId: 'factor',
      selectedActionLabel: 'Çarpanlarına Ayır',
      selectedExpressionKind: WorkspaceExpressionKind.polynomialExpression.name,
      selectedActionRequiresSolverHandler: true,
      selectedActionSupportedByCurrentEngine: false,
    );
    expect(snapshot.selectedActionId, 'factor');
    expect(snapshot.selectedActionLabel, 'Çarpanlarına Ayır');
    expect(snapshot.steps.where((step) => step.title == 'İşlem niyeti'), hasLength(1));
    expect(snapshot.selectedActionRequiresSolverHandler, isTrue);
    expect(snapshot.selectedActionSupportedByCurrentEngine, isFalse);
    expect(snapshot.steps.any((step) => step.description.contains('handler kanıtlanmadığı için mevcut sonuç değiştirilmedi')), isTrue);
    expect(snapshot.result, '—');
    expect(snapshot.steps.any((step) => step.title == 'Sonuç' && step.mathLine == '999'), isFalse);
  });

  test('selected action intent step is injected exactly once in normal snapshots', () {
    final snapshot = SolutionStepsComposer.compose(
      expression: 'x^2 - 5x + 6',
      result: '0',
      selectedActionId: 'factor',
      selectedActionLabel: 'Çarpanlarına Ayır',
      selectedExpressionKind: WorkspaceExpressionKind.polynomialExpression.name,
      selectedActionRequiresSolverHandler: true,
      selectedActionSupportedByCurrentEngine: false,
    );
    expect(snapshot.steps.where((step) => step.title == 'İşlem niyeti'), hasLength(1));
    expect(snapshot.steps.map((step) => step.index).toList(), List<int>.generate(snapshot.steps.length, (index) => index + 1));
  });


  test('unsupported selected action suppresses stale generic result even without explicit unsupported reason', () {
    final snapshot = SolutionStepsComposer.compose(
      expression: 'x^2 - 5x + 6',
      result: '999',
      selectedActionId: 'factor',
      selectedActionLabel: 'Çarpanlarına Ayır',
      selectedExpressionKind: WorkspaceExpressionKind.polynomialExpression.name,
      selectedActionRequiresSolverHandler: true,
      selectedActionSupportedByCurrentEngine: false,
    );
    expect(snapshot.result, '—');
    expect(snapshot.steps.any((step) => step.title == 'Sonuç' && step.mathLine == '999'), isFalse);
    expect(snapshot.steps.any((step) => step.description.contains('sahte sonuç gösterilmiyor')), isTrue);
  });

}
