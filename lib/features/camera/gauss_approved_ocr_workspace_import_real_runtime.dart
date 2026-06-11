import 'gauss_approved_ocr_workspace_import_real_runtime_policy.dart';
import 'gauss_ocr_result_editable_mathlive_review_real_runtime.dart';

/// V172-Q297 — Approved OCR Workspace Import Real Runtime.
///
/// Contract-only phase. It defines the approved-review workspace import envelope
/// without mutating the workspace, evaluating, solving, graphing, writing
/// Solution/History records, binding a native runtime, or claiming OCR PASS.
enum GaussApprovedOcrWorkspaceImportRealRuntimeDecision {
  approvedWorkspaceImportContractReadyRealImportBlocked,
  blockedMissingQ296EditableReview,
  blockedMissingAcceptedEditableReviewDraft,
  blockedReviewDraftNotEditable,
  blockedMissingExplicitUserApproval,
  blockedEmptyApprovedLatexDraft,
  blockedApprovedLatexDraftTooLong,
  blockedMetadataNotPreserved,
  blockedWorkspaceMutationRuntimeExecution,
  blockedDirectEvaluateRisk,
  blockedDirectSolveGraphSolutionHistoryRisk,
  blockedFakePassClaim,
}

class GaussApprovedOcrWorkspaceImportRealRuntimeResult {
  const GaussApprovedOcrWorkspaceImportRealRuntimeResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.workspaceImportFeatureFlag,
    required this.workspaceImportReadinessState,
    required this.workspaceImportDecision,
    required this.workspaceImportPreconditions,
    required this.workspaceImportEnvelopeFields,
    required this.workspaceImportErrorCodes,
    required this.decision,
    required this.workspaceImportFeatureFlagEnabledByDefault,
    required this.realWorkspaceImportRuntimeExecuted,
    required this.realEditableMathLiveReviewOpened,
    required this.realUserApprovalCaptured,
    required this.directWorkspaceImportEnabled,
    required this.autoEvaluateEnabled,
    required this.autoSolveGraphSolutionHistoryEnabled,
    required this.workspaceImportPassClaimed,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String selectedEngineLabel;
  final String workspaceImportFeatureFlag;
  final String workspaceImportReadinessState;
  final String workspaceImportDecision;
  final List<String> workspaceImportPreconditions;
  final List<String> workspaceImportEnvelopeFields;
  final List<String> workspaceImportErrorCodes;
  final GaussApprovedOcrWorkspaceImportRealRuntimeDecision decision;
  final bool workspaceImportFeatureFlagEnabledByDefault;
  final bool realWorkspaceImportRuntimeExecuted;
  final bool realEditableMathLiveReviewOpened;
  final bool realUserApprovalCaptured;
  final bool directWorkspaceImportEnabled;
  final bool autoEvaluateEnabled;
  final bool autoSolveGraphSolutionHistoryEnabled;
  final bool workspaceImportPassClaimed;
  final bool ocrPassClaimed;
}

class GaussApprovedOcrWorkspaceImportEnvelope {
  const GaussApprovedOcrWorkspaceImportEnvelope._({
    required this.workspaceImportRequestId,
    required this.reviewId,
    required this.sourceInferenceRequestId,
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
    required this.cropMetadata,
    required this.imageSha256,
    required this.manualSolveGraphAfterImportOnly,
    required this.directEvaluateAttempted,
    required this.directSolveGraphSolutionHistoryAttempted,
    required this.errorCode,
  });

  factory GaussApprovedOcrWorkspaceImportEnvelope.fromApprovedReviewDraft({
    required bool workspaceImportFeatureFlagEnabled,
    required GaussEditableMathLiveReviewDraftEnvelope reviewDraft,
    required bool userApprovedForWorkspaceImport,
    required String approvedLatexDraft,
    Map<String, String> reviewMetadata = const <String, String>{},
    bool directEvaluateAttempted = false,
    bool directSolveGraphSolutionHistoryAttempted = false,
  }) {
    final trimmed = approvedLatexDraft.trim();
    final flagReady = workspaceImportFeatureFlagEnabled;
    final draftSafe = reviewDraft.isReviewDraftStructurallySafe;
    final approved = userApprovedForWorkspaceImport && trimmed.isNotEmpty && trimmed.length <= GaussApprovedOcrWorkspaceImportRealRuntimePolicy.maxApprovedLatexLength;
    final metadataPreserved = reviewMetadata.isNotEmpty && reviewDraft.engineMetadata.isNotEmpty && reviewDraft.cropMetadata.isNotEmpty && reviewDraft.hasImageSha;
    final directSideEffectsBlocked = !directEvaluateAttempted && !directSolveGraphSolutionHistoryAttempted;
    final errorCode = !flagReady
        ? 'workspaceImportFeatureFlagOff'
        : !draftSafe
            ? 'acceptedEditableReviewDraftMissing'
            : !userApprovedForWorkspaceImport
                ? 'missingExplicitUserApproval'
                : trimmed.isEmpty
                    ? 'approvedLatexDraftEmpty'
                    : trimmed.length > GaussApprovedOcrWorkspaceImportRealRuntimePolicy.maxApprovedLatexLength
                        ? 'approvedLatexDraftTooLong'
                        : !metadataPreserved
                            ? 'metadataNotPreserved'
                            : directEvaluateAttempted
                                ? 'directEvaluateBlocked'
                                : directSolveGraphSolutionHistoryAttempted
                                    ? 'solveGraphSolutionHistoryBlocked'
                                    : 'noRealWorkspaceImportExecutedInQ297';
    final prepared = flagReady && approved && draftSafe && metadataPreserved && directSideEffectsBlocked;
    return GaussApprovedOcrWorkspaceImportEnvelope._(
      workspaceImportRequestId: 'q297-${reviewDraft.reviewId}',
      reviewId: reviewDraft.reviewId,
      sourceInferenceRequestId: reviewDraft.sourceInferenceRequestId,
      captureId: reviewDraft.captureId,
      engineLabel: reviewDraft.engineLabel,
      sourcePhase: GaussApprovedOcrWorkspaceImportRealRuntimePolicy.sourcePhase,
      approvedLatexDraft: trimmed,
      reviewDraftEditable: reviewDraft.isReviewDraftStructurallySafe,
      userApprovedForWorkspaceImport: userApprovedForWorkspaceImport,
      workspaceImportPrepared: prepared,
      workspaceImportRuntimeExecuted: false,
      workspaceExpressionCandidate: prepared ? trimmed : '',
      selectedCandidateIndex: reviewDraft.selectedCandidateIndex,
      confidence: reviewDraft.confidence,
      warnings: reviewDraft.warnings,
      reviewMetadata: reviewMetadata,
      engineMetadata: reviewDraft.engineMetadata,
      cropMetadata: reviewDraft.cropMetadata,
      imageSha256: reviewDraft.imageSha256,
      manualSolveGraphAfterImportOnly: true,
      directEvaluateAttempted: directEvaluateAttempted,
      directSolveGraphSolutionHistoryAttempted: directSolveGraphSolutionHistoryAttempted,
      errorCode: errorCode,
    );
  }

  final String workspaceImportRequestId;
  final String reviewId;
  final String sourceInferenceRequestId;
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
  final Map<String, String> cropMetadata;
  final String imageSha256;
  final bool manualSolveGraphAfterImportOnly;
  final bool directEvaluateAttempted;
  final bool directSolveGraphSolutionHistoryAttempted;
  final String errorCode;

  bool get canMutateWorkspaceInQ297 => false;
  bool get canEvaluateInQ297 => false;
  bool get canSolveGraphSolutionHistoryInQ297 => false;
  bool get canClaimWorkspaceImportPass => false;
}

class GaussApprovedOcrWorkspaceImportRealRuntime {
  const GaussApprovedOcrWorkspaceImportRealRuntime._();

  static GaussApprovedOcrWorkspaceImportRealRuntimeResult evaluateContract() {
    return const GaussApprovedOcrWorkspaceImportRealRuntimeResult(
      phase: GaussApprovedOcrWorkspaceImportRealRuntimePolicy.phase,
      sourcePhase: GaussApprovedOcrWorkspaceImportRealRuntimePolicy.sourcePhase,
      selectedEngineLabel: GaussApprovedOcrWorkspaceImportRealRuntimePolicy.selectedEngineLabel,
      workspaceImportFeatureFlag: GaussApprovedOcrWorkspaceImportRealRuntimePolicy.workspaceImportFeatureFlag,
      workspaceImportReadinessState: GaussApprovedOcrWorkspaceImportRealRuntimePolicy.workspaceImportReadinessState,
      workspaceImportDecision: GaussApprovedOcrWorkspaceImportRealRuntimePolicy.workspaceImportDecision,
      workspaceImportPreconditions: GaussApprovedOcrWorkspaceImportRealRuntimePolicy.workspaceImportPreconditions,
      workspaceImportEnvelopeFields: GaussApprovedOcrWorkspaceImportRealRuntimePolicy.workspaceImportEnvelopeFields,
      workspaceImportErrorCodes: GaussApprovedOcrWorkspaceImportRealRuntimePolicy.workspaceImportErrorCodes,
      decision: GaussApprovedOcrWorkspaceImportRealRuntimeDecision.approvedWorkspaceImportContractReadyRealImportBlocked,
      workspaceImportFeatureFlagEnabledByDefault: GaussApprovedOcrWorkspaceImportRealRuntimePolicy.workspaceImportFeatureFlagEnabledByDefault,
      realWorkspaceImportRuntimeExecuted: GaussApprovedOcrWorkspaceImportRealRuntimePolicy.realWorkspaceImportRuntimeExecuted,
      realEditableMathLiveReviewOpened: GaussApprovedOcrWorkspaceImportRealRuntimePolicy.realEditableMathLiveReviewOpened,
      realUserApprovalCaptured: GaussApprovedOcrWorkspaceImportRealRuntimePolicy.realUserApprovalCaptured,
      directWorkspaceImportEnabled: GaussApprovedOcrWorkspaceImportRealRuntimePolicy.directWorkspaceImportEnabled,
      autoEvaluateEnabled: GaussApprovedOcrWorkspaceImportRealRuntimePolicy.autoEvaluateEnabled,
      autoSolveGraphSolutionHistoryEnabled: GaussApprovedOcrWorkspaceImportRealRuntimePolicy.autoSolveGraphSolutionHistoryEnabled,
      workspaceImportPassClaimed: GaussApprovedOcrWorkspaceImportRealRuntimePolicy.workspaceImportPassClaimed,
      ocrPassClaimed: GaussApprovedOcrWorkspaceImportRealRuntimePolicy.ocrPassClaimed,
    );
  }
}
