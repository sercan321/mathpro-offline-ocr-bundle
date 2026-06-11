import 'gauss_camera_ocr_runtime_finalization_q381_policy.dart';

class GaussCameraOcrRuntimeFinalizationQ381Result {
  const GaussCameraOcrRuntimeFinalizationQ381Result({
    required this.phase,
    required this.cropReady,
    required this.modelPreflightApplied,
    required this.vocabularySidecarProvisionSupported,
    required this.candidateLatexDecoded,
    required this.blockedReason,
    required this.userFacingMessage,
    required this.repairPhase,
    required this.nativeWorkerOffMainThread,
    required this.exifOrientationAccounted,
    required this.memorySafeCropDecodeApplied,
    required this.cropEvidencePixelMappingRecorded,
  });

  factory GaussCameraOcrRuntimeFinalizationQ381Result.fromEvidence(Map<String, Object?> evidence) {
    return GaussCameraOcrRuntimeFinalizationQ381Result(
      phase: evidence['phase'] as String? ?? GaussCameraOcrRuntimeFinalizationQ381Policy.phase,
      cropReady: evidence['q381CropAndRotationApplied'] == true,
      modelPreflightApplied: evidence['q381ModelAndVocabPreflightApplied'] != false,
      vocabularySidecarProvisionSupported: evidence['modelVocabularySidecarEvidence'] != null,
      candidateLatexDecoded: evidence['candidateLatexDecoded'] == true,
      blockedReason: evidence['blockedReason'] as String? ?? evidence['decoderBlockedReason'] as String? ?? '',
      userFacingMessage: evidence['userFacingMessage'] as String? ?? '',
      repairPhase: evidence['repairPhase'] as String? ?? '',
      nativeWorkerOffMainThread: evidence['q381R1NativeWorkerOffMainThread'] == true,
      exifOrientationAccounted: evidence['q381R1ExifOrientationAccounted'] == true,
      memorySafeCropDecodeApplied: evidence['q381R1MemorySafeCropDecodeApplied'] == true,
      cropEvidencePixelMappingRecorded: evidence['q381R1CropEvidencePixelMappingRecorded'] == true,
    );
  }

  final String phase;
  final bool cropReady;
  final bool modelPreflightApplied;
  final bool vocabularySidecarProvisionSupported;
  final bool candidateLatexDecoded;
  final String blockedReason;
  final String userFacingMessage;
  final String repairPhase;
  final bool nativeWorkerOffMainThread;
  final bool exifOrientationAccounted;
  final bool memorySafeCropDecodeApplied;
  final bool cropEvidencePixelMappingRecorded;

  bool get reviewCanOpenWithRealCandidate => cropReady && candidateLatexDecoded;

  Map<String, Object?> toJson() => <String, Object?>{
        'phase': phase,
        'cropReady': cropReady,
        'modelPreflightApplied': modelPreflightApplied,
        'vocabularySidecarProvisionSupported': vocabularySidecarProvisionSupported,
        'candidateLatexDecoded': candidateLatexDecoded,
        'blockedReason': blockedReason,
        'userFacingMessage': userFacingMessage,
        'repairPhase': repairPhase,
        'nativeWorkerOffMainThread': nativeWorkerOffMainThread,
        'exifOrientationAccounted': exifOrientationAccounted,
        'memorySafeCropDecodeApplied': memorySafeCropDecodeApplied,
        'cropEvidencePixelMappingRecorded': cropEvidencePixelMappingRecorded,
        'reviewCanOpenWithRealCandidate': reviewCanOpenWithRealCandidate,
        'directOcrToWorkspaceImportBlockedBeforeReview': true,
        'solveGraphSolutionHistoryAutoTriggerBlocked': true,
        'ocrPassClaimedByPackage': false,
      };
}
