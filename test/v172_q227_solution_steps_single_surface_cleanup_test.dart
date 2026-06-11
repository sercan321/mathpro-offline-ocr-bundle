import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/solution/solution_step_models.dart';
import 'package:mathpro_flutter_phase17/features/solution/solution_steps_single_surface_cleanup_policy.dart';

void main() {
  test('Q227 policy locks solution panel simplification scope', () {
    expect(SolutionStepsSingleSurfaceCleanupPolicy.phase, contains('Q227'));
    expect(SolutionStepsSingleSurfaceCleanupPolicy.singlePanelSurfaceOnly, isTrue);
    expect(SolutionStepsSingleSurfaceCleanupPolicy.tutorialEmptyCardsRemoved, isTrue);
    expect(SolutionStepsSingleSurfaceCleanupPolicy.headerStatusSubtitleRemoved, isTrue);
    expect(SolutionStepsSingleSurfaceCleanupPolicy.stepCardsNestedInPanelAllowed, isFalse);
    expect(SolutionStepsSingleSurfaceCleanupPolicy.internalScrollKept, isTrue);
    expect(SolutionStepsSingleSurfaceCleanupPolicy.mediumExpandedMechanicsKept, isTrue);
    expect(SolutionStepsSingleSurfaceCleanupPolicy.dragMechanicsKept, isTrue);
    expect(SolutionStepsSingleSurfaceCleanupPolicy.keyboardMutationAllowed, isFalse);
    expect(SolutionStepsSingleSurfaceCleanupPolicy.moreMutationAllowed, isFalse);
    expect(SolutionStepsSingleSurfaceCleanupPolicy.longPressMutationAllowed, isFalse);
    expect(SolutionStepsSingleSurfaceCleanupPolicy.mathLiveProductionRouteMutationAllowed, isFalse);
    expect(SolutionStepsSingleSurfaceCleanupPolicy.graphMutationAllowed, isFalse);
    expect(SolutionStepsSingleSurfaceCleanupPolicy.historyMutationAllowed, isFalse);
    expect(SolutionStepsSingleSurfaceCleanupPolicy.solverMutationAllowed, isFalse);
  });

  test('Q227 empty composer no longer emits tutorial steps', () {
    final snapshot = SolutionStepsComposer.compose(expression: '', result: '');

    expect(snapshot.steps, isEmpty);
    expect(snapshot.statusText, isNull);
    expect(snapshot.expression, isEmpty);
  });

  test('Q227 source keeps single-surface list items and removes nested step-card widgets', () {
    final panel = File('lib/features/solution/solution_steps_panel.dart').readAsStringSync();
    final model = File('lib/features/solution/solution_step_models.dart').readAsStringSync();

    expect(panel, contains('mathpro-solution-step-item-'));
    expect(panel, contains('ListView.separated'));
    expect(panel, contains('mathpro-solution-empty-state-message'));
    expect(panel, contains(SolutionStepsSingleSurfaceCleanupPolicy.emptyIdleMessage));
    expect(panel, contains(SolutionStepsSingleSurfaceCleanupPolicy.expressionWithoutStepsMessage));
    expect(panel, isNot(contains('mathpro-solution-step-card-')));
    expect(panel, isNot(contains('class _SolutionStepCard')));
    expect(panel, isNot(contains('class _MathLineBlock')));
    expect(panel, isNot(contains('class _StepToneChip')));
    expect(panel, isNot(contains('Matematik satırı')));
    expect(panel, isNot(contains('widget.snapshot.statusText!')));

    expect(model, isNot(contains('İfade yazıldığında adım paneli aynı ekranda hazır kalır.')));
    expect(model, isNot(contains('Çözüm adımları, yazılan ifade ve hesap sonucu ile aynı bağlamda gösterilir.')));
    expect(model, isNot(contains('Panel açıldığında ifade, sonuç ve klavye görünür kalacak şekilde tasarlanmıştır.')));
    expect(model, isNot(contains("title: 'İfade bekleniyor'")));
    expect(model, isNot(contains("title: 'Bağlam korunur'")));
  });
}
