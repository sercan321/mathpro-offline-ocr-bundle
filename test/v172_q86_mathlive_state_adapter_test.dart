import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/math_editor_adapter.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_lab_screen.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_state_adapter.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q86 MathLive State Adapter', () {
    test('records lab-only state adapter without switching the main editor', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.q86MathLiveStateAdapterRule, contains('MathLive State Adapter'));
      expect(MathProPackageContract.q86MathLiveStateAdapterRule, contains('MathEditorOutputState'));
      expect(MathLiveStateAdapterPolicy.phase, 'V172-Q86');
      expect(MathLiveStateAdapterPolicy.labOnly, isTrue);
      expect(MathLiveStateAdapterPolicy.stateAdapterImplemented, isTrue);
      expect(MathLiveStateAdapterPolicy.mainEditorSwitchAllowed, isFalse);
      expect(MathLiveStateAdapterPolicy.mathLiveVirtualKeyboardEnabled, isFalse);
      expect(MathLiveStateAdapterPolicy.officialMathLiveRuntimeBundled, isFalse);
      expect(MathLiveStateAdapterPolicy.remoteScriptLoadingAllowed, isFalse);
      expect(MathLiveStateAdapterPolicy.protectedUiSurfaceMutationAllowed, isFalse);
    });

    test('parses V172-Q86 JSON bridge state into editor-neutral output state', () {
      final snapshot = MathLiveStateAdapter.parseBridgeMessage(jsonEncode(<String, Object?>{
        'latex': r'\frac{}{}',
        'normalizedLatex': r'\frac{}{}',
        'plainText': '□/□',
        'mathJson': <String, Object?>{'fn': 'Divide'},
        'runtime': 'q84-isolated-lab-bootstrap-no-real-mathlive-runtime',
        'keyboardBridgePhase': 'V172-Q85',
        'stateAdapterPhase': 'V172-Q86',
        'lastCommandLabel': '□/□',
        'lastCommandAction': 'insertLatex',
        'evaluateRequested': false,
        'hasFocus': true,
        'selectionDescription': 'q86-lab-command-state',
        'realMathLiveRuntimeBundled': false,
        'virtualKeyboardEnabled': false,
        'remoteScriptLoadingAllowed': false,
        'mainEditorSwitchAllowed': false,
      }));
      expect(snapshot.normalizedLatex, r'\frac{}{}');
      expect(snapshot.plainText, '□/□');
      expect(snapshot.keyboardBridgePhase, 'V172-Q85');
      expect(snapshot.lastCommandAction, 'insertLatex');
      expect(snapshot.parseDiagnostic, 'q86-json-state-adapter');
      expect(snapshot.isSafeForLabOnlyConsumption, isTrue);

      final output = MathLiveStateAdapter.toMathEditorOutputState(snapshot);
      expect(output, isA<MathEditorOutputState>());
      expect(output.latex, r'\frac{}{}');
      expect(output.plainText, '□/□');
      expect(output.hasFocus, isTrue);
      expect(output.engineDiagnostic, 'q86-json-state-adapter');
    });

    test('keeps raw LaTeX compatibility but still refuses main-editor switch', () {
      final snapshot = MathLiveStateAdapter.parseBridgeMessage(r'\sqrt{}');
      expect(snapshot.normalizedLatex, r'\sqrt{}');
      expect(snapshot.plainText, '√□');
      expect(snapshot.parseDiagnostic, 'q86-raw-latex-compatibility-message');
      expect(
        MathLiveStateAdapterPolicy.canConsumeBridgeState(
          labScreenOpen: true,
          usesRemoteScripts: false,
          protectedSurfacesUnchanged: true,
        ),
        isTrue,
      );
      expect(
        MathLiveStateAdapterPolicy.mayFeedMathProRuntime(
          officialRuntimeBundled: false,
          bridgeStateValid: true,
          realDeviceFocusPasses: true,
          protectedSurfacesUnchanged: true,
        ),
        isFalse,
      );
    });

    test('keeps Q86 state adapter inside local lab assets and metadata', () {
      final bridge = File('assets/mathlive/mathlive_bridge.js').readAsStringSync();
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final pubspec = File('pubspec.yaml').readAsStringSync();
      expect(bridge, contains('stateAdapterPhase: \'V172-Q86\''));
      expect(bridge, contains('JSON.stringify(getState())'));
      expect(bridge, contains('normalizedLatex'));
      expect(bridge, contains('plainText'));
      expect(manifest, contains('"stateAdapterPhase": "V172-Q86"'));
      expect(manifest, contains('"stateAdapterLabOnly": true'));
      expect(pubspec, contains(MathProPackageContract.pubspecDescription));
      expect(bridge, isNot(contains('http://')));
      expect(bridge, isNot(contains('https://')));
    });

    testWidgets('lab screen advertises Q86 state adapter only in isolated lab surface', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: MathLiveLabScreen()));
      await tester.pump();
      expect(find.textContaining('Q86'), findsWidgets);
      expect(find.textContaining('state adapter'), findsWidgets);
      expect(find.textContaining('Main editor switch: disabled'), findsOneWidget);
    });
  });
}
