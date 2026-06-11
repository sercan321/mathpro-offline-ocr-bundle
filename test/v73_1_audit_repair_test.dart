import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/editor_commands.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/key_config.dart';
import 'package:mathpro_flutter_phase17/logic/action_utils.dart';

void main() {
  group('MathPro V73.1 static audit repair contract', () {
    test('uses a fillable derivative-order slot instead of literal n notation', () {
      for (final tab in KeyConfig.tabs) {
        final options = KeyConfig.getLongPressOptions('y', tab);
        expect(options, contains('y⁽□⁾'), reason: tab);
        expect(options, isNot(contains('y⁽ⁿ⁾')), reason: tab);
      }

      final spec = ActionUtils.templateSpecForStructure('y⁽□⁾');
      expect(spec.expression, 'y⁽□⁾');
      expect(spec.focusRole, 'derivativeOrder');
    });

    test('converts numeric derivative order slot into prime notation', () {
      expect(EditorCommands.replaceDerivativeOrderSlot('y⁽□⁾', '1'), "y'");
      expect(EditorCommands.replaceDerivativeOrderSlot('y⁽□⁾', '2'), "y''");
      expect(EditorCommands.replaceDerivativeOrderSlot('y⁽□⁾', '3'), "y'''");
      expect(EditorCommands.replaceDerivativeOrderSlot('y⁽□⁾', '4'), "y''''");
      expect(EditorCommands.replaceDerivativeOrderSlot('y⁽□⁾', 'x'), isNull);
    });

    test('removes duplicate generic log template from MORE function surface', () {
      final functionCategory = ActionUtils.morePanelCategories.firstWhere((category) => category.title == 'Fonksiyon');
      expect(functionCategory.labels, isNot(contains('log(□)')));
      expect(functionCategory.labels, containsAll(<String>['log₁₀(□)', 'log₂(□)', 'log_□(□)']));
    });
  });
}
