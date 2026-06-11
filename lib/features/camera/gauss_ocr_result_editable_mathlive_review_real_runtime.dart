import 'gauss_ocr_result_editable_mathlive_review_real_runtime_policy.dart';

enum GaussOcrResultEditableMathLiveReviewRealRuntimeDecision {
  editableReviewContractReadyRealBindingBlocked,
  blockedMissingQ295CandidateEvidence,
  blockedMissingPrimaryLatexCandidate,
  blockedUnsafeReviewDraft,
  blockedDirectWorkspaceMutationRisk,
  blockedDirectSolveGraphSolutionHistoryRisk,
  blockedFakePassClaim,
}

class GaussOcrResultEditableMathLiveReviewRealRuntimeResult {
  const GaussOcrResultEditableMathLiveReviewRealRuntimeResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.reviewFeatureFlag,
    required this.reviewReadinessState,
    required this.reviewDecision,
    required this.editableReviewPreconditions,
    required this.reviewDraftEnvelopeFields,
    required this.reviewErrorCodes,
    required this.decision,
    required this.reviewFeatureFlagEnabledByDefault,
    required this.realEditableMathLiveReviewOpened,
    required this.realReviewDraftBoundToMathLive,
    required this.realUserCorrectionCaptured,
    required this.realImageToLatexInferenceExecuted,
    required this.directWorkspaceImportEnabled,
    required this.directSolveGraphSolutionHistoryEnabled,
    required this.reviewBindingPassClaimed,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String selectedEngineLabel;
  final String reviewFeatureFlag;
  final String reviewReadinessState;
  final String reviewDecision;
  final List<String> editableReviewPreconditions;
  final List<String> reviewDraftEnvelopeFields;
  final List<String> reviewErrorCodes;
  final GaussOcrResultEditableMathLiveReviewRealRuntimeDecision decision;
  final bool reviewFeatureFlagEnabledByDefault;
  final bool realEditableMathLiveReviewOpened;
  final bool realReviewDraftBoundToMathLive;
  final bool realUserCorrectionCaptured;
  final bool realImageToLatexInferenceExecuted;
  final bool directWorkspaceImportEnabled;
  final bool directSolveGraphSolutionHistoryEnabled;
  final bool reviewBindingPassClaimed;
  final bool ocrPassClaimed;
}

class GaussEditableMathLiveReviewDraftEnvelope {
  const GaussEditableMathLiveReviewDraftEnvelope({
    required this.reviewId,
    required this.sourceInferenceRequestId,
    required this.captureId,
    required this.engineLabel,
    required this.sourcePhase,
    required this.editableLatexDraft,
    required this.primaryLatexCandidate,
    required this.alternativeLatexCandidates,
    required this.selectedCandidateIndex,
    required this.confidence,
    required this.warnings,
    required this.engineMetadata,
    required this.cropMetadata,
    required this.imageSha256,
    required this.reviewOpenedAtIso8601,
    required this.reviewFeatureFlagEnabled,
    required this.userApprovalRequired,
    required this.directWorkspaceMutationAttempted,
    required this.solveGraphSolutionHistoryTriggered,
  });

  final String reviewId;
  final String sourceInferenceRequestId;
  final String captureId;
  final String engineLabel;
  final String sourcePhase;
  final String editableLatexDraft;
  final String primaryLatexCandidate;
  final List<String> alternativeLatexCandidates;
  final int selectedCandidateIndex;
  final double confidence;
  final List<String> warnings;
  final Map<String, String> engineMetadata;
  final Map<String, String> cropMetadata;
  final String imageSha256;
  final String reviewOpenedAtIso8601;
  final bool reviewFeatureFlagEnabled;
  final bool userApprovalRequired;
  final bool directWorkspaceMutationAttempted;
  final bool solveGraphSolutionHistoryTriggered;

  static bool isSha256(String value) => RegExp(r'^[a-fA-F0-9]{64}$').hasMatch(value);

  bool get hasPrimaryCandidate => primaryLatexCandidate.trim().isNotEmpty;
  bool get candidateWithinBudget => editableLatexDraft.length <= GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.maxEditableLatexLength;
  bool get alternativesWithinBudget => alternativeLatexCandidates.length <= GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.maxAlternativeCandidateCount;
  bool get warningsWithinBudget => warnings.length <= GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.maxWarningCount;
  bool get confidenceInRange => confidence >= 0 && confidence <= 1;
  bool get hasEngineMetadata => engineMetadata.isNotEmpty;
  bool get hasCropMetadata => cropMetadata.isNotEmpty;
  bool get hasImageSha => isSha256(imageSha256);
  bool get preservesCandidate => editableLatexDraft == primaryLatexCandidate || alternativeLatexCandidates.contains(editableLatexDraft);
  bool get blocksDirectSideEffects => !directWorkspaceMutationAttempted && !solveGraphSolutionHistoryTriggered;
  bool get requiresApprovalBeforeImport => userApprovalRequired;

  bool get isReviewDraftStructurallySafe {
    return hasPrimaryCandidate &&
        candidateWithinBudget &&
        alternativesWithinBudget &&
        warningsWithinBudget &&
        confidenceInRange &&
        hasEngineMetadata &&
        hasCropMetadata &&
        hasImageSha &&
        preservesCandidate &&
        blocksDirectSideEffects &&
        requiresApprovalBeforeImport;
  }
}

class GaussEditableMathLiveReviewOpenResult {
  const GaussEditableMathLiveReviewOpenResult._({
    required this.status,
    required this.errorCode,
    required this.reviewOpened,
    required this.boundToMathLive,
    required this.userCanEditBeforeApproval,
    required this.workspaceImportPrepared,
    required this.directWorkspaceMutationAttempted,
    required this.solveGraphSolutionHistoryTriggered,
    required this.warnings,
  });

  factory GaussEditableMathLiveReviewOpenResult.blockedFeatureFlagOff() {
    return const GaussEditableMathLiveReviewOpenResult._(
      status: 'blocked',
      errorCode: 'reviewFeatureFlagOff',
      reviewOpened: false,
      boundToMathLive: false,
      userCanEditBeforeApproval: true,
      workspaceImportPrepared: false,
      directWorkspaceMutationAttempted: false,
      solveGraphSolutionHistoryTriggered: false,
      warnings: <String>['Q296 review binding remains default-off; no real MathLive review was opened.'],
    );
  }

  factory GaussEditableMathLiveReviewOpenResult.blockedMissingEvidence(String errorCode) {
    return GaussEditableMathLiveReviewOpenResult._(
      status: 'blocked',
      errorCode: errorCode,
      reviewOpened: false,
      boundToMathLive: false,
      userCanEditBeforeApproval: true,
      workspaceImportPrepared: false,
      directWorkspaceMutationAttempted: false,
      solveGraphSolutionHistoryTriggered: false,
      warnings: const <String>['Q295 real image-to-LaTeX candidate, candidate metadata, crop metadata, review UI evidence, editability evidence, and user approval evidence are required before review binding.'],
    );
  }

  factory GaussEditableMathLiveReviewOpenResult.blockedNoRealReviewOpened() {
    return const GaussEditableMathLiveReviewOpenResult._(
      status: 'blocked',
      errorCode: 'noRealEditableMathLiveReviewOpenedInQ296',
      reviewOpened: false,
      boundToMathLive: false,
      userCanEditBeforeApproval: true,
      workspaceImportPrepared: false,
      directWorkspaceMutationAttempted: false,
      solveGraphSolutionHistoryTriggered: false,
      warnings: <String>['Q296 adds a review contract only; real editable MathLive review opening remains blocked until runtime evidence exists.'],
    );
  }

  final String status;
  final String errorCode;
  final bool reviewOpened;
  final bool boundToMathLive;
  final bool userCanEditBeforeApproval;
  final bool workspaceImportPrepared;
  final bool directWorkspaceMutationAttempted;
  final bool solveGraphSolutionHistoryTriggered;
  final List<String> warnings;

  bool get canImportToWorkspace => reviewOpened && boundToMathLive && workspaceImportPrepared && !directWorkspaceMutationAttempted;
}

class GaussOcrResultEditableMathLiveReviewRealRuntime {
  const GaussOcrResultEditableMathLiveReviewRealRuntime._();

  static GaussOcrResultEditableMathLiveReviewRealRuntimeResult evaluateContract() {
    return const GaussOcrResultEditableMathLiveReviewRealRuntimeResult(
      phase: GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.phase,
      sourcePhase: GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.sourcePhase,
      selectedEngineLabel: GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.selectedEngineLabel,
      reviewFeatureFlag: GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.reviewFeatureFlag,
      reviewReadinessState: GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.reviewReadinessState,
      reviewDecision: GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.reviewDecision,
      editableReviewPreconditions: GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.editableReviewPreconditions,
      reviewDraftEnvelopeFields: GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.reviewDraftEnvelopeFields,
      reviewErrorCodes: GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.reviewErrorCodes,
      decision: GaussOcrResultEditableMathLiveReviewRealRuntimeDecision.editableReviewContractReadyRealBindingBlocked,
      reviewFeatureFlagEnabledByDefault: GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.reviewFeatureFlagEnabledByDefault,
      realEditableMathLiveReviewOpened: GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.realEditableMathLiveReviewOpened,
      realReviewDraftBoundToMathLive: GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.realReviewDraftBoundToMathLive,
      realUserCorrectionCaptured: GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.realUserCorrectionCaptured,
      realImageToLatexInferenceExecuted: GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.realImageToLatexInferenceExecuted,
      directWorkspaceImportEnabled: GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.directWorkspaceImportEnabled,
      directSolveGraphSolutionHistoryEnabled: GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.directSolveGraphSolutionHistoryEnabled,
      reviewBindingPassClaimed: GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.reviewBindingPassClaimed,
      ocrPassClaimed: GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.ocrPassClaimed,
    );
  }

  static GaussEditableMathLiveReviewOpenResult openEditableReviewDraft(
    GaussEditableMathLiveReviewDraftEnvelope draft,
  ) {
    if (!draft.reviewFeatureFlagEnabled) {
      return GaussEditableMathLiveReviewOpenResult.blockedFeatureFlagOff();
    }
    if (!draft.hasPrimaryCandidate) {
      return GaussEditableMathLiveReviewOpenResult.blockedMissingEvidence('primaryLatexCandidateMissing');
    }
    if (!draft.candidateWithinBudget) {
      return GaussEditableMathLiveReviewOpenResult.blockedMissingEvidence('candidateTooLong');
    }
    if (!draft.alternativesWithinBudget) {
      return GaussEditableMathLiveReviewOpenResult.blockedMissingEvidence('tooManyAlternativeCandidates');
    }
    if (!draft.confidenceInRange) {
      return GaussEditableMathLiveReviewOpenResult.blockedMissingEvidence('confidenceMissing');
    }
    if (!draft.hasEngineMetadata) {
      return GaussEditableMathLiveReviewOpenResult.blockedMissingEvidence('engineMetadataMissing');
    }
    if (!draft.hasCropMetadata) {
      return GaussEditableMathLiveReviewOpenResult.blockedMissingEvidence('cropMetadataMissing');
    }
    if (!draft.hasImageSha) {
      return GaussEditableMathLiveReviewOpenResult.blockedMissingEvidence('imageShaMissing');
    }
    if (draft.directWorkspaceMutationAttempted) {
      return GaussEditableMathLiveReviewOpenResult.blockedMissingEvidence('directWorkspaceMutationBlocked');
    }
    if (draft.solveGraphSolutionHistoryTriggered) {
      return GaussEditableMathLiveReviewOpenResult.blockedMissingEvidence('solveGraphSolutionHistoryBlocked');
    }
    return GaussEditableMathLiveReviewOpenResult.blockedNoRealReviewOpened();
  }
}
