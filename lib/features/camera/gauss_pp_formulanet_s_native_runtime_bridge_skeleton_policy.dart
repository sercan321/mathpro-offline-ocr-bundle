class GaussPpFormulaNetSNativeRuntimeBridgeSkeletonPolicy {
  const GaussPpFormulaNetSNativeRuntimeBridgeSkeletonPolicy._();

  static const String phase = 'V172-Q270-PP-FORMULANET-S-NATIVE-RUNTIME-BRIDGE-SKELETON';
  static const String sourcePhase = 'V172-Q269-PP-FORMULANET-S-RUNTIME-DEPENDENCY-ISOLATION';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L';
  static const String bridgeSkeletonMode = 'native-runtime-bridge-skeleton-gate-only-no-native-runtime-no-inference';

  static const bool nativeRuntimeBridgeSkeletonImplemented = true;
  static const bool requiresQ269RuntimeDependencyIsolation = true;
  static const bool realOcrRuntimeAdded = false;
  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool nativeBridgeImplementationAdded = false;
  static const bool jniBindingAdded = false;
  static const bool methodChannelRuntimeBindingAdded = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionModelUrlBound = false;
  static const bool realNetworkDownloadWorkerImplemented = false;
  static const bool productionDownloadEnabled = false;
  static const bool productionInferenceAllowed = false;
  static const bool runtimeDefaultEnabled = false;
  static const bool runtimeFeatureFlagDefaultOff = true;
  static const bool editableMathLiveReviewRequired = true;
  static const bool userApprovalRequiredBeforeWorkspaceImport = true;
  static const bool directCameraSolveBlocked = true;
  static const bool directCameraGraphSolutionHistoryBlocked = true;
  static const bool bridgeSkeletonPassClaimed = false;
  static const bool ocrPassClaimed = false;

  static const int bridgeTimeoutBudgetMs = 3500;
  static const int bridgePeakMemoryBudgetMb = 512;

  static const List<String> bridgeSkeletonDecisionStates = <String>[
    'blockedMissingQ269DependencyIsolation',
    'blockedRuntimeDependencyStillUndecided',
    'blockedMissingMethodChannelProtocol',
    'blockedMissingJniProtocol',
    'blockedMissingInputEnvelope',
    'blockedMissingOutputEnvelope',
    'blockedMissingBridgeErrorTaxonomy',
    'blockedMissingTimeoutCancellationContract',
    'blockedMissingMemoryPressureContract',
    'blockedMissingFeatureFlagDefaultOff',
    'blockedMissingFallbackPlan',
    'blockedMissingMathLiveReviewRequirement',
    'blockedDirectSolveOrImportRisk',
    'blockedUnsafeRuntimeImplementationAddedInQ270',
    'readyForFutureNativeRuntimeBridgePrototypeOnly',
  ];

  static const List<String> requiredBridgeSkeletonGates = <String>[
    'q269RuntimeDependencyIsolationPresent',
    'q269StillNoRuntimeDependencyNoInference',
    'runtimeBridgeCandidateDocumented',
    'methodChannelProtocolDocumented',
    'jniProtocolDocumented',
    'bridgeInputImagePathEnvelopeDocumented',
    'bridgeOutputLatexCandidateEnvelopeDocumented',
    'bridgeErrorCodeTaxonomyDocumented',
    'timeoutCancellationPolicyDocumented',
    'memoryPressurePolicyDocumented',
    'latencyBudgetDocumented',
    'peakMemoryBudgetDocumented',
    'runtimeFeatureFlagDefaultOffDocumented',
    'noDefaultRuntimeEnablement',
    'fallbackPlanDocumented',
    'formulaOcrPrimaryOnly',
    'editableMathLiveReviewRequired',
    'userApprovalRequiredBeforeWorkspaceImport',
    'directSolveBlocked',
    'directGraphSolutionHistoryBlocked',
    'noPaddleRuntimeAddedInQ270',
    'noPaddleOcrDependencyAddedInQ270',
    'noNativeBridgeImplementationAddedInQ270',
    'noJniBindingAddedInQ270',
    'noMethodChannelRuntimeBindingAddedInQ270',
    'noModelBinaryBundledInQ270',
    'noProductionModelUrlBoundInQ270',
    'noRealDownloadWorkerInQ270',
    'noProductionInferenceInQ270',
  ];

  static const List<String> blockedUntilRealEvidence = <String>[
    'acceptedQ269RuntimeDependencyIsolation',
    'realRuntimeDependencySelectionDocument',
    'realMethodChannelProtocolReview',
    'realJniProtocolReview',
    'realBridgeInputEnvelopeReview',
    'realBridgeOutputEnvelopeReview',
    'realBridgeErrorTaxonomyReview',
    'realTimeoutCancellationEvidence',
    'realMemoryPressureEvidence',
    'realFlutterPubGetLog',
    'realFlutterAnalyzeLog',
    'realFlutterTestLog',
    'realFlutterRunLog',
    'realDeviceBridgeSmokeLog',
    'realMathLiveReviewEvidence',
    'realDirectSolveBlockedEvidence',
    'explicitUserApprovalForNativeRuntimeBridgePrototypePhase',
  ];

  static const List<String> bridgeProtocolCandidates = <String>[
    'methodChannelEnvelopeOnlyCandidate',
    'jniNativeBridgeCandidate',
    'isolatedPlatformViewFreeRuntimeCandidate',
    'rejectedDirectWorkspaceMutationCandidate',
  ];

  static const List<String> bridgeInputEnvelopeFields = <String>[
    'requestId',
    'croppedImagePath',
    'artifactPath',
    'artifactSha256',
    'androidAbi',
    'runtimeCandidate',
    'timeoutMs',
    'reviewOnlyMode',
  ];

  static const List<String> bridgeOutputEnvelopeFields = <String>[
    'requestId',
    'primaryLatexCandidate',
    'alternativeLatexCandidates',
    'confidence',
    'warnings',
    'engineMetadata',
    'latencyMs',
    'reviewRequired',
  ];

  static const List<String> bridgeErrorCodes = <String>[
    'modelNotReady',
    'artifactShaMismatch',
    'runtimeUnavailable',
    'unsupportedAbi',
    'timeout',
    'cancelled',
    'memoryPressure',
    'invalidInputImage',
    'nativeCrashGuarded',
    'unknownBridgeError',
  ];

  static const List<String> bridgeSkeletonStrategies = <String>[
    'featureFlagDefaultOffBridgeSkeleton',
    'reviewOnlyBridgeOutputBoundary',
    'noDirectWorkspaceMutationBoundary',
    'methodChannelProtocolBeforeBinding',
    'jniProtocolBeforeNativeImplementation',
    'timeoutCancellationBeforeRuntime',
    'memoryPressureBeforeRuntime',
    'fallbackBeforeRuntime',
  ];

  static const List<String> forbiddenActions = <String>[
    'addPaddleRuntimeDependencyInQ270',
    'addPaddleOcrDependencyInQ270',
    'addNativeBridgeImplementationInQ270',
    'addJniBindingInQ270',
    'bindRuntimeMethodChannelInQ270',
    'bundlePPFormulaNetSModelInBaseApk',
    'bindProductionModelUrlInQ270',
    'startRealNetworkDownloadInQ270',
    'runPpFormulaNetSInferenceInQ270',
    'enableRuntimeBridgeByDefaultInQ270',
    'claimBridgeSkeletonPassWithoutRealBuildEvidence',
    'claimOcrPassWithoutRealInferenceEvidence',
    'importCameraOutputWithoutMathLiveReview',
    'solveGraphSolutionHistoryFromCameraWithoutUserApproval',
  ];
}
