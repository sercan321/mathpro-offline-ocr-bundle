/// V172-Q239B — Camera permission + capture shell.
///
/// This phase turns the Q239A workspace camera entry into a real capture shell:
/// the official Flutter camera plugin is declared, Android camera permission is
/// declared, and a premium in-app camera preview/capture screen is added. It is
/// still not an OCR phase: no math recognition model, no deferred model
/// downloader, no MathLive import, and no direct solver/evaluator path is
/// enabled.
abstract final class GaussCameraPermissionCaptureShellPolicy {
  static const String phase = 'V172-Q239B';
  static const String fullPhase = 'V172-Q239B-CAMERA-PERMISSION-CAPTURE-SHELL';

  static const bool workspaceCameraButtonRoutesToCaptureShell = true;
  static const bool q239aTopActionSlotPreserved = true;
  static const bool premiumCameraShellImplemented = true;
  static const bool officialFlutterCameraPackageDeclared = true;
  static const bool androidCameraPermissionDeclared = true;
  static const bool androidCameraFeatureOptional = true;
  static const bool cameraPreviewImplemented = true;
  static const bool stillPhotoCaptureImplemented = true;
  static const bool cameraSwitchControlImplemented = true;
  static const bool torchControlImplemented = true;
  static const bool captureResultHeldForFutureReviewOnly = true;

  static const bool cropImplemented = false;
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
  static const bool androidRealDeviceCameraPassClaimedByAssistant = false;
}
