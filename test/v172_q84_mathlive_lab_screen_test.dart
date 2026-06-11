import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_lab_screen.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_lab_screen_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_offline_asset_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q84 MathLive Lab Screen', () {
    test('records isolated lab screen without switching the main editor', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.q84MathLiveLabScreenRule, contains('Q84 creates an isolated MathLiveLabScreen shell'));
      expect(MathProPackageContract.q84MathLiveLabScreenRule, contains('MathLiveLabScreen'));
      expect(MathProPackageContract.q84MathLiveLabScreenRule, contains('static fallback in flutter tests'));
      expect(MathLiveLabScreenPolicy.phase, 'V172-Q84');
      expect(MathLiveLabScreenPolicy.labScreenImplemented, isTrue);
      expect(MathLiveLabScreenPolicy.isolatedLabOnly, isTrue);
      expect(MathLiveLabScreenPolicy.mainEditorSwitchAllowed, isFalse);
      expect(MathLiveLabScreenPolicy.mathLiveVirtualKeyboardEnabled, isFalse);
      expect(MathLiveLabScreenPolicy.cdnDependencyAllowed, isFalse);
      expect(MathLiveLabScreenPolicy.remoteScriptLoadingAllowed, isFalse);
      expect(MathLiveLabScreenPolicy.realMathLiveRuntimeBundled, isFalse);
      expect(MathLiveLabScreenPolicy.realDeviceMathLiveCursorPassClaimed, isFalse);
    });

    test('keeps local asset bridge and forbids remote scripts', () {
      final index = File(MathLiveLabScreenPolicy.webViewAssetPath).readAsStringSync();
      final bridge = File(MathLiveOfflineAssetPolicy.bridgeJsAsset).readAsStringSync();
      final manifest = File(MathLiveOfflineAssetPolicy.manifestAsset).readAsStringSync();
      expect(index, contains('mathlive_bridge.js'));
      expect(index, contains('V172-Q84'));
      expect(index, isNot(contains('http://')));
      expect(index, isNot(contains('https://')));
      expect(bridge, contains('MathProMathLiveOfflineBridge'));
      expect(bridge, contains("phase: 'V172-Q84'"));
      expect(bridge, contains('insertLatex'));
      expect(bridge, contains('realMathLiveRuntimeBundled: false'));
      expect(manifest, contains('"phase": "V172-Q84"'));
      expect(manifest, contains('"mainEditorSwitchAllowed": false'));
    });

    test('policy blocks real MathLive cursor PASS until official runtime and court evidence exist', () {
      expect(
        MathLiveLabScreenPolicy.canOpenLab(
          offlineAssetsDeclared: true,
          usesRemoteScripts: false,
          protectedSurfacesUnchanged: true,
        ),
        isTrue,
      );
      expect(
        MathLiveLabScreenPolicy.mayClaimRealMathLiveCursorPass(
          officialRuntimeBundled: false,
          labRunsOnDevice: true,
          cursorCourtPasses: true,
          keyboardBridgePasses: true,
        ),
        isFalse,
      );
    });

    testWidgets('renders isolated static lab fallback during flutter tests', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: MathLiveLabScreen()));
      await tester.pump();
      expect(find.byKey(const ValueKey('mathlive-lab-title')), findsOneWidget);
      expect(find.byKey(const ValueKey('mathlive-lab-red-lines')), findsOneWidget);
      expect(find.byKey(const ValueKey('mathlive-lab-static-fallback')), findsOneWidget);
      expect(find.byKey(const ValueKey('mathlive-lab-seed-fraction')), findsOneWidget);
      expect(find.text('MathLive Lab'), findsOneWidget);
    });
  });
}
