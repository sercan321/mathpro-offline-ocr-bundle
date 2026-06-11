/// V172-Q261 PP-FormulaNet-S runtime feasibility adapter policy.
///
/// This is a feasibility gate only. It documents and verifies the minimum
/// Android runtime evidence needed before any future Paddle/PP-FormulaNet-S
/// inference integration can be enabled. It deliberately does not add Paddle,
/// PaddleOCR, model bytes, JNI bindings, a production download URL, or
/// image-to-LaTeX inference.
class GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy {
  const GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy._();

  static const phase = 'V172-Q261-PP-FORMULANET-S-RUNTIME-FEASIBILITY-ADAPTER';
  static const sourcePhase = 'V172-Q260-PP-FORMULANET-S-REAL-MODEL-DOWNLOAD-INTEGRATION-GATE';
  static const selectedEngineLabel = 'PP-FormulaNet-S';
  static const fallbackEngineLabel = 'PP-FormulaNet_plus-L';
  static const feasibilityMode = 'runtime-feasibility-adapter-gate-only-no-paddle-runtime-no-inference';

  static const realOcrRuntimeAdded = false;
  static const paddleRuntimeAdded = false;
  static const paddleOcrDependencyAdded = false;
  static const nativeBridgeAdded = false;
  static const modelBinaryBundledInBaseApp = false;
  static const productionModelUrlBound = false;
  static const realNetworkDownloadWorkerImplemented = false;
  static const productionDownloadEnabled = false;
  static const productionInferenceAllowed = false;
  static const runtimeFeasibilityPassClaimed = false;
  static const editableMathLiveReviewRequired = true;
  static const userApprovalRequiredBeforeWorkspaceImport = true;

  static const runtimePathCandidates = <String>[
    'Paddle Lite / on-device Android shell feasibility',
    'Paddle native inference feasibility via isolated Android bridge',
    'Converted mobile artifact feasibility if officially supported',
  ];

  static const feasibilityStates = <String>[
    'runtimeEvidenceMissing',
    'runtimeCandidateIdentified',
    'modelFormatUnderReview',
    'nativeBridgeUnderReview',
    'latencyMemoryBudgetUnderReview',
    'androidAbiCompatibilityUnderReview',
    'offlineReadinessUnderReview',
    'runtimeFeasibilityBlockedUntilRealEvidence',
  ];

  static const requiredFeasibilityGates = <String>[
    'officialOnDeviceDeploymentEvidence',
    'ppFormulaNetSModelFormatEvidence',
    'androidRuntimePathEvidence',
    'abiCompatibilityEvidence',
    'nativeBridgePlanEvidence',
    'modelArtifactAccessFromPrivateStorageEvidence',
    'latencyBudgetEvidence',
    'peakMemoryBudgetEvidence',
    'offlineAfterInstallEvidence',
    'thermalAndBatteryRiskReview',
    'noBaseApkModelBundling',
    'noProductionInferenceWithoutRuntimeProof',
    'editableMathLiveReviewRequired',
    'explicitUserApprovalBeforeWorkspaceImport',
    'directSolveGraphSolutionHistoryBlocked',
  ];

  static const blockedUntilRealEvidence = <String>[
    'realAndroidRuntimePrototypeLog',
    'realPPFormulaNetSModelFormatReport',
    'realDeviceLatencyMeasurement',
    'realDevicePeakMemoryMeasurement',
    'ABICompatibilityMatrix',
    'nativeBridgeSmokeLogIfBridgeIsNeeded',
    'offlineReadyModelLoadLog',
    'MathLiveReviewImportLog',
    'FlutterAnalyzeTestRunLog',
  ];

  static const forbiddenActions = <String>[
    'addPaddleRuntimeInQ261',
    'addPaddleOcrDependencyInQ261',
    'bundlePPFormulaNetSModelInBaseApk',
    'bindProductionModelUrlInQ261',
    'startRealNetworkDownloadInQ261',
    'runPpFormulaNetSInferenceInQ261',
    'claimRuntimeFeasibilityPassWithoutDeviceEvidence',
    'claimOcrPassWithoutInferenceEvidence',
    'importCameraOutputWithoutMathLiveReview',
    'solveGraphSolutionHistoryFromCameraWithoutUserApproval',
  ];
}
