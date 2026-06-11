/// V172-Q244R2 — Camera regression Flutter compile hygiene repair.
///
/// This phase repairs the user-side Q244R1 Flutter analyze/test compile failure
/// caused by stale `_CardIconButton` muted references after the Q244R1 analyzer
/// hygiene edit. It does not add OCR runtime, change camera feature scope, or
/// mutate protected keyboard/MORE/MathLive/Graph/Solution/History/splash paths.
abstract final class GaussCameraRegressionFlutterCompileHygienePolicy {
  static const String phase = 'V172-Q244R2';
  static const String fullPhase = 'V172-Q244R2-CAMERA-REGRESSION-FLUTTER-COMPILE-HYGIENE-REPAIR';

  static const bool repairsQ244R1WorkspaceMutedCompileError = true;
  static const bool workspaceCardIconButtonMutedParameterRestored = false;
  static const bool workspaceCardIconButtonMutedReferencesRemoved = true;
  static const bool preservesQ239ACameraEntryButton = true;
  static const bool preservesQ244RegressionCourt = true;

  static const bool ocrRuntimeAdded = false;
  static const bool textOcrFallbackAdded = false;
  static const bool paddleRuntimeAdded = false;
  static const bool pix2TextRuntimeAdded = false;
  static const bool onnxRuntimeAdded = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionModelUrlBound = false;
  static const bool backgroundDownloadWorkerImplemented = false;
  static const bool mathLiveProductionBridgeCalled = false;
  static const bool directWorkspaceImportImplemented = false;
  static const bool directSolveFromCameraAllowed = false;

  static const bool keyboardMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool mathLiveProductionMutationAllowed = false;
  static const bool graphRuntimeMutationAllowed = false;
  static const bool solutionMutationAllowed = false;
  static const bool historyMutationAllowed = false;
  static const bool splashMutationAllowed = false;
  static const bool launcherIconMutationAllowed = false;

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool androidRealDeviceCameraPassClaimedByAssistant = false;
}
