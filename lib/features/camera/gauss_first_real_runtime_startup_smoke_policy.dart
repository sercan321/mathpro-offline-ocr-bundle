class GaussFirstRealRuntimeStartupSmokePolicy {
  const GaussFirstRealRuntimeStartupSmokePolicy._();

  static const String phase = 'V172-Q293-FIRST-REAL-RUNTIME-STARTUP-SMOKE';
  static const String sourcePhase = 'V172-Q292-REAL-PRIVATE-ARTIFACT-LOAD-SMOKE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String startupSmokeMode = 'runtime-startup-smoke-contract-only-blocked-until-real-artifact-load-and-native-runtime-evidence';
  static const String startupFeatureFlag = 'gauss.ppFormulaNetS.firstRealRuntimeStartupSmoke.defaultOff';
  static const String startupReadinessState = 'BLOCKED_PENDING_Q292_REAL_PRIVATE_ARTIFACT_LOAD_AND_NATIVE_RUNTIME_EVIDENCE';
  static const String runtimeActivationDecision = 'blocked-until-verified-private-artifact-native-runtime-package-model-format-probe-abi-memory-latency-and-real-device-startup-evidence';
  static const String runtimeProcessPolicy = 'isolated-runtime-startup-only-no-image-inference-no-workspace-mutation';
  static const String rollbackMode = 'delete-q293-contract-files-without-runtime-state-migration-or-private-artifact-mutation';

  static const int startupTimeoutBudgetMs = 3000;
  static const int cancellationBudgetMs = 400;
  static const int peakMemoryBudgetMb = 384;
  static const int warmupCallBudgetMs = 1200;
  static const int maximumStartupAttemptCount = 1;

  static const bool q292RealPrivateArtifactLoadRequired = true;
  static const bool q292RealPrivateArtifactLoadStillPending = true;
  static const bool verifiedPrivateArtifactRequired = true;
  static const bool expectedActualShaMatchRequired = true;
  static const bool modelFormatProbeRequiredBeforeStartup = true;
  static const bool nativeRuntimePackageRequiredBeforeStartup = true;
  static const bool supportedAndroidAbiRequired = true;
  static const bool startupTimeoutPolicyRequired = true;
  static const bool startupCancellationPolicyRequired = true;
  static const bool memoryPressurePolicyRequired = true;
  static const bool startupEvidenceLogRequired = true;
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

  static const bool startupFeatureFlagEnabledByDefault = false;
  static const bool realRuntimeStartupExecuted = false;
  static const bool nativeRuntimePackageBundled = false;
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
  static const bool imageToLatexInferenceExecuted = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionDownloadEnabled = false;
  static const bool directWorkspaceImportEnabled = false;
  static const bool directSolveGraphSolutionHistoryEnabled = false;
  static const bool runtimeStartupPassClaimed = false;
  static const bool runtimeSmokePassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool storeReadyPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> runtimeStartupSmokePreconditions = [
    'q292-real-private-artifact-load-smoke-present',
    'q292-real-private-artifact-load-still-pending',
    'verified-private-artifact-required-before-runtime-startup',
    'expected-actual-sha256-match-required-before-runtime-startup',
    'model-format-probe-required-before-runtime-startup',
    'native-runtime-package-required-before-runtime-startup',
    'supported-android-abi-required-before-runtime-startup',
    'startup-timeout-budget-required',
    'startup-cancellation-policy-required',
    'memory-pressure-policy-required',
    'runtime-startup-evidence-log-required',
    'editable-mathlive-review-and-explicit-user-approval-remain-mandatory',
    'direct-solve-graph-solution-history-remain-blocked-for-camera-output',
    'no-real-runtime-startup-without-user-side-native-runtime-evidence',
  ];

  static const List<String> runtimeStartupRequestFields = [
    'requestId',
    'engineLabel',
    'verifiedPrivateArtifactPath',
    'expectedSha256',
    'actualSha256',
    'runtimePackageId',
    'androidAbi',
    'startupTimeoutMs',
    'startupFeatureFlagEnabled',
    'modelFormatProbeStatus',
    'privateArtifactLoadStatus',
    'startupMode',
  ];

  static const List<String> runtimeStartupResultFields = [
    'requestId',
    'status',
    'runtimeProcessStarted',
    'modelArtifactOpened',
    'modelFormatProbePassed',
    'warmupCallExecuted',
    'imageInferenceExecuted',
    'errorCode',
    'warnings',
    'startupLatencyMs',
    'peakMemoryMb',
    'reviewRequired',
    'directWorkspaceMutationAttempted',
  ];

  static const List<String> runtimeStartupErrorCodes = [
    'startupFeatureFlagOff',
    'verifiedArtifactMissing',
    'artifactShaMismatch',
    'privateArtifactLoadMissing',
    'modelFormatProbeMissing',
    'nativeRuntimePackageMissing',
    'unsupportedAbi',
    'methodChannelNotBound',
    'nativeHandlerNotImplemented',
    'startupTimeout',
    'startupCancelled',
    'memoryPressure',
    'noRealRuntimeStartupExecutedInQ293',
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
