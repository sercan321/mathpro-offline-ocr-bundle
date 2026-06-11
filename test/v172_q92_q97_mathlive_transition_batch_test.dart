import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/legacy_cursor_main_path_retirement_policy.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/legacy_cursor_physical_cleanup_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_graph_history_solution_adapter_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_main_editor_flag_activation_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_real_device_cursor_court_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_runtime_evidence_closure_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_state_adapter.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/post_cleanup_regression_court_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q92..Q97 MathLive transition batch guard', () {
    test('Q92 builds Graph/History/Solution envelope without UI mutation or main-editor switch', () {
      final snapshot = MathLiveEditorStateSnapshot.fromLatex(r'x^{2}');
      final envelope = MathLiveGraphHistorySolutionAdapterPolicy.buildEnvelope(snapshot);

      expect(MathLiveGraphHistorySolutionAdapterPolicy.phase, 'V172-Q92');
      expect(MathLiveGraphHistorySolutionAdapterPolicy.graphUiMutationAllowed, isFalse);
      expect(MathLiveGraphHistorySolutionAdapterPolicy.historyUiMutationAllowed, isFalse);
      expect(MathLiveGraphHistorySolutionAdapterPolicy.solutionUiMutationAllowed, isFalse);
      expect(MathLiveGraphHistorySolutionAdapterPolicy.mainEditorSwitchAllowed, isFalse);
      expect(MathLiveGraphHistorySolutionAdapterPolicy.physicalLegacyDeletionAllowed, isFalse);
      expect(envelope.normalizedExpression, 'x^2');
      expect(envelope.historyInputMethod, 'mathlive');
      expect(envelope.hasHistoryPayload, isTrue);
      expect(envelope.hasSolutionPayload, isTrue);
      expect(envelope.graphEligibilityKind, 'graphableExplicit');
      expect(envelope.isGraphCandidate, isTrue);
    });

    test('Q92 refuses readiness when Q91 evidence closure is still blocked', () {
      final q91Blocked = MathLiveRuntimeEvidenceClosurePolicy.evaluate(
        userReportedLabWorksOnRealDevice: true,
        officialRuntimeInstallVerified: false,
        canonicalSmokeEvidencePresent: false,
        canonicalSmokeEvidenceVerified: false,
        remoteScriptsDisabled: true,
        virtualKeyboardDisabled: true,
        mainEditorStillLegacy: true,
        protectedSurfacesUnchanged: true,
        fakeCursorPassClaimAbsent: true,
      );
      final q92 = MathLiveGraphHistorySolutionAdapterPolicy.evaluateReadiness(
        q91Verdict: q91Blocked,
        adapterPolicyPresent: true,
        latexNormalizerPresent: true,
        graphBridgePresent: true,
        historyEnvelopePresent: true,
        solutionEnvelopePresent: true,
        protectedSurfacesUnchanged: true,
        noGraphHistorySolutionUiMutation: true,
        noMainEditorSwitch: true,
      );

      expect(q92.status, 'BLOCKED_MATHLIVE_GHS_ADAPTER_HARDENING');
      expect(q92.adapterReadyForFlaggedMainEditor, isFalse);
      expect(q92.maySwitchMainEditor, isFalse);
      expect(q92.mayDeleteLegacyCursor, isFalse);
      expect(q92.mayClaimCursorPass, isFalse);
      expect(q92.issues, contains('Q91 runtime/evidence closure has not verified'));
    });

    test('Q93 stays behind explicit flag and never enables MathLive by default', () {
      const q92Ready = MathLiveGraphHistorySolutionAdapterReadiness(
        status: 'MATHLIVE_GHS_ADAPTER_READY_FOR_Q93_FLAG',
        issues: <String>[],
        adapterReadyForFlaggedMainEditor: true,
        maySwitchMainEditor: false,
        mayDeleteLegacyCursor: false,
        mayClaimCursorPass: false,
      );
      final q93 = MathLiveMainEditorFlagActivationPolicy.evaluate(
        userExplicitlyEnabledFlag: false,
        q91EvidenceClosed: true,
        q92Readiness: q92Ready,
        officialRuntimeVerified: true,
        rollbackAvailable: true,
        protectedSurfacesUnchanged: true,
        virtualKeyboardDisabled: true,
        remoteScriptsDisabled: true,
        mainWorkspaceMountRequested: true,
      );

      expect(MathLiveMainEditorFlagActivationPolicy.phase, 'V172-Q93');
      expect(MathLiveMainEditorFlagActivationPolicy.mathLiveEnabledByDefault, isFalse);
      expect(q93.status, 'BLOCKED_MATHLIVE_MAIN_EDITOR_FLAG');
      expect(q93.selectedEngine, 'legacyFlutterSlotEditor');
      expect(q93.mathLiveEnabledByDefault, isFalse);
      expect(q93.mayDeleteLegacyCursor, isFalse);
    });

    test('Q94 cannot claim cursor PASS without full real-device court evidence', () {
      final q94 = MathLiveRealDeviceCursorCourtPolicy.evaluate(
        flutterAnalyzePassed: false,
        flutterTestPassed: false,
        realDeviceRunPassed: false,
        q93BehindFlagPathAvailable: false,
        protectedSurfacesUnchanged: true,
        scenarioResults: const <String, bool>{},
        blockingFailureCount: 0,
      );

      expect(MathLiveRealDeviceCursorCourtPolicy.staticPackageMayClaimPass, isFalse);
      expect(MathLiveRealDeviceCursorCourtPolicy.requiredScenarios.length, 12);
      expect(q94.status, 'BLOCKED_MATHLIVE_REAL_DEVICE_CURSOR_COURT');
      expect(q94.mayClaimMathLiveCursorPass, isFalse);
      expect(q94.mayRetireLegacyMainPath, isFalse);
      expect(q94.mayDeleteLegacyCursorPhysically, isFalse);
    });

    test('Q95 and Q96 keep legacy deletion blocked until Q94 and explicit cleanup approval exist', () {
      const q93Blocked = MathLiveMainEditorFlagActivationVerdict(
        status: 'BLOCKED_MATHLIVE_MAIN_EDITOR_FLAG',
        issues: <String>['flag missing'],
        selectedEngine: 'legacyFlutterSlotEditor',
        mayMountMathLiveInMainWorkspaceBehindFlag: false,
        mathLiveEnabledByDefault: false,
        legacyRollbackAvailable: true,
        mayDeleteLegacyCursor: false,
        mayClaimCursorPass: false,
      );
      const q94Blocked = MathLiveRealDeviceCursorCourtVerdict(
        status: 'BLOCKED_MATHLIVE_REAL_DEVICE_CURSOR_COURT',
        issues: <String>['device evidence missing'],
        passCount: 0,
        requiredCount: 12,
        mayClaimMathLiveCursorPass: false,
        mayRetireLegacyMainPath: false,
        mayDeleteLegacyCursorPhysically: false,
      );
      final q95 = LegacyCursorMainPathRetirementPolicy.evaluate(
        q93Verdict: q93Blocked,
        q94Verdict: q94Blocked,
        graphHistorySolutionAdaptersReady: false,
        rollbackAvailable: true,
        protectedSurfacesUnchanged: true,
        noPhysicalDeletionAttempted: true,
      );
      final q96 = LegacyCursorPhysicalCleanupPolicy.evaluate(
        q95Verdict: q95,
        cleanupApprovedExplicitly: false,
        rollbackNoLongerRequiredByContract: false,
        postRetirementSoakPassed: false,
        protectedSurfacesUnchanged: true,
        deletionManifestReviewed: true,
      );

      expect(q95.status, 'BLOCKED_LEGACY_CURSOR_MAIN_PATH_RETIREMENT');
      expect(q95.physicalDeletionAllowed, isFalse);
      expect(q96.status, 'BLOCKED_LEGACY_CURSOR_PHYSICAL_CLEANUP');
      expect(q96.physicalCleanupAllowed, isFalse);
      expect(q96.protectedFilesMayBeDeleted, isFalse);
    });

    test('Q97 final court requires real Flutter and real-device evidence', () {
      final q97 = PostCleanupRegressionCourtPolicy.evaluate(
        flutterPubGetPassed: false,
        flutterAnalyzePassed: false,
        flutterTestPassed: false,
        mainAppRealDeviceRunPassed: false,
        mathLiveLabRealDeviceRunPassed: false,
        keyboardContractPreserved: true,
        moreLongPressAnsEnterEqualsPreserved: true,
        graphWorks: false,
        historyWorks: false,
        solutionInputWorks: false,
        noLegacyCursorOverlayVisibleOnMathLivePath: false,
        rollbackFlagWorks: false,
        packageHygieneClean: true,
      );

      expect(PostCleanupRegressionCourtPolicy.staticPackageMayClaimFinalPass, isFalse);
      expect(q97.status, 'BLOCKED_POST_CLEANUP_REGRESSION_COURT');
      expect(q97.finalReleaseCandidate, isFalse);
      expect(q97.mayClaimPostCleanupPass, isFalse);
    });

    test('metadata and audits contain Q92-Q97 transition markers', () {
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final readme = File('README.md').readAsStringSync();
      final audit = File('docs/audit/V172_Q92_Q97_MATHLIVE_TRANSITION_BATCH_AUDIT_REPORT.md').readAsStringSync();
      final changed = File('docs/audit/V172_Q92_Q97_CHANGED_FILES_MANIFEST.md').readAsStringSync();

      expect(MathProPackageContract.readmeTitle, contains('V172-Q92 MathLive GHS Adapter'));
      expect(MathProPackageContract.readmeTitle, contains('V172-Q97 Post Cleanup Regression Court'));
      expect(MathProPackageContract.q92MathLiveGraphHistorySolutionAdapterRule, contains('V172-Q92'));
      expect(MathProPackageContract.q97PostCleanupRegressionCourtRule, contains('V172-Q97'));
      expect(manifest, contains('"q92GraphHistorySolutionAdapterPhase": "V172-Q92"'));
      expect(manifest, contains('"q93MathLiveMainEditorFlagPhase": "V172-Q93"'));
      expect(manifest, contains('"q94RealDeviceMathLiveCursorCourtPhase": "V172-Q94"'));
      expect(manifest, contains('"q95LegacyCursorMainPathRetirementPhase": "V172-Q95"'));
      expect(manifest, contains('"q96LegacyCursorPhysicalCleanupPhase": "V172-Q96"'));
      expect(manifest, contains('"q97PostCleanupRegressionCourtPhase": "V172-Q97"'));
      expect(manifest, contains('"q96PhysicalCleanupPerformedInThisPackage": false'));
      expect(readme, contains('V172-Q92..Q97 MathLive Transition Batch'));
      expect(audit, contains('No fake device PASS'));
      expect(changed, contains('Protected files intentionally untouched'));
    });
  });
}
