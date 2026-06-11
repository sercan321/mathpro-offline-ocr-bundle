/// V172-Q312 — Approved OCR → Workspace Import Runtime Binding Gate.
///
/// Contract/static guard phase only. It defines the future boundary for taking
/// a user-approved editable MathLive OCR review draft and preparing a workspace
/// import envelope. Q312 does not mutate the workspace, evaluate, solve, graph,
/// write Solution/History, call MethodChannel, invoke native runtime, or claim
/// OCR/workspace-import PASS.
class GaussApprovedOcrWorkspaceImportRuntimeBindingGatePolicy {
  const GaussApprovedOcrWorkspaceImportRuntimeBindingGatePolicy._();

  static const String phase = 'V172-Q312-APPROVED-OCR-WORKSPACE-IMPORT-RUNTIME-BINDING-GATE';
  static const String sourcePhase = 'V172-Q311-OCR-CANDIDATE-EDITABLE-MATHLIVE-REVIEW-UI-BINDING-GATE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String workspaceImportBindingFeatureFlag = 'gauss.ppFormulaNetS.approvedOcrWorkspaceImportRuntimeBinding.defaultOff';
  static const String workspaceImportBindingMode = 'approved-ocr-workspace-import-runtime-binding-gate-default-off-no-workspace-mutation';
  static const String readinessState = 'BLOCKED_PENDING_Q311_REAL_REVIEW_APPROVAL_AND_IMPORT_EVIDENCE';
  static const bool contractStaticReady = true;
  static const bool workspaceImportBindingGateDefined = true;
  static const bool workspaceImportBindingDefaultOff = true;

  static const bool q311ReviewUiBindingGatePresent = true;
  static const bool q311RealEditableReviewOpened = false;
  static const bool q311RealUserApprovalCaptured = false;
  static const bool q311ApprovedReviewDraftEnvelopePresent = false;
  static const bool approvedLatexDraftRequired = true;
  static const bool userCorrectionAllowedBeforeApproval = true;
  static const bool explicitUserApprovalRequiredBeforeWorkspaceImport = true;
  static const bool workspaceImportEnvelopePreparedOnly = true;
  static const bool workspaceMutationRuntimeExecutionBlocked = true;
  static const bool directEvaluateBlocked = true;
  static const bool directSolveGraphSolutionHistoryBlocked = true;
  static const bool manualSolveGraphAfterImportOnly = true;
  static const bool realAndroidDeviceWorkspaceImportLogRequired = true;
  static const bool importRollbackPolicyPresent = true;
  static const bool importTimeoutPolicyPresent = true;

  static const bool pubspecChanged = false;
  static const bool androidManifestChanged = false;
  static const bool mainActivityChanged = false;
  static const bool nativeRuntimeDependencyAdded = false;
  static const bool methodChannelRuntimeBoundInsidePackage = false;
  static const bool jniNativeHandlerImplementedInsidePackage = false;
  static const bool productionDownloadEnabled = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool realPrivateArtifactLoaded = false;
  static const bool realRuntimeStartupExecuted = false;
  static const bool realDummyInputRuntimeCallExecuted = false;
  static const bool cameraImageSentToRuntime = false;
  static const bool realImageToLatexInferenceExecuted = false;
  static const bool runtimeLatexResponseParsed = false;
  static const bool realEditableMathLiveReviewOpened = false;
  static const bool realWorkspaceImportExecuted = false;
  static const bool workspaceImportActuallyMutatedWorkspace = false;
  static const bool autoEvaluateEnabled = false;
  static const bool autoSolveGraphSolutionHistoryEnabled = false;
  static const bool solutionHistoryWriteEnabled = false;
  static const bool workspaceImportPassClaimed = false;
  static const bool reviewBindingPassClaimed = false;
  static const bool runtimeIntegrationPassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool storeReadyPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> requiredBeforeWorkspaceImportBinding = [
    'q311-review-ui-binding-gate-present',
    'q311-real-editable-review-opened-evidence',
    'q311-user-edited-review-draft-evidence',
    'q311-explicit-user-approval-evidence',
    'q311-approved-review-draft-envelope-present',
    'approved-latex-draft-required',
    'approved-latex-draft-sanitized',
    'review-metadata-preserved',
    'engine-metadata-preserved',
    'crop-and-image-sha-preserved',
    'workspace-import-envelope-prepared-only',
    'workspace-mutation-runtime-execution-blocked-in-q312',
    'direct-evaluate-blocked',
    'direct-solve-graph-solution-history-blocked',
    'manual-solve-graph-after-import-only',
    'real-android-device-workspace-import-log-required',
  ];

  static const List<String> workspaceImportEnvelopeFields = [
    'workspaceImportRequestId',
    'reviewRequestId',
    'inferenceEvidenceId',
    'approvedLatexDraft',
    'workspaceExpressionCandidate',
    'userApprovedForWorkspaceImport',
    'userEditedBeforeApproval',
    'reviewMetadata',
    'engineMetadata',
    'cropMetadata',
    'sourceImageSha256',
    'importState',
    'workspaceMutationExecuted',
    'manualSolveGraphAfterImportOnly',
    'errorCode',
  ];

  static const List<String> workspaceImportStates = [
    'notStarted',
    'blockedFeatureFlagOff',
    'blockedMissingQ311ReviewApprovalEvidence',
    'blockedMissingApprovedLatexDraft',
    'blockedUnsafeApprovedLatexDraft',
    'workspaceImportEnvelopePrepared',
    'awaitingUserManualWorkspaceAction',
    'importFailed',
    'cleanupRequired',
  ];

  static const List<String> errorCodes = [
    'featureFlagOff',
    'q311ReviewApprovalEvidenceMissing',
    'approvedLatexDraftMissing',
    'approvedLatexDraftUnsafe',
    'metadataNotPreserved',
    'workspaceSurfaceUnavailable',
    'workspaceMutationBlockedInQ312',
    'directEvaluateBlocked',
    'solveGraphSolutionHistoryBlocked',
    'userApprovalMissing',
  ];

  static const List<String> protectedSurfaceMarkers = [
    'keyboard-layout-preserved',
    'more-template-tray-preserved',
    'long-press-lists-preserved',
    'mathlive-production-route-preserved',
    'mathlive-bridge-preserved',
    'graph-solution-history-preserved',
    'camera-shell-runtime-preserved',
    'workspace-runtime-preserved',
    'android-manifest-mainactivity-preserved',
    'pubspec-preserved',
  ];

  static const List<String> forbiddenActions = [
    'mutateWorkspaceInsideQ312Package',
    'callMethodChannelInsideQ312Package',
    'invokeNativeRuntimeInsideQ312Package',
    'autoApproveOcrCandidateInsideQ312Package',
    'autoSolveGraphSolutionHistoryFromOcrInsideQ312Package',
    'writeSolutionHistoryInsideQ312Package',
    'addRuntimeDependencyInQ312',
    'modifyMainActivityForRuntimeInQ312',
    'modifyAndroidManifestForRuntimeInQ312',
    'bypassEditableMathLiveReview',
    'bypassExplicitUserApproval',
    'claimWorkspaceImportPassWithoutDeviceEvidence',
    'claimRuntimeOrOcrPassWithoutEvidence',
  ];

  static const List<String> blockedDependencyFamilies = [
    'paddleocr',
    'paddle_lite',
    'paddle-lite',
    'onnxruntime',
    'tflite_flutter',
    'workmanager',
    'background_downloader',
    'flutter_downloader',
    'dio',
  ];
}
