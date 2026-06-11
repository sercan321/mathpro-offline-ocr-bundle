import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_keyboard_bridge_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_production_command_contract_policy.dart';

void main() {
  test('V172-Q199 production command contract critical labels are locked', () {
    expect(MathLiveProductionCommandContractPolicy.phase, 'V172-Q199');
    expect(MathLiveProductionCommandContractPolicy.rawInsertTokensMayCrossProductionBridge, isFalse);
    expect(MathLiveProductionCommandContractPolicy.rawVisibleLabelsMayCrossProductionBridgeForCriticalTemplates, isFalse);

    const labels = <String>[
      'lim',
      'lim x→□',
      'lim x→∞',
      '□/□',
      'a/b',
      '□⁄□',
      '√□',
      '√x',
      'x^y',
      '□^□',
      'Σ',
      'Π',
      '∫',
      '∫dx',
      '∫□dx',
      '∫ₐᵇ',
      'Taylor',
      'Maclaurin',
      'C',
      '⌫',
      '↵',
      'Ans',
      '=',
    ];

    for (final label in labels) {
      final entry = MathLiveProductionCommandContractPolicy.contractForLabel(label);
      expect(entry, isNotNull, reason: 'missing Q199 command contract for $label');
      expect(entry!.rawInsertTokenAllowed, isFalse, reason: 'raw insert token allowed for $label');
      expect(MathLiveProductionCommandContractPolicy.hasRawInsertToken(entry.documentLatex), isFalse, reason: 'document latex leaks # token for $label');
      expect(MathLiveProductionCommandContractPolicy.documentLatexMatchesPlaceholderContract(entry), isTrue, reason: 'placeholder count mismatch for $label');
    }
  });

  test('V172-Q199 main editor bridge uses document latex for critical templates', () {
    for (final label in <String>['lim', '□/□', '√□', 'x^y', 'Σ', 'Π', '∫', '∫ₐᵇ', 'Taylor', 'Maclaurin']) {
      final command = MathLiveKeyboardBridgePolicy.commandForMainEditorLabel(label, lastAnswer: '42');
      expect(command.accepted, isTrue, reason: label);
      expect(command.action, 'insertLatex', reason: label);
      expect(command.latex, isNot(label), reason: 'raw label leaked for $label');
      expect(MathLiveProductionCommandContractPolicy.hasRawInsertToken(command.latex), isFalse, reason: 'raw # token leaked for $label');
    }

    expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('C').action, 'clear');
    expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('⌫').action, 'deleteBackward');
    expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('↵').action, 'evaluate');
    expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('Ans', lastAnswer: '').accepted, isFalse);
    expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('Ans', lastAnswer: '42').latex, '42');
    expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('=').latex, '=', reason: '= remains the literal equality relation, not an evaluate command.');
  });
}
