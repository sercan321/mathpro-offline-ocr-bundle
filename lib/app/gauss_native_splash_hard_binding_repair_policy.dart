/// V172-Q235R3 — GAUSS native splash hard binding repair.
///
/// Q235R3 fixes the root cause of the remaining black splash: Android native
/// startup resources were still dark-background-only. The full user-provided
/// splash artwork is bound to `launch_background`. Q235R7 later retires the
/// Android 12+ branded icon slot because it appears as a small centered image;
/// the full-size splash is owned by the native overlay.
abstract final class GaussNativeSplashHardBindingRepairPolicy {
  static const String phase = 'V172-Q235R3';
  static const String fullPhase = 'V172-Q235R3-GAUSS-NATIVE-SPLASH-HARD-BINDING-REPAIR';

  static const bool triggeredByRepeatedBlackSplashReport = true;
  static const bool userProvidedSplashReferenceUsed = true;
  static const bool newSplashImageGenerationUsed = false;

  static const bool nativeLaunchBackgroundUsesFullSplashArtwork = true;
  static const bool nativeLaunchBackgroundBlackOnlyRetired = true;
  static const bool android12TransparentIconRetired = false;
  static const bool android12UsesBrandedSplashIcon = false;
  static const bool normalThemeUsesLaunchBackgroundDuringHandoff = true;
  static const bool flutterOverlayRemovedFromProductionHome = true;
  static const bool productionHomeBootsDirectlyToAppShell = true;
  static const bool calculatorStartupCannotWaitForSplashOverlayTimer = true;

  static const bool fullSplashArtworkCropRiskAcceptedOnlyForNativeDeviceSize = false;
  static const bool fullSplashArtworkUsesUserReference = true;
  static const bool splashAssetStillBoxFitContainIfUsed = true;

  static const bool launcherIconMutationAllowed = false;
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
  static const bool q235R4NativeFlutterContinuityRepairActive = true;
  static const bool q235R5NativeOverlayUntilAppShellReadyActive = true;
  static const bool q235R7Android12SmallIconEliminated = true;
}
