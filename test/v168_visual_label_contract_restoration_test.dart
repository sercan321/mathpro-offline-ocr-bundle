import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/features/formula_engine/unified_math_preview_policy.dart';
import 'package:mathpro_flutter_phase17/logic/action_utils.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V168 visual label contract restoration', () {
    test('active metadata keeps visual label restoration closure compatible with later phases', () {
      expect(MathProPackageContract.phase, startsWith('V'));
      expect(MathProPackageContract.version, isNotEmpty);
      expect(MathProPackageContract.auditTitle, contains('Closure'));
    });

    test('human-readable MORE labels stay human-readable and do not leak hidden template expressions', () {
      const labels = <String>[
        'Taylor',
        'Maclaurin',
        'Geometrik',
        'Binom',
        'Kuadratik',
        'EBOB',
        'EKOK',
        'Asal mı?',
        '2×2 Matris',
        'RREF',
        'Rank',
        'Özdeğer',
        'Çöz',
        '0 matris',
      ];

      for (final label in labels) {
        final visible = UnifiedMathPreviewPolicy.visibleDisplayLabel(label);
        expect(visible, label, reason: '$label must remain a user-facing visible label');
        expect(visible, isNot(contains('□')), reason: '$label must not display hidden template placeholders');
        expect(visible, isNot(contains('Σ□₌')), reason: '$label must not display series source');
      }
    });

    test('basic keycaps remain clean labels rather than internal function templates', () {
      const labels = <String>['sin', 'cos', 'tan', 'ln', 'log', 'x', 'y', 'π', '√□', '□^□', '|□|', '□!'];
      for (final label in labels) {
        final visible = UnifiedMathPreviewPolicy.visibleDisplayLabel(label);
        if (label == 'sin' || label == 'cos' || label == 'tan' || label == 'ln' || label == 'log') {
          expect(visible, label, reason: '$label keycap must not become $label(□)');
        } else {
          expect(visible, isNot(contains('functionArgument')), reason: '$label must not show debug/internal names');
        }
      }
    });

    test('semantic template routing still keeps hidden expressions separate from display labels', () {
      final taylorSpec = ActionUtils.templateSpecForStructure('Taylor');
      expect(UnifiedMathPreviewPolicy.canonicalPreviewLabel('Taylor'), 'Taylor');
      expect(taylorSpec.expression, contains('Σ'));

      final quadraticSpec = ActionUtils.templateSpecForStructure('Kuadratik');
      expect(UnifiedMathPreviewPolicy.canonicalPreviewLabel('Kuadratik'), 'Kuadratik');
      expect(quadraticSpec.expression, contains('√'));
    });
  });
}
