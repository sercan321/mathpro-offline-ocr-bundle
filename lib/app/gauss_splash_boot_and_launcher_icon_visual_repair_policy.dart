/// V172-Q235R2 — GAUSS splash boot visibility + launcher icon visual repair.
///
/// Q235R2 repairs two real-device visual regressions:
/// 1. the Q235 splash overlay could be visually swallowed by a black startup
///    layer because the app shell was mounted behind the splash immediately;
/// 2. the adaptive icon route made the user-provided Gauss curve look zoomed
///    and unreadable on the launcher.
///
/// The phase stays surgical: user-provided artwork is reused, no new drawing
/// is generated, and keyboard/MORE/MathLive/Graph/Workspace/Solution/History
/// behavior is not changed.
abstract final class GaussSplashBootAndLauncherIconVisualRepairPolicy {
  static const String phase = 'V172-Q235R2';
  static const String fullPhase = 'V172-Q235R2-GAUSS-SPLASH-BOOT-AND-LAUNCHER-ICON-VISUAL-REPAIR';

  static const bool triggeredByUserSideBlackSplashAndBadLauncherIconReport = true;
  static const bool userProvidedSplashReferenceUsed = true;
  static const bool userProvidedLauncherIconReferenceUsed = true;
  static const bool newSplashImageGenerationUsed = false;
  static const bool newLauncherIconGenerationUsed = false;

  static const bool splashShowsBeforeAppShellMount = true;
  static const bool appShellMountedAfterBoundedSplash = true;
  static const bool splashUsesBoxFitContain = true;
  static const bool splashUsesBoxFitCover = false;
  static const bool firstFrameDeferralAllowed = false;
  static const bool splashDecodeFallbackHasVisibleGaussText = true;

  static const bool adaptiveIconXmlRouteRemoved = true;
  static const bool launcherUsesExactUserReferencePngRoute = true;
  static const bool launcherIconZoomRepairApplied = true;
  static const bool launcherCurveShouldRemainReadable = true;

  static const bool keyboardMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool mathLiveMutationAllowed = false;
  static const bool graphRuntimeMutationAllowed = false;
  static const bool workspaceMutationAllowed = false;
  static const bool resultPanelMutationAllowed = false;
  static const bool solutionMutationAllowed = false;
  static const bool historyMutationAllowed = false;
  static const bool solverMutationAllowed = false;
  static const bool mainDartMutationAllowed = false;
  static const bool androidManifestMutationAllowed = false;

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool androidRealDeviceSplashPassClaimedByAssistant = false;
  static const bool q235R3NativeSplashHardBindingActive = true;
  static const bool androidRealDeviceLauncherIconPassClaimedByAssistant = false;
  static const bool q235R4NativeFlutterContinuityRepairActive = true;
}
