
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_keyboard_bridge_policy.dart';

void main() {
  group('V172-Q139R5 MathLive main editor template polish', () {
    test('main editor hides MathLive virtual keyboard chrome without touching MathPro keyboard', () {
      final html = File('assets/mathlive/main_editor.html').readAsStringSync();
      final bridge = File('assets/mathlive/mathlive_bridge.js').readAsStringSync();

      expect(html, contains('math-field::part(virtual-keyboard-toggle)'));
      expect(html, contains('math-field::part(menu-toggle)'));
      expect(bridge, contains('disableMathLiveVirtualKeyboard'));
      expect(bridge, contains('window.mathVirtualKeyboard.visible = false'));
      expect(bridge, contains('hideMathLiveChrome'));
    });

    test('main editor uses MathLive template insertion options for structural keys', () {
      final bridge = File('assets/mathlive/mathlive_bridge.js').readAsStringSync();
      expect(bridge, contains('selectionMode'));
      expect(bridge, contains('replaceSelection'));
      expect(bridge, contains('insertIntoMathfield'));

      final fraction = MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('a/b');
      final sqrt = MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('√x');
      final power = MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('x^y');
      final integral = MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('∫dx');
      final boundedIntegral = MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('∫ₐᵇ');

      expect(fraction.latex, r'\frac{\placeholder{}}{\placeholder{}}');
      expect(sqrt.latex, r'\sqrt{\placeholder{}}');
      expect(power.latex, r'\placeholder{}^{\placeholder{}}');
      expect(integral.latex, r'\int \placeholder{}\,dx');
      expect(boundedIntegral.latex, r'\int_{\placeholder{}}^{\placeholder{}}\placeholder{}\,dx');
    });
  });
}
