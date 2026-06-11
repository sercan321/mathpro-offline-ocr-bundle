/// V172-Q247R1 — PP-FormulaNet-S user selection lock.
///
/// The user selected PP-FormulaNet-S as the preferred primary camera math OCR
/// candidate. This is a product-direction lock, not a fake benchmark pass. The
/// actual runtime binding still requires license, offline, model-size, latency,
/// and editable MathLive review evidence before Q249 can execute inference.
class GaussPpFormulaNetSUserSelectionPolicy {
  const GaussPpFormulaNetSUserSelectionPolicy._();

  static const phase = 'V172-Q247R1-PP_FORMULANET_S_USER_SELECTION_LOCK';
  static const closesOverPhase = 'V172-Q247-WINNER-ENGINE-SELECTION';
  static const sourcePackageSha256 = 'a6d4c61a4a918721c39c8fbc9ada3f5650ecd1185ff440dd2e183a8201c802d9';

  static const userSelectedPrimaryCandidate = true;
  static const selectedEngineLabel = 'PP-FormulaNet-S';
  static const selectedEngineFamily = 'pp_formula_net_s';
  static const selectedFallbackEngineLabel = 'PP-FormulaNet_plus-L';
  static const selectionSource = 'explicit-user-choice';
  static const selectionIsUserPreferenceNotBenchmarkWinner = true;

  static const benchmarkWinnerSelected = false;
  static const realBenchmarkPassClaimedByAssistant = false;
  static const realOcrRuntimeAdded = false;
  static const paddleRuntimeAdded = false;
  static const paddleOcrDependencyAdded = false;
  static const modelBinaryBundledInBaseApp = false;
  static const productionModelUrlBound = false;
  static const backgroundDownloadWorkerImplemented = false;
  static const productionInferenceAllowed = false;
  static const productionRuntimeBindingAllowed = false;

  static const licenseClearanceStillRequired = true;
  static const offlineAfterInstallProofStillRequired = true;
  static const modelSizeBudgetProofStillRequired = true;
  static const latencyProofStillRequired = true;
  static const androidRuntimeProofStillRequired = true;
  static const mathLiveReviewCompatibilityStillRequired = true;
  static const q248DeferredModelDownloadMayUseSelectedEngine = true;
  static const q249RuntimeAdapterRequiresEvidence = true;

  static const mathLiveEditableReviewRequired = true;
  static const directWorkspaceImportAllowed = false;
  static const directSolveFromCameraAllowed = false;
  static const directGraphFromCameraAllowed = false;
  static const directSolutionFromCameraAllowed = false;
  static const directHistoryFromCameraAllowed = false;

  static const keyboardMutationAllowed = false;
  static const longPressMutationAllowed = false;
  static const moreMutationAllowed = false;
  static const mathLiveProductionMutationAllowed = false;
  static const graphMutationAllowed = false;
  static const solutionMutationAllowed = false;
  static const historyMutationAllowed = false;
  static const splashLauncherMutationAllowed = false;

  static const flutterAnalyzePassClaimedByAssistant = false;
  static const flutterTestPassClaimedByAssistant = false;
  static const flutterRunPassClaimedByAssistant = false;

  static const nextPlannedPhase = 'V172-Q248-DEFERRED-MODEL-DOWNLOAD-RUNTIME';
}
