import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/math_editor_adapter.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/math_editor_engine_switch_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_cursor_court_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q88 Main Editor Engine Switch Behind Flag', () {
    test('records Q88 as a rollback-safe flag gate, not a default MathLive switch', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.q88MainEditorEngineSwitchRule, contains('Main Editor Engine Switch'));
      expect(MathEditorEngineSwitchPolicy.phase, 'V172-Q88');
      expect(MathEditorEngineSwitchPolicy.featureFlagImplemented, isTrue);
      expect(MathEditorEngineSwitchPolicy.defaultEngine, MathEditorEngineKind.legacyFlutterSlotEditor);
      expect(MathEditorEngineSwitchPolicy.rollbackEngine, MathEditorEngineKind.legacyFlutterSlotEditor);
      expect(MathEditorEngineSwitchPolicy.candidateEngine, MathEditorEngineKind.mathLive);
      expect(MathEditorEngineSwitchPolicy.mathLiveMainEditorEnabledByDefault, isFalse);
      expect(MathEditorEngineSwitchPolicy.mainEditorSwitchedToMathLive, isFalse);
      expect(MathEditorEngineSwitchPolicy.legacyFallbackAvailable, isTrue);
      expect(MathEditorEngineSwitchPolicy.protectedUiSurfaceMutationAllowed, isFalse);
      expect(MathEditorEngineSwitchPolicy.fakeMathLivePassClaimAllowed, isFalse);
    });

    test('keeps legacy engine selected when no MathLive flag is enabled', () {
      final selection = MathEditorEngineSwitchPolicy.resolveEngine(
        requestedEngine: MathEditorEngineKind.mathLive,
        mathLiveFlagEnabled: false,
        q87CourtPassed: true,
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
      expect(selection.switchAllowed, isFalse);
      expect(selection.fallbackUsed, isTrue);
      expect(selection.selectedEngine, MathEditorEngineKind.legacyFlutterSlotEditor);
      expect(selection.diagnostic, 'q88-mathlive-switch-blocked-legacy-fallback');
      expect(selection.issues, contains('mathlive editor feature flag is disabled'));
    });

    test('blocks MathLive main editor switch until Q87 court and adapters are proven', () {
      final selection = MathEditorEngineSwitchPolicy.resolveEngine(
        requestedEngine: MathEditorEngineKind.mathLive,
        mathLiveFlagEnabled: true,
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
      expect(selection.switchAllowed, isFalse);
      expect(selection.selectedLegacy, isTrue);
      expect(selection.issues, contains('Q87 MathLive cursor court has not passed'));
      expect(selection.issues, contains('official MathLive runtime is not bundled'));
      expect(selection.issues, contains('Graph/History/Solution adapters are not ready'));
    });

    test('allows MathLive selection only behind flag after all proof gates pass', () {
      final selection = MathEditorEngineSwitchPolicy.resolveEngine(
        requestedEngine: MathEditorEngineKind.mathLive,
        mathLiveFlagEnabled: true,
        q87CourtPassed: true,
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
      expect(selection.switchAllowed, isTrue);
      expect(selection.selectedMathLive, isTrue);
      expect(selection.fallbackUsed, isFalse);
      expect(selection.diagnostic, 'q88-mathlive-switch-allowed-behind-flag');
      expect(selection.issues, isEmpty);
    });

    test('Q87 verdict alone cannot switch if Q88 rollback or Graph/History/Solution gates are missing', () {
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
        passedScenarios: 22,
        totalScenarios: 22,
        blockingFailures: 0,
      );
      final selection = MathEditorEngineSwitchPolicy.resolveFromCourtVerdict(
        verdict: verdict,
        mathLiveFlagEnabled: true,
        graphHistorySolutionAdaptersReady: false,
        rollbackFlagAvailable: false,
        officialRuntimeBundled: true,
        labRunsOnDevice: true,
        keyboardBridgePasses: true,
        stateAdapterPasses: true,
        protectedSurfacesUnchanged: true,
        virtualKeyboardDisabled: true,
        remoteScriptsDisabled: true,
      );
      expect(verdict.status, 'PASS');
      expect(selection.switchAllowed, isFalse);
      expect(selection.selectedLegacy, isTrue);
      expect(selection.issues, contains('Graph/History/Solution adapters are not ready'));
      expect(selection.issues, contains('rollback flag is not available'));
    });

    test('keeps Q88 switch metadata local and aligned with package identity', () {
      final bridge = File('assets/mathlive/mathlive_bridge.js').readAsStringSync();
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final pubspec = File('pubspec.yaml').readAsStringSync();
      expect(bridge, contains("engineSwitchPhase: 'V172-Q88'"));
      expect(bridge, contains('mainEditorSwitchBehindFlag: true'));
      expect(bridge, contains('activeMainEditorEngine: \'legacyFlutterSlotEditor\''));
      expect(manifest, contains('"engineSwitchPhase": "V172-Q88"'));
      expect(manifest, contains('"mainEditorSwitchBehindFlag": true'));
      expect(manifest, contains('"defaultMainEditorEngine": "legacyFlutterSlotEditor"'));
      expect(pubspec, contains(MathProPackageContract.pubspecDescription));
      expect(bridge, isNot(contains('http://')));
      expect(bridge, isNot(contains('https://')));
    });
  });
}
