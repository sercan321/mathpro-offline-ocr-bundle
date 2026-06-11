import 'gauss_editable_mathlive_ocr_review_activation_q368_policy.dart';

class GaussEditableMathLiveOcrReviewActivationQ368Result {
  const GaussEditableMathLiveOcrReviewActivationQ368Result({
    required this.phase,
    required this.sourcePhase,
    required this.status,
    required this.bridgeChannel,
    required this.bridgeMethod,
    required this.candidateEnvelopeVersion,
    required this.mathLiveReviewTarget,
    required this.editableMathLiveReviewActivationPrepared,
    required this.explicitBridgeInvocationRequired,
    required this.requiresQ367CandidateEnvelope,
    required this.requiresNonEmptyCandidateLatex,
    required this.requiresEditableMathLiveReviewBeforeImport,
    required this.requiresExplicitUserApprovalBeforeWorkspaceImport,
    required this.directOcrToWorkspaceImportBlocked,
    required this.directOcrToSolveGraphSolutionHistoryBlocked,
    required this.mathLiveProductionRoutePreserved,
    required this.reviewUiAutoOpened,
    required this.workspaceImportExecuted,
    required this.solveGraphSolutionHistoryTouched,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String status;
  final String bridgeChannel;
  final String bridgeMethod;
  final String candidateEnvelopeVersion;
  final String mathLiveReviewTarget;
  final bool editableMathLiveReviewActivationPrepared;
  final bool explicitBridgeInvocationRequired;
  final bool requiresQ367CandidateEnvelope;
  final bool requiresNonEmptyCandidateLatex;
  final bool requiresEditableMathLiveReviewBeforeImport;
  final bool requiresExplicitUserApprovalBeforeWorkspaceImport;
  final bool directOcrToWorkspaceImportBlocked;
  final bool directOcrToSolveGraphSolutionHistoryBlocked;
  final bool mathLiveProductionRoutePreserved;
  final bool reviewUiAutoOpened;
  final bool workspaceImportExecuted;
  final bool solveGraphSolutionHistoryTouched;
  final bool ocrPassClaimed;
}

class GaussEditableMathLiveOcrReviewActivationQ368 {
  const GaussEditableMathLiveOcrReviewActivationQ368._();

  static GaussEditableMathLiveOcrReviewActivationQ368Result evaluate() {
    return const GaussEditableMathLiveOcrReviewActivationQ368Result(
      phase: GaussEditableMathLiveOcrReviewActivationQ368Policy.phase,
      sourcePhase: GaussEditableMathLiveOcrReviewActivationQ368Policy.sourcePhase,
      status: GaussEditableMathLiveOcrReviewActivationQ368Policy.status,
      bridgeChannel: GaussEditableMathLiveOcrReviewActivationQ368Policy.bridgeChannel,
      bridgeMethod: GaussEditableMathLiveOcrReviewActivationQ368Policy.bridgeMethod,
      candidateEnvelopeVersion: GaussEditableMathLiveOcrReviewActivationQ368Policy.candidateEnvelopeVersion,
      mathLiveReviewTarget: GaussEditableMathLiveOcrReviewActivationQ368Policy.mathLiveReviewTarget,
      editableMathLiveReviewActivationPrepared: true,
      explicitBridgeInvocationRequired: true,
      requiresQ367CandidateEnvelope: true,
      requiresNonEmptyCandidateLatex: true,
      requiresEditableMathLiveReviewBeforeImport: true,
      requiresExplicitUserApprovalBeforeWorkspaceImport: true,
      directOcrToWorkspaceImportBlocked: true,
      directOcrToSolveGraphSolutionHistoryBlocked: true,
      mathLiveProductionRoutePreserved: true,
      reviewUiAutoOpened: false,
      workspaceImportExecuted: false,
      solveGraphSolutionHistoryTouched: false,
      ocrPassClaimed: false,
    );
  }
}
