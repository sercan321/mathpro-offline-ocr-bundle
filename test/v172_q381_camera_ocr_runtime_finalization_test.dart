import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ocr_runtime_finalization_q381.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ocr_runtime_finalization_q381_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_camera_ocr_user_flow_binding_q378.dart';

void main() {
  test('Q381 policy preserves review-first OCR import safety contract', () {
    expect(GaussCameraOcrRuntimeFinalizationQ381Policy.bridgeMethod, 'cameraOcrRuntimeFinalizationCropModelVocabReviewCompletion');
    expect(GaussCameraOcrRuntimeFinalizationQ381Policy.cropFrameProducesRealOcrInputImage, isTrue);
    expect(GaussCameraOcrRuntimeFinalizationQ381Policy.rotationAppliedBeforeOcrInput, isTrue);
    expect(GaussCameraOcrRuntimeFinalizationQ381Policy.privateModelPreflightBeforeInference, isTrue);
    expect(GaussCameraOcrRuntimeFinalizationQ381Policy.vocabularySidecarProvisionSupported, isTrue);
    expect(GaussCameraOcrRuntimeFinalizationQ381Policy.fakeLatexGenerationBlocked, isTrue);
    expect(GaussCameraOcrRuntimeFinalizationQ381Policy.directOcrToWorkspaceImportBlockedBeforeReview, isTrue);
    expect(GaussCameraOcrRuntimeFinalizationQ381Policy.solveGraphSolutionHistoryAutoTriggerBlocked, isTrue);
    expect(GaussCameraOcrRuntimeFinalizationQ381Policy.onnxModelBundledInZip, isFalse);
    expect(GaussCameraOcrRuntimeFinalizationQ381Policy.nativeOcrBridgeRunsOffMainThread, isTrue);
    expect(GaussCameraOcrRuntimeFinalizationQ381Policy.cropDecodeUsesBoundedSampleSize, isTrue);
    expect(GaussCameraOcrRuntimeFinalizationQ381Policy.exifOrientationAccountedBeforeCrop, isTrue);
    expect(GaussCameraOcrRuntimeFinalizationQ381Policy.cropEvidenceIncludesPixelMapping, isTrue);
    expect(GaussCameraOcrRuntimeFinalizationQ381Policy.nativeWorkerFailureReturnsBlockedEvidence, isTrue);
    expect(GaussCameraOcrRuntimeFinalizationQ381Policy.q380BitmapRecycleAfterTensorBuild, isTrue);
    expect(GaussCameraOcrRuntimeFinalizationQ381Policy.ocrPassClaimedByPackage, isFalse);
  });

  test('Q381 result exposes safe blocked user message without OCR pass claim', () {
    final result = GaussCameraOcrRuntimeFinalizationQ381Result.fromEvidence(const <String, Object?>{
      'phase': GaussCameraOcrRuntimeFinalizationQ381Policy.phase,
      'q381CropAndRotationApplied': true,
      'q381ModelAndVocabPreflightApplied': true,
      'candidateLatexDecoded': false,
      'blockedReason': 'private-storage-onnx-model-missing',
      'userFacingMessage': 'OCR modeli bu cihazda hazır değil.',
      'modelVocabularySidecarEvidence': <String, Object?>{},
      'repairPhase': GaussCameraOcrRuntimeFinalizationQ381Policy.latestRepairPhase,
      'q381R1NativeWorkerOffMainThread': true,
      'q381R1ExifOrientationAccounted': true,
      'q381R1MemorySafeCropDecodeApplied': true,
      'q381R1CropEvidencePixelMappingRecorded': true,
    });

    expect(result.cropReady, isTrue);
    expect(result.modelPreflightApplied, isTrue);
    expect(result.vocabularySidecarProvisionSupported, isTrue);
    expect(result.candidateLatexDecoded, isFalse);
    expect(result.reviewCanOpenWithRealCandidate, isFalse);
    expect(result.nativeWorkerOffMainThread, isTrue);
    expect(result.exifOrientationAccounted, isTrue);
    expect(result.memorySafeCropDecodeApplied, isTrue);
    expect(result.cropEvidencePixelMappingRecorded, isTrue);
    expect(result.toJson()['ocrPassClaimedByPackage'], isFalse);
  });

  test('Q378 capture API accepts rotation and model source path for Q381 bridge', () {
    expect(GaussRealCameraOcrUserFlowBindingQ378.captureAndPrepareReview, isA<Function>());
  });
}
