import 'gauss_approved_ocr_workspace_import_runtime_court_policy.dart';
import 'gauss_ocr_result_real_mathlive_review_runtime_binding.dart';

/// V172-Q285 — Approved OCR Workspace Import Runtime Court.
///
/// This is still a court/gate layer: it prepares an approved-review import
/// envelope only. It does not mutate the workspace, does not evaluate, does not
/// solve, does not graph, and does not write Solution/History records.
enum GaussApprovedOcrWorkspaceImportRuntimeCourtDecision {
  blockedMissingQ284ReviewRuntimeBinding,
  blockedMissingAcceptedEditableMathLiveReviewDraft,
  blockedReviewDraftNotEditable,
  blockedMissingExplicitUserApproval,
  blockedEmptyApprovedLatexDraft,
  blockedApprovedLatexDraftTooLong,
  blockedWorkspaceImportPreparedBeforeApproval,
  blockedMetadataNotPreserved,
  blockedWorkspaceMutationRuntimeExecutionAttempted,
  blockedAutoEvaluateRisk,
  blockedAutoSolveGraphSolutionHistoryRisk,
  blockedUnsafeRuntimeInferenceOrPassClaim,
  readyForFutureRuntimeWorkspaceImportOnly,
}

class GaussApprovedOcrWorkspaceImportRuntimeCourtInput {
  const GaussApprovedOcrWorkspaceImportRuntimeCourtInput({
    required this.q284RealMathLiveReviewRuntimeBindingPresent,
    required this.acceptedEditableMathLiveReviewDraftEvidence,
    required this.editableReviewDraftPresent,
    required this.reviewDraftMayBeEditedBeforeApproval,
    required this.explicitUserApprovalReceived,
    required this.approvedLatexDraft,
    required this.workspaceImportPreparedOnlyAfterUserApproval,
    required this.workspaceImportEnvelopePreservesReviewMetadata,
    required this.workspaceImportEnvelopePreservesEngineMetadata,
    required this.workspaceImportEnvelopePreservesImageInputMetadata,
    required this.workspaceMutationRuntimeExecutionAttemptedInQ285,
    required this.autoEvaluateAfterImport,
    required this.autoSolveAfterImport,
    required this.autoGraphAfterImport,
    required this.autoSolutionAfterImport,
    required this.autoHistoryAfterImport,
    required this.manualSolveGraphAfterImportOnly,
    required this.noRealWorkspaceImportRuntimeExecutedInQ285,
    required this.noRealMathLiveReviewRuntimeBindingExecutedInQ285,
    required this.noRealImageToLatexInferenceExecutedInQ285,
    required this.noRealRuntimeInvocationExecutedInQ285,
    required this.noNativeRuntimeBridgeInvokedInQ285,
    required this.noPaddleRuntimeAdded,
    required this.noPaddleOcrDependencyAdded,
    required this.noNativeHandlerImplementationAdded,
    required this.noJniBindingAdded,
    required this.noMethodChannelRuntimeBindingAdded,
    required this.noRuntimeDependencyAddedToPubspec,
    required this.noGradleNativeRuntimeDependencyAdded,
    required this.noModelBinaryBundledInBaseApp,
    required this.noProductionModelUrlBound,
    required this.noProductionDownloadEnabled,
    required this.noRealNetworkDownloadWorkerImplemented,
    required this.workspaceImportRuntimePassClaimed,
    required this.ocrPassClaimed,
    required this.releasePassClaimed,
    required this.importLabel,
  });

  final bool q284RealMathLiveReviewRuntimeBindingPresent;
  final bool acceptedEditableMathLiveReviewDraftEvidence;
  final bool editableReviewDraftPresent;
  final bool reviewDraftMayBeEditedBeforeApproval;
  final bool explicitUserApprovalReceived;
  final String approvedLatexDraft;
  final bool workspaceImportPreparedOnlyAfterUserApproval;
  final bool workspaceImportEnvelopePreservesReviewMetadata;
  final bool workspaceImportEnvelopePreservesEngineMetadata;
  final bool workspaceImportEnvelopePreservesImageInputMetadata;
  final bool workspaceMutationRuntimeExecutionAttemptedInQ285;
  final bool autoEvaluateAfterImport;
  final bool autoSolveAfterImport;
  final bool autoGraphAfterImport;
  final bool autoSolutionAfterImport;
  final bool autoHistoryAfterImport;
  final bool manualSolveGraphAfterImportOnly;
  final bool noRealWorkspaceImportRuntimeExecutedInQ285;
  final bool noRealMathLiveReviewRuntimeBindingExecutedInQ285;
  final bool noRealImageToLatexInferenceExecutedInQ285;
  final bool noRealRuntimeInvocationExecutedInQ285;
  final bool noNativeRuntimeBridgeInvokedInQ285;
  final bool noPaddleRuntimeAdded;
  final bool noPaddleOcrDependencyAdded;
  final bool noNativeHandlerImplementationAdded;
  final bool noJniBindingAdded;
  final bool noMethodChannelRuntimeBindingAdded;
  final bool noRuntimeDependencyAddedToPubspec;
  final bool noGradleNativeRuntimeDependencyAdded;
  final bool noModelBinaryBundledInBaseApp;
  final bool noProductionModelUrlBound;
  final bool noProductionDownloadEnabled;
  final bool noRealNetworkDownloadWorkerImplemented;
  final bool workspaceImportRuntimePassClaimed;
  final bool ocrPassClaimed;
  final bool releasePassClaimed;
  final String importLabel;
}

class GaussApprovedOcrWorkspaceImportRuntimeCourtResult {
  const GaussApprovedOcrWorkspaceImportRuntimeCourtResult._({
    required this.decision,
    required this.workspaceImportRuntimeCourtStaticReady,
    required this.readyForFutureRuntimeWorkspaceImportOnly,
    required this.rejectionReasons,
    required this.canPrepareWorkspaceImportEnvelopeAfterApproval,
    required this.canMutateWorkspaceInQ285,
    required this.canEvaluate,
    required this.canSolve,
    required this.canGraph,
    required this.canWriteSolutionOrHistory,
    required this.canClaimWorkspaceImportRuntimePassInQ285,
    required this.canClaimOcrPassInQ285,
    required this.importLabel,
  });

  final GaussApprovedOcrWorkspaceImportRuntimeCourtDecision decision;
  final bool workspaceImportRuntimeCourtStaticReady;
  final bool readyForFutureRuntimeWorkspaceImportOnly;
  final List<String> rejectionReasons;
  final bool canPrepareWorkspaceImportEnvelopeAfterApproval;
  final bool canMutateWorkspaceInQ285;
  final bool canEvaluate;
  final bool canSolve;
  final bool canGraph;
  final bool canWriteSolutionOrHistory;
  final bool canClaimWorkspaceImportRuntimePassInQ285;
  final bool canClaimOcrPassInQ285;
  final String importLabel;

  String get phase => GaussApprovedOcrWorkspaceImportRuntimeCourtPolicy.phase;
  String get sourcePhase => GaussApprovedOcrWorkspaceImportRuntimeCourtPolicy.sourcePhase;
  String get selectedEngineLabel => GaussApprovedOcrWorkspaceImportRuntimeCourtPolicy.selectedEngineLabel;
  String get fallbackEngineLabel => GaussApprovedOcrWorkspaceImportRuntimeCourtPolicy.fallbackEngineLabel;
  String get workspaceImportMode => GaussApprovedOcrWorkspaceImportRuntimeCourtPolicy.workspaceImportMode;
  bool get realWorkspaceImportRuntimeExecutedInQ285 => GaussApprovedOcrWorkspaceImportRuntimeCourtPolicy.realWorkspaceImportRuntimeExecutedInQ285;
  bool get realImageToLatexInferenceExecutedInQ285 => GaussApprovedOcrWorkspaceImportRuntimeCourtPolicy.realImageToLatexInferenceExecutedInQ285;
  bool get ocrPassClaimed => GaussApprovedOcrWorkspaceImportRuntimeCourtPolicy.ocrPassClaimed;
  List<String> get requiredWorkspaceImportRuntimeCourtGates => GaussApprovedOcrWorkspaceImportRuntimeCourtPolicy.requiredWorkspaceImportRuntimeCourtGates;
  List<String> get blockedUntilRealEvidence => GaussApprovedOcrWorkspaceImportRuntimeCourtPolicy.blockedUntilRealEvidence;
  List<String> get forbiddenActions => GaussApprovedOcrWorkspaceImportRuntimeCourtPolicy.forbiddenActions;
}

class GaussApprovedOcrWorkspaceImportEnvelope {
  const GaussApprovedOcrWorkspaceImportEnvelope._({
    required this.requestId,
    required this.captureId,
    required this.engineLabel,
    required this.sourcePhase,
    required this.approvedLatexDraft,
    required this.reviewDraftEditable,
    required this.userApprovedForWorkspaceImport,
    required this.workspaceImportPrepared,
    required this.workspaceImportRuntimeExecuted,
    required this.workspaceExpressionCandidate,
    required this.selectedCandidateIndex,
    required this.confidence,
    required this.warnings,
    required this.reviewMetadata,
    required this.engineMetadata,
    required this.imageInputMetadata,
    required this.manualSolveGraphAfterImportOnly,
    required this.directEvaluateAttempted,
    required this.directSolveGraphSolutionHistoryAttempted,
    required this.errorCode,
  });

  factory GaussApprovedOcrWorkspaceImportEnvelope.fromApprovedReviewDraft({
    required bool workspaceImportRuntimeCourtFeatureFlagEnabled,
    required GaussRealMathLiveReviewDraftEnvelope reviewDraft,
    required bool userApprovedForWorkspaceImport,
    required String approvedLatexDraft,
    Map<String, String> reviewMetadata = const <String, String>{},
  }) {
    final trimmed = approvedLatexDraft.trim();
    final approved = userApprovedForWorkspaceImport && trimmed.isNotEmpty && trimmed.length <= GaussApprovedOcrWorkspaceImportRuntimeCourtPolicy.maxApprovedLatexLength;
    final flagReady = workspaceImportRuntimeCourtFeatureFlagEnabled;
    final errorCode = !flagReady
        ? 'workspaceImportRuntimeCourtFeatureFlagOff'
        : !reviewDraft.canOpenEditableMathLiveReview
            ? 'missingAcceptedEditableMathLiveReviewDraft'
            : !userApprovedForWorkspaceImport
                ? 'missingExplicitUserApproval'
                : trimmed.isEmpty
                    ? 'approvedLatexDraftEmpty'
                    : trimmed.length > GaussApprovedOcrWorkspaceImportRuntimeCourtPolicy.maxApprovedLatexLength
                        ? 'approvedLatexDraftTooLong'
                        : '';
    return GaussApprovedOcrWorkspaceImportEnvelope._(
      requestId: reviewDraft.requestId,
      captureId: reviewDraft.captureId,
      engineLabel: reviewDraft.engineLabel,
      sourcePhase: GaussApprovedOcrWorkspaceImportRuntimeCourtPolicy.sourcePhase,
      approvedLatexDraft: trimmed,
      reviewDraftEditable: reviewDraft.reviewDraftEditable,
      userApprovedForWorkspaceImport: userApprovedForWorkspaceImport,
      workspaceImportPrepared: flagReady && approved && reviewDraft.canOpenEditableMathLiveReview,
      workspaceImportRuntimeExecuted: false,
      workspaceExpressionCandidate: flagReady && approved ? trimmed : '',
      selectedCandidateIndex: reviewDraft.selectedCandidateIndex,
      confidence: reviewDraft.confidence,
      warnings: reviewDraft.warnings,
      reviewMetadata: reviewMetadata,
      engineMetadata: reviewDraft.engineMetadata,
      imageInputMetadata: reviewDraft.imageInputMetadata,
      manualSolveGraphAfterImportOnly: true,
      directEvaluateAttempted: false,
      directSolveGraphSolutionHistoryAttempted: false,
      errorCode: errorCode,
    );
  }

  final String requestId;
  final String captureId;
  final String engineLabel;
  final String sourcePhase;
  final String approvedLatexDraft;
  final bool reviewDraftEditable;
  final bool userApprovedForWorkspaceImport;
  final bool workspaceImportPrepared;
  final bool workspaceImportRuntimeExecuted;
  final String workspaceExpressionCandidate;
  final int selectedCandidateIndex;
  final double confidence;
  final List<String> warnings;
  final Map<String, String> reviewMetadata;
  final Map<String, String> engineMetadata;
  final Map<String, String> imageInputMetadata;
  final bool manualSolveGraphAfterImportOnly;
  final bool directEvaluateAttempted;
  final bool directSolveGraphSolutionHistoryAttempted;
  final String errorCode;

  bool get canPrepareWorkspaceImportEnvelope => workspaceImportPrepared && errorCode.isEmpty;
  bool get canMutateWorkspaceInQ285 => false;
  bool get canEvaluate => false;
  bool get canSolve => false;
  bool get canGraph => false;
  bool get canWriteSolutionOrHistory => false;
}

class GaussApprovedOcrWorkspaceImportRuntimeCourt {
  const GaussApprovedOcrWorkspaceImportRuntimeCourt._();

  static GaussApprovedOcrWorkspaceImportRuntimeCourtResult evaluate(GaussApprovedOcrWorkspaceImportRuntimeCourtInput input) {
    GaussApprovedOcrWorkspaceImportRuntimeCourtResult reject(GaussApprovedOcrWorkspaceImportRuntimeCourtDecision decision, String reason) {
      return GaussApprovedOcrWorkspaceImportRuntimeCourtResult._(
        decision: decision,
        workspaceImportRuntimeCourtStaticReady: false,
        readyForFutureRuntimeWorkspaceImportOnly: false,
        rejectionReasons: <String>[reason],
        canPrepareWorkspaceImportEnvelopeAfterApproval: false,
        canMutateWorkspaceInQ285: false,
        canEvaluate: false,
        canSolve: false,
        canGraph: false,
        canWriteSolutionOrHistory: false,
        canClaimWorkspaceImportRuntimePassInQ285: false,
        canClaimOcrPassInQ285: false,
        importLabel: input.importLabel,
      );
    }

    if (!input.q284RealMathLiveReviewRuntimeBindingPresent) {
      return reject(GaussApprovedOcrWorkspaceImportRuntimeCourtDecision.blockedMissingQ284ReviewRuntimeBinding, 'missingQ284ReviewRuntimeBinding');
    }
    if (!input.acceptedEditableMathLiveReviewDraftEvidence || !input.editableReviewDraftPresent) {
      return reject(GaussApprovedOcrWorkspaceImportRuntimeCourtDecision.blockedMissingAcceptedEditableMathLiveReviewDraft, 'missingAcceptedEditableMathLiveReviewDraft');
    }
    if (!input.reviewDraftMayBeEditedBeforeApproval) {
      return reject(GaussApprovedOcrWorkspaceImportRuntimeCourtDecision.blockedReviewDraftNotEditable, 'reviewDraftNotEditable');
    }
    if (!input.explicitUserApprovalReceived) {
      return reject(GaussApprovedOcrWorkspaceImportRuntimeCourtDecision.blockedMissingExplicitUserApproval, 'missingExplicitUserApproval');
    }
    final approvedLatex = input.approvedLatexDraft.trim();
    if (approvedLatex.isEmpty) {
      return reject(GaussApprovedOcrWorkspaceImportRuntimeCourtDecision.blockedEmptyApprovedLatexDraft, 'approvedLatexDraftEmpty');
    }
    if (approvedLatex.length > GaussApprovedOcrWorkspaceImportRuntimeCourtPolicy.maxApprovedLatexLength) {
      return reject(GaussApprovedOcrWorkspaceImportRuntimeCourtDecision.blockedApprovedLatexDraftTooLong, 'approvedLatexDraftTooLong');
    }
    if (!input.workspaceImportPreparedOnlyAfterUserApproval) {
      return reject(GaussApprovedOcrWorkspaceImportRuntimeCourtDecision.blockedWorkspaceImportPreparedBeforeApproval, 'workspaceImportPreparedBeforeApproval');
    }
    if (!input.workspaceImportEnvelopePreservesReviewMetadata || !input.workspaceImportEnvelopePreservesEngineMetadata || !input.workspaceImportEnvelopePreservesImageInputMetadata) {
      return reject(GaussApprovedOcrWorkspaceImportRuntimeCourtDecision.blockedMetadataNotPreserved, 'metadataNotPreserved');
    }
    if (input.workspaceMutationRuntimeExecutionAttemptedInQ285) {
      return reject(GaussApprovedOcrWorkspaceImportRuntimeCourtDecision.blockedWorkspaceMutationRuntimeExecutionAttempted, 'workspaceMutationRuntimeExecutionAttemptedInQ285');
    }
    if (input.autoEvaluateAfterImport) {
      return reject(GaussApprovedOcrWorkspaceImportRuntimeCourtDecision.blockedAutoEvaluateRisk, 'autoEvaluateRisk');
    }
    if (input.autoSolveAfterImport || input.autoGraphAfterImport || input.autoSolutionAfterImport || input.autoHistoryAfterImport || !input.manualSolveGraphAfterImportOnly) {
      return reject(GaussApprovedOcrWorkspaceImportRuntimeCourtDecision.blockedAutoSolveGraphSolutionHistoryRisk, 'autoSolveGraphSolutionHistoryRisk');
    }
    final unsafeRuntimeClaim = !input.noRealWorkspaceImportRuntimeExecutedInQ285 ||
        !input.noRealMathLiveReviewRuntimeBindingExecutedInQ285 ||
        !input.noRealImageToLatexInferenceExecutedInQ285 ||
        !input.noRealRuntimeInvocationExecutedInQ285 ||
        !input.noNativeRuntimeBridgeInvokedInQ285 ||
        !input.noPaddleRuntimeAdded ||
        !input.noPaddleOcrDependencyAdded ||
        !input.noNativeHandlerImplementationAdded ||
        !input.noJniBindingAdded ||
        !input.noMethodChannelRuntimeBindingAdded ||
        !input.noRuntimeDependencyAddedToPubspec ||
        !input.noGradleNativeRuntimeDependencyAdded ||
        !input.noModelBinaryBundledInBaseApp ||
        !input.noProductionModelUrlBound ||
        !input.noProductionDownloadEnabled ||
        !input.noRealNetworkDownloadWorkerImplemented ||
        input.workspaceImportRuntimePassClaimed ||
        input.ocrPassClaimed ||
        input.releasePassClaimed;
    if (unsafeRuntimeClaim) {
      return reject(GaussApprovedOcrWorkspaceImportRuntimeCourtDecision.blockedUnsafeRuntimeInferenceOrPassClaim, 'unsafeRuntimeInferenceOrPassClaim');
    }

    return GaussApprovedOcrWorkspaceImportRuntimeCourtResult._(
      decision: GaussApprovedOcrWorkspaceImportRuntimeCourtDecision.readyForFutureRuntimeWorkspaceImportOnly,
      workspaceImportRuntimeCourtStaticReady: true,
      readyForFutureRuntimeWorkspaceImportOnly: true,
      rejectionReasons: const <String>[],
      canPrepareWorkspaceImportEnvelopeAfterApproval: true,
      canMutateWorkspaceInQ285: false,
      canEvaluate: false,
      canSolve: false,
      canGraph: false,
      canWriteSolutionOrHistory: false,
      canClaimWorkspaceImportRuntimePassInQ285: false,
      canClaimOcrPassInQ285: false,
      importLabel: input.importLabel,
    );
  }
}
