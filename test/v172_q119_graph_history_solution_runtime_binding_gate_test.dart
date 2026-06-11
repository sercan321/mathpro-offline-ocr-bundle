import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_graph_history_solution_runtime_binding_gate_policy.dart';

void main() {
  group('V172-Q119 Graph/History/Solution runtime binding gate', () {
    test('keeps package ready but runtime binding blocked without Q118/device/runtime evidence', () {
      final readiness = MathLiveGraphHistorySolutionRuntimeBindingGatePolicy.evaluateReadiness(
        q118ActivationDryRunPackageReady: true,
        q118ActivationEvidenceComplete: false,
        q118HumanReviewApproved: false,
        explicitRuntimeBindingApproval: false,
        q103GraphAdapterReady: true,
        q104HistoryAdapterReady: true,
        q105SolutionAdapterReady: true,
        flutterAnalyzePassed: false,
        flutterTestPassed: false,
        labDeviceRunCaptured: false,
        mainDeviceRunCaptured: false,
        graphRuntimeScenarioEvidenceProvided: false,
        historyRuntimeScenarioEvidenceProvided: false,
        solutionRuntimeScenarioEvidenceProvided: false,
        protectedSurfacesUnchanged: true,
        graphCardUntouched: true,
        historyControllerUntouched: true,
        historyPanelUntouched: true,
        solutionStepsPanelUntouched: true,
        keyboardUntouched: true,
        moreUntouched: true,
        longPressUntouched: true,
        appShellUntouched: true,
        legacyRollbackAvailable: true,
        noRuntimeGraphWriteInThisPackage: true,
        noRuntimeHistoryWriteInThisPackage: true,
        noRuntimeSolutionWriteInThisPackage: true,
        noFakeGraphEvidence: true,
        noFakeHistoryEvidence: true,
        noFakeSolutionEvidence: true,
        noFakeRuntimeEvidence: true,
        noMainEditorSwitchInThisPackage: true,
        noLegacyRetirementOrDeletion: true,
      );

      expect(readiness.packageSideGateReady, isTrue);
      expect(readiness.runtimeBindingEvidenceComplete, isFalse);
      expect(readiness.isEvidenceBlocked, isTrue);
      expect(readiness.mayBindGraphAtRuntime, isFalse);
      expect(readiness.mayBindHistoryAtRuntime, isFalse);
      expect(readiness.mayBindSolutionAtRuntime, isFalse);
      expect(readiness.maySwitchMainEditor, isFalse);
      expect(readiness.mayDeleteLegacyCursor, isFalse);
      expect(readiness.mayClaimCursorPass, isFalse);
    });

    test('requires protected Graph, History, and Solution surfaces to remain untouched', () {
      final readiness = MathLiveGraphHistorySolutionRuntimeBindingGatePolicy.evaluateReadiness(
        q118ActivationDryRunPackageReady: true,
        q118ActivationEvidenceComplete: true,
        q118HumanReviewApproved: true,
        explicitRuntimeBindingApproval: true,
        q103GraphAdapterReady: true,
        q104HistoryAdapterReady: true,
        q105SolutionAdapterReady: true,
        flutterAnalyzePassed: true,
        flutterTestPassed: true,
        labDeviceRunCaptured: true,
        mainDeviceRunCaptured: true,
        graphRuntimeScenarioEvidenceProvided: true,
        historyRuntimeScenarioEvidenceProvided: true,
        solutionRuntimeScenarioEvidenceProvided: true,
        protectedSurfacesUnchanged: false,
        graphCardUntouched: false,
        historyControllerUntouched: true,
        historyPanelUntouched: true,
        solutionStepsPanelUntouched: true,
        keyboardUntouched: true,
        moreUntouched: true,
        longPressUntouched: true,
        appShellUntouched: true,
        legacyRollbackAvailable: true,
        noRuntimeGraphWriteInThisPackage: true,
        noRuntimeHistoryWriteInThisPackage: true,
        noRuntimeSolutionWriteInThisPackage: true,
        noFakeGraphEvidence: true,
        noFakeHistoryEvidence: true,
        noFakeSolutionEvidence: true,
        noFakeRuntimeEvidence: true,
        noMainEditorSwitchInThisPackage: true,
        noLegacyRetirementOrDeletion: true,
      );

      expect(readiness.packageSideGateReady, isFalse);
      expect(readiness.mayBindGraphAtRuntime, isFalse);
      expect(readiness.mayMutateProtectedRuntimeUiSurfaces, isFalse);
      expect(readiness.blockers, contains('protected UI surfaces changed'));
      expect(readiness.blockers, contains('graph_card.dart changed'));
    });
  });
}
