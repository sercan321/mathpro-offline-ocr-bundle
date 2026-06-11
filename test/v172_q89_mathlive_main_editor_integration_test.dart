import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/math_editor_adapter.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/math_editor_engine_switch_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_cursor_court_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_main_editor_integration_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q89 MathLive Main Editor Integration Guard', () {
    test('records Q89 as an integration guard without switching the main editor', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.q89MathLiveMainEditorIntegrationRule, contains('MathLive Main Editor Integration'));
      expect(MathLiveMainEditorIntegrationPolicy.phase, 'V172-Q89');
      expect(MathLiveMainEditorIntegrationPolicy.integrationGuardImplemented, isTrue);
      expect(MathLiveMainEditorIntegrationPolicy.passiveIntegrationShellAllowed, isTrue);
      expect(MathLiveMainEditorIntegrationPolicy.mainEditorIntegratedNow, isFalse);
      expect(MathLiveMainEditorIntegrationPolicy.mathLiveMountedInMainWorkspaceByDefault, isFalse);
      expect(MathLiveMainEditorIntegrationPolicy.legacyEditorRemainsDefault, isTrue);
      expect(MathLiveMainEditorIntegrationPolicy.protectedUiSurfaceMutationAllowed, isFalse);
      expect(MathLiveMainEditorIntegrationPolicy.keyboardSurfaceMutationAllowed, isFalse);
      expect(MathLiveMainEditorIntegrationPolicy.fakeMathLivePassClaimAllowed, isFalse);
    });

    test('keeps legacy selected when Q87/Q88 proof gates are absent', () {
      final q88Selection = MathEditorEngineSwitchPolicy.resolveEngine(
        requestedEngine: MathEditorEngineKind.mathLive,
        mathLiveFlagEnabled: false,
        q87CourtPassed: false,
        officialRuntimeBundled: false,
        labRunsOnDevice: false,
        keyboardBridgePasses: true,
        stateAdapterPasses: true,
        graphHistorySolutionAdaptersReady: false,
        rollbackFlagAvailable: true,
        protectedSurfacesUnchanged: true,
        virtualKeyboardDisabled: true,
        remoteScriptsDisabled: true,
      );
      final courtVerdict = MathLiveCursorCourtPolicy.evaluateEvidence(
        flutterAnalyzePassed: false,
        flutterTestPassed: false,
        flutterRunOnDevicePassed: false,
        officialRuntimeBundled: false,
        labRunsOnDevice: false,
        keyboardBridgePasses: true,
        stateAdapterValid: true,
        virtualKeyboardDisabled: true,
        remoteScriptsDisabled: true,
        protectedSurfacesUnchanged: true,
        passedScenarios: 0,
        totalScenarios: 22,
        blockingFailures: 1,
      );
      final verdict = MathLiveMainEditorIntegrationPolicy.evaluate(
        engineSelection: q88Selection,
        courtVerdict: courtVerdict,
        officialRuntimeBundled: false,
        graphHistorySolutionAdaptersReady: false,
        rollbackAvailable: true,
        protectedSurfacesUnchanged: true,
        virtualKeyboardDisabled: true,
        remoteScriptsDisabled: true,
        userExplicitlyEnabledFlag: false,
      );
      expect(verdict.status, 'BLOCKED_LEGACY_DEFAULT');
      expect(verdict.selectedLegacy, isTrue);
      expect(verdict.mainEditorMayMountMathLive, isFalse);
      expect(verdict.diagnostic, 'q89-mathlive-main-editor-integration-blocked-legacy-default');
      expect(verdict.issues, contains('MathLive main-editor flag is not explicitly enabled'));
      expect(verdict.issues, contains('Q88 engine switch has not selected MathLive'));
      expect(verdict.issues, contains('Q87 cursor court has not passed'));
    });

    test('allows future MathLive mount only when Q87 and Q88 gates are all satisfied', () {
      final courtVerdict = MathLiveCursorCourtPolicy.evaluateEvidence(
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
        passedScenarios: 22,
        totalScenarios: 22,
        blockingFailures: 0,
      );
      final q88Selection = MathEditorEngineSwitchPolicy.resolveEngine(
        requestedEngine: MathEditorEngineKind.mathLive,
        mathLiveFlagEnabled: true,
        q87CourtPassed: courtVerdict.mayClaimMathLiveCursorPass,
        officialRuntimeBundled: true,
        labRunsOnDevice: true,
        keyboardBridgePasses: true,
        stateAdapterPasses: true,
        graphHistorySolutionAdaptersReady: true,
        rollbackFlagAvailable: true,
        protectedSurfacesUnchanged: true,
        virtualKeyboardDisabled: true,
        remoteScriptsDisabled: true,
      );
      final verdict = MathLiveMainEditorIntegrationPolicy.evaluate(
        engineSelection: q88Selection,
        courtVerdict: courtVerdict,
        officialRuntimeBundled: true,
        graphHistorySolutionAdaptersReady: true,
        rollbackAvailable: true,
        protectedSurfacesUnchanged: true,
        virtualKeyboardDisabled: true,
        remoteScriptsDisabled: true,
        userExplicitlyEnabledFlag: true,
      );
      expect(verdict.status, 'READY_BEHIND_FLAG');
      expect(verdict.selectedEngine, MathEditorEngineKind.mathLive);
      expect(verdict.mainEditorMayMountMathLive, isTrue);
      expect(verdict.issues, isEmpty);
      expect(verdict.diagnostic, 'q89-mathlive-main-editor-integration-ready-behind-flag');
    });

    test('passive shell preparation is allowed but active main-editor switch stays blocked', () {
      expect(
        MathLiveMainEditorIntegrationPolicy.mayPreparePassiveShell(
          localAssetsDeclared: true,
          protectedSurfacesUnchanged: true,
          remoteScriptsDisabled: true,
        ),
        isTrue,
      );
      expect(MathLiveMainEditorIntegrationPolicy.mainEditorIntegratedNow, isFalse);
      expect(MathLiveMainEditorIntegrationPolicy.mathLiveMountedInMainWorkspaceByDefault, isFalse);
    });

    test('Q89 metadata is local, non-remote, and aligned with package identity', () {
      final bridge = File('assets/mathlive/mathlive_bridge.js').readAsStringSync();
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final pubspec = File('pubspec.yaml').readAsStringSync();
      expect(bridge, contains("mainEditorIntegrationPhase: 'V172-Q89'"));
      expect(bridge, contains('mainEditorIntegrationGuard: true'));
      expect(bridge, contains('mainEditorIntegratedNow: false'));
      expect(manifest, contains('"mainEditorIntegrationPhase": "V172-Q89"'));
      expect(manifest, contains('"mainEditorIntegrationGuard": true'));
      expect(manifest, contains('"mainEditorIntegratedNow": false'));
      expect(pubspec, contains(MathProPackageContract.pubspecDescription));
      expect(bridge, isNot(contains('http://')));
      expect(bridge, isNot(contains('https://')));
      expect(manifest, isNot(contains('http://')));
      expect(manifest, isNot(contains('https://')));
    });
  });
}
