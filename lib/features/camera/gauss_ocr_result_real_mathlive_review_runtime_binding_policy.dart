class GaussOcrResultRealMathLiveReviewRuntimeBindingPolicy {
  const GaussOcrResultRealMathLiveReviewRuntimeBindingPolicy._();

  static const String phase = 'V172-Q284-OCR-RESULT-REAL-MATHLIVE-REVIEW-RUNTIME-BINDING';
  static const String sourcePhase = 'V172-Q283-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-COURT';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String bindingMode = 'ocr-result-real-mathlive-review-runtime-binding-gate-only-no-real-inference-no-direct-import';
  static const String reviewFeatureFlagName = 'ppFormulaNetSRuntimeReviewBindingEnabled';

  static const int minimumRequiredReviewFields = 18;
  static const int maxEditableLatexLength = 16000;
  static const int maxAlternativeCandidateCount = 8;

  static const bool ocrResultRealMathLiveReviewRuntimeBindingImplemented = true;
  static const bool requiresQ283FirstRealImageToLatexInferenceCourt = true;
  static const bool requiresQ282RuntimeSmokeEvidence = true;
  static const bool requiresQ281PrivateArtifactLoadSmoke = true;
  static const bool requiresQ280NativeRuntimeBridge = true;
  static const bool requiresQ279DependencyTrial = true;
  static const bool requiresQ278EvidenceLock = true;
  static const bool requiresRuntimeCandidateEnvelope = true;
  static const bool requiresPrimaryLatexCandidate = true;
  static const bool requiresCandidateAlternativesConfidenceWarningsMetadata = true;
  static const bool requiresImageInputMetadata = true;
  static const bool editableMathLiveReviewRequired = true;
  static const bool reviewDraftMustRemainEditable = true;
  static const bool explicitUserApprovalRequiredBeforeWorkspaceImport = true;
  static const bool workspaceImportPreparedOnlyAfterUserApproval = true;
  static const bool directWorkspaceImportBlocked = true;
  static const bool directSolveGraphSolutionHistoryBlocked = true;

  static const bool keyboardLayoutChanged = false;
  static const bool moreTemplateTrayChanged = false;
  static const bool longPressListsChanged = false;
  static const bool mathLiveProductionRouteChanged = false;
  static const bool graphSolutionHistoryRuntimeChanged = false;
  static const bool cameraShellRuntimeChanged = false;
  static const bool solverEvaluatorChanged = false;
  static const bool splashIconChanged = false;

  static const bool realMathLiveReviewRuntimeBindingExecutedInQ284 = false;
  static const bool realImageToLatexInferenceExecutedInQ284 = false;
  static const bool realRuntimeInvocationExecutedInQ284 = false;
  static const bool nativeRuntimeBridgeInvokedInQ284 = false;
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
  static const bool reviewBindingPassClaimed = false;
  static const bool imageToLatexPassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool premiumFinalPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> requiredReviewRuntimeBindingGates = [
    'q283FirstRealImageToLatexInferenceCourtPresent',
    'acceptedQ283ImageToLatexCandidateEvidenceRequired',
    'q282FirstRealRuntimeSmokeOnDevicePresent',
    'q281PrivateArtifactLoadSmokePresent',
    'q280NativeRuntimeBridgePresent',
    'q279DependencyTrialPresent',
    'q278EvidenceLockPresent',
    'runtimeCandidateEnvelopeRequired',
    'primaryLatexCandidateRequired',
    'alternativeCandidatesPreserved',
    'confidenceWarningsEngineMetadataPreserved',
    'imageInputMetadataPreserved',
    'editableLatexDraftRequired',
    'mathLiveReviewRequired',
    'reviewDraftMustRemainEditable',
    'explicitUserApprovalRequiredBeforeWorkspaceImport',
    'workspaceImportPreparedOnlyAfterUserApproval',
    'directWorkspaceImportBlocked',
    'directSolveGraphSolutionHistoryBlocked',
    'protectedUiSurfacePreservation',
    'noReviewBindingPassClaimWithoutRealEvidence',
    'noOcrPassClaimWithoutRealInferenceEvidence',
  ];

  static const List<String> blockedUntilRealEvidence = [
    'acceptedQ283ImageToLatexCandidateEvidence',
    'acceptedQ282RuntimeSmokeEvidence',
    'acceptedQ281PrivateArtifactLoadSmokeEvidence',
    'acceptedQ280NativeRuntimeBridgeEvidence',
    'acceptedQ279DependencyTrialEvidence',
    'acceptedQ278EvidenceLock',
    'realRuntimeCandidateEnvelopeEvidence',
    'realPrimaryLatexCandidateEvidence',
    'realAlternativeCandidateEvidence',
    'realConfidenceWarningsEngineMetadataEvidence',
    'realImageInputMetadataEvidence',
    'realEditableMathLiveReviewDraftEvidence',
    'realMathLiveReviewOpenedEvidence',
    'realEditableReviewMutationEvidence',
    'realUserApprovalEvidence',
    'realWorkspaceImportPreparedAfterApprovalEvidence',
    'realDirectWorkspaceImportBlockedEvidence',
    'realDirectSolveGraphSolutionHistoryBlockedEvidence',
    'realFlutterAnalyzeCleanLog',
    'realFlutterTestPassLog',
    'realFlutterRunDeviceLog',
    'explicitUserApprovalForQ284ReviewRuntimeBindingPhase',
  ];

  static const List<String> reviewDraftEnvelopeFields = [
    'requestId',
    'captureId',
    'engineLabel',
    'sourcePhase',
    'editableLatexDraft',
    'primaryLatexCandidate',
    'alternativeLatexCandidates',
    'selectedCandidateIndex',
    'confidence',
    'warnings',
    'engineMetadata',
    'imageInputMetadata',
    'mathLiveReviewRequired',
    'reviewDraftEditable',
    'userApprovalRequiredBeforeWorkspaceImport',
    'workspaceImportPrepared',
    'directWorkspaceMutationAttempted',
    'directSolveGraphSolutionHistoryAttempted',
  ];

  static const List<String> reviewRuntimeBindingFailureCodes = [
    'reviewRuntimeBindingFeatureFlagOff',
    'missingQ283ImageToLatexInferenceCourt',
    'candidateEnvelopeMissing',
    'primaryLatexCandidateMissing',
    'candidateMetadataMissing',
    'imageInputMetadataMissing',
    'mathLiveReviewMissing',
    'reviewDraftNotEditable',
    'userApprovalNotRequired',
    'directWorkspaceImportRiskDetected',
    'directSolveGraphSolutionHistoryRiskDetected',
    'runtimeInferenceAttemptedInQ284',
    'unsafeReviewBindingPassClaimed',
    'unknownReviewRuntimeBindingError',
  ];

  static const List<String> forbiddenActions = [
    'enableReviewRuntimeBindingByDefaultInQ284',
    'addPaddleRuntimeDependencyInQ284',
    'addPaddleOcrDependencyInQ284',
    'addNativeHandlerImplementationInQ284',
    'addJniBindingInQ284',
    'bindRuntimeMethodChannelInQ284',
    'bundlePPFormulaNetSModelInBaseApkInQ284',
    'bindProductionModelUrlInQ284',
    'enableProductionDownloadInQ284',
    'runPpFormulaNetSInferenceInQ284',
    'runRealImageToLatexInferenceInQ284',
    'importCameraOutputWithoutMathLiveReview',
    'importCameraOutputWithoutUserApproval',
    'autoSolveCameraOutput',
    'autoGraphCameraOutput',
    'autoWriteSolutionOrHistoryFromCamera',
    'claimReviewBindingPassWithoutRealEvidence',
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
