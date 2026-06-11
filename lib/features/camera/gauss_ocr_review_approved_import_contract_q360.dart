import 'gauss_ocr_review_approved_import_contract_q360_policy.dart';

class GaussOcrReviewApprovedImportContractQ360Result {
  const GaussOcrReviewApprovedImportContractQ360Result({
    required this.phase,
    required this.sourcePhase,
    required this.status,
    required this.selectedDependencyCoordinate,
    required this.expectedOnnxArtifactSha256,
    required this.expectedOnnxArtifactSizeBytes,
    required this.reviewContractPrepared,
    required this.approvedImportContractPrepared,
    required this.requiresCandidateEnvelope,
    required this.requiresEditableMathLiveReviewBeforeImport,
    required this.requiresExplicitUserApprovalBeforeWorkspaceImport,
    required this.directOcrToWorkspaceImportBlocked,
    required this.directOcrToSolveBlocked,
    required this.directOcrToGraphBlocked,
    required this.directOcrToSolutionBlocked,
    required this.directOcrToHistoryBlocked,
    required this.rejectsEmptyCandidateLatex,
    required this.rejectsUnreviewedCandidateLatex,
    required this.rejectsUnapprovedImport,
    required this.reviewUiAutoOpened,
    required this.workspaceImportExecuted,
    required this.solveGraphSolutionHistoryTouched,
    required this.nativeRuntimeChanged,
    required this.uiRuntimeChanged,
    required this.ocrReviewPassClaimedByPackage,
    required this.workspaceImportPassClaimedByPackage,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String status;
  final String selectedDependencyCoordinate;
  final String expectedOnnxArtifactSha256;
  final int expectedOnnxArtifactSizeBytes;
  final bool reviewContractPrepared;
  final bool approvedImportContractPrepared;
  final bool requiresCandidateEnvelope;
  final bool requiresEditableMathLiveReviewBeforeImport;
  final bool requiresExplicitUserApprovalBeforeWorkspaceImport;
  final bool directOcrToWorkspaceImportBlocked;
  final bool directOcrToSolveBlocked;
  final bool directOcrToGraphBlocked;
  final bool directOcrToSolutionBlocked;
  final bool directOcrToHistoryBlocked;
  final bool rejectsEmptyCandidateLatex;
  final bool rejectsUnreviewedCandidateLatex;
  final bool rejectsUnapprovedImport;
  final bool reviewUiAutoOpened;
  final bool workspaceImportExecuted;
  final bool solveGraphSolutionHistoryTouched;
  final bool nativeRuntimeChanged;
  final bool uiRuntimeChanged;
  final bool ocrReviewPassClaimedByPackage;
  final bool workspaceImportPassClaimedByPackage;
  final bool ocrPassClaimed;
}

class GaussOcrReviewApprovedImportContractQ360 {
  const GaussOcrReviewApprovedImportContractQ360._();

  static GaussOcrReviewApprovedImportContractQ360Result evaluate() {
    return const GaussOcrReviewApprovedImportContractQ360Result(
      phase: GaussOcrReviewApprovedImportContractQ360Policy.phase,
      sourcePhase: GaussOcrReviewApprovedImportContractQ360Policy.sourcePhase,
      status: GaussOcrReviewApprovedImportContractQ360Policy.status,
      selectedDependencyCoordinate: GaussOcrReviewApprovedImportContractQ360Policy.selectedDependencyCoordinate,
      expectedOnnxArtifactSha256: GaussOcrReviewApprovedImportContractQ360Policy.expectedOnnxArtifactSha256,
      expectedOnnxArtifactSizeBytes: GaussOcrReviewApprovedImportContractQ360Policy.expectedOnnxArtifactSizeBytes,
      reviewContractPrepared: true,
      approvedImportContractPrepared: true,
      requiresCandidateEnvelope: true,
      requiresEditableMathLiveReviewBeforeImport: true,
      requiresExplicitUserApprovalBeforeWorkspaceImport: true,
      directOcrToWorkspaceImportBlocked: true,
      directOcrToSolveBlocked: true,
      directOcrToGraphBlocked: true,
      directOcrToSolutionBlocked: true,
      directOcrToHistoryBlocked: true,
      rejectsEmptyCandidateLatex: true,
      rejectsUnreviewedCandidateLatex: true,
      rejectsUnapprovedImport: true,
      reviewUiAutoOpened: false,
      workspaceImportExecuted: false,
      solveGraphSolutionHistoryTouched: false,
      nativeRuntimeChanged: false,
      uiRuntimeChanged: false,
      ocrReviewPassClaimedByPackage: false,
      workspaceImportPassClaimedByPackage: false,
      ocrPassClaimed: false,
    );
  }
}
