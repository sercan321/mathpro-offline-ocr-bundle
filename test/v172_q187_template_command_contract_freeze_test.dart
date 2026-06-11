import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_keyboard_bridge_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_template_command_contract_freeze_policy.dart';

void main() {
  test('V172-Q187 freezes template command contract without mutating protected UI surfaces', () {
    expect(MathLiveTemplateCommandContractFreezePolicy.phase, 'V172-Q187');
    expect(MathLiveTemplateCommandContractFreezePolicy.templateCommandContractFrozen, isTrue);
    expect(MathLiveTemplateCommandContractFreezePolicy.keyboardLayoutMutationAllowed, isFalse);
    expect(MathLiveTemplateCommandContractFreezePolicy.moreInventoryMutationAllowed, isFalse);
    expect(MathLiveTemplateCommandContractFreezePolicy.longPressOrderMutationAllowed, isFalse);
    expect(MathLiveTemplateCommandContractFreezePolicy.productionBridgePublicApiMutationAllowed, isFalse);
    expect(MathLiveTemplateCommandContractFreezePolicy.appShellMutationAllowed, isFalse);
    expect(MathLiveTemplateCommandContractFreezePolicy.graphHistorySolutionUiMutationAllowed, isFalse);
    expect(MathLiveTemplateCommandContractFreezePolicy.rawNamedTemplateFallbackAllowed, isFalse);
    expect(MathLiveTemplateCommandContractFreezePolicy.rawStructuralGlyphFallbackAllowed, isFalse);
    expect(MathLiveTemplateCommandContractFreezePolicy.realDevicePremiumPassClaimed, isFalse);
    expect(MathLiveKeyboardBridgePolicy.mainEditorTemplateCommandFreezePhase, 'V172-Q187');
  });

  test('all structural/wrapper/postfix labels have explicit main-editor MathLive templates', () {
    expect(MathLiveTemplateCommandContractFreezePolicy.missingExplicitTemplateLabels(), isEmpty);
  });

  test('critical named templates cannot fall through as raw visible text', () {
    expect(MathLiveTemplateCommandContractFreezePolicy.rawFallbackViolations(), isEmpty);

    final taylor = MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('Taylor').latex;
    final sigma = MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('Σ').latex;
    final integral = MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('∫□dx').latex;
    final system = MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('{3 denklem').latex;
    final quadratic = MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('Kuadratik').latex;
    final matrix = MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('3×3').latex;

    expect(taylor, contains(r'\sum_{n=0}^{\infty}'));
    expect(taylor, isNot('Taylor'));
    expect(sigma, contains(r'\sum'));
    expect(sigma, isNot('Σ'));
    expect(integral, contains(r'\int'));
    expect(integral, isNot('∫□dx'));
    expect(system, contains(r'\begin{cases}'));
    expect(system, isNot('{3 denklem'));
    expect(quadratic, contains(r'\frac{-b\pm\sqrt'));
    expect(quadratic, isNot('Kuadratik'));
    expect(matrix, contains(r'\begin{bmatrix}'));
    expect(matrix, isNot('3×3'));
  });
}
