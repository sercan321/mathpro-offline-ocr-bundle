import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/release_freeze_clean_full_zip_guard_policy.dart';

void main() {
  test('V172-Q114 creates a release-freeze guard without claiming final release PASS', () {
    final readiness = ReleaseFreezeCleanFullZipGuardPolicy.evaluateReadiness(
      q113PostCleanupRegressionCourtReady: false,
      q113GuardPackageReady: true,
      flutterPubGetPassed: false,
      flutterAnalyzePassed: false,
      flutterTestPassed: false,
      mathLiveLabRealDeviceRunPassed: false,
      mainAppRealDeviceRunPassed: false,
      graphHistorySolutionRuntimeVerified: false,
      rollbackVerified: false,
      protectedSurfacesUnchanged: true,
      zipIntegrityVerified: true,
      freshExtractVerified: true,
      packageHygieneClean: true,
      noStaleArchivesInsidePackage: true,
      noPatchOnlyDelivery: true,
      finalAuditDocsPresent: true,
      noFakeEvidence: true,
      explicitReleaseFreezeApproval: false,
    );

    expect(ReleaseFreezeCleanFullZipGuardPolicy.phase, 'V172-Q114');
    expect(ReleaseFreezeCleanFullZipGuardPolicy.expectedDeliveryZipName, 'MathProFlutterPhase17.zip');
    expect(readiness.packageSideReleaseFreezeGuardReady, isTrue);
    expect(readiness.evidenceCompleteForReleaseFreezeReview, isFalse);
    expect(readiness.releaseFrozenInThisPackage, isFalse);
    expect(readiness.finalReleasePassClaimAllowedInThisPackage, isFalse);
    expect(readiness.cleanFullZipClaimAllowedWithoutFreshExtract, isFalse);
    expect(readiness.maySwitchMathLiveDefaultEditorNow, isFalse);
    expect(readiness.mayDeleteLegacyCursorNow, isFalse);
    expect(readiness.protectedUiSurfaceMutationAllowed, isFalse);
  });

  test('V172-Q114 only opens final approval review after every release-freeze evidence gate is real', () {
    final readiness = ReleaseFreezeCleanFullZipGuardPolicy.evaluateReadiness(
      q113PostCleanupRegressionCourtReady: true,
      q113GuardPackageReady: true,
      flutterPubGetPassed: true,
      flutterAnalyzePassed: true,
      flutterTestPassed: true,
      mathLiveLabRealDeviceRunPassed: true,
      mainAppRealDeviceRunPassed: true,
      graphHistorySolutionRuntimeVerified: true,
      rollbackVerified: true,
      protectedSurfacesUnchanged: true,
      zipIntegrityVerified: true,
      freshExtractVerified: true,
      packageHygieneClean: true,
      noStaleArchivesInsidePackage: true,
      noPatchOnlyDelivery: true,
      finalAuditDocsPresent: true,
      noFakeEvidence: true,
      explicitReleaseFreezeApproval: true,
    );

    expect(readiness.status, 'RELEASE_FREEZE_CLEAN_FULL_ZIP_READY_FOR_FINAL_APPROVAL');
    expect(readiness.evidenceCompleteForReleaseFreezeReview, isTrue);
    expect(readiness.releaseFrozenInThisPackage, isFalse);
    expect(readiness.finalReleasePassClaimAllowedInThisPackage, isFalse);
    expect(readiness.mayDeleteLegacyCursorNow, isFalse);
  });
}
