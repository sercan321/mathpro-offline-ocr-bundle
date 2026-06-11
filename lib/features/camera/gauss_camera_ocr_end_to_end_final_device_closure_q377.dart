import 'gauss_camera_ocr_end_to_end_final_device_closure_q377_policy.dart';

class GaussCameraOcrEndToEndEvidenceQ377 {
  const GaussCameraOcrEndToEndEvidenceQ377({
    this.flutterAnalyzePass = false,
    this.flutterTestPass = false,
    this.flutterRunRealDevicePass = false,
    this.privateStorageReady = false,
    this.modelLoadSmokePass = false,
    this.dummyRuntimeCallPass = false,
    this.imageToLatexCandidatePass = false,
    this.editableMathLiveReviewPass = false,
    this.approvedWorkspaceImportEnvelopePass = false,
    this.reviewFirstApprovedImportBindingPass = false,
    this.directOcrToWorkspaceBlocked = true,
    this.directOcrToSolveGraphSolutionHistoryBlocked = true,
  });

  final bool flutterAnalyzePass;
  final bool flutterTestPass;
  final bool flutterRunRealDevicePass;
  final bool privateStorageReady;
  final bool modelLoadSmokePass;
  final bool dummyRuntimeCallPass;
  final bool imageToLatexCandidatePass;
  final bool editableMathLiveReviewPass;
  final bool approvedWorkspaceImportEnvelopePass;
  final bool reviewFirstApprovedImportBindingPass;
  final bool directOcrToWorkspaceBlocked;
  final bool directOcrToSolveGraphSolutionHistoryBlocked;
}

class GaussCameraOcrEndToEndFinalDeviceClosureQ377Result {
  const GaussCameraOcrEndToEndFinalDeviceClosureQ377Result({
    required this.phase,
    required this.sourcePhase,
    required this.activeProductGatePreservedPhase,
    required this.status,
    required this.closureVersion,
    required this.finalClosureContractPrepared,
    required this.requiresFinalUserSideEvidence,
    required this.requiresFlutterAnalyzePass,
    required this.requiresFlutterTestPass,
    required this.requiresFlutterRunPass,
    required this.requiresPrivateStorageEvidence,
    required this.requiresModelLoadSmokeEvidence,
    required this.requiresDummyRuntimeCallEvidence,
    required this.requiresImageToLatexEvidence,
    required this.requiresEditableMathLiveReviewEvidence,
    required this.requiresApprovedWorkspaceImportEvidence,
    required this.cameraOcrEndToEndEvidenceComplete,
    required this.cameraOcrUsableFlowReady,
    required this.blockedReasons,
    required this.directOcrToWorkspaceBlocked,
    required this.directOcrToSolveGraphSolutionHistoryBlocked,
    required this.workspaceImportAutoExecuted,
    required this.solveGraphSolutionHistoryTouched,
    required this.ocrPassClaimedByPackage,
    required this.storeReadyPassClaimedByPackage,
    required this.releaseReadyPassClaimedByPackage,
  });

  final String phase;
  final String sourcePhase;
  final String activeProductGatePreservedPhase;
  final String status;
  final String closureVersion;
  final bool finalClosureContractPrepared;
  final bool requiresFinalUserSideEvidence;
  final bool requiresFlutterAnalyzePass;
  final bool requiresFlutterTestPass;
  final bool requiresFlutterRunPass;
  final bool requiresPrivateStorageEvidence;
  final bool requiresModelLoadSmokeEvidence;
  final bool requiresDummyRuntimeCallEvidence;
  final bool requiresImageToLatexEvidence;
  final bool requiresEditableMathLiveReviewEvidence;
  final bool requiresApprovedWorkspaceImportEvidence;
  final bool cameraOcrEndToEndEvidenceComplete;
  final bool cameraOcrUsableFlowReady;
  final List<String> blockedReasons;
  final bool directOcrToWorkspaceBlocked;
  final bool directOcrToSolveGraphSolutionHistoryBlocked;
  final bool workspaceImportAutoExecuted;
  final bool solveGraphSolutionHistoryTouched;
  final bool ocrPassClaimedByPackage;
  final bool storeReadyPassClaimedByPackage;
  final bool releaseReadyPassClaimedByPackage;

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'phase': phase,
      'sourcePhase': sourcePhase,
      'activeProductGatePreservedPhase': activeProductGatePreservedPhase,
      'status': status,
      'closureVersion': closureVersion,
      'finalClosureContractPrepared': finalClosureContractPrepared,
      'requiresFinalUserSideEvidence': requiresFinalUserSideEvidence,
      'requiresFlutterAnalyzePass': requiresFlutterAnalyzePass,
      'requiresFlutterTestPass': requiresFlutterTestPass,
      'requiresFlutterRunPass': requiresFlutterRunPass,
      'requiresPrivateStorageEvidence': requiresPrivateStorageEvidence,
      'requiresModelLoadSmokeEvidence': requiresModelLoadSmokeEvidence,
      'requiresDummyRuntimeCallEvidence': requiresDummyRuntimeCallEvidence,
      'requiresImageToLatexEvidence': requiresImageToLatexEvidence,
      'requiresEditableMathLiveReviewEvidence': requiresEditableMathLiveReviewEvidence,
      'requiresApprovedWorkspaceImportEvidence': requiresApprovedWorkspaceImportEvidence,
      'cameraOcrEndToEndEvidenceComplete': cameraOcrEndToEndEvidenceComplete,
      'cameraOcrUsableFlowReady': cameraOcrUsableFlowReady,
      'blockedReasons': blockedReasons,
      'directOcrToWorkspaceBlocked': directOcrToWorkspaceBlocked,
      'directOcrToSolveGraphSolutionHistoryBlocked': directOcrToSolveGraphSolutionHistoryBlocked,
      'workspaceImportAutoExecuted': workspaceImportAutoExecuted,
      'solveGraphSolutionHistoryTouched': solveGraphSolutionHistoryTouched,
      'ocrPassClaimedByPackage': ocrPassClaimedByPackage,
      'storeReadyPassClaimedByPackage': storeReadyPassClaimedByPackage,
      'releaseReadyPassClaimedByPackage': releaseReadyPassClaimedByPackage,
    };
  }
}

class GaussCameraOcrEndToEndFinalDeviceClosureQ377 {
  const GaussCameraOcrEndToEndFinalDeviceClosureQ377._();

  static GaussCameraOcrEndToEndFinalDeviceClosureQ377Result evaluate({
    GaussCameraOcrEndToEndEvidenceQ377 evidence = const GaussCameraOcrEndToEndEvidenceQ377(),
  }) {
    final blockedReasons = <String>[];
    if (!evidence.flutterAnalyzePass) blockedReasons.add('flutter-analyze-evidence-missing');
    if (!evidence.flutterTestPass) blockedReasons.add('flutter-test-evidence-missing');
    if (!evidence.flutterRunRealDevicePass) blockedReasons.add('flutter-run-real-device-evidence-missing');
    if (!evidence.privateStorageReady) blockedReasons.add('q364-private-storage-evidence-missing');
    if (!evidence.modelLoadSmokePass) blockedReasons.add('q365-model-load-smoke-evidence-missing');
    if (!evidence.dummyRuntimeCallPass) blockedReasons.add('q366-dummy-runtime-call-evidence-missing');
    if (!evidence.imageToLatexCandidatePass) blockedReasons.add('q367-image-to-latex-candidate-evidence-missing');
    if (!evidence.editableMathLiveReviewPass) blockedReasons.add('q368-editable-review-evidence-missing');
    if (!evidence.approvedWorkspaceImportEnvelopePass) blockedReasons.add('q369-approved-import-envelope-evidence-missing');
    if (!evidence.reviewFirstApprovedImportBindingPass) blockedReasons.add('q376-review-first-approved-import-binding-evidence-missing');
    if (!evidence.directOcrToWorkspaceBlocked) blockedReasons.add('direct-ocr-to-workspace-block-broken');
    if (!evidence.directOcrToSolveGraphSolutionHistoryBlocked) {
      blockedReasons.add('direct-ocr-to-solve-graph-solution-history-block-broken');
    }

    final complete = blockedReasons.isEmpty;
    return GaussCameraOcrEndToEndFinalDeviceClosureQ377Result(
      phase: GaussCameraOcrEndToEndFinalDeviceClosureQ377Policy.phase,
      sourcePhase: GaussCameraOcrEndToEndFinalDeviceClosureQ377Policy.sourcePhase,
      activeProductGatePreservedPhase: GaussCameraOcrEndToEndFinalDeviceClosureQ377Policy.activeProductGatePreservedPhase,
      status: complete
          ? 'CAMERA_OCR_END_TO_END_EVIDENCE_COMPLETE_READY_FOR_USER_VALIDATION'
          : GaussCameraOcrEndToEndFinalDeviceClosureQ377Policy.status,
      closureVersion: GaussCameraOcrEndToEndFinalDeviceClosureQ377Policy.closureVersion,
      finalClosureContractPrepared: true,
      requiresFinalUserSideEvidence: true,
      requiresFlutterAnalyzePass: true,
      requiresFlutterTestPass: true,
      requiresFlutterRunPass: true,
      requiresPrivateStorageEvidence: true,
      requiresModelLoadSmokeEvidence: true,
      requiresDummyRuntimeCallEvidence: true,
      requiresImageToLatexEvidence: true,
      requiresEditableMathLiveReviewEvidence: true,
      requiresApprovedWorkspaceImportEvidence: true,
      cameraOcrEndToEndEvidenceComplete: complete,
      cameraOcrUsableFlowReady: complete,
      blockedReasons: List<String>.unmodifiable(blockedReasons),
      directOcrToWorkspaceBlocked: evidence.directOcrToWorkspaceBlocked,
      directOcrToSolveGraphSolutionHistoryBlocked: evidence.directOcrToSolveGraphSolutionHistoryBlocked,
      workspaceImportAutoExecuted: false,
      solveGraphSolutionHistoryTouched: false,
      ocrPassClaimedByPackage: false,
      storeReadyPassClaimedByPackage: false,
      releaseReadyPassClaimedByPackage: false,
    );
  }
}
