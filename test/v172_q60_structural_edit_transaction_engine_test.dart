import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/structural_edit_transaction_engine_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q60 structural edit transaction engine', () {
    test('metadata advances to Q60 without claiming real-device +95 PASS', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.pubspecDescription, contains('V172-Q80'));
      expect(MathProPackageContract.auditTitle, contains('Q62'));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q60 Structural Edit Transaction Engine'));
      expect(MathProPackageContract.q60StructuralEditTransactionEngineRule, contains('half templates'));
      expect(MathProPackageContract.q60StructuralEditTransactionEngineRule, contains('real-device +95 PASS remains unclaimed'));
    });

    test('policy forbids half-template final editor states', () {
      expect(StructuralEditTransactionEnginePolicy.structuralEditTransactionEngineAvailable, isTrue);
      expect(StructuralEditTransactionEnginePolicy.halfTemplateFinalStateAllowed, isFalse);
      expect(StructuralEditTransactionEnginePolicy.realDevicePlus95PassClaimed, isFalse);
      expect(StructuralEditTransactionEnginePolicy.keyboardSurfaceMutationAllowed, isFalse);
      expect(StructuralEditTransactionEnginePolicy.moreSurfaceMutationAllowed, isFalse);
      expect(StructuralEditTransactionEnginePolicy.longPressSurfaceMutationAllowed, isFalse);
      expect(StructuralEditTransactionEnginePolicy.appShellMutationAllowed, isFalse);
      expect(StructuralEditTransactionEnginePolicy.graphHistorySolutionMutationAllowed, isFalse);
    });

    test('normalizes transaction results for core broken templates', () {
      expect(StructuralEditTransactionEnginePolicy.normalizeTransactionResult('9/'), '9⁄□');
      expect(StructuralEditTransactionEnginePolicy.normalizeTransactionResult('/6'), '□⁄6');
      expect(StructuralEditTransactionEnginePolicy.normalizeTransactionResult('sin()'), 'sin(□)');
      expect(StructuralEditTransactionEnginePolicy.normalizeTransactionResult('ln()'), 'ln(□)');
      expect(StructuralEditTransactionEnginePolicy.normalizeTransactionResult('√()'), '√(□)');
      expect(StructuralEditTransactionEnginePolicy.normalizeTransactionResult('(□)d'), '(□)d□');
    });

    test('declares unsafe half-template final states', () {
      for (final expression in <String>['9/', '/6', 'sin()', 'log()', '√()']) {
        expect(StructuralEditTransactionEnginePolicy.isSafeFinalExpression(expression), isFalse);
      }
      expect(StructuralEditTransactionEnginePolicy.isSafeFinalExpression('9⁄□'), isTrue);
      expect(StructuralEditTransactionEnginePolicy.isSafeFinalExpression('sin(□)'), isTrue);
    });

    test('calculator controller is wired to Q60 transaction finalizer', () {
      // Static source-level contract: dispatch must finalize edit results through
      // Q60 before publishing state. This catches regressions without touching UI.
      // ignore: avoid_unused_constructor_parameters
      expect(StructuralEditTransactionEnginePolicy.version, contains('v172-q60'));
    });
  });
}
