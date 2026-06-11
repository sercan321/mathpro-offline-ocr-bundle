import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/final_package_evidence_closure_intake_guard_v172_q125_policy.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/release_freeze_final_review_guard_v172_q124_policy.dart';

void main() {
  test('V172-Q125 blocks final evidence closure without real Q124 release-freeze evidence', () {
    final readiness = FinalPackageEvidenceClosureIntakeGuardV172Q125Policy.evaluateReadiness(
      q124ReleaseFreezeFinalReviewGuardPackageReady: true,
      q124ReleaseFreezeFinalReviewEvidenceComplete: false,
      q124HumanReviewApproved: false,
      q124ReleaseFreezeApproved: false,
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
      finalEvidenceLedgerPresent: false,
      frozenDefectLedgerPresent: false,
      touchedFilesManifestPresent: false,
      selectedVerifierReportsPresent: false,
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
      noFakeEvidenceClosure: true,
      explicitEvidenceClosureApproval: false,
    );

    expect(FinalPackageEvidenceClosureIntakeGuardV172Q125Policy.phase, 'V172-Q125');
    expect(
      FinalPackageEvidenceClosureIntakeGuardV172Q125Policy.prerequisiteReleaseFreezeFinalReviewPhase,
      ReleaseFreezeFinalReviewGuardV172Q124Policy.phase,
    );
    expect(readiness.packageSideFinalPackageEvidenceClosureIntakeGuardReady, isTrue);
    expect(readiness.finalPackageEvidenceClosureComplete, isFalse);
    expect(readiness.mayOpenFinalPackageEvidenceClosure, isFalse);
    expect(readiness.mayClaimReleasePass, isFalse);
    expect(readiness.mayClaimCursorPass, isFalse);
    expect(readiness.mayDeleteLegacyCursorNow, isFalse);
    expect(readiness.protectedUiSurfaceMutationAllowed, isFalse);
  });

  test('V172-Q125 only opens later human approval when every final evidence artifact is real', () {
    final readiness = FinalPackageEvidenceClosureIntakeGuardV172Q125Policy.evaluateReadiness(
      q124ReleaseFreezeFinalReviewGuardPackageReady: true,
      q124ReleaseFreezeFinalReviewEvidenceComplete: true,
      q124HumanReviewApproved: true,
      q124ReleaseFreezeApproved: true,
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
      finalEvidenceLedgerPresent: true,
      frozenDefectLedgerPresent: true,
      touchedFilesManifestPresent: true,
      selectedVerifierReportsPresent: true,
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
      noFakeEvidenceClosure: true,
      explicitEvidenceClosureApproval: true,
    );

    expect(readiness.status, 'Q125_FINAL_PACKAGE_EVIDENCE_CLOSURE_READY_FOR_HUMAN_APPROVAL');
    expect(readiness.finalPackageEvidenceClosureComplete, isTrue);
    expect(readiness.mayOpenFinalPackageEvidenceClosure, isTrue);
    expect(readiness.mayClaimReleasePass, isFalse);
    expect(readiness.mayDeleteLegacyCursorNow, isFalse);
    expect(readiness.maySwitchDefaultEditorNow, isFalse);
  });
}
