class GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy {
  const GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy._();

  static const String phase = 'V172-Q290-NATIVE-RUNTIME-HANDLER-SKELETON-ANDROID-BINDING';
  static const String sourcePhase = 'V172-Q289-RUNTIME-DEPENDENCY-ACTUAL-TRIAL-BEHIND-DEFAULT-OFF-FLAG';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String skeletonMode = 'native-runtime-handler-skeleton-contract-only-no-android-runtime-binding-no-inference';
  static const String reservedMethodChannelName = 'com.mathpro.gauss/pp_formulanet_s_runtime';
  static const String reservedNativeHandlerName = 'GaussPpFormulaNetSRuntimeHandler';
  static const String reservedAndroidEntryPoint = 'MainActivity-to-future-runtime-handler-contract-only';
  static const String bridgeFeatureFlag = 'gauss.ppFormulaNetS.nativeRuntimeHandler.defaultOff';
  static const String bindingDecision = 'blocked-until-q289-default-off-trial-real-artifact-sha-abi-runtime-package-and-user-side-smoke-evidence';
  static const String rollbackMode = 'delete-q290-contract-files-without-runtime-state-migration';

  static const int requestTimeoutBudgetMs = 2500;
  static const int cancellationBudgetMs = 400;
  static const int peakMemoryBudgetMb = 384;
  static const int maximumAlternativeCandidateCount = 4;

  static const bool q289DependencyTrialRequired = true;
  static const bool q289DependencyTrialStillBlocked = true;
  static const bool q288ArtifactSha256StillPending = true;
  static const bool nativeHandlerSkeletonContractDefined = true;
  static const bool methodChannelProtocolReserved = true;
  static const bool requestEnvelopeRequired = true;
  static const bool responseEnvelopeRequired = true;
  static const bool errorTaxonomyRequired = true;
  static const bool timeoutCancellationPolicyRequired = true;
  static const bool memoryPressurePolicyRequired = true;
  static const bool editableMathLiveReviewRequired = true;
  static const bool explicitUserApprovalRequiredBeforeWorkspaceImport = true;
  static const bool directSolveGraphSolutionHistoryBlocked = true;
  static const bool rollbackRequiredBeforeActivation = true;

  static const bool changesRuntimeBehavior = false;
  static const bool keyboardLayoutChanged = false;
  static const bool moreTemplateTrayChanged = false;
  static const bool longPressListsChanged = false;
  static const bool graphSolutionHistoryChanged = false;
  static const bool mathLiveProductionRouteChanged = false;
  static const bool cameraShellRuntimeChanged = false;
  static const bool workspaceRuntimeChanged = false;
  static const bool solverEvaluatorChanged = false;
  static const bool androidToolchainChanged = false;
  static const bool cameraDependencyChanged = false;
  static const bool androidManifestChanged = false;
  static const bool mainActivityChanged = false;

  static const bool bridgeFeatureFlagEnabledByDefault = false;
  static const bool runtimeInvocationAllowedWhenFlagOff = false;
  static const bool nativeHandlerImplementationAdded = false;
  static const bool androidBindingImplementationAdded = false;
  static const bool jniBindingAdded = false;
  static const bool methodChannelRuntimeBindingAdded = false;
  static const bool realOcrRuntimeAdded = false;
  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool runtimeDependencyAddedToPubspec = false;
  static const bool gradleNativeRuntimeDependencyAdded = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionModelUrlBound = false;
  static const bool productionDownloadEnabled = false;
  static const bool realNetworkDownloadWorkerImplemented = false;
  static const bool imageToLatexInferenceExecuted = false;
  static const bool directWorkspaceImportEnabled = false;
  static const bool directSolveGraphSolutionHistoryEnabled = false;
  static const bool nativeHandlerSkeletonPassClaimed = false;
  static const bool androidBindingPassClaimed = false;
  static const bool runtimeIntegrationPassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool storeReadyPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> requestEnvelopeFields = [
    'requestId',
    'croppedImagePrivatePath',
    'verifiedArtifactPrivatePath',
    'expectedArtifactSha256',
    'actualArtifactSha256',
    'androidAbi',
    'timeoutMs',
    'reviewOnlyMode',
    'runtimeFeatureFlagEnabled',
  ];

  static const List<String> responseEnvelopeFields = [
    'requestId',
    'status',
    'primaryLatexCandidate',
    'alternativeLatexCandidates',
    'confidence',
    'warnings',
    'errorCode',
    'engineMetadata',
    'latencyMs',
    'peakMemoryMb',
    'reviewRequired',
    'directWorkspaceMutationAttempted',
  ];

  static const List<String> bridgeErrorCodes = [
    'runtimeFeatureFlagOff',
    'nativeHandlerNotImplemented',
    'methodChannelNotBound',
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

  static const List<String> handlerSkeletonPreconditions = [
    'q289-runtime-dependency-trial-default-off-present',
    'q288-real-artifact-sha256-still-pending',
    'method-channel-name-reserved-without-binding',
    'native-handler-name-reserved-without-implementation',
    'request-envelope-documented',
    'response-envelope-documented',
    'error-taxonomy-documented',
    'timeout-cancellation-policy-documented',
    'memory-pressure-policy-documented',
    'runtime-invocation-blocked-while-flag-off',
    'model-binary-stays-out-of-base-apk',
    'editable-mathlive-review-and-explicit-user-approval-remain-mandatory',
    'direct-solve-graph-solution-history-remain-blocked-for-camera-output',
  ];

  static const List<String> forbiddenActions = [
    'modify-mainactivity-for-q290-runtime-binding',
    'modify-androidmanifest-for-q290-runtime-binding',
    'add-methodchannel-runtime-binding-in-q290',
    'add-jni-binding-in-q290',
    'add-native-runtime-handler-implementation-in-q290',
    'add-paddle-runtime-dependency-in-q290',
    'add-paddleocr-dependency-in-q290',
    'bundle-pp-formulanet-s-model-in-base-apk-in-q290',
    'enable-production-download-in-q290',
    'run-image-to-latex-inference-in-q290',
    'import-camera-output-without-mathlive-review',
    'auto-solve-camera-output',
    'auto-graph-camera-output',
    'auto-write-solution-or-history-from-camera',
    'claim-android-binding-pass-without-real-device-log',
    'claim-ocr-pass-without-real-inference-evidence',
    'claim-release-pass-without-store-audit-evidence',
  ];

  static const List<String> blockedDependencyFamilies = [
    'paddleocr',
    'paddle_ocr',
    'paddle_flutter',
    'paddle_lite',
    'onnxruntime',
    'tesseract',
    'pix2text',
    'flutter_downloader',
    'background_downloader',
    'dio',
  ];

  static const List<String> requiresUserSideRetest = [
    'flutter clean',
    'flutter pub get',
    'flutter analyze',
    'flutter test',
    'flutter run -d 23106RN0DA',
  ];
}
