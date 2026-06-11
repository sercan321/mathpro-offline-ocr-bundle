class GaussFirstRealImageToLatexInferenceCourtPolicy {
  const GaussFirstRealImageToLatexInferenceCourtPolicy._();

  static const String phase = 'V172-Q283-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-COURT';
  static const String sourcePhase = 'V172-Q282-FIRST-REAL-RUNTIME-SMOKE-ON-DEVICE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String courtMode = 'first-real-image-to-latex-inference-court-gate-only-no-real-inference-no-direct-import';
  static const String featureFlagName = 'ppFormulaNetSImageToLatexCourtEnabled';

  static const int maxInputImageBytes = 8 * 1024 * 1024;
  static const int maxInferenceLatencyMs = 4500;
  static const int peakMemoryBudgetMb = 512;
  static const int minimumRequiredCandidateFields = 14;

  static const bool firstRealImageToLatexInferenceCourtImplemented = true;
  static const bool requiresQ282FirstRealRuntimeSmokeOnDevice = true;
  static const bool requiresQ281PrivateArtifactLoadSmoke = true;
  static const bool requiresQ280NativeRuntimeBridge = true;
  static const bool requiresQ279DependencyTrial = true;
  static const bool requiresQ278EvidenceLock = true;
  static const bool requiresAcceptedRuntimeSmokeEvidence = true;
  static const bool requiresCroppedImageEvidence = true;
  static const bool requiresPreprocessMetadataEvidence = true;
  static const bool requiresRuntimeCandidateEnvelope = true;
  static const bool requiresConfidenceWarningsEngineMetadata = true;
  static const bool editableMathLiveReviewRequired = true;
  static const bool explicitUserApprovalRequiredBeforeWorkspaceImport = true;
  static const bool directSolveGraphSolutionHistoryBlocked = true;

  static const bool keyboardLayoutChanged = false;
  static const bool moreTemplateTrayChanged = false;
  static const bool longPressListsChanged = false;
  static const bool mathLiveProductionRouteChanged = false;
  static const bool graphSolutionHistoryRuntimeChanged = false;
  static const bool cameraShellRuntimeChanged = false;
  static const bool solverEvaluatorChanged = false;
  static const bool splashIconChanged = false;

  static const bool imageToLatexCourtEnvelopeAdded = true;
  static const bool realImageToLatexInferenceExecutedInQ283 = false;
  static const bool realRuntimeInvocationExecutedInQ283 = false;
  static const bool nativeRuntimeBridgeInvokedInQ283 = false;
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
  static const bool directWorkspaceMutationAllowed = false;
  static const bool imageToLatexPassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool premiumFinalPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> requiredImageToLatexCourtGates = [
    'q282FirstRealRuntimeSmokeOnDevicePresent',
    'acceptedQ282RuntimeSmokeEvidenceRequired',
    'q281PrivateArtifactLoadSmokePresent',
    'q280NativeRuntimeBridgePresent',
    'q279DependencyTrialPresent',
    'q278EvidenceLockPresent',
    'croppedImagePathRequired',
    'croppedImageSha256Required',
    'cropBoundsRequired',
    'rotationAndOrientationRequired',
    'lightingAndFocusHintsRequired',
    'preprocessProfileRequired',
    'runtimeCandidateEnvelopeRequired',
    'primaryLatexCandidateRequired',
    'alternativeLatexCandidatesAllowed',
    'confidenceWarningsEngineMetadataRequired',
    'latencyMeasurementRequired',
    'peakMemoryMeasurementRequired',
    'timeoutCancellationPolicyRequired',
    'memoryPressurePolicyRequired',
    'featureFlagDefaultOffUntilEvidence',
    'editableMathLiveReviewRequired',
    'explicitUserApprovalRequiredBeforeWorkspaceImport',
    'directSolveGraphSolutionHistoryBlocked',
    'protectedUiSurfacePreservation',
    'noImageToLatexPassClaimWithoutRealEvidence',
  ];

  static const List<String> blockedUntilRealEvidence = [
    'acceptedQ282RuntimeSmokeEvidence',
    'acceptedQ281PrivateArtifactLoadSmokeEvidence',
    'acceptedQ280NativeRuntimeBridgeEvidence',
    'acceptedQ279DependencyTrialEvidence',
    'acceptedQ278EvidenceLock',
    'realCroppedImageCaptureEvidence',
    'realCroppedImageSha256Evidence',
    'realPreprocessMetadataEvidence',
    'realRuntimeCandidateResponseEvidence',
    'realPrimaryLatexCandidateEvidence',
    'realAlternativeLatexCandidateEvidence',
    'realConfidenceWarningsEngineMetadataEvidence',
    'realLatencyMeasurementEvidence',
    'realPeakMemoryMeasurementEvidence',
    'realTimeoutCancellationEvidence',
    'realMemoryPressureEvidence',
    'realFlutterAnalyzeCleanLog',
    'realFlutterTestPassLog',
    'realFlutterRunDeviceLog',
    'realDeviceCrashFreeInferenceCourtEvidence',
    'editableMathLiveReviewEvidence',
    'directSolveGraphSolutionHistoryBlockEvidence',
    'explicitUserApprovalForImageToLatexInferenceCourt',
  ];

  static const List<String> imageInputEnvelopeFields = [
    'requestId',
    'captureId',
    'croppedImagePath',
    'croppedImageSha256',
    'croppedImageBytes',
    'cropBounds',
    'rotationDegrees',
    'orientationLabel',
    'lightingHint',
    'focusHint',
    'preprocessProfile',
    'runtimeFeatureFlagEnabled',
    'reviewOnlyMode',
  ];

  static const List<String> latexCandidateEnvelopeFields = [
    'requestId',
    'engineLabel',
    'primaryLatexCandidate',
    'alternativeLatexCandidates',
    'confidence',
    'warnings',
    'engineMetadata',
    'latencyMs',
    'peakMemoryMb',
    'mathLiveReviewRequired',
    'userApprovalRequiredBeforeWorkspaceImport',
    'directWorkspaceMutationAttempted',
    'directSolveGraphSolutionHistoryAttempted',
    'errorCode',
  ];

  static const List<String> imageToLatexCourtErrorCodes = [
    'imageToLatexFeatureFlagOff',
    'missingQ282RuntimeSmokeEvidence',
    'invalidCroppedImageEnvelope',
    'missingPreprocessMetadata',
    'nativeRuntimeBridgeUnavailableInQ283',
    'noRealImageToLatexInferenceExecutedInQ283',
    'unsafeDirectWorkspaceMutationAttempted',
    'unsafeDirectSolveGraphSolutionHistoryAttempted',
    'mathLiveReviewMissing',
    'unknownImageToLatexCourtError',
  ];

  static const List<String> forbiddenActions = [
    'enableImageToLatexCourtByDefaultInQ283',
    'addPaddleRuntimeDependencyInQ283',
    'addPaddleOcrDependencyInQ283',
    'addNativeHandlerImplementationInQ283',
    'addJniBindingInQ283',
    'bindRuntimeMethodChannelInQ283',
    'bundlePPFormulaNetSModelInBaseApkInQ283',
    'bindProductionModelUrlInQ283',
    'enableProductionDownloadInQ283',
    'runRealImageToLatexInferenceInQ283',
    'importCameraOutputWithoutMathLiveReview',
    'importCameraOutputWithoutUserApproval',
    'autoSolveCameraOutput',
    'autoGraphCameraOutput',
    'autoWriteSolutionOrHistoryFromCamera',
    'claimImageToLatexPassWithoutRealEvidence',
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
