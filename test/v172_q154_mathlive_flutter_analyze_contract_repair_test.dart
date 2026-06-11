import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_flutter_analyze_contract_repair_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_keyboard_bridge_policy.dart';

void main() {
  group('V172-Q154 MathLive Flutter analyze contract repair', () {
    test('policy records syntax/test-contract repair without fake PASS claims', () {
      expect(MathLiveFlutterAnalyzeContractRepairPolicy.phase, 'V172-Q154');
      expect(MathLiveFlutterAnalyzeContractRepairPolicy.dartStringInterpolationEscaped, isTrue);
      expect(MathLiveFlutterAnalyzeContractRepairPolicy.q140LegacyMarkersPreservedThroughLaterPhases, isTrue);
      expect(MathLiveFlutterAnalyzeContractRepairPolicy.evolvedLimitTemplateContractAccepted, isTrue);
      expect(MathLiveFlutterAnalyzeContractRepairPolicy.keyboardLayoutMutationAllowed, isFalse);
      expect(MathLiveFlutterAnalyzeContractRepairPolicy.longPressOrderMutationAllowed, isFalse);
      expect(MathLiveFlutterAnalyzeContractRepairPolicy.graphHistorySolutionUiMutationAllowed, isFalse);
      expect(MathLiveFlutterAnalyzeContractRepairPolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
      expect(MathLiveFlutterAnalyzeContractRepairPolicy.flutterTestPassClaimedByAssistant, isFalse);
      expect(MathLiveFlutterAnalyzeContractRepairPolicy.photomathLevelClaimed, isFalse);
    });

    test('Q153 verifier-string test uses raw Dart strings so dollar anchors compile', () {
      final testFile = File('test/v172_q153_mathlive_flutter_test_contract_repair_test.dart').readAsStringSync();
      expect(testFile, contains(r"contains(r'/(^|\/)build(\/|$)/')"));
      expect(testFile, contains(r"contains(r'/(^|\/)\.dart_tool(\/|$)/')"));
      expect(testFile, isNot(contains(r"contains('/(^|\\/)build(\\/|$)/')")));
    });

    test('Q140 compatibility markers survive Q143/Q148/Q149 event and CSS evolution', () {
      final bridge = File('assets/mathlive/mathlive_bridge.js').readAsStringSync();
      final html = File('assets/mathlive/main_editor.html').readAsStringSync();
      expect(bridge, contains('q140-after-insert-focus-restored'));
      expect(bridge, contains('q140-pointerdown-focus-restored'));
      expect(html, contains('touch-action: manipulation'));
      expect(html, contains('touch-action: auto'));
    });

    test('Q140 limit test contract accepts later Q145 compact textstyle template', () {
      final latex = MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('lim').latex;
      expect(latex, contains(r'\lim_{x\to \placeholder{}}\placeholder{}'));
      expect(latex, isNot(contains('#')));
      expect(latex, isNot(contains(r'\textstyle')));
      expect(latex, isNot('lim'));
    });
  });
}
