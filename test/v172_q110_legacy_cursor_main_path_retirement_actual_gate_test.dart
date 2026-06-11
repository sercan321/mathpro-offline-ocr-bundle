import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/legacy_cursor_main_path_retirement_actual_gate_policy.dart';

void main() {
  test('V172-Q110 blocks actual retirement without Q109/device/flutter/soak approval evidence', () {
    final readiness = LegacyCursorMainPathRetirementActualGatePolicy.evaluateReadiness(
      q109ConditionalActivationReadyForReview: false,
      mathLiveMainEditorActivatedBehindInternalFlag: false,
      q108RealDeviceCursorCourtPassed: false,
      flutterAnalyzePassed: false,
      flutterTestPassed: false,
      graphAdapterReady: true,
      historyAdapterReady: true,
      solutionAdapterReady: true,
      legacyRollbackAvailable: true,
      postActivationSoakPassed: false,
      explicitRetirementApprovalApproved: false,
      protectedSurfacesUnchanged: true,
      keyboardUntouched: true,
      moreUntouched: true,
      longPressUntouched: true,
      appShellUntouched: true,
      graphHistorySolutionUiUntouched: true,
      noFakeEvidence: true,
      noActualRetirementInThisPackage: true,
      noPhysicalDeletionAttempted: true,
    );

    expect(LegacyCursorMainPathRetirementActualGatePolicy.phase, 'V172-Q110');
    expect(readiness.packageSideGateReady, isTrue);
    expect(readiness.evidenceCompleteForLaterRetirementReview, isFalse);
    expect(readiness.mayRetireLegacyMainPathNow, isFalse);
    expect(readiness.mayDeleteLegacyCursor, isFalse);
    expect(readiness.maySwitchDefaultEditorNow, isFalse);
    expect(readiness.selectedDefaultEngine, 'legacyFlutterSlotEditor');
    expect(readiness.rollbackEngine, 'legacyFlutterSlotEditor');
  });

  test('V172-Q110 allows only a later explicit review when every gate is real', () {
    final readiness = LegacyCursorMainPathRetirementActualGatePolicy.evaluateReadiness(
      q109ConditionalActivationReadyForReview: true,
      mathLiveMainEditorActivatedBehindInternalFlag: true,
      q108RealDeviceCursorCourtPassed: true,
      flutterAnalyzePassed: true,
      flutterTestPassed: true,
      graphAdapterReady: true,
      historyAdapterReady: true,
      solutionAdapterReady: true,
      legacyRollbackAvailable: true,
      postActivationSoakPassed: true,
      explicitRetirementApprovalApproved: true,
      protectedSurfacesUnchanged: true,
      keyboardUntouched: true,
      moreUntouched: true,
      longPressUntouched: true,
      appShellUntouched: true,
      graphHistorySolutionUiUntouched: true,
      noFakeEvidence: true,
      noActualRetirementInThisPackage: true,
      noPhysicalDeletionAttempted: true,
    );

    expect(readiness.status, 'LEGACY_CURSOR_MAIN_PATH_RETIREMENT_READY_FOR_EXPLICIT_REVIEW');
    expect(readiness.mayRetireLegacyMainPathInLaterReviewedPhase, isTrue);
    expect(readiness.mayRetireLegacyMainPathNow, isFalse);
    expect(readiness.actualLegacyMainPathRetirementImplementedInThisPackage, isFalse);
    expect(readiness.protectedUiSurfaceMutationAllowed, isFalse);
  });
}
