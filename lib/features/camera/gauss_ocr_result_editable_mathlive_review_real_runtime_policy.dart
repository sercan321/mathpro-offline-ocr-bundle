class GaussOcrResultEditableMathLiveReviewRealRuntimePolicy {
  const GaussOcrResultEditableMathLiveReviewRealRuntimePolicy._();

  static const String phase = 'V172-Q296-OCR-RESULT-EDITABLE-MATHLIVE-REVIEW-REAL-RUNTIME';
  static const String sourcePhase = 'V172-Q295-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String reviewMode = 'ocr-result-editable-mathlive-review-real-runtime-contract-only-real-review-binding-blocked';
  static const String reviewFeatureFlag = 'gauss.ppFormulaNetS.ocrResultEditableMathLiveReview.defaultOff';
  static const String reviewReadinessState = 'BLOCKED_PENDING_Q295_REAL_IMAGE_TO_LATEX_CANDIDATE_AND_REVIEW_UI_EVIDENCE';
  static const String reviewDecision = 'blocked-until-real-image-to-latex-candidate-review-draft-editability-user-correction-and-approval-evidence';
  static const String reviewPolicy = 'ocr-candidate-to-editable-mathlive-review-only-no-direct-workspace-no-solve-graph-solution-history';
  static const String rollbackMode = 'delete-q296-contract-files-without-workspace-state-migration-runtime-state-change-or-review-data_persistence';

  static const int maxEditableLatexLength = 16000;
  static const int maxAlternativeCandidateCount = 8;
  static const int maxWarningCount = 16;
  static const int reviewOpenTimeoutBudgetMs = 1200;

  static const bool q295FirstRealImageToLatexInferenceRequired = true;
  static const bool q295RealImageToLatexInferenceStillPending = true;
  static const bool runtimeCandidateEnvelopeRequired = true;
  static const bool primaryLatexCandidateRequired = true;
  static const bool alternativeCandidatesPreserved = true;
  static const bool confidenceWarningsEngineMetadataPreserved = true;
  static const bool cropAndImageMetadataPreserved = true;
  static const bool editableLatexDraftRequired = true;
  static const bool editableMathLiveReviewRequired = true;
  static const bool reviewDraftMustRemainEditableBeforeApproval = true;
  static const bool userCorrectionAllowedBeforeApproval = true;
  static const bool explicitUserApprovalRequiredBeforeWorkspaceImport = true;
  static const bool workspaceImportPreparedOnlyAfterUserApproval = true;
  static const bool directWorkspaceImportBlocked = true;
  static const bool directSolveGraphSolutionHistoryBlocked = true;

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

  static const bool reviewFeatureFlagEnabledByDefault = false;
  static const bool realEditableMathLiveReviewOpened = false;
  static const bool realReviewDraftBoundToMathLive = false;
  static const bool realUserCorrectionCaptured = false;
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
  static const bool directSolveGraphSolutionHistoryEnabled = false;
  static const bool reviewBindingPassClaimed = false;
  static const bool imageToLatexPassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool storeReadyPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> editableReviewPreconditions = [
    'q295-first-real-image-to-latex-inference-present',
    'q295-real-image-to-latex-inference-still-pending',
    'runtime-candidate-envelope-required-before-review',
    'primary-latex-candidate-required-before-review',
    'alternative-candidates-preserved-for-review',
    'confidence-warnings-engine-metadata-preserved-for-review',
    'crop-and-image-metadata-preserved-for-review',
    'editable-latex-draft-required',
    'editable-mathlive-review-required',
    'review-draft-must-remain-editable-before-user-approval',
    'user-correction-allowed-before-approval',
    'explicit-user-approval-required-before-workspace-import',
    'direct-workspace-import-remains-blocked',
    'direct-solve-graph-solution-history-remain-blocked',
    'no-real-editable-mathlive-review-binding-without-user-side-runtime-candidate-evidence',
  ];

  static const List<String> reviewDraftEnvelopeFields = [
    'reviewId',
    'sourceInferenceRequestId',
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
    'cropMetadata',
    'imageSha256',
    'reviewOpenedAtIso8601',
    'reviewFeatureFlagEnabled',
    'userApprovalRequired',
    'directWorkspaceMutationAttempted',
  ];

  static const List<String> reviewErrorCodes = [
    'reviewFeatureFlagOff',
    'q295ImageToLatexCandidateMissing',
    'primaryLatexCandidateMissing',
    'candidateTooLong',
    'tooManyAlternativeCandidates',
    'confidenceMissing',
    'engineMetadataMissing',
    'cropMetadataMissing',
    'imageShaMissing',
    'reviewUiEvidenceMissing',
    'userApprovalMissing',
    'directWorkspaceMutationBlocked',
    'solveGraphSolutionHistoryBlocked',
    'noRealEditableMathLiveReviewOpenedInQ296',
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
