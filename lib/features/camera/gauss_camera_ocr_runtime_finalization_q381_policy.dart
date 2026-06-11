class GaussCameraOcrRuntimeFinalizationQ381Policy {
  const GaussCameraOcrRuntimeFinalizationQ381Policy._();

  static const String phase = 'V172-Q381-CAMERA-OCR-RUNTIME-FINALIZATION-CROP-MODEL-VOCAB-REVIEW-COMPLETION';
  static const String sourcePhase = 'V172-Q380-OCR-RUNTIME-READINESS-ADAPTIVE-INPUT-DECODER-COMPLETION';
  static const String bridgeChannel = 'mathpro/ocr_runtime_bridge';
  static const String bridgeMethod = 'cameraOcrRuntimeFinalizationCropModelVocabReviewCompletion';
  static const String bindingVersion = 'q381-camera-ocr-runtime-finalization-crop-model-vocab-review-v1';
  static const String latestRepairPhase = 'V172-Q381R1-CAMERA-OCR-RUNTIME-RISK-REPAIR';
  static const String latestRepairBindingVersion = 'q381r1-off-main-thread-exif-memory-safe-crop-repair-v1';

  static const double normalizedCropFrameWidth = 0.78;
  static const double normalizedCropFrameHeight = 0.34;

  static const bool cameraFlowUsesQ381Bridge = true;
  static const bool cropFrameProducesRealOcrInputImage = true;
  static const bool rotationAppliedBeforeOcrInput = true;
  static const bool privateModelPreflightBeforeInference = true;
  static const bool vocabularySidecarProvisionSupported = true;
  static const bool adaptiveInputDecoderPreserved = true;
  static const bool fakeLatexGenerationBlocked = true;
  static const bool userFriendlyBlockedReasonProvided = true;
  static const bool editableReviewRequiredBeforeImport = true;
  static const bool explicitUserApprovalRequiredBeforeImport = true;
  static const bool directOcrToWorkspaceImportBlockedBeforeReview = true;
  static const bool solveGraphSolutionHistoryAutoTriggerBlocked = true;
  static const bool onnxModelBundledInZip = false;
  static const bool nativeOcrBridgeRunsOffMainThread = true;
  static const bool cropDecodeUsesBoundedSampleSize = true;
  static const bool exifOrientationAccountedBeforeCrop = true;
  static const bool cropEvidenceIncludesPixelMapping = true;
  static const bool nativeWorkerFailureReturnsBlockedEvidence = true;
  static const bool q380BitmapRecycleAfterTensorBuild = true;
  static const bool ocrPassClaimedByPackage = false;
}
