import 'gauss_approved_ocr_workspace_import_activation_q369_policy.dart';

class GaussApprovedOcrWorkspaceImportActivationQ369Result {
  const GaussApprovedOcrWorkspaceImportActivationQ369Result({
    required this.phase,
    required this.sourcePhase,
    required this.status,
    required this.bridgeChannel,
    required this.bridgeMethod,
    required this.approvedImportEnvelopeVersion,
    required this.workspaceImportTarget,
    required this.approvedWorkspaceImportActivationPrepared,
    required this.explicitBridgeInvocationRequired,
    required this.requiresQ368EditableReviewHandoff,
    required this.requiresEditableMathLiveReviewBeforeImport,
    required this.requiresExplicitUserApprovalBeforeWorkspaceImport,
    required this.requiresNonEmptyApprovedLatex,
    required this.directOcrToWorkspaceImportBlocked,
    required this.directOcrToSolveGraphSolutionHistoryBlocked,
    required this.mathLiveProductionRoutePreserved,
    required this.workspaceImportAutoExecuted,
    required this.workspaceImportExecuted,
    required this.approvedWorkspaceImportExecuted,
    required this.solveGraphSolutionHistoryTouched,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String status;
  final String bridgeChannel;
  final String bridgeMethod;
  final String approvedImportEnvelopeVersion;
  final String workspaceImportTarget;
  final bool approvedWorkspaceImportActivationPrepared;
  final bool explicitBridgeInvocationRequired;
  final bool requiresQ368EditableReviewHandoff;
  final bool requiresEditableMathLiveReviewBeforeImport;
  final bool requiresExplicitUserApprovalBeforeWorkspaceImport;
  final bool requiresNonEmptyApprovedLatex;
  final bool directOcrToWorkspaceImportBlocked;
  final bool directOcrToSolveGraphSolutionHistoryBlocked;
  final bool mathLiveProductionRoutePreserved;
  final bool workspaceImportAutoExecuted;
  final bool workspaceImportExecuted;
  final bool approvedWorkspaceImportExecuted;
  final bool solveGraphSolutionHistoryTouched;
  final bool ocrPassClaimed;
}

class GaussApprovedOcrWorkspaceImportActivationQ369 {
  const GaussApprovedOcrWorkspaceImportActivationQ369._();

  static GaussApprovedOcrWorkspaceImportActivationQ369Result evaluate() {
    return const GaussApprovedOcrWorkspaceImportActivationQ369Result(
      phase: GaussApprovedOcrWorkspaceImportActivationQ369Policy.phase,
      sourcePhase: GaussApprovedOcrWorkspaceImportActivationQ369Policy.sourcePhase,
      status: GaussApprovedOcrWorkspaceImportActivationQ369Policy.status,
      bridgeChannel: GaussApprovedOcrWorkspaceImportActivationQ369Policy.bridgeChannel,
      bridgeMethod: GaussApprovedOcrWorkspaceImportActivationQ369Policy.bridgeMethod,
      approvedImportEnvelopeVersion: GaussApprovedOcrWorkspaceImportActivationQ369Policy.approvedImportEnvelopeVersion,
      workspaceImportTarget: GaussApprovedOcrWorkspaceImportActivationQ369Policy.workspaceImportTarget,
      approvedWorkspaceImportActivationPrepared: true,
      explicitBridgeInvocationRequired: true,
      requiresQ368EditableReviewHandoff: true,
      requiresEditableMathLiveReviewBeforeImport: true,
      requiresExplicitUserApprovalBeforeWorkspaceImport: true,
      requiresNonEmptyApprovedLatex: true,
      directOcrToWorkspaceImportBlocked: true,
      directOcrToSolveGraphSolutionHistoryBlocked: true,
      mathLiveProductionRoutePreserved: true,
      workspaceImportAutoExecuted: false,
      workspaceImportExecuted: false,
      approvedWorkspaceImportExecuted: false,
      solveGraphSolutionHistoryTouched: false,
      ocrPassClaimed: false,
    );
  }
}
