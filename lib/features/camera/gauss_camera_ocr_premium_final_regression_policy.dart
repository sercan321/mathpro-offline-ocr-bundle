/// V172-Q252 — Camera/OCR Premium Final Regression policy.
///
/// Q252 is the final static/regression closure for the camera/OCR foundation
/// from Q239A through Q251. It does not add Paddle runtime, does not bundle
/// PP-FormulaNet-S model bytes, does not run image-to-LaTeX inference, and does
/// not claim real OCR PASS. It locks the premium regression obligations:
/// keyboard/MORE/long-press/MathLive production/Graph/Solution/History/splash
/// remain untouched; the camera chain remains review-first; model bytes stay out
/// of the base APK; and direct workspace import, solve, Graph, Solution, and
/// History writes from camera output remain blocked unless a future, explicitly
/// approved runtime phase proves the full PP-FormulaNet-S stack.
class GaussCameraOcrPremiumFinalRegressionPolicy {
  const GaussCameraOcrPremiumFinalRegressionPolicy._();

  static const phase = 'V172-Q252-CAMERA-OCR-PREMIUM-FINAL-REGRESSION';
  static const closesOverPhase = 'V172-Q251-CAMERA-MATH-OCR-END-TO-END-COURT';
  static const sourcePackageSha256 = 'fef6abfeeeb7b5b0c15801726a96555baea7cdd36855015756115f26d8508768';

  static const selectedEngineLabel = 'PP-FormulaNet-S';
  static const fallbackEngineLabel = 'PP-FormulaNet_plus-L';
  static const regressionMode = 'camera-ocr-premium-final-static-regression-closure';

  static const q245RealDeviceEvidenceClosureRequired = true;
  static const q246BenchmarkPackageRequired = true;
  static const q247WinnerGateRequired = true;
  static const q247r1PpFormulaNetSUserSelectionRequired = true;
  static const q248DeferredModelRuntimeRequired = true;
  static const q249ReviewOnlyAdapterRequired = true;
  static const q250MathLiveReviewImportRequired = true;
  static const q251EndToEndCourtRequired = true;

  static const keyboardLayoutMustRemainUnchanged = true;
  static const moreInventoryMustRemainUnchanged = true;
  static const longPressInventoryMustRemainUnchanged = true;
  static const mathLiveProductionRouteMustRemainUnchanged = true;
  static const graphSurfaceMustRemainUnchanged = true;
  static const solutionSurfaceMustRemainUnchanged = true;
  static const historySurfaceMustRemainUnchanged = true;
  static const splashAndLauncherMustRemainUnchanged = true;
  static const workspaceCameraShellMustRemainUnchanged = true;

  static const editableMathLiveReviewRequired = true;
  static const userApprovalRequiredBeforeWorkspaceImport = true;
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
  static const premiumFinalPassClaimedByAssistant = false;

  static const androidToolchainModernizationDeferredToQ253 = true;
  static const splashSystemRepairDeferredUnlessEvidenceRequires = true;
  static const realPpFormulaNetSRuntimeIntegrationDeferred = true;

  static const cameraDependencyChanged = false;
  static const androidSettingsGradleChanged = false;
  static const androidManifestChanged = false;
  static const mainActivityChanged = false;

  static const flutterAnalyzePassClaimedByAssistant = false;
  static const flutterTestPassClaimedByAssistant = false;
  static const flutterRunPassClaimedByAssistant = false;
  static const androidRealDevicePassClaimedByAssistant = false;
  static const realPpFormulaNetSInferencePassClaimedByAssistant = false;

  static const requiredFinalRegressionGates = <String>[
    'q245RealDeviceEvidenceClosure',
    'q246BenchmarkPackage',
    'q247WinnerGate',
    'q247r1PpFormulaNetSUserSelection',
    'q248DeferredModelRuntime',
    'q249ReviewOnlyAdapterEnvelope',
    'q250MathLiveReviewImport',
    'q251EndToEndCourt',
    'keyboardLayoutUnchanged',
    'moreInventoryUnchanged',
    'longPressInventoryUnchanged',
    'mathLiveProductionRouteUnchanged',
    'graphSolutionHistoryUnchanged',
    'modelNotBundledInBaseApk',
    'directCameraSolveBlocked',
    'directCameraGraphSolutionHistoryBlocked',
    'noRealOcrPassClaimed',
    'androidToolchainDeferredToQ253',
  ];

  static const deferredFuturePhases = <String>[
    'V172-Q253-ANDROID-TOOLCHAIN-MODERNIZATION',
    'V172-Q235R8-ANDROID-12-PREMIUM-SPLASH-SYSTEM-SPLASH-REPAIR-IF-EVIDENCE-REQUIRES',
    'V172-PP-FORMULANET-S-REAL-RUNTIME-DOWNLOAD-INFERENCE-INTEGRATION',
  ];
}
