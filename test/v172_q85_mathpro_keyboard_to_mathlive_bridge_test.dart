import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_keyboard_bridge_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_lab_screen.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q85 MathPro Keyboard to MathLive Bridge', () {
    test('records lab-only bridge without switching the main editor', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.q85MathProKeyboardToMathLiveBridgeRule, contains('MathPro Keyboard to MathLive bridge'));
      expect(MathProPackageContract.q85MathProKeyboardToMathLiveBridgeRule, contains('executeMathProCommand'));
      expect(MathLiveKeyboardBridgePolicy.phase, 'V172-Q85');
      expect(MathLiveKeyboardBridgePolicy.labOnly, isTrue);
      expect(MathLiveKeyboardBridgePolicy.mainEditorSwitchAllowed, isFalse);
      expect(MathLiveKeyboardBridgePolicy.mathLiveVirtualKeyboardEnabled, isFalse);
      expect(MathLiveKeyboardBridgePolicy.realMathLiveRuntimeBundled, isFalse);
      expect(MathLiveKeyboardBridgePolicy.remoteScriptLoadingAllowed, isFalse);
      expect(MathLiveKeyboardBridgePolicy.protectedKeyboardMutationAllowed, isFalse);
    });

    test('maps frozen MathPro key labels to deterministic lab bridge commands', () {
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('7').toJson()['latex'], '7');
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('+').toJson()['latex'], '+');
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('×').toJson()['latex'], r'\times ');
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('÷').toJson()['latex'], r'\div ');
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('□/□').toJson()['latex'], r'\frac{}{}');
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('√□').toJson()['latex'], r'\sqrt{}');
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('□^□').toJson()['latex'], '^{}');
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('sin').toJson()['latex'], r'\sin\left(\right)');
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('log_□(□)').toJson()['latex'], r'\log_{}\left(\right)');
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('∫ₐᵇ').toJson()['latex'], r'\int_{}^{} {}\,d{}');
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('⌫').toJson()['action'], 'deleteBackward');
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('C').toJson()['action'], 'clear');
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('↵').toJson()['action'], 'evaluate');
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('MORE').accepted, isFalse);
    });

    test('keeps Q85 bridge inside local assets and blocks fake PASS claims', () {
      final bridge = File('assets/mathlive/mathlive_bridge.js').readAsStringSync();
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final index = File('assets/mathlive/index.html').readAsStringSync();
      expect(bridge, contains('executeMathProCommand'));
      expect(bridge, contains("keyboardBridgePhase: 'V172-Q85'"));
      expect(bridge, contains('mainEditorSwitchAllowed: false'));
      expect(manifest, contains('"keyboardBridgePhase": "V172-Q85"'));
      expect(manifest, contains('"keyboardBridgeLabOnly": true'));
      expect(index, isNot(contains('http://')));
      expect(index, isNot(contains('https://')));
      expect(
        MathLiveKeyboardBridgePolicy.canUseLabBridge(
          labScreenOpen: true,
          usesRemoteScripts: false,
          protectedSurfacesUnchanged: true,
        ),
        isTrue,
      );
      expect(
        MathLiveKeyboardBridgePolicy.mayClaimKeyboardBridgePass(
          bridgeCommandsReachWebView: true,
          officialRuntimeBundled: false,
          realDeviceFocusPasses: true,
        ),
        isFalse,
      );
    });

    testWidgets('lab screen exposes Q85 command buttons only in the isolated lab surface', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: MathLiveLabScreen()));
      await tester.pump();
      expect(find.byKey(const ValueKey('mathlive-lab-seed-fraction')), findsOneWidget);
      expect(find.byKey(const ValueKey('mathlive-lab-insert-seven')), findsOneWidget);
      expect(find.byKey(const ValueKey('mathlive-lab-backspace')), findsOneWidget);
      expect(find.byKey(const ValueKey('mathlive-lab-clear')), findsOneWidget);
      expect(find.textContaining('Q85 bridge: lab-only'), findsOneWidget);
    });
  });
}
