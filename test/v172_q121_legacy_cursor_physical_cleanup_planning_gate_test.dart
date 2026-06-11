import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/legacy_cursor_physical_cleanup_planning_gate_policy.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/legacy_main_path_retirement_review_gate_policy.dart';

void main() {
  test('V172-Q121 blocks physical cleanup planning without Q120/device/runtime/human-review evidence', () {
    final readiness = LegacyCursorPhysicalCleanupPlanningGatePolicy.evaluateReadiness(
      q120RetirementReviewPackageReady: true,
      q120RetirementReviewEvidenceComplete: false,
      q120HumanReviewApproved: false,
      explicitPhysicalCleanupPlanningApproval: false,
      flutterAnalyzePassed: false,
      flutterTestPassed: false,
      labDeviceRunCaptured: false,
      mainDeviceRunCaptured: false,
      graphRuntimeEvidencePassed: false,
      historyRuntimeEvidencePassed: false,
      solutionRuntimeEvidencePassed: false,
      postActivationSoakPassed: false,
      planningDraftPresent: true,
      planningDraftHasRequiredCategories: true,
      protectedSurfacesUnchanged: true,
      keyboardUntouched: true,
      moreUntouched: true,
      longPressUntouched: true,
      appShellUntouched: true,
      graphHistorySolutionUiUntouched: true,
      rollbackFilesPreserved: true,
      sharedEditorDataPathPreserved: true,
      noDefaultEditorSwitchInThisPackage: true,
      noMainWorkspaceMountInThisPackage: true,
      noLegacyRetirementInThisPackage: true,
      noPhysicalLegacyDeletionInThisPackage: true,
      noRuntimeBehaviorChangeInThisPackage: true,
      noFakeRuntimeEvidence: true,
      noFakeDeviceEvidence: true,
      noFakePlanningApproval: true,
    );

    expect(LegacyCursorPhysicalCleanupPlanningGatePolicy.phase, 'V172-Q121');
    expect(LegacyCursorPhysicalCleanupPlanningGatePolicy.prerequisiteRetirementReviewPhase, LegacyMainPathRetirementReviewGatePolicy.phase);
    expect(readiness.packageSidePlanningReady, isTrue);
    expect(readiness.planningEvidenceComplete, isFalse);
    expect(readiness.mayProceedToPhysicalCleanupExecutionReview, isFalse);
    expect(readiness.mayDeleteLegacyCursorNow, isFalse);
    expect(readiness.mayRetireLegacyMainPathNow, isFalse);
    expect(readiness.maySwitchDefaultEditorNow, isFalse);
    expect(readiness.mayClaimCursorPass, isFalse);
    expect(readiness.protectedUiSurfaceMutationAllowed, isFalse);
  });

  test('V172-Q121 can only prepare a later cleanup execution review when every prerequisite is real', () {
    final readiness = LegacyCursorPhysicalCleanupPlanningGatePolicy.evaluateReadiness(
      q120RetirementReviewPackageReady: true,
      q120RetirementReviewEvidenceComplete: true,
      q120HumanReviewApproved: true,
      explicitPhysicalCleanupPlanningApproval: true,
      flutterAnalyzePassed: true,
      flutterTestPassed: true,
      labDeviceRunCaptured: true,
      mainDeviceRunCaptured: true,
      graphRuntimeEvidencePassed: true,
      historyRuntimeEvidencePassed: true,
      solutionRuntimeEvidencePassed: true,
      postActivationSoakPassed: true,
      planningDraftPresent: true,
      planningDraftHasRequiredCategories: true,
      protectedSurfacesUnchanged: true,
      keyboardUntouched: true,
      moreUntouched: true,
      longPressUntouched: true,
      appShellUntouched: true,
      graphHistorySolutionUiUntouched: true,
      rollbackFilesPreserved: true,
      sharedEditorDataPathPreserved: true,
      noDefaultEditorSwitchInThisPackage: true,
      noMainWorkspaceMountInThisPackage: true,
      noLegacyRetirementInThisPackage: true,
      noPhysicalLegacyDeletionInThisPackage: true,
      noRuntimeBehaviorChangeInThisPackage: true,
      noFakeRuntimeEvidence: true,
      noFakeDeviceEvidence: true,
      noFakePlanningApproval: true,
    );

    expect(readiness.status, 'Q121_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_READY_FOR_HUMAN_APPROVAL');
    expect(readiness.planningEvidenceComplete, isTrue);
    expect(readiness.mayProceedToPhysicalCleanupExecutionReview, isTrue);
    expect(readiness.mayDeleteLegacyCursorNow, isFalse);
    expect(readiness.mayRetireLegacyMainPathNow, isFalse);
    expect(readiness.mayClaimReleasePass, isFalse);
  });
}
