import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_keyboard_bridge_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_semantic_template_coverage_policy.dart';

void main() {
  group('V172-Q142 MathLive semantic template coverage', () {
    test('policy records broad semantic coverage without fake PASS claims', () {
      expect(MathLiveSemanticTemplateCoveragePolicy.phase, 'V172-Q142');
      expect(MathLiveSemanticTemplateCoveragePolicy.realBehaviorRepair, isTrue);
      expect(MathLiveSemanticTemplateCoveragePolicy.namedLabelsDoNotInsertPlainText, isTrue);
      expect(MathLiveSemanticTemplateCoveragePolicy.cursorPassClaimed, isFalse);
      expect(MathLiveSemanticTemplateCoveragePolicy.photomathLevelClaimed, isFalse);
    });

    test('previously textual algebra/function labels now emit semantic LaTeX', () {
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('EBOB').latex, contains(r'\operatorname{EBOB}'));
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('EKOK').latex, contains(r'\operatorname{EKOK}'));
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('Asal mı?').latex, contains(r'\operatorname{asal}'));
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('İşaret').latex, contains(r'\operatorname{sgn}'));
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('⌊□⌋').latex, contains(r'\lfloor'));
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('⌈□⌉').latex, contains(r'\lceil'));
    });

    test('trig aliases, composition, combinatorics and gamma are semantic', () {
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('asin(□)').latex, r'\sin^{-1}\left(\placeholder{}\right)');
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('cot').latex, r'\cot\left(\placeholder{}\right)');
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('sec(□)').latex, r'\sec\left(\placeholder{}\right)');
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('csc(□)').latex, r'\csc\left(\placeholder{}\right)');
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('f∘g').latex, r'f\circ g');
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('□C□').latex, r'\binom{\placeholder{}}{\placeholder{}}');
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('Γ(□)').latex, r'\Gamma\left(\placeholder{}\right)');
    });

    test('complex, matrix and vector labels no longer fall through as plain text', () {
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('real(□)').latex, contains(r'\operatorname{Re}'));
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('conj(□)').latex, r'\overline{\placeholder{}}');
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('cis(□)').latex, contains(r'\operatorname{cis}'));
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('4×4').latex, contains(r'\begin{bmatrix}'));
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('3D vektör').latex, contains(r'\begin{bmatrix}'));
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('pseudo-inverse').latex, r'\placeholder{}^{+}');
      expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('projeksiyon').latex, contains(r'\operatorname{proj}'));
    });
  });
}
