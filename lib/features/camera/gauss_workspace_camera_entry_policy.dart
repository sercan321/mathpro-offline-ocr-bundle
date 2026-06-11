/// V172-Q239A — Workspace camera entry button replacement.
///
/// This phase is intentionally surgical: it replaces only the inert workspace
/// top-row ellipsis action with a premium camera entry point. It does not add a
/// camera runtime, Android permission, OCR engine, model download, solver path,
/// or MathLive import. Real capture/OCR remains deferred to later phases so the
/// existing keyboard, MORE, long-press, MathLive production editor, Graph,
/// Result, Solution, History, splash, and launcher icon surfaces stay isolated.
abstract final class GaussWorkspaceCameraEntryButtonPolicy {
  static const String phase = 'V172-Q239A';
  static const String fullPhase = 'V172-Q239A-WORKSPACE-CAMERA-ENTRY-BUTTON-REPLACEMENT';

  static const bool replacesWorkspaceEllipsisAction = true;
  static const bool workspaceTopActionSlotPreserved = true;
  static const bool premiumVisualShellPreserved = true;
  static const bool tooltipProvided = true;
  static const bool semanticLabelProvided = true;
  static const bool safePlaceholderSheetOnly = true;

  static const bool cameraPackageAdded = false;
  static const bool androidCameraPermissionAdded = false;
  static const bool cameraPreviewImplemented = false;
  static const bool ocrEngineAdded = false;
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
