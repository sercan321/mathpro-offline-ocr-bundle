/// V172-Q249 — OCR Runtime Adapter policy.
///
/// Q249 creates the PP-FormulaNet-S OCR runtime adapter contract after Q248's
/// deferred model readiness gate. This phase is deliberately review-only: it
/// defines input/output envelopes, candidate validation, confidence/warning
/// semantics, and MathLive editable review routing. It does not bundle model
/// bytes, add Paddle/PaddleOCR dependencies, download a production model, load a
/// runtime, run inference, mutate the workspace, or solve/graph camera output.
class GaussOcrRuntimeAdapterPolicy {
  const GaussOcrRuntimeAdapterPolicy._();

  static const phase = 'V172-Q249-OCR-RUNTIME-ADAPTER';
  static const closesOverPhase = 'V172-Q248-DEFERRED-MODEL-DOWNLOAD-RUNTIME';
  static const sourcePackageSha256 = '93c98953e93205a0ee65792672b4271218e711d9827eeadf453f378ed2e8a1ae';

  static const selectedEngineLabel = 'PP-FormulaNet-S';
  static const selectedEngineFamily = 'pp_formula_net_s';
  static const fallbackEngineLabel = 'PP-FormulaNet_plus-L';
  static const adapterMode = 'review-only-runtime-adapter-contract';
  static const modelPackId = 'gauss_pp_formulanet_s_optional_math_ocr_pack';

  static const q247R1UserSelectionRequired = true;
  static const q248DeferredModelReadinessRequired = true;
  static const ppFormulaNetSAdapterContractImplemented = true;
  static const adapterInputEnvelopeImplemented = true;
  static const adapterOutputEnvelopeImplemented = true;
  static const latexCandidateContractImplemented = true;
  static const alternativeCandidatesContractImplemented = true;
  static const confidenceContractImplemented = true;
  static const warningContractImplemented = true;
  static const modelEvidenceGateRequiredBeforeAdapterUse = true;
  static const mathLiveEditableReviewRequiredBeforeImport = true;
  static const directSolveFromCameraAllowed = false;
  static const directWorkspaceImportAllowed = false;
  static const directGraphFromCameraAllowed = false;
  static const directSolutionFromCameraAllowed = false;
  static const directHistoryFromCameraAllowed = false;

  static const realOcrRuntimeAdded = false;
  static const paddleRuntimeAdded = false;
  static const paddleOcrDependencyAdded = false;
  static const ppFormulaNetSModelBinaryBundledInBaseApp = false;
  static const productionModelUrlBound = false;
  static const productionDownloadWorkerImplemented = false;
  static const productionInferenceAllowed = false;
  static const productionRuntimeBindingAllowed = false;
  static const mathLiveProductionBridgeCalled = false;
  static const workspaceRuntimeChanged = false;
  static const cameraRuntimeShellChanged = false;
  static const solverRuntimeChanged = false;
  static const graphRuntimeChanged = false;
  static const solutionRuntimeChanged = false;
  static const historyRuntimeChanged = false;

  static const cameraDependencyChanged = false;
  static const androidSettingsGradleChanged = false;
  static const androidManifestChanged = false;
  static const mainActivityChanged = false;
  static const androidToolchainModernizationDeferredToQ253 = true;

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
  static const androidRealDeviceAdapterPassClaimedByAssistant = false;
  static const realPpFormulaNetSInferencePassClaimedByAssistant = false;

  static const nextPlannedPhase = 'V172-Q250-OCR-MATHLIVE-REVIEW-IMPORT';
}
