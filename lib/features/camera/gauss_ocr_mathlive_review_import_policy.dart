/// V172-Q250 — OCR → MathLive Review Import policy.
///
/// Q250 connects the Q249 PP-FormulaNet-S adapter envelope to an editable
/// MathLive review-import contract. It deliberately remains review-first: no
/// Paddle runtime is loaded, no model bytes are bundled, no production model URL
/// is bound, no production MathLive bridge call is made, and no workspace,
/// solver, graph, solution, or history mutation can happen before explicit user
/// approval from the editable review surface.
class GaussOcrMathLiveReviewImportPolicy {
  const GaussOcrMathLiveReviewImportPolicy._();

  static const phase = 'V172-Q250-OCR-MATHLIVE-REVIEW-IMPORT';
  static const closesOverPhase = 'V172-Q249-OCR-RUNTIME-ADAPTER';
  static const sourcePackageSha256 = '2677f6b93ee2a57f31dbc1cfd0cf748457057050191deaee88d7460ead54ce19';

  static const selectedEngineLabel = 'PP-FormulaNet-S';
  static const fallbackEngineLabel = 'PP-FormulaNet_plus-L';
  static const reviewImportMode = 'editable-mathlive-review-first-import-contract';
  static const reviewSurfaceKey = 'mathpro-ocr-mathlive-review-import-surface';
  static const modelPackId = 'gauss_pp_formulanet_s_optional_math_ocr_pack';

  static const q249AdapterEnvelopeRequired = true;
  static const q248DeferredModelReadinessStillRequired = true;
  static const adapterPrimaryCandidateRequiredBeforeReview = true;
  static const candidateAlternativesPreserved = true;
  static const confidenceAndWarningsPreserved = true;
  static const editableMathLiveReviewDraftImplemented = true;
  static const userApprovalRequiredBeforeWorkspaceImport = true;
  static const workspaceImportPreparedOnlyAfterUserApproval = true;
  static const reviewDraftCanBeEditedBeforeApproval = true;
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
  static const productionMathLiveBridgeCalled = false;
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
  static const androidRealDeviceReviewImportPassClaimedByAssistant = false;
  static const realPpFormulaNetSInferencePassClaimedByAssistant = false;

  static const nextPlannedPhase = 'V172-Q251-CAMERA-MATH-OCR-END-TO-END-COURT';
}
