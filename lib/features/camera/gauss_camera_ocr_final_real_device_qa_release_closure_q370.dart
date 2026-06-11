import 'gauss_camera_ocr_final_real_device_qa_release_closure_q370_policy.dart';

class GaussCameraOcrFinalRealDeviceQaReleaseClosureQ370Result {
  const GaussCameraOcrFinalRealDeviceQaReleaseClosureQ370Result({
    required this.phase,
    required this.sourcePhase,
    required this.status,
    required this.engine,
    required this.finalClosureEnvelopeVersion,
    required this.finalRealDeviceQaClosurePrepared,
    required this.requiresFlutterAnalyzePass,
    required this.requiresFlutterTestPass,
    required this.requiresFlutterRunPass,
    required this.requiresQ364PrivateStorageEvidence,
    required this.requiresQ365ModelLoadSmokeEvidence,
    required this.requiresQ366DummyRuntimeCallEvidence,
    required this.requiresQ367ImageToLatexEvidence,
    required this.requiresQ368EditableReviewEvidence,
    required this.requiresQ369ApprovedImportEvidence,
    required this.requiresNoDirectOcrToWorkspaceImport,
    required this.requiresNoDirectOcrToSolveGraphSolutionHistory,
    required this.requiresStorePrivacyDataSafetyReview,
    required this.ocrPassClaimed,
    required this.storeReadyPassClaimed,
    required this.releaseReadyPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String status;
  final String engine;
  final String finalClosureEnvelopeVersion;
  final bool finalRealDeviceQaClosurePrepared;
  final bool requiresFlutterAnalyzePass;
  final bool requiresFlutterTestPass;
  final bool requiresFlutterRunPass;
  final bool requiresQ364PrivateStorageEvidence;
  final bool requiresQ365ModelLoadSmokeEvidence;
  final bool requiresQ366DummyRuntimeCallEvidence;
  final bool requiresQ367ImageToLatexEvidence;
  final bool requiresQ368EditableReviewEvidence;
  final bool requiresQ369ApprovedImportEvidence;
  final bool requiresNoDirectOcrToWorkspaceImport;
  final bool requiresNoDirectOcrToSolveGraphSolutionHistory;
  final bool requiresStorePrivacyDataSafetyReview;
  final bool ocrPassClaimed;
  final bool storeReadyPassClaimed;
  final bool releaseReadyPassClaimed;
}

class GaussCameraOcrFinalRealDeviceQaReleaseClosureQ370 {
  const GaussCameraOcrFinalRealDeviceQaReleaseClosureQ370._();

  static GaussCameraOcrFinalRealDeviceQaReleaseClosureQ370Result evaluate() {
    return const GaussCameraOcrFinalRealDeviceQaReleaseClosureQ370Result(
      phase: GaussCameraOcrFinalRealDeviceQaReleaseClosureQ370Policy.phase,
      sourcePhase: GaussCameraOcrFinalRealDeviceQaReleaseClosureQ370Policy.sourcePhase,
      status: GaussCameraOcrFinalRealDeviceQaReleaseClosureQ370Policy.status,
      engine: GaussCameraOcrFinalRealDeviceQaReleaseClosureQ370Policy.engine,
      finalClosureEnvelopeVersion: GaussCameraOcrFinalRealDeviceQaReleaseClosureQ370Policy.finalClosureEnvelopeVersion,
      finalRealDeviceQaClosurePrepared: true,
      requiresFlutterAnalyzePass: true,
      requiresFlutterTestPass: true,
      requiresFlutterRunPass: true,
      requiresQ364PrivateStorageEvidence: true,
      requiresQ365ModelLoadSmokeEvidence: true,
      requiresQ366DummyRuntimeCallEvidence: true,
      requiresQ367ImageToLatexEvidence: true,
      requiresQ368EditableReviewEvidence: true,
      requiresQ369ApprovedImportEvidence: true,
      requiresNoDirectOcrToWorkspaceImport: true,
      requiresNoDirectOcrToSolveGraphSolutionHistory: true,
      requiresStorePrivacyDataSafetyReview: true,
      ocrPassClaimed: false,
      storeReadyPassClaimed: false,
      releaseReadyPassClaimed: false,
    );
  }
}
