class GaussOcrResultMathLiveRealReviewBindingPolicy {
  const GaussOcrResultMathLiveRealReviewBindingPolicy._();

  static const String phase = 'V172-Q274-OCR-RESULT-MATHLIVE-REAL-REVIEW-BINDING';
  static const String sourcePhase = 'V172-Q273-PP-FORMULANET-S-IMAGE-TO-LATEX-PROTOTYPE-GATE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L';
  static const String reviewBindingMode = 'ocr-result-to-mathlive-real-review-binding-gate-only-no-real-inference-no-direct-import';

  static const bool ocrResultMathLiveReviewBindingImplemented = true;
  static const bool requiresQ273ImageToLatexPrototypeGate = true;
  static const bool q273CandidateEnvelopeRequired = true;
  static const bool editableMathLiveReviewRequired = true;
  static const bool userApprovalRequiredBeforeWorkspaceImport = true;
  static const bool reviewDraftMustRemainEditable = true;
  static const bool reviewMayDisplayPrimaryCandidate = true;
  static const bool reviewMayDisplayAlternatives = true;
  static const bool reviewMayDisplayConfidenceWarningsMetadata = true;
  static const bool workspaceImportPreparedOnlyAfterUserApproval = true;
  static const bool directWorkspaceImportBlocked = true;
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
  static const bool reviewBindingPassClaimed = false;
  static const bool ocrPassClaimed = false;

  static const List<String> reviewBindingDecisionStates = <String>[
    'blockedMissingQ273ImageToLatexPrototypeGate',
    'blockedMissingCandidateEnvelope',
    'blockedMissingPrimaryLatexCandidate',
    'blockedMissingEditableMathLiveReview',
    'blockedMissingAlternativeCandidateHandling',
    'blockedMissingConfidenceWarningsMetadata',
    'blockedUserApprovalNotRequired',
    'blockedDirectWorkspaceImportRisk',
    'blockedDirectSolveGraphSolutionHistoryRisk',
    'blockedUnsafeRuntimeOrInferenceClaim',
    'readyForFutureMathLiveReviewBindingOnly',
  ];

  static const List<String> requiredReviewBindingGates = <String>[
    'q273ImageToLatexPrototypeGatePresent',
    'q273StillNoRealInferenceNoRuntime',
    'candidateEnvelopeAccepted',
    'primaryLatexCandidatePreserved',
    'alternativeCandidatesPreserved',
    'confidenceWarningsEngineMetadataPreserved',
    'imageHashCropBoundsPreprocessMetadataPreserved',
    'editableMathLiveReviewRequired',
    'reviewDraftMayBeEditedBeforeImport',
    'userApprovalRequiredBeforeWorkspaceImport',
    'workspaceImportPreparedOnlyAfterUserApproval',
    'directWorkspaceImportBlocked',
    'directSolveBlocked',
    'directGraphSolutionHistoryBlocked',
    'noPaddleRuntimeAddedInQ274',
    'noPaddleOcrDependencyAddedInQ274',
    'noNativeBridgeImplementationAddedInQ274',
    'noJniBindingAddedInQ274',
    'noMethodChannelRuntimeBindingAddedInQ274',
    'noModelBinaryBundledInQ274',
    'noProductionModelUrlBoundInQ274',
    'noRealDownloadWorkerInQ274',
    'noProductionInferenceInQ274',
    'noRealImageToLatexInferenceInQ274',
    'noReviewBindingPassClaimedWithoutRealEvidence',
    'noOcrPassClaimedWithoutRealInferenceEvidence',
  ];

  static const List<String> reviewDraftEnvelopeFields = <String>[
    'requestId',
    'engineLabel',
    'editableLatexDraft',
    'primaryLatexCandidate',
    'alternativeLatexCandidates',
    'selectedCandidateIndex',
    'confidence',
    'warnings',
    'engineMetadata',
    'imageInputMetadata',
    'mathLiveReviewRequired',
    'userApprovalRequiredBeforeWorkspaceImport',
    'workspaceImportPrepared',
  ];

  static const List<String> blockedUntilRealEvidence = <String>[
    'acceptedQ273ImageToLatexPrototypeEvidence',
    'realPrimaryLatexCandidateEvidence',
    'realAlternativeCandidateEvidence',
    'realConfidenceWarningsMetadataEvidence',
    'realMathLiveReviewOpenedEvidence',
    'realEditableReviewMutationEvidence',
    'realUserApprovalEvidence',
    'realWorkspaceImportPreparedAfterApprovalEvidence',
    'realDirectWorkspaceImportBlockedEvidence',
    'realDirectSolveBlockedEvidence',
    'realGraphSolutionHistoryBlockedEvidence',
    'realFlutterPubGetLog',
    'realFlutterAnalyzeLog',
    'realFlutterTestLog',
    'realFlutterRunLog',
    'explicitUserApprovalForQ274ReviewBindingPhase',
  ];

  static const List<String> reviewBindingFailureCodes = <String>[
    'missingQ273ImageToLatexPrototypeGate',
    'candidateEnvelopeMissing',
    'primaryLatexCandidateMissing',
    'mathLiveReviewMissing',
    'reviewDraftNotEditable',
    'userApprovalNotRequired',
    'directWorkspaceImportRiskDetected',
    'directSolveRiskDetected',
    'runtimeInferenceAttemptedInQ274',
    'unsafeReviewBindingPassClaimed',
    'unknownReviewBindingError',
  ];

  static const List<String> forbiddenActions = <String>[
    'addPaddleRuntimeDependencyInQ274',
    'addPaddleOcrDependencyInQ274',
    'addNativeBridgeImplementationInQ274',
    'addJniBindingInQ274',
    'bindRuntimeMethodChannelInQ274',
    'bundlePPFormulaNetSModelInBaseApk',
    'bindProductionModelUrlInQ274',
    'startRealNetworkDownloadInQ274',
    'runPpFormulaNetSInferenceInQ274',
    'runRealImageToLatexInQ274',
    'importCameraOutputWithoutMathLiveReview',
    'importCameraOutputWithoutUserApproval',
    'solveGraphSolutionHistoryFromCameraWithoutUserApproval',
    'claimReviewBindingPassWithoutRealEvidence',
    'claimOcrPassWithoutRealInferenceEvidence',
  ];
}
