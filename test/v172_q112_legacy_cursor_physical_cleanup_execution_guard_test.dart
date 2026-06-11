import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/legacy_cursor_physical_cleanup_execution_guard_policy.dart';

void main() {
  test('V172-Q112 creates cleanup execution guard without deleting files', () {
    final readiness = LegacyCursorPhysicalCleanupExecutionGuardPolicy.evaluateReadiness(
      q111PlanningPackageReady: true,
      q111EvidenceCompleteForCleanupExecutionReview: false,
      q110RetirementGateReadyForReview: false,
      q109ConditionalActivationReadyForReview: false,
      q108RealDeviceCursorCourtPassed: false,
      flutterAnalyzePassed: false,
      flutterTestPassed: false,
      postActivationSoakPassed: false,
      inventoryManifestPresent: true,
      inventoryCategoriesComplete: true,
      cleanupCandidatesClassified: true,
      cleanupCandidateFilesStillPresent: true,
      protectedSurfacesUnchanged: true,
      rollbackFilesPreserved: true,
      dataPathFilesPreserved: true,
      noPhysicalDeletionAttempted: true,
      noRuntimeBehaviorChange: true,
      noFakeEvidence: true,
      manualInventoryReviewCompleted: false,
      explicitQ112CleanupApprovalApproved: false,
    );

    expect(LegacyCursorPhysicalCleanupExecutionGuardPolicy.phase, 'V172-Q112');
    expect(readiness.packageSideExecutionGuardReady, isTrue);
    expect(readiness.evidenceCompleteForPhysicalCleanupExecution, isFalse);
    expect(readiness.physicalCleanupExecutionImplementedInThisPackage, isFalse);
    expect(readiness.mayDeleteLegacyCursorNow, isFalse);
    expect(readiness.mayExecuteCleanupInThisPackage, isFalse);
    expect(readiness.protectedUiSurfaceMutationAllowed, isFalse);
    expect(readiness.q111InventoryManifest, contains('V172_Q111_LEGACY_CURSOR_PHYSICAL_CLEANUP_INVENTORY.json'));
  });

  test('V172-Q112 only allows a later separate approved cleanup package after every evidence gate is real', () {
    final readiness = LegacyCursorPhysicalCleanupExecutionGuardPolicy.evaluateReadiness(
      q111PlanningPackageReady: true,
      q111EvidenceCompleteForCleanupExecutionReview: true,
      q110RetirementGateReadyForReview: true,
      q109ConditionalActivationReadyForReview: true,
      q108RealDeviceCursorCourtPassed: true,
      flutterAnalyzePassed: true,
      flutterTestPassed: true,
      postActivationSoakPassed: true,
      inventoryManifestPresent: true,
      inventoryCategoriesComplete: true,
      cleanupCandidatesClassified: true,
      cleanupCandidateFilesStillPresent: true,
      protectedSurfacesUnchanged: true,
      rollbackFilesPreserved: true,
      dataPathFilesPreserved: true,
      noPhysicalDeletionAttempted: true,
      noRuntimeBehaviorChange: true,
      noFakeEvidence: true,
      manualInventoryReviewCompleted: true,
      explicitQ112CleanupApprovalApproved: true,
    );

    expect(readiness.status, 'LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_READY_FOR_SEPARATE_APPROVED_PACKAGE');
    expect(readiness.mayExecuteCleanupInSeparateApprovedPackage, isTrue);
    expect(readiness.mayExecuteCleanupInThisPackage, isFalse);
    expect(readiness.mayDeleteLegacyCursorNow, isFalse);
    expect(readiness.cursorPassClaimAllowedInThisPackage, isFalse);
  });
}
