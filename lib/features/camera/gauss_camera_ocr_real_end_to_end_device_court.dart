import 'gauss_camera_ocr_real_end_to_end_device_court_policy.dart';

enum GaussCameraOcrRealEndToEndDeviceCourtDecision {
  blockedMissingQ275ApprovedImportGate,
  blockedMissingCameraCaptureEvidence,
  blockedMissingCropScanFrameEvidence,
  blockedMissingQ273CandidateEnvelope,
  blockedMissingQ274MathLiveReviewBinding,
  blockedMissingExplicitUserApproval,
  blockedAutoEvaluateSolveOrGraphRisk,
  blockedUnsafeRuntimeOrOcrClaim,
  readyForFutureRealDeviceCourtOnly,
}

class GaussCameraOcrRealEndToEndDeviceCourtInput {
  const GaussCameraOcrRealEndToEndDeviceCourtInput({
    required this.q275ApprovedOcrWorkspaceImportGatePresent,
    required this.cameraCaptureEvidenceAvailable,
    required this.cropScanFrameEvidenceAvailable,
    required this.q273ImageToLatexCandidateEnvelopeAvailable,
    required this.q274MathLiveReviewBindingAvailable,
    required this.editableMathLiveReviewRequired,
    required this.explicitUserApprovalRequiredBeforeWorkspaceImport,
    required this.autoEvaluateAfterImport,
    required this.autoSolveAfterImport,
    required this.autoGraphAfterImport,
    required this.autoSolutionAfterImport,
    required this.autoHistoryAfterImport,
    required this.directCameraSolveBlocked,
    required this.directCameraGraphSolutionHistoryBlocked,
    required this.requiredCaseCount,
    required this.realOcrRuntimeAdded,
    required this.paddleRuntimeAdded,
    required this.paddleOcrDependencyAdded,
    required this.nativeBridgeImplementationAdded,
    required this.jniBindingAdded,
    required this.methodChannelRuntimeBindingAdded,
    required this.modelBinaryBundledInBaseApp,
    required this.productionModelUrlBound,
    required this.realNetworkDownloadWorkerImplemented,
    required this.productionDownloadEnabled,
    required this.productionInferenceAllowed,
    required this.realImageToLatexInferenceExecuted,
    required this.realEndToEndDeviceCourtPassClaimed,
    required this.ocrPassClaimed,
  });

  final bool q275ApprovedOcrWorkspaceImportGatePresent;
  final bool cameraCaptureEvidenceAvailable;
  final bool cropScanFrameEvidenceAvailable;
  final bool q273ImageToLatexCandidateEnvelopeAvailable;
  final bool q274MathLiveReviewBindingAvailable;
  final bool editableMathLiveReviewRequired;
  final bool explicitUserApprovalRequiredBeforeWorkspaceImport;
  final bool autoEvaluateAfterImport;
  final bool autoSolveAfterImport;
  final bool autoGraphAfterImport;
  final bool autoSolutionAfterImport;
  final bool autoHistoryAfterImport;
  final bool directCameraSolveBlocked;
  final bool directCameraGraphSolutionHistoryBlocked;
  final int requiredCaseCount;
  final bool realOcrRuntimeAdded;
  final bool paddleRuntimeAdded;
  final bool paddleOcrDependencyAdded;
  final bool nativeBridgeImplementationAdded;
  final bool jniBindingAdded;
  final bool methodChannelRuntimeBindingAdded;
  final bool modelBinaryBundledInBaseApp;
  final bool productionModelUrlBound;
  final bool realNetworkDownloadWorkerImplemented;
  final bool productionDownloadEnabled;
  final bool productionInferenceAllowed;
  final bool realImageToLatexInferenceExecuted;
  final bool realEndToEndDeviceCourtPassClaimed;
  final bool ocrPassClaimed;
}

class GaussCameraOcrRealEndToEndDeviceCourtResult {
  const GaussCameraOcrRealEndToEndDeviceCourtResult({
    required this.decision,
    required this.input,
  });

  final GaussCameraOcrRealEndToEndDeviceCourtDecision decision;
  final GaussCameraOcrRealEndToEndDeviceCourtInput input;

  String get phase => GaussCameraOcrRealEndToEndDeviceCourtPolicy.phase;
  String get sourcePhase => GaussCameraOcrRealEndToEndDeviceCourtPolicy.sourcePhase;
  String get selectedEngineLabel => GaussCameraOcrRealEndToEndDeviceCourtPolicy.selectedEngineLabel;
  String get courtMode => GaussCameraOcrRealEndToEndDeviceCourtPolicy.courtMode;
  List<String> get requiredRealDeviceCourtCases => GaussCameraOcrRealEndToEndDeviceCourtPolicy.requiredRealDeviceCourtCases;
  List<String> get requiredCourtGates => GaussCameraOcrRealEndToEndDeviceCourtPolicy.requiredCourtGates;
  List<String> get courtEvidenceFields => GaussCameraOcrRealEndToEndDeviceCourtPolicy.courtEvidenceFields;
  List<String> get blockedUntilRealEvidence => GaussCameraOcrRealEndToEndDeviceCourtPolicy.blockedUntilRealEvidence;
  List<String> get forbiddenActions => GaussCameraOcrRealEndToEndDeviceCourtPolicy.forbiddenActions;

  bool get staticReadyForFutureCourtOnly => decision == GaussCameraOcrRealEndToEndDeviceCourtDecision.readyForFutureRealDeviceCourtOnly;
  bool get realOcrRuntimeAdded => GaussCameraOcrRealEndToEndDeviceCourtPolicy.realOcrRuntimeAdded;
  bool get paddleRuntimeAdded => GaussCameraOcrRealEndToEndDeviceCourtPolicy.paddleRuntimeAdded;
  bool get paddleOcrDependencyAdded => GaussCameraOcrRealEndToEndDeviceCourtPolicy.paddleOcrDependencyAdded;
  bool get productionInferenceAllowed => GaussCameraOcrRealEndToEndDeviceCourtPolicy.productionInferenceAllowed;
  bool get realEndToEndDeviceCourtPassClaimed => GaussCameraOcrRealEndToEndDeviceCourtPolicy.realEndToEndDeviceCourtPassClaimed;
  bool get ocrPassClaimed => GaussCameraOcrRealEndToEndDeviceCourtPolicy.ocrPassClaimed;
}

class GaussCameraOcrRealEndToEndDeviceCourt {
  const GaussCameraOcrRealEndToEndDeviceCourt._();

  static GaussCameraOcrRealEndToEndDeviceCourtResult evaluate(GaussCameraOcrRealEndToEndDeviceCourtInput input) {
    if (!input.q275ApprovedOcrWorkspaceImportGatePresent) return GaussCameraOcrRealEndToEndDeviceCourtResult(decision: GaussCameraOcrRealEndToEndDeviceCourtDecision.blockedMissingQ275ApprovedImportGate, input: input);
    if (!input.cameraCaptureEvidenceAvailable) return GaussCameraOcrRealEndToEndDeviceCourtResult(decision: GaussCameraOcrRealEndToEndDeviceCourtDecision.blockedMissingCameraCaptureEvidence, input: input);
    if (!input.cropScanFrameEvidenceAvailable) return GaussCameraOcrRealEndToEndDeviceCourtResult(decision: GaussCameraOcrRealEndToEndDeviceCourtDecision.blockedMissingCropScanFrameEvidence, input: input);
    if (!input.q273ImageToLatexCandidateEnvelopeAvailable) return GaussCameraOcrRealEndToEndDeviceCourtResult(decision: GaussCameraOcrRealEndToEndDeviceCourtDecision.blockedMissingQ273CandidateEnvelope, input: input);
    if (!input.q274MathLiveReviewBindingAvailable || !input.editableMathLiveReviewRequired) return GaussCameraOcrRealEndToEndDeviceCourtResult(decision: GaussCameraOcrRealEndToEndDeviceCourtDecision.blockedMissingQ274MathLiveReviewBinding, input: input);
    if (!input.explicitUserApprovalRequiredBeforeWorkspaceImport) return GaussCameraOcrRealEndToEndDeviceCourtResult(decision: GaussCameraOcrRealEndToEndDeviceCourtDecision.blockedMissingExplicitUserApproval, input: input);
    if (input.autoEvaluateAfterImport || input.autoSolveAfterImport || input.autoGraphAfterImport || input.autoSolutionAfterImport || input.autoHistoryAfterImport || !input.directCameraSolveBlocked || !input.directCameraGraphSolutionHistoryBlocked) return GaussCameraOcrRealEndToEndDeviceCourtResult(decision: GaussCameraOcrRealEndToEndDeviceCourtDecision.blockedAutoEvaluateSolveOrGraphRisk, input: input);
    if (input.realOcrRuntimeAdded || input.paddleRuntimeAdded || input.paddleOcrDependencyAdded || input.nativeBridgeImplementationAdded || input.jniBindingAdded || input.methodChannelRuntimeBindingAdded || input.modelBinaryBundledInBaseApp || input.productionModelUrlBound || input.realNetworkDownloadWorkerImplemented || input.productionDownloadEnabled || input.productionInferenceAllowed || input.realImageToLatexInferenceExecuted || input.realEndToEndDeviceCourtPassClaimed || input.ocrPassClaimed) return GaussCameraOcrRealEndToEndDeviceCourtResult(decision: GaussCameraOcrRealEndToEndDeviceCourtDecision.blockedUnsafeRuntimeOrOcrClaim, input: input);
    return GaussCameraOcrRealEndToEndDeviceCourtResult(decision: GaussCameraOcrRealEndToEndDeviceCourtDecision.readyForFutureRealDeviceCourtOnly, input: input);
  }
}
