import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_keyboard_bridge_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_runtime_render_contract_policy.dart';

void main() {
  test('Q191 critical runtime render labels use explicit document placeholders', () {
    expect(MathLiveRuntimeRenderContractPolicy.phase, 'V172-Q191');
    for (final label in MathLiveRuntimeRenderContractPolicy.criticalLabels) {
      final command = MathLiveKeyboardBridgePolicy.commandForMainEditorLabel(label);
      expect(command.accepted, isTrue, reason: label);
      final latex = MathLiveKeyboardBridgePolicy.productionRuntimeRenderLatexForMainEditorLabel(label, command.latex);
      expect(latex, isNot(contains('#0')), reason: label);
      expect(latex, isNot(contains('#?')), reason: label);
      expect(latex, isNot(contains('#@')), reason: label);
      expect(latex.trim(), isNotEmpty, reason: label);
    }
  });

  test('Q191 core template contracts are mathematical LaTeX, not visible labels', () {
    const contracts = MathLiveKeyboardBridgePolicy.productionRuntimeRenderLatexContracts;
    expect(contracts['lim'], contains(r'\lim_{x\to \placeholder{}}'));
    expect(contracts['□/□'], contains(r'\frac{\placeholder{}}{\placeholder{}}'));
    expect(contracts['√□'], contains(r'\sqrt{\placeholder{}}'));
    expect(contracts['x^y'], contains(r'\placeholder{}^{\placeholder{}}'));
    expect(contracts['Σ'], contains(r'\sum_{n=\placeholder{}}^{\placeholder{}}\placeholder{}'));
    expect(contracts['∫□dx'], contains(r'\int \placeholder{}\,dx'));
    expect(contracts['Taylor'], contains(r'\sum_{n=0}^{\infty}'));
    expect(contracts['Maclaurin'], contains(r'\sum_{n=0}^{\infty}'));
  });
}
