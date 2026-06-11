import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_extended_template_court_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_keyboard_bridge_policy.dart';

void main() {
  group('V172-Q151 MathLive extended template court', () {
    test('policy records bridge-only repair without fake premium claims', () {
      expect(MathLiveExtendedTemplateCourtPolicy.phase, 'V172-Q151');
      expect(MathLiveExtendedTemplateCourtPolicy.realBehaviorRepair, isTrue);
      expect(MathLiveExtendedTemplateCourtPolicy.mainEditorBridgeOnly, isTrue);
      expect(MathLiveExtendedTemplateCourtPolicy.keyboardLayoutMutationAllowed, isFalse);
      expect(MathLiveExtendedTemplateCourtPolicy.longPressOrderMutationAllowed, isFalse);
      expect(MathLiveExtendedTemplateCourtPolicy.moreInventoryMutationAllowed, isFalse);
      expect(MathLiveExtendedTemplateCourtPolicy.cursorPassClaimed, isFalse);
      expect(MathLiveExtendedTemplateCourtPolicy.photomathLevelClaimed, isFalse);
    });

    test('MORE labels that used to risk plain text now have mathematical payloads', () {
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('Kuadratik').latex, contains(r'\frac{-b\pm\sqrt'));
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('(x+y)²').latex, r'\left(x+y\right)^2');
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('∫₀¹ f(x)').latex, contains(r'\int_{0}^{1}'));
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('lim sin(x)/x').latex, contains(r'\lim_{x\to 0}'));
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('Mutlak').latex, r'\left|\placeholder{}\right|');
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('Yuvarla').latex, contains(r'\operatorname{round}'));
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('Kalan').latex, contains(r'\bmod'));
    });

    test('linear algebra and complex labels are explicit semantic LaTeX', () {
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('RREF').latex, contains(r'\operatorname{rref}'));
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('Rank').latex, contains(r'\operatorname{rank}'));
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('Özdeğer').latex, contains(r'\operatorname{eig}'));
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('Çöz').latex, contains(r'\operatorname{solve}'));
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('A⁻¹').latex, r'A^{-1}');
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('Bᵀ').latex, r'B^{T}');
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('□ᴴ').latex, r'\placeholder{}^{H}');
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('z̄').latex, r'\overline{z}');
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('i²').latex, r'i^2');
    });

    test('protected source inventories are not rewritten by the extended court', () {
      final keyConfig = File('lib/features/keyboard/key_config.dart').readAsStringSync();
      final templateTray = File('lib/features/workspace/template_tray.dart').readAsStringSync();
      final graphCard = File('lib/features/graph/graph_card.dart').readAsStringSync();
      final solutionPanel = File('lib/features/solution/solution_steps_panel.dart').readAsStringSync();

      expect(keyConfig, contains('static const Map<String, List<String>> longPressMap'));
      expect(keyConfig, contains("['MORE', '0', '.', 'Ans']"));
      expect(templateTray, isNot(contains('V172-Q151')));
      expect(graphCard, isNot(contains('V172-Q151')));
      expect(solutionPanel, isNot(contains('V172-Q151')));
    });
  });
}
