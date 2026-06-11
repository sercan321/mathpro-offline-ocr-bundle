import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/legacy_cursor_physical_cleanup_planning_policy.dart';

void main() {
  test('V172-Q111 creates cleanup inventory planning without deleting files', () {
    final readiness = LegacyCursorPhysicalCleanupPlanningPolicy.evaluateReadiness(
      q110RetirementGateReadyForReview: false,
      q109ConditionalActivationReadyForReview: false,
      q108RealDeviceCursorCourtPassed: false,
      flutterAnalyzePassed: false,
      flutterTestPassed: false,
      inventoryManifestPresent: true,
      inventoryHasRequiredCategories: true,
      protectedSurfacesUnchanged: true,
      rollbackFilesPreserved: true,
      dataPathFilesPreserved: true,
      noPhysicalDeletionAttempted: true,
      noRuntimeBehaviorChange: true,
      noFakeEvidence: true,
      manualReviewCompleted: false,
      explicitCleanupApprovalApproved: false,
    );

    expect(LegacyCursorPhysicalCleanupPlanningPolicy.phase, 'V172-Q111');
    expect(readiness.packageSidePlanningReady, isTrue);
    expect(readiness.evidenceCompleteForCleanupExecutionReview, isFalse);
    expect(readiness.actualPhysicalCleanupImplementedInThisPackage, isFalse);
    expect(readiness.mayDeleteLegacyCursorNow, isFalse);
    expect(readiness.protectedUiSurfaceMutationAllowed, isFalse);
    expect(readiness.inventoryManifest, contains('V172_Q111_LEGACY_CURSOR_PHYSICAL_CLEANUP_INVENTORY.json'));
  });

  test('V172-Q111 allows only a later explicit Q112 review when every gate is real', () {
    final readiness = LegacyCursorPhysicalCleanupPlanningPolicy.evaluateReadiness(
      q110RetirementGateReadyForReview: true,
      q109ConditionalActivationReadyForReview: true,
      q108RealDeviceCursorCourtPassed: true,
      flutterAnalyzePassed: true,
      flutterTestPassed: true,
      inventoryManifestPresent: true,
      inventoryHasRequiredCategories: true,
      protectedSurfacesUnchanged: true,
      rollbackFilesPreserved: true,
      dataPathFilesPreserved: true,
      noPhysicalDeletionAttempted: true,
      noRuntimeBehaviorChange: true,
      noFakeEvidence: true,
      manualReviewCompleted: true,
      explicitCleanupApprovalApproved: true,
    );

    expect(readiness.status, 'LEGACY_CURSOR_PHYSICAL_CLEANUP_READY_FOR_EXPLICIT_Q112_REVIEW');
    expect(readiness.mayExecuteCleanupInLaterReviewedQ112, isTrue);
    expect(readiness.mayDeleteLegacyCursorNow, isFalse);
    expect(readiness.cursorPassClaimAllowedInThisPackage, isFalse);
  });
}
