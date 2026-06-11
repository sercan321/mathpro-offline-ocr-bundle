class GaussFirstRealDummyInputRuntimeCallPolicy {
  const GaussFirstRealDummyInputRuntimeCallPolicy._();

  static const String phase = 'V172-Q294-FIRST-REAL-DUMMY-INPUT-RUNTIME-CALL';
  static const String sourcePhase = 'V172-Q293-FIRST-REAL-RUNTIME-STARTUP-SMOKE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String dummyInputCallMode = 'dummy-input-runtime-call-contract-only-blocked-until-real-runtime-startup-evidence';
  static const String dummyCallFeatureFlag = 'gauss.ppFormulaNetS.firstRealDummyInputRuntimeCall.defaultOff';
  static const String dummyCallReadinessState = 'BLOCKED_PENDING_Q293_REAL_RUNTIME_STARTUP_AND_METHOD_CHANNEL_EVIDENCE';
  static const String runtimeInvocationDecision = 'blocked-until-real-runtime-startup-method-channel-native-handler-dummy-input-fixture-timeout-memory-and-real-device-call-evidence';
  static const String runtimeCallPolicy = 'dummy-input-only-no-camera-image-no-image-to-latex-no-workspace-mutation';
  static const String rollbackMode = 'delete-q294-contract-files-without-runtime-state-migration-or-private-artifact-mutation';

  static const int dummyInputTimeoutBudgetMs = 1800;
  static const int cancellationBudgetMs = 400;
  static const int peakMemoryBudgetMb = 384;
  static const int maximumDummyCallAttemptCount = 1;

  static const bool q293FirstRealRuntimeStartupRequired = true;
  static const bool q293RealRuntimeStartupStillPending = true;
  static const bool verifiedPrivateArtifactRequired = true;
  static const bool expectedActualShaMatchRequired = true;
  static const bool modelFormatProbeRequired = true;
  static const bool nativeRuntimeStartupRequiredBeforeDummyCall = true;
  static const bool methodChannelBindingRequiredBeforeDummyCall = true;
  static const bool nativeHandlerRequiredBeforeDummyCall = true;
  static const bool deterministicDummyInputFixtureRequired = true;
  static const bool dummyInputTimeoutPolicyRequired = true;
  static const bool dummyInputCancellationPolicyRequired = true;
  static const bool memoryPressurePolicyRequired = true;
  static const bool dummyInputEvidenceLogRequired = true;
  static const bool editableMathLiveReviewRequired = true;
  static const bool explicitUserApprovalRequiredBeforeWorkspaceImport = true;
  static const bool directSolveGraphSolutionHistoryBlocked = true;

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

  static const bool dummyCallFeatureFlagEnabledByDefault = false;
  static const bool realDummyInputRuntimeCallExecuted = false;
  static const bool nativeRuntimeStartupExecuted = false;
  static const bool nativeRuntimeHandlerImplemented = false;
  static const bool methodChannelRuntimeBindingAdded = false;
  static const bool jniBindingAdded = false;
  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool runtimeDependencyAddedToPubspec = false;
  static const bool gradleNativeRuntimeDependencyAdded = false;
  static const bool realPrivateArtifactFileLoaded = false;
  static const bool modelFormatProbeExecuted = false;
  static const bool runtimeWarmupCallExecuted = false;
  static const bool dummyInputFixtureSentToNativeRuntime = false;
  static const bool dummyRuntimeResponseParsed = false;
  static const bool imageToLatexInferenceExecuted = false;
  static const bool cameraImageUsedAsInput = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionDownloadEnabled = false;
  static const bool directWorkspaceImportEnabled = false;
  static const bool directSolveGraphSolutionHistoryEnabled = false;
  static const bool runtimeDummyCallPassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool storeReadyPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> dummyInputRuntimeCallPreconditions = [
    'q293-first-real-runtime-startup-smoke-present',
    'q293-real-runtime-startup-still-pending',
    'verified-private-artifact-required-before-dummy-call',
    'expected-actual-sha256-match-required-before-dummy-call',
    'model-format-probe-required-before-dummy-call',
    'native-runtime-startup-required-before-dummy-call',
    'method-channel-binding-required-before-dummy-call',
    'native-handler-required-before-dummy-call',
    'deterministic-dummy-input-fixture-required',
    'dummy-input-timeout-budget-required',
    'dummy-input-cancellation-policy-required',
    'memory-pressure-policy-required',
    'dummy-input-evidence-log-required',
    'editable-mathlive-review-and-explicit-user-approval-remain-mandatory',
    'direct-solve-graph-solution-history-remain-blocked-for-camera-output',
    'no-real-dummy-input-call-without-user-side-runtime-startup-evidence',
  ];

  static const List<String> dummyInputRuntimeCallRequestFields = [
    'requestId',
    'engineLabel',
    'runtimeSessionId',
    'verifiedPrivateArtifactPath',
    'expectedSha256',
    'actualSha256',
    'androidAbi',
    'dummyInputFixtureId',
    'dummyInputPayloadHash',
    'timeoutMs',
    'dummyCallFeatureFlagEnabled',
    'runtimeStartupStatus',
    'methodChannelBindingStatus',
    'nativeHandlerStatus',
    'callMode',
  ];

  static const List<String> dummyInputRuntimeCallResultFields = [
    'requestId',
    'status',
    'runtimeSessionUsed',
    'dummyInputSent',
    'nativeRuntimeInvoked',
    'dummyResponseParsed',
    'imageInferenceExecuted',
    'errorCode',
    'warnings',
    'dummyCallLatencyMs',
    'peakMemoryMb',
    'reviewRequired',
    'directWorkspaceMutationAttempted',
  ];

  static const List<String> dummyInputRuntimeCallErrorCodes = [
    'dummyCallFeatureFlagOff',
    'runtimeStartupMissing',
    'methodChannelNotBound',
    'nativeHandlerNotImplemented',
    'verifiedArtifactMissing',
    'artifactShaMismatch',
    'modelFormatProbeMissing',
    'dummyInputFixtureMissing',
    'dummyPayloadHashMissing',
    'dummyCallTimeout',
    'dummyCallCancelled',
    'memoryPressure',
    'noRealDummyInputRuntimeCallExecutedInQ294',
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
