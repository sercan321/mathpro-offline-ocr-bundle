import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/features/formula_engine/unified_math_preview_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V170 full premium visible label restoration', () {
    test('active metadata has advanced while preserving V170 visible label closure', () {
      final phaseNumber = int.parse(MathProPackageContract.phase.substring(1));
      expect(phaseNumber, greaterThanOrEqualTo(170));
      expect(MathProPackageContract.auditTitle, contains('Closure'));
    });

    test('high-risk keycap labels do not expose raw placeholder source', () {
      const labels = <String>['□/□', '√□', '□^□', '□!', '|□|', '∫□dx', 'f(□)', 'log_□(□)', '[□ □]', '[□]'];
      for (final label in labels) {
        final visible = UnifiedMathPreviewPolicy.visibleDisplayLabel(label);
        expect(visible, isNot(contains('□')), reason: label);
      }
    });

    test('human-readable MORE labels remain names, not hidden expressions', () {
      const labels = <String>['Taylor', 'Maclaurin', 'Geometrik', 'Binom', 'Kuadratik', 'EBOB', 'EKOK', 'RREF', 'Rank', '2×2 Matris'];
      for (final label in labels) {
        expect(UnifiedMathPreviewPolicy.visibleDisplayLabel(label), label, reason: label);
      }
    });
  });
}
