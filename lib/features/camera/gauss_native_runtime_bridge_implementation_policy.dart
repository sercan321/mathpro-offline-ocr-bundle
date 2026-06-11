class GaussNativeRuntimeBridgeImplementationPolicy {
  const GaussNativeRuntimeBridgeImplementationPolicy._();

  static const String phase = 'V172-Q280-NATIVE-RUNTIME-BRIDGE-IMPLEMENTATION-BEHIND-FLAG';
  static const String sourcePhase = 'V172-Q279-SELECTED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String bridgeImplementationMode = 'native-runtime-bridge-implementation-behind-default-off-flag-no-native-handler-no-inference';
  static const String methodChannelName = 'com.mathpro.gauss/pp_formulanet_s_runtime_bridge';

  static const int bridgeTimeoutBudgetMs = 2500;
  static const int bridgeCancellationBudgetMs = 400;
  static const int bridgePeakMemoryBudgetMb = 384;
  static const int maximumAlternativeCandidateCount = 4;

  static const bool nativeRuntimeBridgeImplementationGateImplemented = true;
  static const bool requiresQ279DependencyTrial = true;
  static const bool requiresQ278EvidenceLock = true;
  static const bool requiresDefaultOffBridgeFlag = true;
  static const bool requiresRuntimeInvocationBlockedWhenFlagOff = true;
  static const bool requiresMethodChannelEnvelope = true;
  static const bool requiresRequestEnvelope = true;
  static const bool requiresResponseEnvelope = true;
  static const bool requiresErrorTaxonomy = true;
  static const bool requiresTimeoutCancellationPolicy = true;
  static const bool requiresMemoryPressurePolicy = true;
  static const bool reviewOnlyModeRequired = true;
  static const bool editableMathLiveReviewRequired = true;
  static const bool explicitUserApprovalRequiredBeforeWorkspaceImport = true;
  static const bool directSolveGraphSolutionHistoryBlocked = true;

  static const bool keyboardLayoutChanged = false;
  static const bool moreTemplateTrayChanged = false;
  static const bool longPressListsChanged = false;
  static const bool mathLiveProductionRouteChanged = false;
  static const bool legacyFlutterCursorRouteReintroduced = false;
  static const bool graphSolutionHistoryRuntimeChanged = false;
  static const bool cameraShellRuntimeChanged = false;
  static const bool solverEvaluatorChanged = false;
  static const bool splashIconChanged = false;

  static const bool dartBridgeFacadeAdded = true;
  static const bool methodChannelEnvelopeDeclared = true;
  static const bool bridgeFeatureFlagEnabledByDefault = false;
  static const bool runtimeInvocationAllowedWhenFlagOff = false;
  static const bool nativeHandlerImplementationAdded = false;
  static const bool realOcrRuntimeAdded = false;
  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool runtimeDependencyAddedToPubspec = false;
  static const bool gradleNativeRuntimeDependencyAdded = false;
  static const bool jniBindingAdded = false;
  static const bool methodChannelRuntimeBindingAdded = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionModelUrlBound = false;
  static const bool productionDownloadEnabled = false;
  static const bool realNetworkDownloadWorkerImplemented = false;
  static const bool realImageToLatexInferenceExecuted = false;
  static const bool bridgeImplementationPassClaimed = false;
  static const bool runtimeIntegrationPassClaimed = false;
  static const bool imageToLatexPassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool premiumFinalPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> requiredBridgeImplementationGates = [
    'q279DependencyTrialPresent',
    'q278EvidenceLockPresent',
    'defaultOffBridgeFeatureFlagRequired',
    'runtimeInvocationBlockedWhenFlagOff',
    'methodChannelNameDeclaredWithoutNativeHandler',
    'requestEnvelopeDocumented',
    'responseEnvelopeDocumented',
    'errorTaxonomyDocumented',
    'timeoutCancellationPolicyDocumented',
    'memoryPressurePolicyDocumented',
    'reviewOnlyModeRequired',
    'editableMathLiveReviewRequired',
    'explicitUserApprovalRequiredBeforeWorkspaceImport',
    'directSolveGraphSolutionHistoryBlocked',
    'noNativeHandlerImplementationInQ280',
    'noJniBindingInQ280',
    'noPaddleRuntimeInQ280',
    'noPaddleOcrDependencyInQ280',
    'noModelBinaryBundledInBaseApk',
    'noProductionDownloadOrInference',
    'protectedUiSurfacePreservation',
  ];

  static const List<String> blockedUntilRealEvidence = [
    'acceptedQ279DependencyTrialEvidence',
    'acceptedQ278RuntimeEvidenceLock',
    'explicitUserApprovalForBridgeTrial',
    'methodChannelProtocolHumanReview',
    'nativeHandlerDesignReview',
    'runtimeDependencyCoordinatesEvidence',
    'privateArtifactLoadPlanEvidence',
    'userSideFlutterAnalyzeCleanLog',
    'userSideFlutterTestPassLog',
    'userSideFlutterRunLog',
    'realDeviceBridgeFlagOffBlockEvidence',
    'editableMathLiveReviewEvidence',
    'directSolveGraphSolutionHistoryBlockEvidence',
  ];

  static const List<String> bridgeRequestEnvelopeFields = [
    'requestId',
    'croppedImagePath',
    'privateArtifactPath',
    'artifactSha256',
    'androidAbi',
    'timeoutMs',
    'reviewOnlyMode',
    'runtimeFeatureFlagEnabled',
  ];

  static const List<String> bridgeResponseEnvelopeFields = [
    'requestId',
    'status',
    'primaryLatexCandidate',
    'alternativeLatexCandidates',
    'confidence',
    'warnings',
    'errorCode',
    'engineMetadata',
    'latencyMs',
    'reviewRequired',
    'directWorkspaceMutationAttempted',
  ];

  static const List<String> bridgeErrorCodes = [
    'runtimeFeatureFlagOff',
    'nativeHandlerNotBound',
    'modelArtifactNotReady',
    'artifactShaMismatch',
    'unsupportedAbi',
    'timeout',
    'cancelled',
    'memoryPressure',
    'invalidInputImage',
    'nativeRuntimeUnavailable',
    'unknownBridgeError',
  ];

  static const List<String> forbiddenActions = [
    'enableNativeRuntimeBridgeByDefaultInQ280',
    'invokeRuntimeWhenBridgeFlagOff',
    'addNativeHandlerImplementationInQ280',
    'addJniBindingInQ280',
    'addPaddleRuntimeDependencyInQ280',
    'addPaddleOcrDependencyInQ280',
    'bundlePPFormulaNetSModelInBaseApkInQ280',
    'bindProductionModelUrlInQ280',
    'enableProductionDownloadInQ280',
    'runImageToLatexInferenceInQ280',
    'importCameraOutputWithoutMathLiveReview',
    'importCameraOutputWithoutUserApproval',
    'autoSolveCameraOutput',
    'autoGraphCameraOutput',
    'autoWriteSolutionOrHistoryFromCamera',
    'claimBridgeImplementationPassWithoutNativeDeviceEvidence',
    'claimOcrPassWithoutRealInferenceEvidence',
    'claimReleasePassWithoutStoreAuditEvidence',
  ];

  static const List<String> requiresUserSideRetest = [
    'flutter clean',
    'flutter pub get',
    'flutter analyze',
    'flutter test',
    'flutter run -d 23106RN0DA',
  ];
}
