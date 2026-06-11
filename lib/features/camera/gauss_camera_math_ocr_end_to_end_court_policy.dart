/// V172-Q251 — Camera Math OCR End-to-End Court policy.
///
/// Q251 is a regression/evidence court for the camera math OCR chain after
/// Q250. It does not add Paddle runtime, does not bundle PP-FormulaNet-S model
/// bytes, does not run image-to-LaTeX inference, and does not claim OCR PASS.
/// Instead it verifies the mandatory sequence: camera capture, crop/scan-frame,
/// Q248 deferred model readiness, Q249 review-only adapter envelope, Q250
/// editable MathLive review, explicit user approval, and only then a prepared
/// workspace-import court state. Solver, graph, solution, and history remain
/// blocked from camera output until after separate user-approved runtime work.
class GaussCameraMathOcrEndToEndCourtPolicy {
  const GaussCameraMathOcrEndToEndCourtPolicy._();

  static const phase = 'V172-Q251-CAMERA-MATH-OCR-END-TO-END-COURT';
  static const closesOverPhase = 'V172-Q250-OCR-MATHLIVE-REVIEW-IMPORT';
  static const sourcePackageSha256 = '4a3222b2967b4af1d43044235e45ea6b369bd482a66dcb7eb03a0fcd0f6738b4';

  static const selectedEngineLabel = 'PP-FormulaNet-S';
  static const fallbackEngineLabel = 'PP-FormulaNet_plus-L';
  static const courtMode = 'camera-crop-adapter-review-approval-end-to-end-court-guard';
  static const reviewSurfaceKey = 'mathpro-ocr-mathlive-review-import-surface';
  static const modelPackId = 'gauss_pp_formulanet_s_optional_math_ocr_pack';

  static const cameraCaptureRequired = true;
  static const cropScanFrameRequired = true;
  static const q248DeferredModelReadinessRequired = true;
  static const q249AdapterEnvelopeRequired = true;
  static const q250MathLiveReviewImportRequired = true;
  static const editableMathLiveReviewRequired = true;
  static const userApprovalRequiredBeforeWorkspaceImport = true;
  static const workspaceImportPreparedOnlyAfterUserApproval = true;
  static const endToEndCourtMayOpenReviewBeforeApproval = true;
  static const endToEndCourtMayPrepareWorkspaceImportAfterApproval = true;

  static const directWorkspaceImportAllowed = false;
  static const directSolveFromCameraAllowed = false;
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
  static const realEndToEndOcrPassClaimed = false;

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
  static const androidRealDeviceEndToEndPassClaimedByAssistant = false;
  static const realPpFormulaNetSInferencePassClaimedByAssistant = false;

  static const requiredCourtStages = <String>[
    'cameraCapture',
    'cropScanFrame',
    'deferredModelReadiness',
    'reviewOnlyAdapterEnvelope',
    'editableMathLiveReviewDraft',
    'explicitUserApproval',
    'workspaceImportPreparedAfterApprovalOnly',
  ];

  static const requiredRealDeviceCourtCases = <String>[
    'simpleArithmetic',
    'quadraticExpression',
    'fraction',
    'squareRoot',
    'indefiniteIntegral',
    'definiteIntegral',
    'primeDerivative',
    'leibnizDerivative',
    'limit',
    'sigma',
    'matrix',
    'lowLight',
    'skewedCapture',
    'mildBlur',
    'notebookLinesOrShadow',
  ];

  static const nextPlannedPhase = 'V172-Q252-CAMERA-OCR-PREMIUM-FINAL-REGRESSION';
}
