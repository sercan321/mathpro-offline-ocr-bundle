import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/legacy_cursor_post_cleanup_regression_court_guard_v172_q123_policy.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/release_freeze_final_review_guard_v172_q124_policy.dart';

void main() {
  test('V172-Q124 blocks release-freeze final review without real Q123 post-cleanup evidence', () {
    final readiness = ReleaseFreezeFinalReviewGuardV172Q124Policy.evaluateReadiness(
      q123PostCleanupRegressionGuardPackageReady: true,
      q123PostCleanupRegressionEvidenceComplete: false,
      q123HumanReviewApproved: false,
      flutterPubGetPassed: false,
      flutterAnalyzePassed: false,
      flutterTestPassed: false,
      mathLiveLabDeviceRunCaptured: false,
      mainAppDeviceRunCaptured: false,
      q108Q116CursorCourtPassed: false,
      graphRuntimeEvidencePassed: false,
      historyRuntimeEvidencePassed: false,
      solutionRuntimeEvidencePassed: false,
      rollbackVerificationPassed: false,
      protectedSurfacesUnchanged: true,
      keyboardUntouched: true,
      moreUntouched: true,
      longPressUntouched: true,
      appShellUntouched: true,
      graphHistorySolutionUiUntouched: true,
      packageHygieneClean: true,
      zipIntegrityVerified: true,
      freshExtractVerified: true,
      noStaleNestedArtifacts: true,
      primaryZipNameLocked: true,
      noDefaultEditorSwitchInThisPackage: true,
      noMainWorkspaceMountInThisPackage: true,
      noLegacyRetirementInThisPackage: true,
      noPhysicalLegacyDeletionInThisPackage: true,
      noRuntimeBehaviorChangeInThisPackage: true,
      noFakeRuntimeEvidence: true,
      noFakeDeviceEvidence: true,
      noFakeReleaseEvidence: true,
      explicitReleaseFreezeApproval: false,
    );

    expect(ReleaseFreezeFinalReviewGuardV172Q124Policy.phase, 'V172-Q124');
    expect(
      ReleaseFreezeFinalReviewGuardV172Q124Policy.prerequisitePostCleanupRegressionPhase,
      LegacyCursorPostCleanupRegressionCourtGuardV172Q123Policy.phase,
    );
    expect(readiness.packageSideReleaseFreezeFinalReviewGuardReady, isTrue);
    expect(readiness.releaseFreezeFinalReviewEvidenceComplete, isFalse);
    expect(readiness.mayOpenReleaseFreezeFinalReview, isFalse);
    expect(readiness.mayClaimReleasePass, isFalse);
    expect(readiness.mayClaimCursorPass, isFalse);
    expect(readiness.mayDeleteLegacyCursorNow, isFalse);
    expect(readiness.protectedUiSurfaceMutationAllowed, isFalse);
  });

  test('V172-Q124 only opens later human approval when every release prerequisite is real', () {
    final readiness = ReleaseFreezeFinalReviewGuardV172Q124Policy.evaluateReadiness(
      q123PostCleanupRegressionGuardPackageReady: true,
      q123PostCleanupRegressionEvidenceComplete: true,
      q123HumanReviewApproved: true,
      flutterPubGetPassed: true,
      flutterAnalyzePassed: true,
      flutterTestPassed: true,
      mathLiveLabDeviceRunCaptured: true,
      mainAppDeviceRunCaptured: true,
      q108Q116CursorCourtPassed: true,
      graphRuntimeEvidencePassed: true,
      historyRuntimeEvidencePassed: true,
      solutionRuntimeEvidencePassed: true,
      rollbackVerificationPassed: true,
      protectedSurfacesUnchanged: true,
      keyboardUntouched: true,
      moreUntouched: true,
      longPressUntouched: true,
      appShellUntouched: true,
      graphHistorySolutionUiUntouched: true,
      packageHygieneClean: true,
      zipIntegrityVerified: true,
      freshExtractVerified: true,
      noStaleNestedArtifacts: true,
      primaryZipNameLocked: true,
      noDefaultEditorSwitchInThisPackage: true,
      noMainWorkspaceMountInThisPackage: true,
      noLegacyRetirementInThisPackage: true,
      noPhysicalLegacyDeletionInThisPackage: true,
      noRuntimeBehaviorChangeInThisPackage: true,
      noFakeRuntimeEvidence: true,
      noFakeDeviceEvidence: true,
      noFakeReleaseEvidence: true,
      explicitReleaseFreezeApproval: true,
    );

    expect(readiness.status, 'Q124_RELEASE_FREEZE_FINAL_REVIEW_READY_FOR_HUMAN_APPROVAL');
    expect(readiness.releaseFreezeFinalReviewEvidenceComplete, isTrue);
    expect(readiness.mayOpenReleaseFreezeFinalReview, isTrue);
    expect(readiness.mayClaimReleasePass, isFalse);
    expect(readiness.mayDeleteLegacyCursorNow, isFalse);
    expect(readiness.maySwitchDefaultEditorNow, isFalse);
  });
}
