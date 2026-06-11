/// V172-Q263 PP-FormulaNet-S runtime prototype smoke evidence template policy.
///
/// This phase creates the evidence template for a future real-device runtime
/// prototype smoke. It does not add Paddle, PaddleOCR, JNI/native bridge code,
/// MethodChannel runtime binding, model bytes, production network download, or
/// image-to-LaTeX inference.
class GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplatePolicy {
  const GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplatePolicy._();

  static const phase = 'V172-Q263-PP-FORMULANET-S-RUNTIME-PROTOTYPE-SMOKE-EVIDENCE-TEMPLATE';
  static const sourcePhase = 'V172-Q262-PP-FORMULANET-S-RUNTIME-PROTOTYPE-BRIDGE-GATE';
  static const selectedEngineLabel = 'PP-FormulaNet-S';
  static const fallbackEngineLabel = 'PP-FormulaNet_plus-L';
  static const smokeEvidenceMode = 'runtime-prototype-smoke-evidence-template-only-no-runtime-no-inference';

  static const runtimePrototypeSmokeEvidenceTemplateImplemented = true;
  static const realOcrRuntimeAdded = false;
  static const paddleRuntimeAdded = false;
  static const paddleOcrDependencyAdded = false;
  static const nativeBridgeAdded = false;
  static const jniBindingAdded = false;
  static const methodChannelRuntimeBindingAdded = false;
  static const modelBinaryBundledInBaseApp = false;
  static const productionModelUrlBound = false;
  static const realNetworkDownloadWorkerImplemented = false;
  static const productionDownloadEnabled = false;
  static const productionInferenceAllowed = false;
  static const runtimeSmokePassClaimed = false;
  static const ocrPassClaimed = false;
  static const editableMathLiveReviewRequired = true;
  static const userApprovalRequiredBeforeWorkspaceImport = true;

  static const smokeEvidenceStates = <String>[
    'smokeEvidenceBlockedMissingQ262BridgeGate',
    'smokeEvidenceBlockedMissingDeviceAndAbiTemplate',
    'smokeEvidenceBlockedMissingArtifactLoadTemplate',
    'smokeEvidenceBlockedMissingBridgeInvocationTemplate',
    'smokeEvidenceBlockedMissingPerformanceTemplate',
    'smokeEvidenceBlockedMissingSafetyTemplate',
    'smokeEvidenceTemplateReadyButRuntimeDisabled',
    'smokeEvidenceBlockedUntilRealDeviceRun',
  ];

  static const requiredSmokeEvidenceFields = <String>[
    'deviceId',
    'appVersionPhase',
    'androidApiLevel',
    'androidAbi',
    'runtimeCandidate',
    'privateArtifactPath',
    'artifactSha256',
    'modelFormatProbeResult',
    'bridgeInputEnvelopeHash',
    'bridgeOutputEnvelopeHash',
    'bridgeInvocationStatus',
    'latencyMs',
    'peakMemoryMb',
    'timeoutCancellationStatus',
    'bridgeErrorCode',
    'mathLiveReviewOpened',
    'directSolveBlocked',
    'flutterAnalyzeTestRunLogReference',
  ];

  static const requiredTemplateGates = <String>[
    'q262RuntimePrototypeBridgeGatePresent',
    'realDeviceIdentityTemplateRequired',
    'androidAbiMatrixCaptureRequired',
    'privateArtifactLoadSmokeTemplateRequired',
    'modelFormatProbeTemplateRequired',
    'bridgeInvocationSmokeTemplateRequired',
    'latencyMeasurementTemplateRequired',
    'peakMemoryMeasurementTemplateRequired',
    'timeoutCancellationEvidenceTemplateRequired',
    'memoryPressureEvidenceTemplateRequired',
    'bridgeErrorTaxonomyEvidenceTemplateRequired',
    'MathLiveReviewImportEvidenceTemplateRequired',
    'directSolveGraphSolutionHistoryBlockEvidenceRequired',
    'noRuntimeSmokePassWithoutRealDeviceEvidence',
    'noOcrPassWithoutRealInferenceEvidence',
  ];

  static const blockedUntilRealEvidence = <String>[
    'realDeviceRuntimeSmokeJson',
    'realAndroidAbiMatrixCapture',
    'realPrivateArtifactLoadSmoke',
    'realModelFormatProbeLog',
    'realBridgeInvocationSmoke',
    'realLatencyMeasurement',
    'realPeakMemoryMeasurement',
    'realTimeoutCancellationEvidence',
    'realMathLiveReviewImportEvidence',
    'realDirectSolveBlockedEvidence',
    'FlutterAnalyzeTestRunLog',
  ];

  static const forbiddenActions = <String>[
    'addPaddleRuntimeInQ263',
    'addPaddleOcrDependencyInQ263',
    'addJniBindingInQ263',
    'bindRuntimeMethodChannelInQ263',
    'bundlePPFormulaNetSModelInBaseApk',
    'bindProductionModelUrlInQ263',
    'startRealNetworkDownloadInQ263',
    'runPpFormulaNetSInferenceInQ263',
    'claimRuntimeSmokePassWithoutRealDeviceEvidence',
    'claimOcrPassWithoutInferenceEvidence',
    'importCameraOutputWithoutMathLiveReview',
    'solveGraphSolutionHistoryFromCameraWithoutUserApproval',
  ];
}
