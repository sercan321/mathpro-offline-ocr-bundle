/// V172-Q239E — MathLive OCR Review Surface Foundation policy.
///
/// This phase prepares the camera-to-MathLive review contract only. It does not
/// add an OCR engine, does not download model bytes, does not call the
/// production MathLive bridge, and never sends camera output directly to the
/// solver/evaluator.
class GaussMathLiveOcrReviewSurfacePolicy {
  const GaussMathLiveOcrReviewSurfacePolicy._();

  static const String phase = 'V172-Q239E';
  static const String fullPhase = 'V172-Q239E-MATHLIVE-OCR-REVIEW-SURFACE-FOUNDATION';

  static const bool q239dDeferredModelManagerPreserved = true;
  static const bool q239cCropScanFramePreserved = true;
  static const bool mathLiveOcrReviewSurfaceImplemented = true;
  static const bool ocrCandidateContractPrepared = true;
  static const bool candidateListPrepared = true;
  static const bool editableReviewRequiredBeforeWorkspaceImport = true;
  static const bool reviewSurfaceReceivesCaptureMetadata = true;
  static const bool reviewSurfaceShowsModelStatus = true;
  static const bool reviewSurfaceCanQueueDeferredModel = true;
  static const bool workspaceImportDeferredUntilRealCandidate = true;

  static const bool realOcrEngineAdded = false;
  static const bool textOcrFallbackAdded = false;
  static const bool paddleRuntimeAdded = false;
  static const bool pix2TextRuntimeAdded = false;
  static const bool onnxRuntimeAdded = false;
  static const bool backgroundDownloadWorkerImplemented = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionModelUrlBound = false;
  static const bool productionMathLiveBridgeCalled = false;
  static const bool mathLiveProductionFilesMutated = false;
  static const bool directWorkspaceImportImplemented = false;
  static const bool directSolveFromCameraAllowed = false;

  static const bool keyboardMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool moreMutationAllowed = false;
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
  static const bool androidRealDeviceReviewPassClaimedByAssistant = false;

  static const String reviewContract =
      'camera-crop-metadata -> future-ocr-latex-candidates -> MathLive editable review -> explicit user confirmation -> workspace import';
  static const String noDirectSolveContract =
      'camera output must never be sent directly to Evaluate, Graph, Solution, History, or solver without MathLive editable review';
}
