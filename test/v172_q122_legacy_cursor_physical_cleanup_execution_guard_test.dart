import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/legacy_cursor_physical_cleanup_execution_guard_v172_q122_policy.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/legacy_cursor_physical_cleanup_planning_gate_policy.dart';

void main() {
  test('V172-Q122 blocks physical cleanup execution without Q121/device/runtime/human-review evidence', () {
    final readiness = LegacyCursorPhysicalCleanupExecutionGuardV172Q122Policy.evaluateReadiness(
      q121PlanningPackageReady: true,
      q121PlanningEvidenceComplete: false,
      q121HumanReviewApproved: false,
      explicitPhysicalCleanupExecutionApproval: false,
      flutterAnalyzePassed: false,
      flutterTestPassed: false,
      labDeviceRunCaptured: false,
      mainDeviceRunCaptured: false,
      graphRuntimeEvidencePassed: false,
      historyRuntimeEvidencePassed: false,
      solutionRuntimeEvidencePassed: false,
      postActivationSoakPassed: false,
      cleanupDeltaManifestPrepared: false,
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
      noFakeExecutionApproval: true,
    );

    expect(LegacyCursorPhysicalCleanupExecutionGuardV172Q122Policy.phase, 'V172-Q122');
    expect(LegacyCursorPhysicalCleanupExecutionGuardV172Q122Policy.prerequisitePlanningPhase, LegacyCursorPhysicalCleanupPlanningGatePolicy.phase);
    expect(readiness.packageSideExecutionGuardReady, isTrue);
    expect(readiness.executionEvidenceComplete, isFalse);
    expect(readiness.mayExecutePhysicalCleanupReview, isFalse);
    expect(readiness.mayDeleteLegacyCursorNow, isFalse);
    expect(readiness.mayRetireLegacyMainPathNow, isFalse);
    expect(readiness.maySwitchDefaultEditorNow, isFalse);
    expect(readiness.mayClaimCursorPass, isFalse);
    expect(readiness.protectedUiSurfaceMutationAllowed, isFalse);
  });

  test('V172-Q122 can only prepare later physical cleanup review when every prerequisite is real', () {
    final readiness = LegacyCursorPhysicalCleanupExecutionGuardV172Q122Policy.evaluateReadiness(
      q121PlanningPackageReady: true,
      q121PlanningEvidenceComplete: true,
      q121HumanReviewApproved: true,
      explicitPhysicalCleanupExecutionApproval: true,
      flutterAnalyzePassed: true,
      flutterTestPassed: true,
      labDeviceRunCaptured: true,
      mainDeviceRunCaptured: true,
      graphRuntimeEvidencePassed: true,
      historyRuntimeEvidencePassed: true,
      solutionRuntimeEvidencePassed: true,
      postActivationSoakPassed: true,
      cleanupDeltaManifestPrepared: true,
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
      noFakeExecutionApproval: true,
    );

    expect(readiness.status, 'Q122_LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_READY_FOR_HUMAN_APPROVAL');
    expect(readiness.executionEvidenceComplete, isTrue);
    expect(readiness.mayExecutePhysicalCleanupReview, isTrue);
    expect(readiness.mayDeleteLegacyCursorNow, isFalse);
    expect(readiness.mayRetireLegacyMainPathNow, isFalse);
    expect(readiness.mayClaimReleasePass, isFalse);
  });
}
