import 'gauss_pp_formulanet_s_user_selection_policy.dart';

/// User-direction record for PP-FormulaNet-S.
///
/// Q247R1 locks the product direction to PP-FormulaNet-S while keeping the
/// engineering gate honest: no OCR runtime, model bytes, production URL, direct
/// import, direct solve, graph, solution, or history write is added by the
/// selection lock itself.
class GaussPpFormulaNetSUserSelection {
  const GaussPpFormulaNetSUserSelection._();

  static const phase = GaussPpFormulaNetSUserSelectionPolicy.phase;
  static const selectedEngineLabel = GaussPpFormulaNetSUserSelectionPolicy.selectedEngineLabel;
  static const selectedEngineFamily = GaussPpFormulaNetSUserSelectionPolicy.selectedEngineFamily;
  static const fallbackEngineLabel = GaussPpFormulaNetSUserSelectionPolicy.selectedFallbackEngineLabel;

  static const requiredBeforeRuntimeAdapter = <String>[
    'licenseClearanceForDistribution',
    'offlineAfterInstallProof',
    'modelSizeBudgetProof',
    'medianAndP95LatencyProof',
    'androidRuntimeFeasibilityProof',
    'mathLiveEditableReviewCompatibilityProof',
    'sha256VerifiedModelArtifact',
  ];

  static const blockedUntilEvidence = <String>[
    'productionPaddleRuntimeBinding',
    'productionModelUrlBinding',
    'backgroundModelDownloaderWorker',
    'cameraImageToLatexInference',
    'directWorkspaceImport',
    'directSolveFromCamera',
    'directGraphFromCamera',
    'directSolutionFromCamera',
    'directHistoryFromCamera',
  ];

  static bool get isUserSelectedPreferredPrimaryCandidate => true;
  static bool get isBenchmarkWinnerClaimed => false;
  static bool get canProceedToQ248DeferredDownloadPlanning => true;
  static bool get canProceedToQ249RuntimeAdapterWithoutEvidence => false;
  static bool get requiresEditableMathLiveReview => true;
  static bool get allowsDirectSolve => false;
  static bool get bundlesModelInBaseApk => false;

  static Map<String, Object> toAuditJson() {
    return <String, Object>{
      'phase': phase,
      'selectedEngineLabel': selectedEngineLabel,
      'selectedEngineFamily': selectedEngineFamily,
      'fallbackEngineLabel': fallbackEngineLabel,
      'selectionIsUserPreferenceNotBenchmarkWinner': true,
      'benchmarkWinnerSelected': false,
      'realOcrRuntimeAdded': false,
      'modelBinaryBundledInBaseApp': false,
      'productionRuntimeBindingAllowed': false,
      'mathLiveEditableReviewRequired': true,
      'directSolveFromCameraAllowed': false,
      'requiredBeforeRuntimeAdapter': requiredBeforeRuntimeAdapter,
      'blockedUntilEvidence': blockedUntilEvidence,
    };
  }
}
