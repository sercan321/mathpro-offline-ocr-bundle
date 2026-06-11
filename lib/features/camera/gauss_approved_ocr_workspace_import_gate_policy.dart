class GaussApprovedOcrWorkspaceImportGatePolicy {
  const GaussApprovedOcrWorkspaceImportGatePolicy._();

  static const String phase = 'V172-Q275-APPROVED-OCR-WORKSPACE-IMPORT-GATE';
  static const String sourcePhase = 'V172-Q274-OCR-RESULT-MATHLIVE-REAL-REVIEW-BINDING';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L';
  static const String workspaceImportMode = 'approved-ocr-workspace-import-gate-only-no-auto-solve-no-real-inference';

  static const bool approvedOcrWorkspaceImportGateImplemented = true;
  static const bool requiresQ274OcrResultMathLiveReviewBinding = true;
  static const bool editableMathLiveReviewDraftRequired = true;
  static const bool userMayEditReviewDraftBeforeApproval = true;
  static const bool explicitUserApprovalRequired = true;
  static const bool approvedLatexMustBeNonEmpty = true;
  static const bool workspaceImportPreparedOnlyAfterUserApproval = true;
  static const bool workspaceImportMayUseApprovedLatexDraft = true;
  static const bool importDoesNotAutoEvaluate = true;
  static const bool importDoesNotAutoSolve = true;
  static const bool importDoesNotAutoGraph = true;
  static const bool importDoesNotAutoWriteSolution = true;
  static const bool importDoesNotAutoWriteHistory = true;
  static const bool directWorkspaceImportWithoutApprovalBlocked = true;
  static const bool directCameraSolveBlocked = true;
  static const bool directCameraGraphSolutionHistoryBlocked = true;
  static const bool realOcrRuntimeAdded = false;
  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool nativeBridgeImplementationAdded = false;
  static const bool jniBindingAdded = false;
  static const bool methodChannelRuntimeBindingAdded = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionModelUrlBound = false;
  static const bool realNetworkDownloadWorkerImplemented = false;
  static const bool productionDownloadEnabled = false;
  static const bool productionInferenceAllowed = false;
  static const bool runtimeDefaultEnabled = false;
  static const bool runtimeFeatureFlagDefaultOff = true;
  static const bool realImageToLatexInferenceExecuted = false;
  static const bool workspaceImportRuntimePassClaimed = false;
  static const bool ocrPassClaimed = false;

  static const List<String> workspaceImportDecisionStates = <String>[
    'blockedMissingQ274ReviewBindingGate',
    'blockedMissingEditableMathLiveReviewDraft',
    'blockedReviewDraftNotUserEditable',
    'blockedMissingExplicitUserApproval',
    'blockedEmptyApprovedLatexDraft',
    'blockedWorkspaceImportPreparedBeforeApproval',
    'blockedAutoEvaluateRisk',
    'blockedAutoSolveRisk',
    'blockedAutoGraphSolutionHistoryRisk',
    'blockedDirectImportWithoutApprovalRisk',
    'blockedUnsafeRuntimeOrOcrClaim',
    'readyForFutureApprovedWorkspaceImportOnly',
  ];

  static const List<String> requiredWorkspaceImportGates = <String>[
    'q274OcrResultMathLiveReviewBindingPresent',
    'q274StillNoRealInferenceNoRuntime',
    'editableMathLiveReviewDraftRequired',
    'reviewDraftMayBeEditedBeforeApproval',
    'explicitUserApprovalRequired',
    'approvedLatexDraftNonEmpty',
    'workspaceImportPreparedOnlyAfterUserApproval',
    'workspaceImportMayUseApprovedLatexDraft',
    'importDoesNotAutoEvaluate',
    'importDoesNotAutoSolve',
    'importDoesNotAutoGraph',
    'importDoesNotAutoWriteSolution',
    'importDoesNotAutoWriteHistory',
    'directWorkspaceImportWithoutApprovalBlocked',
    'directSolveBlocked',
    'directGraphSolutionHistoryBlocked',
    'noPaddleRuntimeAddedInQ275',
    'noPaddleOcrDependencyAddedInQ275',
    'noNativeBridgeImplementationAddedInQ275',
    'noJniBindingAddedInQ275',
    'noMethodChannelRuntimeBindingAddedInQ275',
    'noModelBinaryBundledInQ275',
    'noProductionModelUrlBoundInQ275',
    'noRealDownloadWorkerInQ275',
    'noProductionInferenceInQ275',
    'noRealImageToLatexInferenceInQ275',
    'noWorkspaceImportPassClaimedWithoutRealEvidence',
    'noOcrPassClaimedWithoutRealInferenceEvidence',
  ];

  static const List<String> workspaceImportEnvelopeFields = <String>[
    'requestId',
    'engineLabel',
    'sourceReviewDraftId',
    'approvedLatexDraft',
    'selectedCandidateIndex',
    'userEditedLatexBeforeApproval',
    'explicitUserApproved',
    'workspaceImportPrepared',
    'autoEvaluateAfterImport',
    'autoSolveAfterImport',
    'autoGraphAfterImport',
    'autoSolutionAfterImport',
    'autoHistoryAfterImport',
    'sourceImageMetadata',
    'sourceOcrMetadata',
  ];

  static const List<String> blockedUntilRealEvidence = <String>[
    'acceptedQ274MathLiveReviewBindingEvidence',
    'realEditableMathLiveReviewDraftEvidence',
    'realUserEditOrConfirmationEvidence',
    'realExplicitUserApprovalEvidence',
    'realApprovedLatexDraftEvidence',
    'realWorkspaceImportPreparedAfterApprovalEvidence',
    'realNoAutoEvaluateEvidence',
    'realNoAutoSolveEvidence',
    'realNoAutoGraphEvidence',
    'realNoAutoSolutionEvidence',
    'realNoAutoHistoryEvidence',
    'realDirectImportWithoutApprovalBlockedEvidence',
    'realDirectSolveBlockedEvidence',
    'realGraphSolutionHistoryBlockedEvidence',
    'realFlutterPubGetLog',
    'realFlutterAnalyzeLog',
    'realFlutterTestLog',
    'realFlutterRunLog',
  ];

  static const List<String> workspaceImportFailureCodes = <String>[
    'missingQ274ReviewBindingGate',
    'mathLiveReviewDraftMissing',
    'reviewDraftNotEditable',
    'userApprovalMissing',
    'approvedLatexDraftEmpty',
    'workspaceImportPreparedBeforeApproval',
    'autoEvaluateRiskDetected',
    'autoSolveRiskDetected',
    'autoGraphRiskDetected',
    'autoSolutionRiskDetected',
    'autoHistoryRiskDetected',
    'directImportWithoutApprovalRiskDetected',
    'runtimeInferenceAttemptedInQ275',
    'unsafeWorkspaceImportPassClaimed',
    'unknownWorkspaceImportGateError',
  ];

  static const List<String> forbiddenActions = <String>[
    'addPaddleRuntimeDependencyInQ275',
    'addPaddleOcrDependencyInQ275',
    'addNativeBridgeImplementationInQ275',
    'addJniBindingInQ275',
    'bindRuntimeMethodChannelInQ275',
    'bundlePPFormulaNetSModelInBaseApk',
    'bindProductionModelUrlInQ275',
    'startRealNetworkDownloadInQ275',
    'runPpFormulaNetSInferenceInQ275',
    'runRealImageToLatexInQ275',
    'importCameraOutputWithoutMathLiveReview',
    'importCameraOutputWithoutUserApproval',
    'autoSolveCameraOutputAfterImport',
    'autoGraphCameraOutputAfterImport',
    'autoWriteSolutionOrHistoryAfterImport',
    'claimWorkspaceImportPassWithoutRealEvidence',
    'claimOcrPassWithoutRealInferenceEvidence',
  ];
}
