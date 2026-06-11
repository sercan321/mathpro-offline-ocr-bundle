import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/structural_edit_transaction_stress_court_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q63 structural edit transaction stress court', () {
    test('metadata advances to Q63 without claiming real-device +95 PASS', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.pubspecDescription, contains('V172-Q80'));
      expect(MathProPackageContract.pubspecDescription, contains('V172-Q80'));
      expect(MathProPackageContract.auditTitle, contains('Q63'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q63 Structural Edit Transaction Stress Test'));
      expect(MathProPackageContract.q63StructuralEditTransactionStressCourtRule, contains('20/20 attempts'));
      expect(MathProPackageContract.q63StructuralEditTransactionStressCourtRule, contains('real-device +95 PASS unclaimed'));
    });

    test('policy forbids half-template stress failures and protected surface mutation', () {
      expect(StructuralEditTransactionStressCourtPolicy.structuralEditTransactionStressCourtAvailable, isTrue);
      expect(StructuralEditTransactionStressCourtPolicy.halfTemplateStressFailureAllowed, isFalse);
      expect(StructuralEditTransactionStressCourtPolicy.keyboardSurfaceMutationAllowed, isFalse);
      expect(StructuralEditTransactionStressCourtPolicy.moreSurfaceMutationAllowed, isFalse);
      expect(StructuralEditTransactionStressCourtPolicy.longPressSurfaceMutationAllowed, isFalse);
      expect(StructuralEditTransactionStressCourtPolicy.appShellMutationAllowed, isFalse);
      expect(StructuralEditTransactionStressCourtPolicy.graphHistorySolutionMutationAllowed, isFalse);
      expect(StructuralEditTransactionStressCourtPolicy.realDevicePlus95PassClaimed, isFalse);
    });

    test('core transaction stress matrix reaches the strict 20/20 threshold', () {
      final matrix = StructuralEditTransactionStressCourtPolicy.evaluateCoreMatrix();
      expect(matrix.scenarioCount, greaterThanOrEqualTo(12));
      expect(matrix.totalAttempts, matrix.scenarioCount * StructuralEditTransactionStressCourtPolicy.attemptsPerScenario);
      expect(matrix.passed, isTrue, reason: matrix.summary);
      expect(matrix.successRate, StructuralEditTransactionStressCourtPolicy.requiredStressSuccessRate);
      for (final scenario in matrix.scenarios) {
        expect(
          scenario.correct,
          StructuralEditTransactionStressCourtPolicy.requiredCorrectPerScenario,
          reason: scenario.summary,
        );
      }
    });

    test('normalizes representative half-template transaction outputs', () {
      for (final testCase in StructuralEditTransactionStressCourtPolicy.coreCases) {
        final verdict = StructuralEditTransactionStressCourtPolicy.evaluateCase(testCase);
        expect(verdict.normalized, testCase.expected, reason: verdict.summary);
        expect(verdict.passed, isTrue, reason: verdict.summary);
      }
    });

    test('forbidden half-template fragments are never accepted by the stress court', () {
      for (final expression in <String>['9/', '⁄6', 'sin()', 'cos()', 'ln()', 'log()', '√()', '³√()', '∫(9)d']) {
        expect(StructuralEditTransactionStressCourtPolicy.isForbiddenHalfTemplate(expression), isTrue, reason: expression);
      }
    });

    test('Q63 source is wired without mutating frozen visual surfaces', () {
      final policySource = File('lib/features/formula_engine/structural_edit_transaction_stress_court_policy.dart').readAsStringSync();
      final contractSource = File('lib/logic/mathpro_package_contract.dart').readAsStringSync();
      final verifierSource = File('tool/verify_mathpro_contract.py').readAsStringSync();
      expect(policySource, contains('StructuralEditTransactionStressCourtPolicy'));
      expect(policySource, contains('requiredCorrectPerScenario = 20'));
      expect(policySource, contains('halfTemplateStressFailureAllowed = false'));
      expect(policySource, contains('realDevicePlus95PassClaimed = false'));
      expect(contractSource, contains('q63StructuralEditTransactionStressCourtRule'));
      expect(verifierSource, contains('check_v172_q63_structural_edit_transaction_stress_court'));
      expect(policySource, isNot(contains('keyboardSurfaceMutationAllowed = true')));
      expect(policySource, isNot(contains('longPressSurfaceMutationAllowed = true')));
    });
  });
}
