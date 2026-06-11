class GaussRealPrivateArtifactLoadSmokePolicy {
  const GaussRealPrivateArtifactLoadSmokePolicy._();

  static const String phase = 'V172-Q292-REAL-PRIVATE-ARTIFACT-LOAD-SMOKE';
  static const String sourcePhase = 'V172-Q291-PRIVATE-MODEL-DOWNLOAD-SHA-VERIFICATION-RUNTIME';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String smokeMode = 'real-private-artifact-load-smoke-contract-only-blocked-until-verified-artifact-evidence';
  static const String loadFeatureFlag = 'gauss.ppFormulaNetS.realPrivateArtifactLoadSmoke.defaultOff';
  static const String verifiedPrivateArtifactState = 'BLOCKED_PENDING_REAL_VERIFIED_PRIVATE_ARTIFACT';
  static const String artifactAcceptanceDecision = 'blocked-until-q291-verified-private-artifact-expected-sha-actual-sha-atomic-move-and-real-device-load-evidence';
  static const String privateArtifactRootPolicy = 'application-private-files-dir-only';
  static const String modelFormatProbeMode = 'format-probe-planned-only-no-real-probe-executed';
  static const String rollbackMode = 'delete-q292-contract-files-without-runtime-state-migration-or-private-artifact-mutation';

  static const int maxArtifactSizeBudgetMb = 260;
  static const int loadTimeoutBudgetMs = 2500;
  static const int formatProbeTimeoutBudgetMs = 900;
  static const int peakMemoryBudgetMb = 384;
  static const int cancellationBudgetMs = 400;

  static const bool q291DownloadShaVerificationRequired = true;
  static const bool q291VerifiedArtifactStillPending = true;
  static const bool expectedSha256Required = true;
  static const bool actualSha256Required = true;
  static const bool checksumMatchRequiredBeforeLoad = true;
  static const bool atomicMoveCompletedEvidenceRequired = true;
  static const bool privateAppStoragePathRequired = true;
  static const bool modelFormatProbePlanRequired = true;
  static const bool dummyInputOnlySmokeRequired = true;
  static const bool timeoutCancellationPolicyRequired = true;
  static const bool memoryPressurePolicyRequired = true;
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

  static const bool loadFeatureFlagEnabledByDefault = false;
  static const bool realPrivateArtifactFileLoaded = false;
  static const bool modelFormatProbeExecuted = false;
  static const bool nativeRuntimeBridgeInvoked = false;
  static const bool runtimeInvocationEnabled = false;
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
  static const bool privateArtifactLoadPassClaimed = false;
  static const bool runtimeSmokePassClaimed = false;
  static const bool modelFormatProbePassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool storeReadyPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> privateArtifactLoadSmokePreconditions = [
    'q291-private-model-download-sha-verification-present',
    'q291-verified-private-artifact-still-pending',
    'expected-sha256-required-before-private-artifact-load',
    'actual-sha256-required-before-private-artifact-load',
    'expected-actual-sha256-match-required-before-load',
    'atomic-move-completed-evidence-required-before-load',
    'private-app-storage-path-required',
    'model-format-probe-plan-required',
    'dummy-input-only-smoke-required-before-inference',
    'load-timeout-budget-required',
    'memory-pressure-policy-required',
    'editable-mathlive-review-and-explicit-user-approval-remain-mandatory',
    'direct-solve-graph-solution-history-remain-blocked-for-camera-output',
    'no-real-private-artifact-load-without-user-side-evidence',
  ];

  static const List<String> privateArtifactLoadRequestFields = [
    'requestId',
    'engineLabel',
    'verifiedPrivatePath',
    'expectedSha256',
    'actualSha256',
    'artifactSizeBytes',
    'androidAbi',
    'timeoutMs',
    'loadFeatureFlagEnabled',
    'privateStoragePathVerified',
    'checksumStatus',
    'atomicMoveStatus',
    'dummyInputOnly',
  ];

  static const List<String> privateArtifactLoadResultFields = [
    'requestId',
    'status',
    'artifactPathAccepted',
    'shaMatch',
    'realFileLoadExecuted',
    'modelFormatProbeExecuted',
    'runtimeBridgeInvoked',
    'errorCode',
    'warnings',
    'latencyMs',
    'reviewRequired',
    'directWorkspaceMutationAttempted',
  ];

  static const List<String> artifactLoadErrorCodes = [
    'loadFeatureFlagOff',
    'verifiedArtifactMissing',
    'privateStoragePathNotVerified',
    'invalidExpectedSha256',
    'invalidActualSha256',
    'artifactShaMismatch',
    'atomicMoveEvidenceMissing',
    'artifactTooLargeForBudget',
    'unsupportedAbi',
    'noRealArtifactLoadExecutedInQ292',
    'timeout',
    'cancelled',
    'memoryPressure',
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
