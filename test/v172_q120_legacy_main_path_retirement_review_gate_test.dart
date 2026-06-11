import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/legacy_main_path_retirement_review_gate_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_graph_history_solution_runtime_binding_gate_policy.dart';

void main() {
  test('V172-Q120 blocks legacy main-path retirement without Q119/runtime/device/human-review evidence', () {
    final readiness = LegacyMainPathRetirementReviewGatePolicy.evaluateReadiness(
      q119RuntimeBindingPackageReady: true,
      q119RuntimeBindingEvidenceComplete: false,
      q119HumanReviewApproved: false,
      explicitRetirementReviewApproval: false,
      flutterAnalyzePassed: false,
      flutterTestPassed: false,
      labDeviceRunCaptured: false,
      mainDeviceRunCaptured: false,
      graphRuntimeEvidencePassed: false,
      historyRuntimeEvidencePassed: false,
      solutionRuntimeEvidencePassed: false,
      postActivationSoakPassed: false,
      protectedSurfacesUnchanged: true,
      keyboardUntouched: true,
      moreUntouched: true,
      longPressUntouched: true,
      appShellUntouched: true,
      graphHistorySolutionUiUntouched: true,
      legacyRollbackAvailable: true,
      noDefaultEditorSwitchInThisPackage: true,
      noMainWorkspaceMountInThisPackage: true,
      noActualLegacyRetirementInThisPackage: true,
      noPhysicalLegacyDeletionInThisPackage: true,
      noFakeRuntimeEvidence: true,
      noFakeDeviceEvidence: true,
      noFakeRetirementApproval: true,
    );

    expect(LegacyMainPathRetirementReviewGatePolicy.phase, 'V172-Q120');
    expect(LegacyMainPathRetirementReviewGatePolicy.prerequisiteRuntimeBindingPhase, MathLiveGraphHistorySolutionRuntimeBindingGatePolicy.phase);
    expect(readiness.packageSideGateReady, isTrue);
    expect(readiness.reviewEvidenceComplete, isFalse);
    expect(readiness.mayRetireLegacyMainPathNow, isFalse);
    expect(readiness.mayDeleteLegacyCursor, isFalse);
    expect(readiness.maySwitchDefaultEditorNow, isFalse);
    expect(readiness.mayMountMathLiveInMainWorkspaceNow, isFalse);
    expect(readiness.mayProceedToPhysicalCleanupPlanning, isFalse);
    expect(readiness.selectedDefaultEngine, 'legacyFlutterSlotEditor');
    expect(readiness.rollbackEngine, 'legacyFlutterSlotEditor');
  });

  test('V172-Q120 only opens a later human review when every prerequisite is real', () {
    final readiness = LegacyMainPathRetirementReviewGatePolicy.evaluateReadiness(
      q119RuntimeBindingPackageReady: true,
      q119RuntimeBindingEvidenceComplete: true,
      q119HumanReviewApproved: true,
      explicitRetirementReviewApproval: true,
      flutterAnalyzePassed: true,
      flutterTestPassed: true,
      labDeviceRunCaptured: true,
      mainDeviceRunCaptured: true,
      graphRuntimeEvidencePassed: true,
      historyRuntimeEvidencePassed: true,
      solutionRuntimeEvidencePassed: true,
      postActivationSoakPassed: true,
      protectedSurfacesUnchanged: true,
      keyboardUntouched: true,
      moreUntouched: true,
      longPressUntouched: true,
      appShellUntouched: true,
      graphHistorySolutionUiUntouched: true,
      legacyRollbackAvailable: true,
      noDefaultEditorSwitchInThisPackage: true,
      noMainWorkspaceMountInThisPackage: true,
      noActualLegacyRetirementInThisPackage: true,
      noPhysicalLegacyDeletionInThisPackage: true,
      noFakeRuntimeEvidence: true,
      noFakeDeviceEvidence: true,
      noFakeRetirementApproval: true,
    );

    expect(readiness.status, 'Q120_LEGACY_MAIN_PATH_RETIREMENT_REVIEW_READY_FOR_HUMAN_APPROVAL');
    expect(readiness.reviewEvidenceComplete, isTrue);
    expect(readiness.mayProceedToPhysicalCleanupPlanning, isTrue);
    expect(readiness.mayRetireLegacyMainPathNow, isFalse);
    expect(readiness.mayDeleteLegacyCursor, isFalse);
    expect(readiness.protectedUiSurfaceMutationAllowed, isFalse);
    expect(readiness.releasePassClaimAllowedInThisPackage, isFalse);
  });
}
