class GaussApprovedOcrWorkspaceImportRealRuntimePolicy {
  const GaussApprovedOcrWorkspaceImportRealRuntimePolicy._();

  static const String phase = 'V172-Q297-APPROVED-OCR-WORKSPACE-IMPORT-REAL-RUNTIME';
  static const String sourcePhase = 'V172-Q296-OCR-RESULT-EDITABLE-MATHLIVE-REVIEW-REAL-RUNTIME';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String workspaceImportMode = 'approved-ocr-workspace-import-real-runtime-contract-only-real-import-blocked';
  static const String workspaceImportFeatureFlag = 'gauss.ppFormulaNetS.approvedOcrWorkspaceImport.defaultOff';
  static const String workspaceImportReadinessState = 'BLOCKED_PENDING_Q296_REAL_EDITABLE_MATHLIVE_REVIEW_USER_APPROVAL_AND_IMPORT_UI_EVIDENCE';
  static const String workspaceImportDecision = 'blocked-until-real-editable-review-user-correction-explicit-approval-and-workspace-import-evidence';
  static const String workspaceImportPolicy = 'approved-review-to-workspace-import-only-no-auto-evaluate-no-auto-solve-graph-solution-history';
  static const String rollbackMode = 'delete-q297-contract-files-without-workspace-state-migration-runtime-state-change-or-history-solution-write';

  static const int maxApprovedLatexLength = 16000;
  static const int minRequiredWorkspaceImportEnvelopeFields = 22;
  static const int workspaceImportTimeoutBudgetMs = 900;

  static const bool q296EditableMathLiveReviewRequired = true;
  static const bool q296RealEditableReviewStillPending = true;
  static const bool acceptedEditableReviewDraftRequired = true;
  static const bool userCorrectionAllowedBeforeApproval = true;
  static const bool explicitUserApprovalRequiredBeforeWorkspaceImport = true;
  static const bool approvedLatexDraftRequired = true;
  static const bool workspaceImportPreparedOnlyAfterUserApproval = true;
  static const bool workspaceImportEnvelopeMustPreserveReviewMetadata = true;
  static const bool workspaceImportEnvelopeMustPreserveEngineMetadata = true;
  static const bool workspaceImportEnvelopeMustPreserveImageInputMetadata = true;
  static const bool workspaceMutationRuntimeExecutionBlockedInQ297 = true;
  static const bool directEvaluateBlocked = true;
  static const bool directSolveGraphSolutionHistoryBlocked = true;
  static const bool manualSolveGraphAfterImportOnly = true;
  static const bool editableMathLiveReviewStillRequired = true;

  static const bool changesRuntimeBehavior = false;
  static const bool keyboardLayoutChanged = false;
  static const bool moreTemplateTrayChanged = false;
  static const bool longPressListsChanged = false;
  static const bool graphSolutionHistoryChanged = false;
  static const bool mathLiveProductionRouteChanged = false;
  static const bool mathLiveBridgeChanged = false;
  static const bool cameraShellRuntimeChanged = false;
  static const bool workspaceRuntimeChanged = false;
  static const bool solverEvaluatorChanged = false;
  static const bool androidToolchainChanged = false;
  static const bool cameraDependencyChanged = false;
  static const bool androidManifestChanged = false;
  static const bool mainActivityChanged = false;

  static const bool workspaceImportFeatureFlagEnabledByDefault = false;
  static const bool realWorkspaceImportRuntimeExecuted = false;
  static const bool realEditableMathLiveReviewOpened = false;
  static const bool realReviewDraftBoundToMathLive = false;
  static const bool realUserCorrectionCaptured = false;
  static const bool realUserApprovalCaptured = false;
  static const bool realImageToLatexInferenceExecuted = false;
  static const bool nativeRuntimeStartupExecuted = false;
  static const bool nativeRuntimeHandlerImplemented = false;
  static const bool methodChannelRuntimeBindingAdded = false;
  static const bool jniBindingAdded = false;
  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool runtimeDependencyAddedToPubspec = false;
  static const bool gradleNativeRuntimeDependencyAdded = false;
  static const bool realPrivateArtifactFileLoaded = false;
  static const bool cameraImageSentToNativeRuntime = false;
  static const bool latexCandidateReturnedByRuntime = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionDownloadEnabled = false;
  static const bool directWorkspaceImportEnabled = false;
  static const bool autoEvaluateEnabled = false;
  static const bool autoSolveGraphSolutionHistoryEnabled = false;
  static const bool solutionHistoryWriteEnabled = false;
  static const bool workspaceImportPassClaimed = false;
  static const bool reviewBindingPassClaimed = false;
  static const bool imageToLatexPassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool storeReadyPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> workspaceImportPreconditions = [
    'q296-editable-mathlive-review-contract-present',
    'q296-real-editable-review-still-pending',
    'accepted-editable-review-draft-required',
    'review-draft-must-remain-editable-before-approval',
    'user-correction-allowed-before-approval',
    'explicit-user-approval-required-before-workspace-import',
    'approved-latex-draft-required',
    'workspace-import-prepared-only-after-user-approval',
    'workspace-import-envelope-preserves-review-metadata',
    'workspace-import-envelope-preserves-engine-metadata',
    'workspace-import-envelope-preserves-image-input-metadata',
    'workspace-mutation-runtime-execution-blocked-in-q297',
    'direct-evaluate-remains-blocked',
    'direct-solve-graph-solution-history-remain-blocked',
    'manual-solve-graph-after-import-only',
    'no-real-workspace-import-without-user-side-review-approval-evidence',
  ];

  static const List<String> workspaceImportEnvelopeFields = [
    'workspaceImportRequestId',
    'reviewId',
    'sourceInferenceRequestId',
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
    'cropMetadata',
    'imageSha256',
    'manualSolveGraphAfterImportOnly',
    'directEvaluateAttempted',
    'directSolveGraphSolutionHistoryAttempted',
    'errorCode',
  ];

  static const List<String> workspaceImportErrorCodes = [
    'workspaceImportFeatureFlagOff',
    'q296EditableReviewMissing',
    'acceptedEditableReviewDraftMissing',
    'reviewDraftNotEditable',
    'missingExplicitUserApproval',
    'approvedLatexDraftEmpty',
    'approvedLatexDraftTooLong',
    'metadataNotPreserved',
    'workspaceMutationRuntimeExecutionBlockedInQ297',
    'directEvaluateBlocked',
    'solveGraphSolutionHistoryBlocked',
    'noRealWorkspaceImportExecutedInQ297',
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
