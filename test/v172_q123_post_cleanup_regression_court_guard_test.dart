import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/legacy_cursor_physical_cleanup_execution_guard_v172_q122_policy.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/legacy_cursor_post_cleanup_regression_court_guard_v172_q123_policy.dart';

void main() {
  test('V172-Q123 blocks post-cleanup regression court without real Q122 cleanup evidence', () {
    final readiness = LegacyCursorPostCleanupRegressionCourtGuardV172Q123Policy.evaluateReadiness(
      q122ExecutionGuardPackageReady: true,
      q122ExecutionEvidenceComplete: false,
      q122HumanReviewApproved: false,
      approvedCleanupActuallyExecuted: false,
      cleanupDeltaManifestPresent: false,
      flutterPubGetPassed: false,
      flutterAnalyzePassed: false,
      flutterTestPassed: false,
      labDeviceRunCaptured: false,
      mainDeviceRunCaptured: false,
      q108RealDeviceCursorCourtPassed: false,
      graphRuntimeEvidencePassed: false,
      historyRuntimeEvidencePassed: false,
      solutionRuntimeEvidencePassed: false,
      noLegacyCursorOverlayOnMathLivePath: false,
      rollbackVerificationPassed: false,
      protectedSurfacesUnchanged: true,
      keyboardUntouched: true,
      moreUntouched: true,
      longPressUntouched: true,
      appShellUntouched: true,
      graphHistorySolutionUiUntouched: true,
      packageHygieneClean: true,
      noDefaultEditorSwitchInThisPackage: true,
      noMainWorkspaceMountInThisPackage: true,
      noLegacyRetirementInThisPackage: true,
      noPhysicalLegacyDeletionInThisPackage: true,
      noRuntimeBehaviorChangeInThisPackage: true,
      noFakeRuntimeEvidence: true,
      noFakeDeviceEvidence: true,
      noFakeCleanupEvidence: true,
      explicitPostCleanupRegressionCourtApproval: false,
    );

    expect(LegacyCursorPostCleanupRegressionCourtGuardV172Q123Policy.phase, 'V172-Q123');
    expect(
      LegacyCursorPostCleanupRegressionCourtGuardV172Q123Policy.prerequisiteCleanupExecutionPhase,
      LegacyCursorPhysicalCleanupExecutionGuardV172Q122Policy.phase,
    );
    expect(readiness.packageSidePostCleanupRegressionGuardReady, isTrue);
    expect(readiness.postCleanupRegressionEvidenceComplete, isFalse);
    expect(readiness.mayRunPostCleanupRegressionCourtReview, isFalse);
    expect(readiness.mayClaimPostCleanupPass, isFalse);
    expect(readiness.mayClaimCursorPass, isFalse);
    expect(readiness.mayClaimReleasePass, isFalse);
    expect(readiness.mayDeleteLegacyCursorNow, isFalse);
    expect(readiness.protectedUiSurfaceMutationAllowed, isFalse);
  });

  test('V172-Q123 only opens a later human review when every post-cleanup prerequisite is real', () {
    final readiness = LegacyCursorPostCleanupRegressionCourtGuardV172Q123Policy.evaluateReadiness(
      q122ExecutionGuardPackageReady: true,
      q122ExecutionEvidenceComplete: true,
      q122HumanReviewApproved: true,
      approvedCleanupActuallyExecuted: true,
      cleanupDeltaManifestPresent: true,
      flutterPubGetPassed: true,
      flutterAnalyzePassed: true,
      flutterTestPassed: true,
      labDeviceRunCaptured: true,
      mainDeviceRunCaptured: true,
      q108RealDeviceCursorCourtPassed: true,
      graphRuntimeEvidencePassed: true,
      historyRuntimeEvidencePassed: true,
      solutionRuntimeEvidencePassed: true,
      noLegacyCursorOverlayOnMathLivePath: true,
      rollbackVerificationPassed: true,
      protectedSurfacesUnchanged: true,
      keyboardUntouched: true,
      moreUntouched: true,
      longPressUntouched: true,
      appShellUntouched: true,
      graphHistorySolutionUiUntouched: true,
      packageHygieneClean: true,
      noDefaultEditorSwitchInThisPackage: true,
      noMainWorkspaceMountInThisPackage: true,
      noLegacyRetirementInThisPackage: true,
      noPhysicalLegacyDeletionInThisPackage: true,
      noRuntimeBehaviorChangeInThisPackage: true,
      noFakeRuntimeEvidence: true,
      noFakeDeviceEvidence: true,
      noFakeCleanupEvidence: true,
      explicitPostCleanupRegressionCourtApproval: true,
    );

    expect(readiness.status, 'Q123_POST_CLEANUP_REGRESSION_COURT_READY_FOR_HUMAN_REVIEW');
    expect(readiness.postCleanupRegressionEvidenceComplete, isTrue);
    expect(readiness.mayRunPostCleanupRegressionCourtReview, isTrue);
    expect(readiness.mayClaimReleasePass, isFalse);
    expect(readiness.mayDeleteLegacyCursorNow, isFalse);
    expect(readiness.maySwitchDefaultEditorNow, isFalse);
  });
}
