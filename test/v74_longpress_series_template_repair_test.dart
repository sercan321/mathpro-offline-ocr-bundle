import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/render/math_tex_serializer.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/key_config.dart';
import 'package:mathpro_flutter_phase17/logic/action_utils.dart';

void main() {
  group('MathPro V74 long-press and series template repair', () {
    test('removes unwanted function and series text entries from visible long-press sources', () {
      expect(KeyConfig.longPressMap['f(□)'], isNot(contains('parçalı')));
      expect(KeyConfig.longPressMap['Σ'], isNot(contains('seri')));
      expect(KeyConfig.longPressMap['Σ'], containsAll(<String>[
        'Taylor',
        'Maclaurin',
        'Geometrik',
        'Binom',
        'eˣ serisi',
        'sin serisi',
        'cos serisi',
        'ln serisi',
        'arctan serisi',
      ]));
    });

    test('series labels insert mathematical formulas instead of name-call text', () {
      final taylor = ActionUtils.templateForStructure('Taylor');
      final maclaurin = ActionUtils.templateForStructure('Maclaurin');
      final binom = ActionUtils.templateForStructure('Binom');

      expect(taylor, isNot(contains('Taylor(')));
      expect(maclaurin, isNot(contains('Maclaurin(')));
      expect(binom, isNot(contains('Binom(')));
      expect(taylor, contains('Σ□₌₀∞'));
      expect(taylor, contains('f⁽□⁾(□)'));
      expect(maclaurin, contains('f⁽□⁾(0)'));
      expect(binom, contains('Σ□₌₀∞'));
      expect(taylor, contains('□'));
      expect(binom, contains('□'));
    });

    test('limit and equation-system templates serialize as real mathematical notation', () {
      expect(MathTexSerializer.toTex(ActionUtils.templateForStructure('lim')), contains(r'\lim_{x\to \Box}'));
      expect(MathTexSerializer.toTex(ActionUtils.templateForStructure('{□=□')), contains(r'\begin{cases}'));
    });

    test('series formulas serialize to TeX instead of plain Turkish labels', () {
      expect(MathTexSerializer.toTex(ActionUtils.templateForStructure('Taylor')), contains(r'\sum_{\Box=0}^{\infty}'));
      expect(MathTexSerializer.toTex(ActionUtils.templateForStructure('eˣ serisi')), contains(r'e^{\Box}=\sum'));
      expect(MathTexSerializer.toTex(ActionUtils.templateForStructure('ln serisi')), contains(r'\ln(1+\Box)=\sum'));
    });
  });
}
