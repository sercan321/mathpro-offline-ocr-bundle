import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/render/math_tex_serializer.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/structural_renderer_bridge.dart';
import 'package:mathpro_flutter_phase17/logic/action_utils.dart';

void main() {
  group('MathPro V77 series structural slot hardening', () {
    test('series labels insert editable placeholder formulas, not fixed name-call text', () {
      for (final label in <String>[
        'Taylor',
        'Maclaurin',
        'Geometrik',
        'Binom',
        'eˣ serisi',
        'sin serisi',
        'cos serisi',
        'ln serisi',
        'arctan serisi',
      ]) {
        final expression = ActionUtils.templateForStructure(label);
        expect(expression, isNot(contains('$label(')));
        expect(expression, contains('□'), reason: '$label must expose editable user parameters as visible slots.');
      }
    });

    test('Taylor exposes structural slot roles for variable, index, order and center', () {
      final expression = ActionUtils.templateForStructure('Taylor');
      final snapshot = StructuralRendererBridge.snapshotForExpression(expression);
      final roles = snapshot.registry.entries.map((entry) => entry.role).toSet();

      expect(roles, contains('seriesVariable'));
      expect(roles, contains('seriesIndex'));
      expect(roles, contains('seriesOrder'));
      expect(roles, contains('seriesCenter'));
      expect(snapshot.registry.entries.length, greaterThanOrEqualTo(7));
    });

    test('all series formulas serialize to mathematical TeX with visible box placeholders', () {
      final expectedFragments = <String, String>{
        'Taylor': r'\sum_{\Box=0}^{\infty}',
        'Maclaurin': r'\sum_{\Box=0}^{\infty}',
        'Geometrik': r'\frac{\Box}{1-\Box}',
        'Binom': r'{\Box\choose \Box}',
        'eˣ serisi': r'e^{\Box}=\sum',
        'sin serisi': r'\sin(\Box)=\sum',
        'cos serisi': r'\cos(\Box)=\sum',
        'ln serisi': r'\ln(1+\Box)=\sum',
        'arctan serisi': r'\arctan(\Box)=\sum',
      };

      for (final entry in expectedFragments.entries) {
        final tex = MathTexSerializer.toTex(ActionUtils.templateForStructure(entry.key));
        expect(tex, contains(entry.value), reason: '${entry.key} must render as formula TeX, not as plain text.');
        expect(tex, contains(r'\Box'), reason: '${entry.key} must preserve editable placeholder boxes in TeX.');
      }
    });

    test('series templates prefer seriesVariable focus for first edit', () {
      expect(ActionUtils.templateSpecForStructure('Taylor').focusRole, 'seriesVariable');
      expect(ActionUtils.templateSpecForStructure('Binom').focusRole, 'seriesVariable');
      expect(ActionUtils.templateSpecForStructure('Geometrik').focusRole, 'seriesVariable');
    });
  });
}
