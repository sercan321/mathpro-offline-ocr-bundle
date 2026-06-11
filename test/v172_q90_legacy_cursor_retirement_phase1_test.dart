import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/legacy_cursor_retirement_policy.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/math_editor_adapter.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/math_editor_engine_switch_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_cursor_court_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_main_editor_integration_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q90 Legacy Cursor Retirement Phase 1 Guard', () {
    test('records Q90 as a non-deleting retirement guard', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.q90LegacyCursorRetirementPhase1Rule, contains('Legacy Cursor Retirement Phase 1'));
      expect(LegacyCursorRetirementPolicy.phase, 'V172-Q90');
      expect(LegacyCursorRetirementPolicy.phase1GuardImplemented, isTrue);
      expect(LegacyCursorRetirementPolicy.physicalLegacyDeletionAllowed, isFalse);
      expect(LegacyCursorRetirementPolicy.legacyCursorFilesMayBeDeleted, isFalse);
      expect(LegacyCursorRetirementPolicy.legacyEngineRemainsRollback, isTrue);
      expect(LegacyCursorRetirementPolicy.broadCustomCursorPatchingAllowed, isFalse);
      expect(LegacyCursorRetirementPolicy.fakeRetirementPassClaimAllowed, isFalse);
      expect(LegacyCursorRetirementPolicy.protectedUiSurfaceMutationAllowed, isFalse);
      expect(LegacyCursorRetirementPolicy.keyboardSurfaceMutationAllowed, isFalse);
    });

    test('keeps legacy active when MathLive main-editor proof is absent', () {
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
      final q89Verdict = MathLiveMainEditorIntegrationPolicy.evaluate(
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
      final verdict = LegacyCursorRetirementPolicy.evaluate(
        mainEditorVerdict: q89Verdict,
        activeEngine: MathEditorEngineKind.legacyFlutterSlotEditor,
        q89GateReady: false,
        rollbackAvailable: true,
        protectedSurfacesUnchanged: true,
        graphHistorySolutionAdaptersReady: false,
        mathLiveRuntimeOfficialAndOffline: false,
        virtualKeyboardDisabled: true,
        remoteScriptsDisabled: true,
        userExplicitlyEnabledMathLiveFlag: false,
      );
      expect(verdict.status, 'BLOCKED_KEEP_LEGACY_ACTIVE');
      expect(verdict.selectedLegacy, isTrue);
      expect(verdict.legacyDeletionAllowed, isFalse);
      expect(verdict.legacyOverlayMayBeBypassedForActiveMathLivePath, isFalse);
      expect(verdict.issues, contains('Q89 main-editor MathLive mount gate is not ready'));
      expect(verdict.issues, contains('active editor engine is not MathLive'));
      expect(verdict.issues, contains('Graph/History/Solution adapters are not ready'));
    });

    test('allows only phase-1 bypass behind a proven MathLive path, never deletion', () {
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
      final q89Verdict = MathLiveMainEditorIntegrationPolicy.evaluate(
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
      final verdict = LegacyCursorRetirementPolicy.evaluate(
        mainEditorVerdict: q89Verdict,
        activeEngine: MathEditorEngineKind.mathLive,
        q89GateReady: true,
        rollbackAvailable: true,
        protectedSurfacesUnchanged: true,
        graphHistorySolutionAdaptersReady: true,
        mathLiveRuntimeOfficialAndOffline: true,
        virtualKeyboardDisabled: true,
        remoteScriptsDisabled: true,
        userExplicitlyEnabledMathLiveFlag: true,
      );
      expect(verdict.status, 'PHASE1_BYPASS_READY_BEHIND_FLAG');
      expect(verdict.selectedEngine, MathEditorEngineKind.mathLive);
      expect(verdict.legacyOverlayMayBeBypassedForActiveMathLivePath, isTrue);
      expect(verdict.legacyHitTestMayBeBypassedForActiveMathLivePath, isTrue);
      expect(verdict.legacyDeletionAllowed, isFalse);
      expect(verdict.issues, isEmpty);
      expect(
        LegacyCursorRetirementPolicy.mayDeleteLegacyCursorFiles(
          phase1BypassProven: true,
          laterRetirementPhaseApproved: true,
          rollbackNoLongerRequiredByContract: true,
        ),
        isFalse,
      );
    });

    test('metadata stays local and aligned with Q90 package identity', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final bridge = File('assets/mathlive/mathlive_bridge.js').readAsStringSync();
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      expect(pubspec, contains(MathProPackageContract.pubspecDescription));
      expect(bridge, contains("legacyCursorRetirementPhase: 'V172-Q90'"));
      expect(bridge, contains('legacyCursorFilesMayBeDeleted: false'));
      expect(manifest, contains('"legacyCursorRetirementPhase": "V172-Q90"'));
      expect(manifest, contains('"legacyCursorFilesMayBeDeleted": false'));
      expect(bridge, isNot(contains('http://')));
      expect(bridge, isNot(contains('https://')));
      expect(manifest, isNot(contains('http://')));
      expect(manifest, isNot(contains('https://')));
    });
  });
}
