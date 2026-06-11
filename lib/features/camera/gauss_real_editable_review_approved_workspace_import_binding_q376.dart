import 'gauss_real_editable_review_approved_workspace_import_binding_q376_policy.dart';
import 'gauss_real_ocr_execution_output_decoder_closure_q375.dart';

class GaussRealEditableReviewApprovedWorkspaceImportBindingQ376Result {
  const GaussRealEditableReviewApprovedWorkspaceImportBindingQ376Result({
    required this.phase,
    required this.sourcePhase,
    required this.status,
    required this.bindingVersion,
    required this.reviewTarget,
    required this.workspaceImportTarget,
    required this.realEditableReviewBindingPrepared,
    required this.approvedWorkspaceImportBindingPrepared,
    required this.requiresQ375DecodedCandidate,
    required this.requiresEditableMathLiveReviewBeforeImport,
    required this.requiresExplicitUserApprovalBeforeWorkspaceImport,
    required this.requiresNonEmptyApprovedLatex,
    required this.directOcrToWorkspaceImportBlocked,
    required this.directOcrToSolveGraphSolutionHistoryBlocked,
    required this.mathLiveProductionRoutePreserved,
    required this.workspaceUiPreserved,
    required this.workspaceImportAutoExecuted,
    required this.approvedWorkspaceImportExecutedByPackage,
    required this.solveGraphSolutionHistoryTouched,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String status;
  final String bindingVersion;
  final String reviewTarget;
  final String workspaceImportTarget;
  final bool realEditableReviewBindingPrepared;
  final bool approvedWorkspaceImportBindingPrepared;
  final bool requiresQ375DecodedCandidate;
  final bool requiresEditableMathLiveReviewBeforeImport;
  final bool requiresExplicitUserApprovalBeforeWorkspaceImport;
  final bool requiresNonEmptyApprovedLatex;
  final bool directOcrToWorkspaceImportBlocked;
  final bool directOcrToSolveGraphSolutionHistoryBlocked;
  final bool mathLiveProductionRoutePreserved;
  final bool workspaceUiPreserved;
  final bool workspaceImportAutoExecuted;
  final bool approvedWorkspaceImportExecutedByPackage;
  final bool solveGraphSolutionHistoryTouched;
  final bool ocrPassClaimed;
}

class GaussEditableOcrReviewDraftQ376 {
  const GaussEditableOcrReviewDraftQ376({
    required this.candidateLatex,
    required this.candidateConfidence,
    required this.candidateSource,
    required this.reviewLatex,
    required this.reviewReady,
    required this.blockedReason,
    required this.requiresEditableMathLiveReviewBeforeImport,
    required this.requiresExplicitUserApprovalBeforeWorkspaceImport,
    required this.directOcrToWorkspaceImportBlocked,
  });

  final String candidateLatex;
  final double candidateConfidence;
  final String candidateSource;
  final String reviewLatex;
  final bool reviewReady;
  final String blockedReason;
  final bool requiresEditableMathLiveReviewBeforeImport;
  final bool requiresExplicitUserApprovalBeforeWorkspaceImport;
  final bool directOcrToWorkspaceImportBlocked;

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'phase': GaussRealEditableReviewApprovedWorkspaceImportBindingQ376Policy.phase,
      'candidateLatex': candidateLatex,
      'candidateConfidence': candidateConfidence,
      'candidateSource': candidateSource,
      'reviewLatex': reviewLatex,
      'reviewReady': reviewReady,
      'blockedReason': blockedReason,
      'requiresEditableMathLiveReviewBeforeImport': requiresEditableMathLiveReviewBeforeImport,
      'requiresExplicitUserApprovalBeforeWorkspaceImport': requiresExplicitUserApprovalBeforeWorkspaceImport,
      'directOcrToWorkspaceImportBlocked': directOcrToWorkspaceImportBlocked,
      'workspaceImportExecuted': false,
      'ocrPassClaimed': false,
    };
  }
}

class GaussApprovedWorkspaceImportCommandQ376 {
  const GaussApprovedWorkspaceImportCommandQ376({
    required this.approvedLatex,
    required this.candidateConfidence,
    required this.reviewCompleted,
    required this.explicitUserApproval,
    required this.approvedWorkspaceImportReady,
    required this.blockedReason,
    required this.workspaceImportTarget,
    required this.autoSolveBlocked,
    required this.autoGraphBlocked,
    required this.autoSolutionHistoryBlocked,
    required this.workspaceImportExecutedByPackage,
  });

  final String approvedLatex;
  final double candidateConfidence;
  final bool reviewCompleted;
  final bool explicitUserApproval;
  final bool approvedWorkspaceImportReady;
  final String blockedReason;
  final String workspaceImportTarget;
  final bool autoSolveBlocked;
  final bool autoGraphBlocked;
  final bool autoSolutionHistoryBlocked;
  final bool workspaceImportExecutedByPackage;

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'phase': GaussRealEditableReviewApprovedWorkspaceImportBindingQ376Policy.phase,
      'approvedLatex': approvedLatex,
      'candidateConfidence': candidateConfidence,
      'reviewCompleted': reviewCompleted,
      'explicitUserApproval': explicitUserApproval,
      'approvedWorkspaceImportReady': approvedWorkspaceImportReady,
      'blockedReason': blockedReason,
      'workspaceImportTarget': workspaceImportTarget,
      'autoSolveBlocked': autoSolveBlocked,
      'autoGraphBlocked': autoGraphBlocked,
      'autoSolutionHistoryBlocked': autoSolutionHistoryBlocked,
      'workspaceImportExecutedByPackage': workspaceImportExecutedByPackage,
      'ocrPassClaimed': false,
    };
  }
}

class GaussRealEditableReviewApprovedWorkspaceImportBindingQ376 {
  const GaussRealEditableReviewApprovedWorkspaceImportBindingQ376._();

  static GaussRealEditableReviewApprovedWorkspaceImportBindingQ376Result evaluate() {
    return const GaussRealEditableReviewApprovedWorkspaceImportBindingQ376Result(
      phase: GaussRealEditableReviewApprovedWorkspaceImportBindingQ376Policy.phase,
      sourcePhase: GaussRealEditableReviewApprovedWorkspaceImportBindingQ376Policy.sourcePhase,
      status: GaussRealEditableReviewApprovedWorkspaceImportBindingQ376Policy.status,
      bindingVersion: GaussRealEditableReviewApprovedWorkspaceImportBindingQ376Policy.bindingVersion,
      reviewTarget: GaussRealEditableReviewApprovedWorkspaceImportBindingQ376Policy.reviewTarget,
      workspaceImportTarget: GaussRealEditableReviewApprovedWorkspaceImportBindingQ376Policy.workspaceImportTarget,
      realEditableReviewBindingPrepared: true,
      approvedWorkspaceImportBindingPrepared: true,
      requiresQ375DecodedCandidate: true,
      requiresEditableMathLiveReviewBeforeImport: true,
      requiresExplicitUserApprovalBeforeWorkspaceImport: true,
      requiresNonEmptyApprovedLatex: true,
      directOcrToWorkspaceImportBlocked: true,
      directOcrToSolveGraphSolutionHistoryBlocked: true,
      mathLiveProductionRoutePreserved: true,
      workspaceUiPreserved: true,
      workspaceImportAutoExecuted: false,
      approvedWorkspaceImportExecutedByPackage: false,
      solveGraphSolutionHistoryTouched: false,
      ocrPassClaimed: false,
    );
  }

  static GaussEditableOcrReviewDraftQ376 prepareReviewDraft(
    GaussRealOcrDecodedCandidateQ375 decodedCandidate, {
    String editedLatex = '',
  }) {
    final candidateLatex = decodedCandidate.candidateLatex.trim();
    final reviewLatex = editedLatex.trim().isNotEmpty ? editedLatex.trim() : candidateLatex;
    final reviewReady = decodedCandidate.candidateLatexDecoded && reviewLatex.isNotEmpty;
    return GaussEditableOcrReviewDraftQ376(
      candidateLatex: candidateLatex,
      candidateConfidence: decodedCandidate.candidateConfidence,
      candidateSource: decodedCandidate.candidateSource,
      reviewLatex: reviewLatex,
      reviewReady: reviewReady,
      blockedReason: reviewReady ? '' : 'q376-review-blocked-empty-or-undecoded-candidate',
      requiresEditableMathLiveReviewBeforeImport: true,
      requiresExplicitUserApprovalBeforeWorkspaceImport: true,
      directOcrToWorkspaceImportBlocked: true,
    );
  }

  static GaussApprovedWorkspaceImportCommandQ376 buildApprovedWorkspaceImportCommand({
    required GaussEditableOcrReviewDraftQ376 reviewDraft,
    required bool reviewCompleted,
    required bool explicitUserApproval,
    String approvedLatexOverride = '',
  }) {
    final approvedLatex = approvedLatexOverride.trim().isNotEmpty
        ? approvedLatexOverride.trim()
        : reviewDraft.reviewLatex.trim();
    final ready = reviewDraft.reviewReady && reviewCompleted && explicitUserApproval && approvedLatex.isNotEmpty;
    return GaussApprovedWorkspaceImportCommandQ376(
      approvedLatex: approvedLatex,
      candidateConfidence: reviewDraft.candidateConfidence,
      reviewCompleted: reviewCompleted,
      explicitUserApproval: explicitUserApproval,
      approvedWorkspaceImportReady: ready,
      blockedReason: ready ? '' : _approvedImportBlockedReason(reviewDraft, reviewCompleted, explicitUserApproval, approvedLatex),
      workspaceImportTarget: GaussRealEditableReviewApprovedWorkspaceImportBindingQ376Policy.workspaceImportTarget,
      autoSolveBlocked: true,
      autoGraphBlocked: true,
      autoSolutionHistoryBlocked: true,
      workspaceImportExecutedByPackage: false,
    );
  }

  static String _approvedImportBlockedReason(
    GaussEditableOcrReviewDraftQ376 reviewDraft,
    bool reviewCompleted,
    bool explicitUserApproval,
    String approvedLatex,
  ) {
    if (!reviewDraft.reviewReady) return 'editable-review-not-ready';
    if (!reviewCompleted) return 'editable-review-not-completed';
    if (!explicitUserApproval) return 'explicit-user-approval-missing';
    if (approvedLatex.trim().isEmpty) return 'approved-latex-empty';
    return 'approved-workspace-import-not-ready';
  }
}
