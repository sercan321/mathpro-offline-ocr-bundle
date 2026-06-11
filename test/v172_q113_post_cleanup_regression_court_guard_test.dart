import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/post_cleanup_regression_court_guard_policy.dart';

void main() {
  test('V172-Q113 creates post-cleanup regression guard without claiming final PASS', () {
    final readiness = PostCleanupRegressionCourtGuardPolicy.evaluateReadiness(
      q112ExecutionGuardPackageReady: true,
      q112EvidenceCompleteForPhysicalCleanupExecution: false,
      approvedCleanupActuallyExecuted: false,
      cleanupDeltaManifestPresent: false,
      flutterPubGetPassed: false,
      flutterAnalyzePassed: false,
      flutterTestPassed: false,
      mathLiveLabRealDeviceRunPassed: false,
      mainAppRealDeviceRunPassed: false,
      q108RealDeviceCursorCourtPassed: false,
      graphWorks: false,
      historyWorks: false,
      solutionInputWorks: false,
      noLegacyCursorOverlayVisibleOnMathLivePath: false,
      rollbackFlagWorks: false,
      protectedSurfacesUnchanged: true,
      packageHygieneClean: true,
      noFakeEvidence: true,
      explicitReleaseApprovalApproved: false,
    );

    expect(PostCleanupRegressionCourtGuardPolicy.phase, 'V172-Q113');
    expect(readiness.packageSideRegressionGuardReady, isTrue);
    expect(readiness.evidenceCompleteForPostCleanupRegressionCourt, isFalse);
    expect(readiness.postCleanupRegressionExecutedInThisPackage, isFalse);
    expect(readiness.physicalCleanupAssumedCompleteInThisPackage, isFalse);
    expect(readiness.finalReleaseCandidateClaimAllowedInThisPackage, isFalse);
    expect(readiness.mayClaimPostCleanupPassNow, isFalse);
    expect(readiness.mayClaimCursorPassNow, isFalse);
    expect(readiness.maySwitchMathLiveDefaultEditorNow, isFalse);
    expect(readiness.mayDeleteLegacyCursorNow, isFalse);
    expect(readiness.protectedUiSurfaceMutationAllowed, isFalse);
  });

  test('V172-Q113 only opens release review after every post-cleanup evidence gate is real', () {
    final readiness = PostCleanupRegressionCourtGuardPolicy.evaluateReadiness(
      q112ExecutionGuardPackageReady: true,
      q112EvidenceCompleteForPhysicalCleanupExecution: true,
      approvedCleanupActuallyExecuted: true,
      cleanupDeltaManifestPresent: true,
      flutterPubGetPassed: true,
      flutterAnalyzePassed: true,
      flutterTestPassed: true,
      mathLiveLabRealDeviceRunPassed: true,
      mainAppRealDeviceRunPassed: true,
      q108RealDeviceCursorCourtPassed: true,
      graphWorks: true,
      historyWorks: true,
      solutionInputWorks: true,
      noLegacyCursorOverlayVisibleOnMathLivePath: true,
      rollbackFlagWorks: true,
      protectedSurfacesUnchanged: true,
      packageHygieneClean: true,
      noFakeEvidence: true,
      explicitReleaseApprovalApproved: true,
    );

    expect(readiness.status, 'POST_CLEANUP_REGRESSION_COURT_READY_FOR_RELEASE_REVIEW');
    expect(readiness.evidenceCompleteForPostCleanupRegressionCourt, isTrue);
    expect(readiness.finalReleaseCandidateClaimAllowedInThisPackage, isFalse);
    expect(readiness.mayClaimPostCleanupPassNow, isFalse);
    expect(readiness.mayClaimPhotomathWolframLevelNow, isFalse);
  });
}
