/// V172-Q239C — Formula crop / scan frame shell policy.
///
/// This is a UI-and-state-preparation phase only. It converts a captured camera
/// photo into a bounded review surface with a premium formula scan frame, retake,
/// rotate, and use-frame controls. It does not perform OCR, does not download a
/// model, does not import into MathLive, and never sends camera output directly
/// to the solver.
class GaussFormulaCropScanFramePolicy {
  const GaussFormulaCropScanFramePolicy._();

  static const String phase = 'V172-Q239C';
  static const String fullPhase = 'V172-Q239C-FORMULA-CROP-SCAN-FRAME-SHELL';

  static const bool q239bCaptureShellPreserved = true;
  static const bool premiumFormulaCropReviewImplemented = true;
  static const bool capturedPhotoPreviewImplemented = true;
  static const bool boundedFormulaScanFrameImplemented = true;
  static const bool retakeControlImplemented = true;
  static const bool rotateControlImplemented = true;
  static const bool useFrameControlImplemented = true;
  static const bool cropMetadataPreparedForFuturePreprocess = true;
  static const bool actualImageCropFileWritten = false;
  static const bool galleryImportImplemented = false;

  static const double normalizedFrameWidth = 0.78;
  static const double normalizedFrameHeight = 0.34;
  static const String normalizedFrameDescription = 'center 78% × 34%';

  static const bool ocrEngineAdded = false;
  static const bool textOcrFallbackAdded = false;
  static const bool paddleOcrAdded = false;
  static const bool pix2TextAdded = false;
  static const bool onnxRuntimeAdded = false;
  static const bool deferredModelDownloadImplemented = false;
  static const bool mathLiveImportImplemented = false;
  static const bool directSolveFromCameraAllowed = false;

  static const bool keyboardMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool mathLiveProductionMutationAllowed = false;
  static const bool graphRuntimeMutationAllowed = false;
  static const bool resultPanelMutationAllowed = false;
  static const bool solutionMutationAllowed = false;
  static const bool historyMutationAllowed = false;
  static const bool solverMutationAllowed = false;
  static const bool splashMutationAllowed = false;
  static const bool launcherIconMutationAllowed = false;

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool androidRealDeviceCropPassClaimedByAssistant = false;
}
