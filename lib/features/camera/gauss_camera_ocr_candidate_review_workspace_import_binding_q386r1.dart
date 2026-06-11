class GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy {
  const GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy._();

  static const String phase = 'V172-Q386R1-OCR-CANDIDATE-REVIEW-WORKSPACE-IMPORT-BINDING';
  static const String sourcePhase = 'V172-Q386-REAL-PADDLE-OCR-INFERENCE-BRIDGE';
  static const String reviewSurface = 'GaussMathLiveOcrReviewSheet';
  static const String workspaceImportRuntime = 'AppShell._handleApprovedOcrWorkspaceImport';
  static const String workspaceImportMode = 'explicit-user-approved-reviewed-latex-only';
  static const String blockedNoCandidate = 'q386r1-real-ocr-candidate-required';
  static const String blockedNoReviewDraft = 'q386r1-editable-review-draft-required';
  static const String blockedNoCallback = 'q386r1-workspace-import-callback-required';
  static const String blockedEmptyApprovedLatex = 'q386r1-approved-latex-required';
  static const String blockedMissingExplicitApproval = 'q386r1-explicit-user-approval-required';
  static const String ready = 'q386r1-approved-review-workspace-import-ready';

  static const bool requiresRealDecodedCandidate = true;
  static const bool requiresEditableReviewDraft = true;
  static const bool requiresNonEmptyReviewedLatex = true;
  static const bool requiresExplicitUserApproval = true;
  static const bool requiresWorkspaceImportCallback = true;
  static const bool importButtonDisabledUntilReady = true;
  static const bool directCameraToWorkspaceImportBlocked = true;
  static const bool autoEvaluateBlocked = true;
  static const bool autoGraphBlocked = true;
  static const bool autoSolutionHistoryBlocked = true;
  static const bool fakeOcrCandidateAllowed = false;
  static const bool workspaceImportPassClaimedByQ386R1 = false;
  static const bool ocrPassClaimedByQ386R1 = false;
  static const bool keyboardQ382Touched = false;
  static const bool graphHistorySolutionSolverTouched = false;
}

class GaussQ386R1WorkspaceImportGate {
  const GaussQ386R1WorkspaceImportGate({
    required this.phase,
    required this.hasRealOcrCandidate,
    required this.hasEditableReviewDraft,
    required this.workspaceImportCallbackAvailable,
    required this.explicitUserApproval,
    required this.approvedLatex,
    required this.canSubmit,
    required this.blockedReason,
    required this.directCameraToWorkspaceImportBlocked,
    required this.autoEvaluateBlocked,
    required this.autoGraphBlocked,
    required this.autoSolutionHistoryBlocked,
  });

  final String phase;
  final bool hasRealOcrCandidate;
  final bool hasEditableReviewDraft;
  final bool workspaceImportCallbackAvailable;
  final bool explicitUserApproval;
  final String approvedLatex;
  final bool canSubmit;
  final String blockedReason;
  final bool directCameraToWorkspaceImportBlocked;
  final bool autoEvaluateBlocked;
  final bool autoGraphBlocked;
  final bool autoSolutionHistoryBlocked;

  static GaussQ386R1WorkspaceImportGate evaluate({
    required bool hasRealOcrCandidate,
    required bool hasEditableReviewDraft,
    required bool workspaceImportCallbackAvailable,
    required bool explicitUserApproval,
    required String approvedLatex,
  }) {
    final trimmed = approvedLatex.trim();
    final blockedReason = !hasRealOcrCandidate
        ? GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.blockedNoCandidate
        : !hasEditableReviewDraft
            ? GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.blockedNoReviewDraft
            : !workspaceImportCallbackAvailable
                ? GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.blockedNoCallback
                : !explicitUserApproval
                    ? GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.blockedMissingExplicitApproval
                    : trimmed.isEmpty
                        ? GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.blockedEmptyApprovedLatex
                        : '';
    return GaussQ386R1WorkspaceImportGate(
      phase: GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.phase,
      hasRealOcrCandidate: hasRealOcrCandidate,
      hasEditableReviewDraft: hasEditableReviewDraft,
      workspaceImportCallbackAvailable: workspaceImportCallbackAvailable,
      explicitUserApproval: explicitUserApproval,
      approvedLatex: trimmed,
      canSubmit: blockedReason.isEmpty,
      blockedReason: blockedReason.isEmpty
          ? GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.ready
          : blockedReason,
      directCameraToWorkspaceImportBlocked:
          GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.directCameraToWorkspaceImportBlocked,
      autoEvaluateBlocked: GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.autoEvaluateBlocked,
      autoGraphBlocked: GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.autoGraphBlocked,
      autoSolutionHistoryBlocked:
          GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.autoSolutionHistoryBlocked,
    );
  }

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'phase': phase,
      'hasRealOcrCandidate': hasRealOcrCandidate,
      'hasEditableReviewDraft': hasEditableReviewDraft,
      'workspaceImportCallbackAvailable': workspaceImportCallbackAvailable,
      'explicitUserApproval': explicitUserApproval,
      'approvedLatex': approvedLatex,
      'canSubmit': canSubmit,
      'blockedReason': blockedReason,
      'directCameraToWorkspaceImportBlocked': directCameraToWorkspaceImportBlocked,
      'autoEvaluateBlocked': autoEvaluateBlocked,
      'autoGraphBlocked': autoGraphBlocked,
      'autoSolutionHistoryBlocked': autoSolutionHistoryBlocked,
      'workspaceImportPassClaimed': false,
      'ocrPassClaimed': false,
    };
  }
}
