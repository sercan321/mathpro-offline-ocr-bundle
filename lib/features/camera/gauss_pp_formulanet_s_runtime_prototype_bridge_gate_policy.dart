/// V172-Q262 PP-FormulaNet-S runtime prototype bridge gate policy.
///
/// This phase is a protocol gate only. It prepares the evidence contract for a
/// future isolated Android runtime prototype bridge without adding Paddle,
/// PaddleOCR, JNI/native bridge code, model bytes, production network download,
/// or image-to-LaTeX inference.
class GaussPpFormulaNetSRuntimePrototypeBridgeGatePolicy {
  const GaussPpFormulaNetSRuntimePrototypeBridgeGatePolicy._();

  static const phase = 'V172-Q262-PP-FORMULANET-S-RUNTIME-PROTOTYPE-BRIDGE-GATE';
  static const sourcePhase = 'V172-Q261-PP-FORMULANET-S-RUNTIME-FEASIBILITY-ADAPTER';
  static const selectedEngineLabel = 'PP-FormulaNet-S';
  static const fallbackEngineLabel = 'PP-FormulaNet_plus-L';
  static const prototypeBridgeMode = 'runtime-prototype-bridge-gate-only-no-native-runtime-no-inference';

  static const runtimePrototypeBridgeGateImplemented = true;
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
  static const runtimePrototypePassClaimed = false;
  static const editableMathLiveReviewRequired = true;
  static const userApprovalRequiredBeforeWorkspaceImport = true;

  static const bridgeProtocolCandidates = <String>[
    'isolated Android method-channel protocol candidate',
    'Paddle Lite shell prototype protocol candidate',
    'future JNI bridge protocol candidate behind evidence gate',
  ];

  static const prototypeBridgeStates = <String>[
    'prototypeBridgeBlockedMissingQ261Feasibility',
    'prototypeBridgeBlockedMissingAbiMatrix',
    'prototypeBridgeBlockedMissingModelFormatProof',
    'prototypeBridgeBlockedMissingPrivateArtifactAccess',
    'prototypeBridgeBlockedMissingLatencyMemoryBudget',
    'prototypeBridgeBlockedMissingReviewOnlyContract',
    'prototypeBridgeProtocolDraftReadyButRuntimeDisabled',
    'prototypeBridgeBlockedUntilRealDeviceSmoke',
  ];

  static const requiredBridgeProtocolGates = <String>[
    'q261RuntimeFeasibilityAdapterPresent',
    'officialOnDeviceDeploymentEvidenceReviewed',
    'androidAbiMatrixPrepared',
    'modelFormatCompatibilityEvidenceRequired',
    'privateArtifactPathContractRequired',
    'bridgeInputEnvelopeRequired',
    'bridgeOutputEnvelopeRequired',
    'timeoutAndCancellationPolicyRequired',
    'memoryPressurePolicyRequired',
    'latencyBudgetPolicyRequired',
    'bridgeErrorTaxonomyRequired',
    'noProductionInferenceWithoutRealSmoke',
    'editableMathLiveReviewRequired',
    'explicitUserApprovalBeforeWorkspaceImport',
    'directSolveGraphSolutionHistoryBlocked',
  ];

  static const bridgeInputEnvelopeFields = <String>[
    'croppedImagePathInPrivateStorage',
    'cropBounds',
    'rotationDegrees',
    'modelArtifactPrivatePath',
    'modelSha256Evidence',
    'engineLabel',
    'requestId',
    'timeoutMs',
  ];

  static const bridgeOutputEnvelopeFields = <String>[
    'requestId',
    'status',
    'primaryLatexCandidate',
    'alternativeLatexCandidates',
    'confidence',
    'warnings',
    'runtimeDiagnostics',
    'mathLiveReviewRequired',
  ];

  static const blockedUntilRealEvidence = <String>[
    'realAndroidAbiMatrix',
    'realPpFormulaNetSModelFormatCompatibilityLog',
    'realPrivateArtifactLoadSmokeLog',
    'realBridgeInvocationSmokeLog',
    'realDeviceLatencyMeasurement',
    'realDevicePeakMemoryMeasurement',
    'timeoutCancellationSmokeLog',
    'MathLiveReviewImportSmokeLog',
    'FlutterAnalyzeTestRunLog',
  ];

  static const forbiddenActions = <String>[
    'addPaddleRuntimeInQ262',
    'addPaddleOcrDependencyInQ262',
    'addJniBindingInQ262',
    'bindRuntimeMethodChannelInQ262',
    'bundlePPFormulaNetSModelInBaseApk',
    'bindProductionModelUrlInQ262',
    'startRealNetworkDownloadInQ262',
    'runPpFormulaNetSInferenceInQ262',
    'claimRuntimePrototypePassWithoutDeviceSmoke',
    'claimOcrPassWithoutInferenceEvidence',
    'importCameraOutputWithoutMathLiveReview',
    'solveGraphSolutionHistoryFromCameraWithoutUserApproval',
  ];
}
