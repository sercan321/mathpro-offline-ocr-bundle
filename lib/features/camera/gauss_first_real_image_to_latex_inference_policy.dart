class GaussFirstRealImageToLatexInferencePolicy {
  const GaussFirstRealImageToLatexInferencePolicy._();

  static const String phase = 'V172-Q295-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE';
  static const String sourcePhase = 'V172-Q294-FIRST-REAL-DUMMY-INPUT-RUNTIME-CALL';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String inferenceMode = 'first-real-image-to-latex-inference-contract-only-real-inference-blocked';
  static const String inferenceFeatureFlag = 'gauss.ppFormulaNetS.firstRealImageToLatexInference.defaultOff';
  static const String inferenceReadinessState = 'BLOCKED_PENDING_Q294_REAL_DUMMY_INPUT_RUNTIME_CALL_AND_CAMERA_IMAGE_EVIDENCE';
  static const String inferenceDecision = 'blocked-until-real-dummy-input-runtime-call-cropped-image-preprocess-runtime-response-review-and-user-approval-evidence';
  static const String inferencePolicy = 'camera-image-to-latex-candidate-only-review-first-no-direct-workspace-no-solve-graph-solution-history';
  static const String rollbackMode = 'delete-q295-contract-files-without-runtime-state-migration-private-artifact-mutation-or-workspace-data-change';

  static const int maxInputImageBytes = 8 * 1024 * 1024;
  static const int inferenceTimeoutBudgetMs = 4500;
  static const int cancellationBudgetMs = 600;
  static const int peakMemoryBudgetMb = 512;
  static const int maximumInferenceAttemptCount = 1;
  static const double minimumCandidateConfidenceForReviewHintOnly = 0.0;

  static const bool q294FirstRealDummyInputRuntimeCallRequired = true;
  static const bool q294RealDummyInputRuntimeCallStillPending = true;
  static const bool q293RuntimeStartupEvidenceRequired = true;
  static const bool verifiedPrivateArtifactRequired = true;
  static const bool expectedActualShaMatchRequired = true;
  static const bool modelFormatProbeRequired = true;
  static const bool methodChannelBindingRequired = true;
  static const bool nativeHandlerRequired = true;
  static const bool deterministicDummyInputCallEvidenceRequired = true;
  static const bool croppedImageEvidenceRequired = true;
  static const bool croppedImageSha256Required = true;
  static const bool cropBoundsRequired = true;
  static const bool preprocessMetadataRequired = true;
  static const bool runtimeCandidateEnvelopeRequired = true;
  static const bool primaryLatexCandidateFieldRequired = true;
  static const bool alternativeLatexCandidatesAllowed = true;
  static const bool confidenceWarningsEngineMetadataRequired = true;
  static const bool inferenceLatencyEvidenceRequired = true;
  static const bool peakMemoryEvidenceRequired = true;
  static const bool timeoutCancellationEvidenceRequired = true;
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

  static const bool inferenceFeatureFlagEnabledByDefault = false;
  static const bool realImageToLatexInferenceExecuted = false;
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
  static const bool cameraImageSentToNativeRuntime = false;
  static const bool latexCandidateReturnedByRuntime = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionDownloadEnabled = false;
  static const bool directWorkspaceImportEnabled = false;
  static const bool directSolveGraphSolutionHistoryEnabled = false;
  static const bool imageToLatexPassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool storeReadyPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> firstRealImageToLatexInferencePreconditions = [
    'q294-first-real-dummy-input-runtime-call-present',
    'q294-real-dummy-input-runtime-call-still-pending',
    'q293-runtime-startup-evidence-required',
    'verified-private-artifact-required-before-image-inference',
    'expected-actual-sha256-match-required-before-image-inference',
    'model-format-probe-required-before-image-inference',
    'method-channel-binding-required-before-image-inference',
    'native-handler-required-before-image-inference',
    'dummy-input-runtime-call-evidence-required-before-camera-image',
    'cropped-image-path-required',
    'cropped-image-sha256-required',
    'crop-bounds-required',
    'rotation-orientation-lighting-focus-required',
    'preprocess-metadata-required',
    'runtime-candidate-envelope-required',
    'primary-latex-candidate-field-required',
    'alternative-latex-candidates-allowed',
    'confidence-warnings-engine-metadata-required',
    'latency-peak-memory-timeout-cancellation-evidence-required',
    'editable-mathlive-review-and-explicit-user-approval-remain-mandatory',
    'direct-solve-graph-solution-history-remain-blocked-for-camera-output',
    'no-real-image-to-latex-inference-without-user-side-runtime-and-image-evidence',
  ];

  static const List<String> imageToLatexInferenceRequestFields = [
    'requestId',
    'engineLabel',
    'runtimeSessionId',
    'verifiedPrivateArtifactPath',
    'expectedSha256',
    'actualSha256',
    'androidAbi',
    'captureId',
    'croppedImagePath',
    'croppedImageSha256',
    'croppedImageBytes',
    'cropLeft',
    'cropTop',
    'cropWidth',
    'cropHeight',
    'rotationDegrees',
    'orientationLabel',
    'lightingHint',
    'focusHint',
    'preprocessProfile',
    'timeoutMs',
    'inferenceFeatureFlagEnabled',
    'dummyInputRuntimeCallStatus',
    'callMode',
  ];

  static const List<String> imageToLatexInferenceResultFields = [
    'requestId',
    'status',
    'runtimeSessionUsed',
    'cameraImageSent',
    'nativeRuntimeInvoked',
    'latexCandidateReturned',
    'primaryLatexCandidate',
    'alternativeLatexCandidates',
    'confidence',
    'warnings',
    'engineMetadata',
    'errorCode',
    'inferenceLatencyMs',
    'peakMemoryMb',
    'reviewRequired',
    'directWorkspaceMutationAttempted',
  ];

  static const List<String> imageToLatexInferenceErrorCodes = [
    'imageToLatexFeatureFlagOff',
    'q294DummyInputCallMissing',
    'runtimeStartupMissing',
    'methodChannelNotBound',
    'nativeHandlerNotImplemented',
    'verifiedArtifactMissing',
    'artifactShaMismatch',
    'modelFormatProbeMissing',
    'croppedImageMissing',
    'croppedImageShaMissing',
    'invalidCropBounds',
    'imageTooLarge',
    'preprocessMetadataMissing',
    'runtimeCandidateMissing',
    'latexCandidateMissing',
    'imageToLatexTimeout',
    'imageToLatexCancelled',
    'memoryPressure',
    'noRealImageToLatexInferenceExecutedInQ295',
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
