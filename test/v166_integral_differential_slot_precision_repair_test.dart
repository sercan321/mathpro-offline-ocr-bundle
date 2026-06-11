import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/features/formula_engine/structural_renderer_bridge.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V166 integral differential slot precision repair', () {
    test('active metadata has advanced while preserving the V166 repair contract', () {
      expect(MathProPackageContract.phase, startsWith('V'));
      expect(MathProPackageContract.version, isNotEmpty);
    });

    test('fixed definite integrals expose no false editable slots', () {
      final fixedNumeric = StructuralRendererBridge.snapshotForExpression('∫₀¹(x)dx');
      expect(fixedNumeric.registry.entries, isEmpty);

      final fixedLegacy = StructuralRendererBridge.snapshotForExpression('∫ₐᵇ(x)dx');
      expect(fixedLegacy.registry.entries, isEmpty);
    });

    test('partially fixed differential-only integral exposes only integralDifferential', () {
      final snapshot = StructuralRendererBridge.snapshotForExpression('∫_{0}^{1}(x)d□');
      expect(snapshot.registry.entries.map((entry) => entry.role).toList(), equals(<String>['integralDifferential']));
    });

    test('editable template with open limits still keeps filled body clearable', () {
      final snapshot = StructuralRendererBridge.snapshotForExpression('∫_{□}^{□}(x)d□');
      final roles = snapshot.registry.entries.map((entry) => entry.role).toSet();
      expect(roles, containsAll(<String>{'integralLowerLimit', 'integralUpperLimit', 'integralBody', 'integralDifferential'}));
    });
  });
}
