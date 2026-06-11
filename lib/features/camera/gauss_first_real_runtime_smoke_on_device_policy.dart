class GaussFirstRealRuntimeSmokeOnDevicePolicy {
  const GaussFirstRealRuntimeSmokeOnDevicePolicy._();

  static const String phase = 'V172-Q282-FIRST-REAL-RUNTIME-SMOKE-ON-DEVICE';
  static const String sourcePhase = 'V172-Q281-PRIVATE-ARTIFACT-LOAD-REAL-SMOKE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String smokeMode = 'first-real-runtime-smoke-on-device-gate-only-dummy-input-no-image-to-latex-no-workspace-mutation';
  static const String runtimeFeatureFlagName = 'ppFormulaNetSRuntimeSmokeEnabled';

  static const int runtimeStartupTimeoutMs = 3000;
  static const int dummyInputTimeoutMs = 1200;
  static const int peakMemoryBudgetMb = 384;
  static const int maxDummyInputPayloadBytes = 4096;
  static const int minimumRequiredDeviceEvidenceFields = 18;

  static const bool firstRealRuntimeSmokeOnDeviceGateImplemented = true;
  static const bool requiresQ281PrivateArtifactLoadSmoke = true;
  static const bool requiresQ280NativeRuntimeBridge = true;
  static const bool requiresQ279DependencyTrial = true;
  static const bool requiresQ278EvidenceLock = true;
  static const bool requiresVerifiedPrivateArtifact = true;
  static const bool requiresAcceptedArtifactSha = true;
  static const bool requiresModelFormatProbeEvidence = true;
  static const bool requiresRuntimeStartupEvidence = true;
  static const bool requiresDummyInputOnlyBridgeEvidence = true;
  static const bool requiresTimeoutCancellationEvidence = true;
  static const bool requiresMemoryPressureEvidence = true;
  static const bool requiresLatencyMeasurementEvidence = true;
  static const bool requiresRealDeviceFlutterRunEvidence = true;
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

  static const bool runtimeSmokeEnvelopeAdded = true;
  static const bool realRuntimeStartedInQ282 = false;
  static const bool realDummyInputBridgeExecutedInQ282 = false;
  static const bool realModelFormatProbeExecutedInQ282 = false;
  static const bool nativeRuntimeBridgeInvokedInQ282 = false;
  static const bool imageToLatexInferenceExecuted = false;
  static const bool realOcrRuntimeAdded = false;
  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool runtimeDependencyAddedToPubspec = false;
  static const bool gradleNativeRuntimeDependencyAdded = false;
  static const bool nativeHandlerImplementationAdded = false;
  static const bool jniBindingAdded = false;
  static const bool methodChannelRuntimeBindingAdded = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionModelUrlBound = false;
  static const bool productionDownloadEnabled = false;
  static const bool realNetworkDownloadWorkerImplemented = false;
  static const bool runtimeSmokePassClaimed = false;
  static const bool imageToLatexPassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool premiumFinalPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> requiredRuntimeSmokeGates = [
    'q281PrivateArtifactLoadSmokePresent',
    'q280NativeRuntimeBridgePresent',
    'q279DependencyTrialPresent',
    'q278EvidenceLockPresent',
    'verifiedPrivateArtifactRequired',
    'acceptedArtifactShaRequired',
    'privateAppStoragePathRequired',
    'modelFormatProbeEvidenceRequired',
    'runtimeStartupEvidenceRequired',
    'dummyInputOnlyBridgeEvidenceRequired',
    'runtimeFeatureFlagDefaultOffUntilEvidence',
    'startupTimeoutBudgetRequired',
    'dummyInputTimeoutBudgetRequired',
    'memoryPressurePolicyRequired',
    'latencyMeasurementRequired',
    'realDeviceFlutterRunEvidenceRequired',
    'reviewOnlyModeRequired',
    'editableMathLiveReviewRequired',
    'explicitUserApprovalRequiredBeforeWorkspaceImport',
    'directSolveGraphSolutionHistoryBlocked',
    'noImageToLatexInferenceInQ282',
    'noOcrPassClaimInQ282',
    'protectedUiSurfacePreservation',
  ];

  static const List<String> blockedUntilRealEvidence = [
    'acceptedQ281PrivateArtifactLoadSmokeEvidence',
    'acceptedQ280NativeRuntimeBridgeEvidence',
    'acceptedQ279DependencyTrialEvidence',
    'acceptedQ278EvidenceLock',
    'realPrivateArtifactPathEvidence',
    'acceptedArtifactSha256Evidence',
    'realModelFormatProbeLog',
    'realRuntimeStartupLog',
    'realDummyInputBridgeLog',
    'realTimeoutCancellationEvidence',
    'realMemoryPressureEvidence',
    'realLatencyMeasurementEvidence',
    'realFlutterAnalyzeCleanLog',
    'realFlutterTestPassLog',
    'realFlutterRunDeviceLog',
    'realDeviceCrashFreeSmokeEvidence',
    'editableMathLiveReviewEvidence',
    'directSolveGraphSolutionHistoryBlockEvidence',
    'explicitUserApprovalForRuntimeSmokeExecution',
  ];

  static const List<String> runtimeSmokeRequestFields = [
    'requestId',
    'privateArtifactPath',
    'acceptedArtifactSha256',
    'androidAbi',
    'deviceModel',
    'androidApiLevel',
    'runtimeFeatureFlagEnabled',
    'dummyInputPayloadHash',
    'dummyInputPayloadBytes',
    'startupTimeoutMs',
    'dummyInputTimeoutMs',
    'reviewOnlyMode',
  ];

  static const List<String> runtimeSmokeResultFields = [
    'requestId',
    'status',
    'runtimeStartupAttempted',
    'dummyInputBridgeAttempted',
    'modelFormatProbeAttempted',
    'imageToLatexInferenceAttempted',
    'latencyMs',
    'peakMemoryMb',
    'errorCode',
    'warnings',
    'reviewRequired',
    'directWorkspaceMutationAttempted',
  ];

  static const List<String> runtimeSmokeErrorCodes = [
    'runtimeFeatureFlagOff',
    'missingQ281ArtifactLoadEvidence',
    'missingAcceptedArtifactSha',
    'invalidDummyInputEnvelope',
    'unsupportedAbi',
    'startupTimeout',
    'dummyInputTimeout',
    'memoryPressure',
    'nativeBridgeUnavailableInQ282',
    'noRealRuntimeSmokeExecutedInQ282',
    'unsafeImageToLatexAttempted',
    'directWorkspaceMutationAttempted',
    'unknownRuntimeSmokeError',
  ];

  static const List<String> forbiddenActions = [
    'enableRuntimeSmokeByDefaultInQ282',
    'addPaddleRuntimeDependencyInQ282',
    'addPaddleOcrDependencyInQ282',
    'addNativeHandlerImplementationInQ282',
    'addJniBindingInQ282',
    'bindRuntimeMethodChannelInQ282',
    'bundlePPFormulaNetSModelInBaseApkInQ282',
    'bindProductionModelUrlInQ282',
    'enableProductionDownloadInQ282',
    'runImageToLatexInferenceInQ282',
    'importCameraOutputWithoutMathLiveReview',
    'importCameraOutputWithoutUserApproval',
    'autoSolveCameraOutput',
    'autoGraphCameraOutput',
    'autoWriteSolutionOrHistoryFromCamera',
    'claimRuntimeSmokePassWithoutRealDeviceEvidence',
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
