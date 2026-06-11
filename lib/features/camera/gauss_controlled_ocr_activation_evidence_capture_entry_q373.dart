import 'gauss_controlled_ocr_activation_evidence_capture_entry_q373_policy.dart';
import 'gauss_controlled_ocr_activation_flutter_evidence_harness_q372.dart';

class GaussControlledOcrActivationEvidenceCaptureEntryQ373Request {
  const GaussControlledOcrActivationEvidenceCaptureEntryQ373Request({
    required this.modelSourcePath,
    required this.imagePath,
    this.candidateLatex,
    this.approvedLatex,
    this.candidateConfidence,
    this.enablePrivateStorageActivation = true,
    this.enableModelLoadSmoke = true,
    this.enableDummyRuntimeCall = true,
    this.enableImageToLatex = true,
    this.enableReviewHandoff = true,
    this.enableApprovedImport = false,
    this.reviewCompleted = false,
    this.userApproved = false,
  });

  final String modelSourcePath;
  final String imagePath;
  final String? candidateLatex;
  final String? approvedLatex;
  final double? candidateConfidence;
  final bool enablePrivateStorageActivation;
  final bool enableModelLoadSmoke;
  final bool enableDummyRuntimeCall;
  final bool enableImageToLatex;
  final bool enableReviewHandoff;
  final bool enableApprovedImport;
  final bool reviewCompleted;
  final bool userApproved;

  bool get hasRequiredEvidenceInputs => modelSourcePath.trim().isNotEmpty && imagePath.trim().isNotEmpty;

  bool get approvedImportMayBeRequested {
    return enableApprovedImport && reviewCompleted && userApproved && (approvedLatex ?? '').trim().isNotEmpty;
  }

  GaussControlledOcrActivationFlutterEvidenceHarnessQ372Request toHarnessRequest() {
    return GaussControlledOcrActivationFlutterEvidenceHarnessQ372Request(
      modelSourcePath: modelSourcePath,
      imagePath: imagePath,
      candidateLatex: candidateLatex,
      approvedLatex: approvedLatex,
      candidateConfidence: candidateConfidence,
      executePrivateStorageActivation: enablePrivateStorageActivation,
      executeModelLoadSmoke: enableModelLoadSmoke,
      executeDummyRuntimeCall: enableDummyRuntimeCall,
      executeImageToLatex: enableImageToLatex,
      prepareReviewHandoff: enableReviewHandoff,
      prepareApprovedImport: approvedImportMayBeRequested,
      reviewCompleted: reviewCompleted,
      userApproved: userApproved,
    );
  }
}

class GaussControlledOcrActivationEvidenceCaptureEntryQ373Result {
  const GaussControlledOcrActivationEvidenceCaptureEntryQ373Result({
    required this.phase,
    required this.sourcePhase,
    required this.status,
    required this.bridgeChannel,
    required this.nativeBridgeMethod,
    required this.entryVersion,
    required this.entryPrepared,
    required this.explicitUserInvocationRequired,
    required this.requiresModelSourcePath,
    required this.requiresImagePath,
    required this.requiresQ372FlutterHarness,
    required this.directOcrToWorkspaceImportBlocked,
    required this.directOcrToSolveGraphSolutionHistoryBlocked,
    required this.startupAutoExecutionBlocked,
    required this.cameraAutoExecutionBlocked,
    required this.workspaceAutoExecutionBlocked,
    required this.workspaceImportExecuted,
    required this.approvedWorkspaceImportExecuted,
    required this.solveGraphSolutionHistoryTouched,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String status;
  final String bridgeChannel;
  final String nativeBridgeMethod;
  final String entryVersion;
  final bool entryPrepared;
  final bool explicitUserInvocationRequired;
  final bool requiresModelSourcePath;
  final bool requiresImagePath;
  final bool requiresQ372FlutterHarness;
  final bool directOcrToWorkspaceImportBlocked;
  final bool directOcrToSolveGraphSolutionHistoryBlocked;
  final bool startupAutoExecutionBlocked;
  final bool cameraAutoExecutionBlocked;
  final bool workspaceAutoExecutionBlocked;
  final bool workspaceImportExecuted;
  final bool approvedWorkspaceImportExecuted;
  final bool solveGraphSolutionHistoryTouched;
  final bool ocrPassClaimed;
}

class GaussControlledOcrActivationEvidenceCaptureEntryQ373 {
  const GaussControlledOcrActivationEvidenceCaptureEntryQ373._();

  static GaussControlledOcrActivationEvidenceCaptureEntryQ373Result evaluate() {
    return const GaussControlledOcrActivationEvidenceCaptureEntryQ373Result(
      phase: GaussControlledOcrActivationEvidenceCaptureEntryQ373Policy.phase,
      sourcePhase: GaussControlledOcrActivationEvidenceCaptureEntryQ373Policy.sourcePhase,
      status: GaussControlledOcrActivationEvidenceCaptureEntryQ373Policy.status,
      bridgeChannel: GaussControlledOcrActivationEvidenceCaptureEntryQ373Policy.bridgeChannel,
      nativeBridgeMethod: GaussControlledOcrActivationEvidenceCaptureEntryQ373Policy.nativeBridgeMethod,
      entryVersion: GaussControlledOcrActivationEvidenceCaptureEntryQ373Policy.entryVersion,
      entryPrepared: true,
      explicitUserInvocationRequired: true,
      requiresModelSourcePath: true,
      requiresImagePath: true,
      requiresQ372FlutterHarness: true,
      directOcrToWorkspaceImportBlocked: true,
      directOcrToSolveGraphSolutionHistoryBlocked: true,
      startupAutoExecutionBlocked: true,
      cameraAutoExecutionBlocked: true,
      workspaceAutoExecutionBlocked: true,
      workspaceImportExecuted: false,
      approvedWorkspaceImportExecuted: false,
      solveGraphSolutionHistoryTouched: false,
      ocrPassClaimed: false,
    );
  }

  static Map<String, Object?> buildEvidenceArguments(
    GaussControlledOcrActivationEvidenceCaptureEntryQ373Request request,
  ) {
    final arguments = GaussControlledOcrActivationFlutterEvidenceHarnessQ372.buildArguments(
      request.toHarnessRequest(),
    );
    return <String, Object?>{
      ...arguments,
      'q373EntryVersion': GaussControlledOcrActivationEvidenceCaptureEntryQ373Policy.entryVersion,
      'q373EntryPrepared': true,
      'q373HasRequiredEvidenceInputs': request.hasRequiredEvidenceInputs,
      'q373ApprovedImportMayBeRequested': request.approvedImportMayBeRequested,
      'q373DirectOcrToWorkspaceImportBlocked': true,
      'q373DirectOcrToSolveGraphSolutionHistoryBlocked': true,
    };
  }

  static Future<Map<String, Object?>> captureEvidence(
    GaussControlledOcrActivationEvidenceCaptureEntryQ373Request request,
  ) {
    return GaussControlledOcrActivationFlutterEvidenceHarnessQ372.captureEvidence(
      request.toHarnessRequest(),
    );
  }
}
