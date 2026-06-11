import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_cursor_court_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q87 MathLive Cursor Court / Runtime Proof Gate', () {
    test('records Q87 as a blocked proof gate, not as a main editor switch', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.q87MathLiveCursorCourtRule, contains('MathLive Cursor Court'));
      expect(MathProPackageContract.q87MathLiveCursorCourtRule, contains('20/22'));
      expect(MathLiveCursorCourtPolicy.phase, 'V172-Q87');
      expect(MathLiveCursorCourtPolicy.labOnly, isTrue);
      expect(MathLiveCursorCourtPolicy.mainEditorSwitchAllowed, isFalse);
      expect(MathLiveCursorCourtPolicy.mainEditorSwitchAllowedBeforeCourt, isFalse);
      expect(MathLiveCursorCourtPolicy.officialMathLiveRuntimeBundled, isFalse);
      expect(MathLiveCursorCourtPolicy.mathLiveVirtualKeyboardEnabled, isFalse);
      expect(MathLiveCursorCourtPolicy.remoteScriptLoadingAllowed, isFalse);
      expect(MathLiveCursorCourtPolicy.protectedUiSurfaceMutationAllowed, isFalse);
      expect(MathLiveCursorCourtPolicy.realDeviceMathLiveCursorPassClaimed, isFalse);
      expect(MathLiveCursorCourtPolicy.photomathLevelClaimAllowedWithoutEvidence, isFalse);
    });

    test('keeps a complete manual cursor scenario court without fake pass claims', () {
      expect(MathLiveCursorCourtPolicy.requiredScenarioCount, 22);
      expect(MathLiveCursorCourtPolicy.minimumPassingScenarios, 20);
      expect(MathLiveCursorCourtPolicy.maximumBlockingFailures, 0);
      expect(MathLiveCursorCourtPolicy.scenarioListIsComplete, isTrue);
      expect(
        MathLiveCursorCourtPolicy.requiredScenarios.map((scenario) => scenario.id),
        containsAll(<String>[
          'fraction-numerator-denominator',
          'sqrt-body',
          'log-base-argument',
          'function-argument-sin300',
          'integral-differential',
          'android-focus-retention',
          'protected-surfaces-unchanged',
        ]),
      );
    });

    test('blocks PASS when official runtime or real-device evidence is missing', () {
      final verdict = MathLiveCursorCourtPolicy.evaluateEvidence(
        flutterAnalyzePassed: true,
        flutterTestPassed: true,
        flutterRunOnDevicePassed: true,
        officialRuntimeBundled: false,
        labRunsOnDevice: true,
        keyboardBridgePasses: true,
        stateAdapterValid: true,
        virtualKeyboardDisabled: true,
        remoteScriptsDisabled: true,
        protectedSurfacesUnchanged: true,
        passedScenarios: 22,
        totalScenarios: 22,
        blockingFailures: 0,
      );
      expect(verdict.status, 'BLOCKED');
      expect(verdict.isBlocked, isTrue);
      expect(verdict.mayClaimMathLiveCursorPass, isFalse);
      expect(verdict.maySwitchMainEditorToMathLive, isFalse);
      expect(verdict.issues, contains('official MathLive runtime is not bundled'));
    });

    test('allows cursor PASS only after full evidence but still does not switch the main editor by itself', () {
      final verdict = MathLiveCursorCourtPolicy.evaluateEvidence(
        flutterAnalyzePassed: true,
        flutterTestPassed: true,
        flutterRunOnDevicePassed: true,
        officialRuntimeBundled: true,
        labRunsOnDevice: true,
        keyboardBridgePasses: true,
        stateAdapterValid: true,
        virtualKeyboardDisabled: true,
        remoteScriptsDisabled: true,
        protectedSurfacesUnchanged: true,
        passedScenarios: 20,
        totalScenarios: 22,
        blockingFailures: 0,
      );
      expect(verdict.status, 'PASS');
      expect(verdict.mayClaimMathLiveCursorPass, isTrue);
      expect(verdict.maySwitchMainEditorToMathLive, isFalse);
      expect(
        MathLiveCursorCourtPolicy.maySwitchMainEditorAfterCourt(
          courtPassed: true,
          graphHistorySolutionAdaptersReady: false,
          rollbackFlagAvailable: true,
        ),
        isFalse,
      );
    });

    test('keeps Q87 proof gate inside local lab assets and metadata', () {
      final bridge = File('assets/mathlive/mathlive_bridge.js').readAsStringSync();
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final index = File('assets/mathlive/index.html').readAsStringSync();
      final pubspec = File('pubspec.yaml').readAsStringSync();
      expect(bridge, contains("cursorCourtPhase: 'V172-Q87'"));
      expect(bridge, contains('realDeviceCursorCourtPassClaimed: false'));
      expect(manifest, contains('"cursorCourtPhase": "V172-Q87"'));
      expect(manifest, contains('"realDeviceCursorCourtPassClaimed": false'));
      expect(manifest, contains('"mainEditorSwitchBlockedUntilCursorCourtPasses": true'));
      expect(index, contains('V172-Q87'));
      expect(pubspec, contains(MathProPackageContract.pubspecDescription));
      expect(bridge, isNot(contains('http://')));
      expect(bridge, isNot(contains('https://')));
      expect(index, isNot(contains('http://')));
      expect(index, isNot(contains('https://')));
    });
  });
}
