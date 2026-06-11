import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/solution/solution_step_models.dart';
import 'package:mathpro_flutter_phase17/features/solution/solution_steps_premium_copy_polish_policy.dart';
import 'package:mathpro_flutter_phase17/features/solution/solution_steps_single_surface_cleanup_policy.dart';

void main() {
  test('Q228 policy locks copy-only solution step polish scope', () {
    expect(SolutionStepsPremiumCopyPolishPolicy.phase, contains('Q228'));
    expect(SolutionStepsPremiumCopyPolishPolicy.copyOnly, isTrue);
    expect(SolutionStepsPremiumCopyPolishPolicy.singleSurfaceLayoutKept, isTrue);
    expect(SolutionStepsPremiumCopyPolishPolicy.nestedStepCardsAllowed, isFalse);
    expect(SolutionStepsPremiumCopyPolishPolicy.longTechnicalCopyAllowed, isFalse);
    expect(SolutionStepsPremiumCopyPolishPolicy.headerSubtitleAllowed, isFalse);
    expect(SolutionStepsPremiumCopyPolishPolicy.solverMutationAllowed, isFalse);
    expect(SolutionStepsPremiumCopyPolishPolicy.keyboardMutationAllowed, isFalse);
    expect(SolutionStepsPremiumCopyPolishPolicy.moreMutationAllowed, isFalse);
    expect(SolutionStepsPremiumCopyPolishPolicy.longPressMutationAllowed, isFalse);
    expect(SolutionStepsPremiumCopyPolishPolicy.mathLiveProductionRouteMutationAllowed, isFalse);
    expect(SolutionStepsPremiumCopyPolishPolicy.graphMutationAllowed, isFalse);
    expect(SolutionStepsPremiumCopyPolishPolicy.historyMutationAllowed, isFalse);
    expect(SolutionStepsPremiumCopyPolishPolicy.workspaceLayoutMutationAllowed, isFalse);
  });

  test('Q228 numeric steps use short premium copy', () {
    final snapshot = SolutionStepsComposer.compose(expression: '2+3×4', result: '14');

    expect(snapshot.steps.map((step) => step.title), containsAllInOrder(<String>[
      'İfade alındı',
      'İşlem değerlendirildi',
      'Sonuç',
    ]));
    expect(snapshot.steps.expand((step) => <String>[step.title, step.description]).join(' '), isNot(contains('hesaplama köprüsüne')));
    expect(snapshot.steps.expand((step) => <String>[step.title, step.description]).join(' '), isNot(contains('güvenli sayısal değerlendiriciden')));
    expect(snapshot.steps.expand((step) => <String>[step.title, step.description]).join(' '), isNot(contains('panel yalnızca açıklama katmanı')));
  });

  test('Q228 source keeps Q227 single-surface panel and removes technical copy', () {
    final model = File('lib/features/solution/solution_step_models.dart').readAsStringSync();
    final panel = File('lib/features/solution/solution_steps_panel.dart').readAsStringSync();

    expect(panel, contains('mathpro-solution-step-item-'));
    expect(panel, contains('ListView.separated'));
    expect(panel, contains(SolutionStepsSingleSurfaceCleanupPolicy.emptyIdleMessage));
    expect(panel, contains(SolutionStepsPremiumCopyPolishPolicy.expressionWithoutStepsMessage));
    expect(panel, isNot(contains('class _SolutionStepCard')));
    expect(panel, isNot(contains('mathpro-solution-step-card-')));

    for (final forbidden in <String>[
      'Yazılan ifade hesaplama köprüsüne gönderilmeden önce editördeki mevcut biçimiyle korunur.',
      'Desteklenen temel aritmetik ifade güvenli sayısal değerlendiriciden geçirilir.',
      'Sonuç ana kartta görünür kalır; panel yalnızca açıklama katmanı olarak açılır.',
      'Bu ifade için çözüm adımı henüz oluşturulamadı.',
      'Gelişmiş adım motoru gerekli',
      'Solver bridge durumu',
      'Sayısal değerlendirme',
      'Sonuç gösterildi',
      'İfade hazırlandı',
    ]) {
      expect(model, isNot(contains(forbidden)));
      expect(panel, isNot(contains(forbidden)));
    }
  });
}
