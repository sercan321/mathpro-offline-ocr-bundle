import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_user_selection.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_user_selection_policy.dart';

void main() {
  group('V172-Q247R1 PP-FormulaNet-S user selection lock', () {
    test('records PP-FormulaNet-S as user-selected preferred primary candidate without fake benchmark pass', () {
      expect(GaussPpFormulaNetSUserSelectionPolicy.phase, 'V172-Q247R1-PP_FORMULANET_S_USER_SELECTION_LOCK');
      expect(GaussPpFormulaNetSUserSelectionPolicy.closesOverPhase, 'V172-Q247-WINNER-ENGINE-SELECTION');
      expect(GaussPpFormulaNetSUserSelectionPolicy.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(GaussPpFormulaNetSUserSelectionPolicy.selectedFallbackEngineLabel, 'PP-FormulaNet_plus-L');
      expect(GaussPpFormulaNetSUserSelectionPolicy.selectionIsUserPreferenceNotBenchmarkWinner, isTrue);
      expect(GaussPpFormulaNetSUserSelectionPolicy.benchmarkWinnerSelected, isFalse);
      expect(GaussPpFormulaNetSUserSelectionPolicy.realBenchmarkPassClaimedByAssistant, isFalse);
      expect(GaussPpFormulaNetSUserSelection.isBenchmarkWinnerClaimed, isFalse);
    });

    test('keeps runtime binding and direct import blocked until evidence exists', () {
      expect(GaussPpFormulaNetSUserSelectionPolicy.realOcrRuntimeAdded, isFalse);
      expect(GaussPpFormulaNetSUserSelectionPolicy.paddleRuntimeAdded, isFalse);
      expect(GaussPpFormulaNetSUserSelectionPolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussPpFormulaNetSUserSelectionPolicy.productionModelUrlBound, isFalse);
      expect(GaussPpFormulaNetSUserSelectionPolicy.backgroundDownloadWorkerImplemented, isFalse);
      expect(GaussPpFormulaNetSUserSelectionPolicy.productionRuntimeBindingAllowed, isFalse);
      expect(GaussPpFormulaNetSUserSelectionPolicy.mathLiveEditableReviewRequired, isTrue);
      expect(GaussPpFormulaNetSUserSelectionPolicy.directWorkspaceImportAllowed, isFalse);
      expect(GaussPpFormulaNetSUserSelectionPolicy.directSolveFromCameraAllowed, isFalse);
      expect(GaussPpFormulaNetSUserSelectionPolicy.directGraphFromCameraAllowed, isFalse);
      expect(GaussPpFormulaNetSUserSelectionPolicy.directSolutionFromCameraAllowed, isFalse);
      expect(GaussPpFormulaNetSUserSelectionPolicy.directHistoryFromCameraAllowed, isFalse);
    });

    test('allows Q248 planning but blocks Q249 adapter without evidence', () {
      expect(GaussPpFormulaNetSUserSelection.canProceedToQ248DeferredDownloadPlanning, isTrue);
      expect(GaussPpFormulaNetSUserSelection.canProceedToQ249RuntimeAdapterWithoutEvidence, isFalse);
      expect(GaussPpFormulaNetSUserSelection.requiresEditableMathLiveReview, isTrue);
      expect(GaussPpFormulaNetSUserSelection.allowsDirectSolve, isFalse);
      expect(GaussPpFormulaNetSUserSelection.bundlesModelInBaseApk, isFalse);
      expect(GaussPpFormulaNetSUserSelection.requiredBeforeRuntimeAdapter, contains('licenseClearanceForDistribution'));
      expect(GaussPpFormulaNetSUserSelection.requiredBeforeRuntimeAdapter, contains('sha256VerifiedModelArtifact'));
      expect(GaussPpFormulaNetSUserSelection.blockedUntilEvidence, contains('cameraImageToLatexInference'));
      expect(GaussPpFormulaNetSUserSelection.blockedUntilEvidence, contains('directSolveFromCamera'));
    });
  });
}
