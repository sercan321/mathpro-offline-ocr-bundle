class GaussApprovedOcrWorkspaceImportRuntimeCourtPolicy {
  const GaussApprovedOcrWorkspaceImportRuntimeCourtPolicy._();

  static const String phase = 'V172-Q285-APPROVED-OCR-WORKSPACE-IMPORT-RUNTIME-COURT';
  static const String sourcePhase = 'V172-Q284-OCR-RESULT-REAL-MATHLIVE-REVIEW-RUNTIME-BINDING';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String workspaceImportMode = 'approved-ocr-workspace-import-runtime-court-gate-only-no-auto-solve-no-real-inference';
  static const String importFeatureFlagName = 'ppFormulaNetSApprovedWorkspaceImportRuntimeCourtEnabled';

  static const int minimumRequiredWorkspaceImportFields = 20;
  static const int maxApprovedLatexLength = 16000;

  static const bool approvedOcrWorkspaceImportRuntimeCourtImplemented = true;
  static const bool requiresQ284RealMathLiveReviewRuntimeBinding = true;
  static const bool requiresAcceptedEditableMathLiveReviewDraft = true;
  static const bool requiresReviewDraftMutationEvidence = true;
  static const bool requiresExplicitUserApprovalBeforeWorkspaceImport = true;
  static const bool requiresApprovedLatexDraft = true;
  static const bool workspaceImportPreparedOnlyAfterUserApproval = true;
  static const bool workspaceImportEnvelopeMustPreserveReviewMetadata = true;
  static const bool workspaceImportEnvelopeMustPreserveEngineMetadata = true;
  static const bool workspaceImportEnvelopeMustPreserveImageInputMetadata = true;
  static const bool workspaceMutationRuntimeExecutionBlockedInQ285 = true;
  static const bool directSolveGraphSolutionHistoryBlocked = true;
  static const bool manualSolveGraphAfterImportOnly = true;
  static const bool editableMathLiveReviewStillRequired = true;

  static const bool keyboardLayoutChanged = false;
  static const bool moreTemplateTrayChanged = false;
  static const bool longPressListsChanged = false;
  static const bool mathLiveProductionRouteChanged = false;
  static const bool graphSolutionHistoryRuntimeChanged = false;
  static const bool cameraShellRuntimeChanged = false;
  static const bool solverEvaluatorChanged = false;
  static const bool splashIconChanged = false;

  static const bool realWorkspaceImportRuntimeExecutedInQ285 = false;
  static const bool realMathLiveReviewRuntimeBindingExecutedInQ285 = false;
  static const bool realImageToLatexInferenceExecutedInQ285 = false;
  static const bool realRuntimeInvocationExecutedInQ285 = false;
  static const bool nativeRuntimeBridgeInvokedInQ285 = false;
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
  static const bool directSolveAllowed = false;
  static const bool directGraphAllowed = false;
  static const bool directSolutionHistoryWriteAllowed = false;
  static const bool workspaceImportRuntimePassClaimed = false;
  static const bool reviewBindingPassClaimed = false;
  static const bool imageToLatexPassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool premiumFinalPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> requiredWorkspaceImportRuntimeCourtGates = [
    'q284RealMathLiveReviewRuntimeBindingPresent',
    'acceptedEditableMathLiveReviewDraftEvidenceRequired',
    'reviewDraftMayBeEditedBeforeApproval',
    'explicitUserApprovalReceivedBeforeWorkspaceImport',
    'approvedLatexDraftRequired',
    'approvedLatexDraftWithinLengthBudget',
    'workspaceImportPreparedOnlyAfterUserApproval',
    'workspaceImportEnvelopePreservesReviewMetadata',
    'workspaceImportEnvelopePreservesEngineMetadata',
    'workspaceImportEnvelopePreservesImageInputMetadata',
    'workspaceMutationRuntimeExecutionBlockedInQ285',
    'autoEvaluateAfterImportBlocked',
    'autoSolveAfterImportBlocked',
    'autoGraphAfterImportBlocked',
    'autoSolutionAfterImportBlocked',
    'autoHistoryAfterImportBlocked',
    'manualSolveGraphAfterImportOnly',
    'protectedUiSurfacePreservation',
    'noWorkspaceImportRuntimePassClaimWithoutRealEvidence',
    'noOcrPassClaimWithoutRealInferenceEvidence',
  ];

  static const List<String> blockedUntilRealEvidence = [
    'acceptedQ284ReviewRuntimeBindingEvidence',
    'realEditableMathLiveReviewDraftEvidence',
    'realReviewDraftMutationEvidence',
    'realExplicitUserApprovalEvidence',
    'realApprovedLatexDraftEvidence',
    'realWorkspaceImportEnvelopeEvidence',
    'realWorkspaceImportPreparedAfterApprovalEvidence',
    'realDirectWorkspaceMutationBlockedEvidence',
    'realAutoEvaluateBlockedEvidence',
    'realAutoSolveBlockedEvidence',
    'realAutoGraphSolutionHistoryBlockedEvidence',
    'realManualSolveGraphAfterImportEvidence',
    'realFlutterAnalyzeCleanLog',
    'realFlutterTestPassLog',
    'realFlutterRunDeviceLog',
    'explicitUserApprovalForQ285WorkspaceImportRuntimeCourtPhase',
  ];

  static const List<String> workspaceImportEnvelopeFields = [
    'requestId',
    'captureId',
    'engineLabel',
    'sourcePhase',
    'approvedLatexDraft',
    'reviewDraftEditable',
    'userApprovedForWorkspaceImport',
    'workspaceImportPrepared',
    'workspaceImportRuntimeExecuted',
    'workspaceExpressionCandidate',
    'selectedCandidateIndex',
    'confidence',
    'warnings',
    'reviewMetadata',
    'engineMetadata',
    'imageInputMetadata',
    'manualSolveGraphAfterImportOnly',
    'directEvaluateAttempted',
    'directSolveGraphSolutionHistoryAttempted',
    'errorCode',
  ];

  static const List<String> workspaceImportRuntimeCourtFailureCodes = [
    'workspaceImportRuntimeCourtFeatureFlagOff',
    'missingQ284ReviewRuntimeBinding',
    'missingAcceptedEditableMathLiveReviewDraft',
    'reviewDraftNotEditable',
    'missingExplicitUserApproval',
    'approvedLatexDraftEmpty',
    'approvedLatexDraftTooLong',
    'workspaceImportPreparedBeforeApproval',
    'metadataNotPreserved',
    'workspaceMutationRuntimeExecutionAttemptedInQ285',
    'autoEvaluateRiskDetected',
    'autoSolveGraphSolutionHistoryRiskDetected',
    'unsafeRuntimeInferenceOrPassClaim',
    'unknownApprovedWorkspaceImportRuntimeCourtError',
  ];

  static const List<String> forbiddenActions = [
    'enableWorkspaceImportRuntimeByDefaultInQ285',
    'mutateWorkspaceFromCameraOutputInQ285',
    'importCameraOutputWithoutEditableMathLiveReview',
    'importCameraOutputWithoutUserApproval',
    'autoEvaluateApprovedCameraOutput',
    'autoSolveApprovedCameraOutput',
    'autoGraphApprovedCameraOutput',
    'autoWriteSolutionOrHistoryFromCameraOutput',
    'addPaddleRuntimeDependencyInQ285',
    'addPaddleOcrDependencyInQ285',
    'addNativeHandlerImplementationInQ285',
    'addJniBindingInQ285',
    'bindRuntimeMethodChannelInQ285',
    'bundlePPFormulaNetSModelInBaseApkInQ285',
    'bindProductionModelUrlInQ285',
    'enableProductionDownloadInQ285',
    'runPpFormulaNetSInferenceInQ285',
    'runRealImageToLatexInferenceInQ285',
    'claimWorkspaceImportRuntimePassWithoutRealEvidence',
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
